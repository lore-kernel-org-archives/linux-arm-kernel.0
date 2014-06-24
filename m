From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 24 Jun 2014 19:27:53 +0200
Subject: [PATCH v7 7/9] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
In-Reply-To: <1403560693-21809-8-git-send-email-keescook@chromium.org>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-8-git-send-email-keescook@chromium.org>
Message-ID: <20140624172753.GA31435@redhat.com>
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
> +		pid_t failed;
> +
> +		if (thread->seccomp.mode == SECCOMP_MODE_DISABLED ||
> +		    (thread->seccomp.mode == SECCOMP_MODE_FILTER &&
> +		     is_ancestor(thread->seccomp.filter,
> +				 caller->seccomp.filter)))
> +			continue;
> +
> +		/* Return the first thread that cannot be synchronized. */
> +		failed = task_pid_vnr(thread);
> +		/* If the pid cannot be resolved, then return -ESRCH */
> +		if (failed == 0)
> +			failed = -ESRCH;

forgot to mention, task_pid_vnr() can't fail. sighand->siglock is held,
for_each_thread() can't see a thread which has passed unhash_process().

Oleg.
