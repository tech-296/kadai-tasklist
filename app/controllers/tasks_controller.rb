class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :new, :edit]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @pagy, @tasks = pagy(current_user.tasks.all, items: 5)
  end

  def show
    #@task = Task.find(params[:id])
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスク登録完了'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク登録できませんでした'
      render :new
    end
  end

  def edit
    #@task = Task.find(params[:id])
  end

  def update
    #@task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'タスク編集完了'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク編集できませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'タスク削除完了'
    redirect_to tasks_url
  end


  private

  def task_params
    params.require(:task).permit(:status, :content)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end