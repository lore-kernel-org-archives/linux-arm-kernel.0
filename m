From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 24 Jun 2014 19:08:00 +0200
Subject: [PATCH v7 7/9] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
In-Reply-To: <1403560693-21809-8-git-send-email-keescook@chromium.org>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-8-git-send-email-keescook@chromium.org>
Message-ID: <20140624170800.GA30480@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23, Kees Cook wrote:
>
> +static pid_t seccomp_can_sync_threads(void)
> +{
> +	struct task_struct *thread, *caller;
> +
> +	BUG_ON(write_can_lock(&tasklist_lock));
> +	BUG_ON(!spin_is_locked(&current->sighand->siglock));
> +
> +	if (current->seccomp.mode != SECCOMP_MODE_FILTER)
> +		return -EACCES;
> +
> +	/* Validate all threads being eligible for synchronization. */
> +	thread = caller = current;
> +	for_each_thread(caller, thread) {

You only need to initialize "caller" for for_each_thread(). Same for
seccomp_sync_threads().

> @@ -586,6 +701,17 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  	if (IS_ERR(prepared))
>  		return PTR_ERR(prepared);
>
> +	/*
> +	 * If we're doing thread sync, we must hold tasklist_lock
> +	 * to make sure seccomp filter changes are stable on threads
> +	 * entering or leaving the task list. And we must take it
> +	 * before the sighand lock to avoid deadlocking.
> +	 */
> +	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
> +		write_lock_irqsave(&tasklist_lock, taskflags);
> +	else
> +		__acquire(&tasklist_lock); /* keep sparse happy */
> +

Why? ->siglock should be enough, it seems.

It obviously does not protect the global process list, but *sync_threads()
only care about current's thread group list, no?

Oleg.
