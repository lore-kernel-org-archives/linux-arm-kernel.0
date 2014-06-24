From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 24 Jun 2014 18:52:16 +0200
Subject: [PATCH v7 3/9] seccomp: introduce writer locking
In-Reply-To: <1403560693-21809-4-git-send-email-keescook@chromium.org>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-4-git-send-email-keescook@chromium.org>
Message-ID: <20140624165216.GA29272@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kees,

I am still trying to force myself to read and try to understand what
this series does ;) Just a minor nit so far.

On 06/23, Kees Cook wrote:
>
> @@ -1142,6 +1168,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  {
>  	int retval;
>  	struct task_struct *p;
> +	unsigned long irqflags;
>  
>  	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
>  		return ERR_PTR(-EINVAL);
> @@ -1196,7 +1223,6 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  		goto fork_out;
>  
>  	ftrace_graph_init_task(p);
> -	get_seccomp_filter(p);
>  
>  	rt_mutex_init_task(p);
>  
> @@ -1434,7 +1460,13 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  		p->parent_exec_id = current->self_exec_id;
>  	}
>  
> -	spin_lock(&current->sighand->siglock);
> +	spin_lock_irqsave(&current->sighand->siglock, irqflags);
> +
> +	/*
> +	 * Copy seccomp details explicitly here, in case they were changed
> +	 * before holding tasklist_lock.
> +	 */
> +	copy_seccomp(p);
>  
>  	/*
>  	 * Process group and session signals need to be delivered to just the
> @@ -1446,7 +1478,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  	*/
>  	recalc_sigpending();
>  	if (signal_pending(current)) {
> -		spin_unlock(&current->sighand->siglock);
> +		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
>  		write_unlock_irq(&tasklist_lock);
>  		retval = -ERESTARTNOINTR;
>  		goto bad_fork_free_pid;
> @@ -1486,7 +1518,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  	}
>  
>  	total_forks++;
> -	spin_unlock(&current->sighand->siglock);
> +	spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
>  	write_unlock_irq(&tasklist_lock);
>  	proc_fork_connector(p);
>  	cgroup_post_fork(p);

It seems that the only change copy_process() needs is copy_seccomp() under the locks.
Everythinh else (irqflags games) looks obviously unneeded?

> @@ -524,6 +528,9 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
>  	}
>  #endif
>
> +	if (unlikely(!lock_task_sighand(current, &irqflags)))
> +		goto out_free;
> +

Unless this task is exiting (namely, it has already called exit_notify()),
lock_task_sighand(current) must not fail. Looks like you can simly do
spin_lock_irq(->siglock).

Oleg.
