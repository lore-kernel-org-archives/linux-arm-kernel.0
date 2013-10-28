From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 28 Oct 2013 18:12:40 +0000
Subject: [RFC v3 PATCH 3/7] ARM64: defer reloading a task's FPSIMD state
 to userland resume
In-Reply-To: <1381666503-23726-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
 <1381666503-23726-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20131028181238.GB18563@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 13, 2013 at 01:14:59PM +0100, Ard Biesheuvel wrote:
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -72,7 +72,7 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
>  void fpsimd_thread_switch(struct task_struct *next)
>  {
>  	/* check if not kernel threads */
> -	if (current->mm)
> +	if (current->mm && !test_and_clear_thread_flag(TIF_RELOAD_FPSTATE))
>  		fpsimd_save_state(&current->thread.fpsimd_state);

Why does it need test_and_set_thread_flag() here? Some comments would be
useful as it looks strange to check a reload flag to decide whether to
save a state. Or change the name to something like 'dirty'.

>  	if (next->mm)
>  		fpsimd_load_state(&next->thread.fpsimd_state);

This function could be optimised a bit more to avoid saving/restoring if
the switch only happened between a user thread and a kernel one (and
back again) since the FP state may not have been dirtied. But what I had
in mind was per-CPU fpstate (possibly pointer or some flag) rather than
per-thread.

> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -416,4 +416,6 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
>  		clear_thread_flag(TIF_NOTIFY_RESUME);
>  		tracehook_notify_resume(regs);
>  	}
> +	if (test_and_clear_thread_flag(TIF_RELOAD_FPSTATE))
> +		fpsimd_load_state(&current->thread.fpsimd_state);

I think this code can be preempted, it is run with IRQs enabled. And
there is a small window where we cleared the flag but haven't loaded the
state.

-- 
Catalin
