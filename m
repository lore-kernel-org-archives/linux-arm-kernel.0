From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 13 Dec 2016 13:49:09 +0000
Subject: [PATCH v6] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <1481632529-24218-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1481632529-24218-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161213134908.GG1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 12:35:29PM +0000, Ard Biesheuvel wrote:
> Currently, we allow kernel mode NEON in softirq or hardirq context by
> stacking and unstacking a slice of the NEON register file for each call
> to kernel_neon_begin() and kernel_neon_end(), respectively.
> 
> Given that
> a) a CPU typically spends most of its time in userland, during which time
>    no kernel mode NEON in process context is in progress,
> b) a CPU spends most of its time in the kernel doing other things than
>    kernel mode NEON when it gets interrupted to perform kernel mode NEON
>    in softirq context
> 
> the stacking and subsequent unstacking is only necessary if we are
> interrupting a thread while it is performing kernel mode NEON in process
> context, which means that in all other cases, we can simply preserve the
> userland FPSIMD state once, and only restore it upon return to userland,
> even if we are being invoked from softirq or hardirq context.
> 
> So instead of checking whether we are running in interrupt context, keep
> track of the level of nested kernel mode NEON calls in progress, and only
> perform the eager stack/unstack if the level exceeds 1.

Hang on ... we could be in the middle of fpsimd_save_state() for other
reasons, say on the context switch path.  Wouldn't we need to take the
lock for those too?

Also, a spinlock can't protect a critical section from code running on
the same CPU... wouldn't it just deadlock in that case?

I still tend to prefer v4 -- there we do a redundant double-save only if
one kernel_neon_begin() interrupts the actual task context save.

Cheers
---Dave

> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v6:
> - use a spinlock instead of disabling interrupts
> 
> v5:
> - perform the test-and-set and the fpsimd_save_state with interrupts disabled,
>   to prevent nested kernel_neon_begin()/_end() pairs to clobber the state
>   while it is being preserved
> 
> v4:
> - use this_cpu_inc/dec, which give sufficient guarantees regarding
>   concurrency, but do not imply SMP barriers, which are not needed here
> 
> v3:
> - avoid corruption by concurrent invocations of kernel_neon_begin()/_end()
> 
> v2:
> - BUG() on unexpected values of the nesting level
> - relax the BUG() on num_regs>32 to a WARN, given that nothing actually
>   breaks in that case
> 
>  arch/arm64/include/asm/fpsimd.h |  3 +
>  arch/arm64/kernel/fpsimd.c      | 77 ++++++++++++++------
>  2 files changed, 58 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index 50f559f574fe..ee09fe1c37b6 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -17,6 +17,7 @@
>  #define __ASM_FP_H
>  
>  #include <asm/ptrace.h>
> +#include <linux/spinlock.h>
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -37,6 +38,8 @@ struct fpsimd_state {
>  			u32 fpcr;
>  		};
>  	};
> +	/* lock protecting the preserved state while it is being saved */
> +	spinlock_t lock;
>  	/* the id of the last cpu to have restored this state */
>  	unsigned int cpu;
>  };
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 394c61db5566..886eea2d4084 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -160,6 +160,7 @@ void fpsimd_flush_thread(void)
>  	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
>  	fpsimd_flush_task_state(current);
>  	set_thread_flag(TIF_FOREIGN_FPSTATE);
> +	spin_lock_init(&current->thread.fpsimd_state.lock);
>  }
>  
>  /*
> @@ -220,45 +221,77 @@ void fpsimd_flush_task_state(struct task_struct *t)
>  
>  #ifdef CONFIG_KERNEL_MODE_NEON
>  
> -static DEFINE_PER_CPU(struct fpsimd_partial_state, hardirq_fpsimdstate);
> -static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);
> +/*
> + * Although unlikely, it is possible for three kernel mode NEON contexts to
> + * be live at the same time: process context, softirq context and hardirq
> + * context. So while the userland context is stashed in the thread's fpsimd
> + * state structure, we need two additional levels of storage.
> + */
> +static DEFINE_PER_CPU(struct fpsimd_partial_state, nested_fpsimdstate[2]);
> +static DEFINE_PER_CPU(int, kernel_neon_nesting_level);
>  
>  /*
>   * Kernel-side NEON support functions
>   */
>  void kernel_neon_begin_partial(u32 num_regs)
>  {
> -	if (in_interrupt()) {
> -		struct fpsimd_partial_state *s = this_cpu_ptr(
> -			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> +	struct fpsimd_partial_state *s;
> +	int level;
>  
> -		BUG_ON(num_regs > 32);
> -		fpsimd_save_partial_state(s, roundup(num_regs, 2));
> -	} else {
> +	preempt_disable();
> +
> +	/*
> +	 * Save the userland FPSIMD state if we have one and if we
> +	 * haven't done so already. Clear fpsimd_last_state to indicate
> +	 * that there is no longer userland FPSIMD state in the
> +	 * registers.
> +	 */
> +	if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE)) {
>  		/*
> -		 * Save the userland FPSIMD state if we have one and if we
> -		 * haven't done so already. Clear fpsimd_last_state to indicate
> -		 * that there is no longer userland FPSIMD state in the
> +		 * Whoever test-and-sets the TIF_FOREIGN_FPSTATE flag should
> +		 * preserve the userland FP/SIMD state without interruption by
> +		 * nested kernel_neon_begin()/_end() calls.
> +		 * The reason is that the FP/SIMD register file is shared with
> +		 * SVE on hardware that supports it, and nested kernel mode NEON
> +		 * calls do not restore the upper part of the shared SVE/SIMD
>  		 * registers.
>  		 */
> -		preempt_disable();
> -		if (current->mm &&
> -		    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> -			fpsimd_save_state(&current->thread.fpsimd_state);
> -		this_cpu_write(fpsimd_last_state, NULL);
> +		if (spin_trylock(&current->thread.fpsimd_state.lock)) {
> +			if (!test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> +				fpsimd_save_state(&current->thread.fpsimd_state);
> +			spin_unlock(&current->thread.fpsimd_state.lock);
> +		}
> +	}
> +	this_cpu_write(fpsimd_last_state, NULL);
> +
> +	level = this_cpu_inc_return(kernel_neon_nesting_level);
> +	BUG_ON(level > 3);
> +
> +	if (level > 1) {
> +		s = this_cpu_ptr(nested_fpsimdstate);
> +
> +		WARN_ON_ONCE(num_regs > 32);
> +		num_regs = min(roundup(num_regs, 2), 32U);
> +
> +		fpsimd_save_partial_state(&s[level - 2], num_regs);
>  	}
>  }
>  EXPORT_SYMBOL(kernel_neon_begin_partial);
>  
>  void kernel_neon_end(void)
>  {
> -	if (in_interrupt()) {
> -		struct fpsimd_partial_state *s = this_cpu_ptr(
> -			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> -		fpsimd_load_partial_state(s);
> -	} else {
> -		preempt_enable();
> +	struct fpsimd_partial_state *s;
> +	int level;
> +
> +	level = this_cpu_read(kernel_neon_nesting_level);
> +	BUG_ON(level < 1);
> +
> +	if (level > 1) {
> +		s = this_cpu_ptr(nested_fpsimdstate);
> +		fpsimd_load_partial_state(&s[level - 2]);
>  	}
> +	this_cpu_dec(kernel_neon_nesting_level);
> +	preempt_enable();
>  }
>  EXPORT_SYMBOL(kernel_neon_end);
>  
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
