From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 25 Jun 2014 15:51:22 +0200
Subject: [PATCH v8 5/9] seccomp: split mode set routines
In-Reply-To: <1403642893-23107-6-git-send-email-keescook@chromium.org>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-6-git-send-email-keescook@chromium.org>
Message-ID: <20140625135121.GB7892@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24, Kees Cook wrote:
>
> +static inline void seccomp_assign_mode(struct task_struct *task,
> +				       unsigned long seccomp_mode)
> +{
> +	BUG_ON(!spin_is_locked(&task->sighand->siglock));
> +
> +	task->seccomp.mode = seccomp_mode;
> +	set_tsk_thread_flag(task, TIF_SECCOMP);
> +}

OK, but unless task == current this can race with secure_computing().
I think this needs smp_mb__before_atomic() and secure_computing() needs
rmb() after test_bit(TIF_SECCOMP).

Otherwise, can't __secure_computing() hit BUG() if it sees the old
mode == SECCOMP_MODE_DISABLED ?

Or seccomp_run_filters() can see ->filters == NULL and WARN(),
smp_load_acquire() only serializes that LOAD with the subsequent memory
operations.

Oleg.
