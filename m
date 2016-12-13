From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 13 Dec 2016 11:11:20 +0000
Subject: [PATCH v5] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <1481565387-8039-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1481565387-8039-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161213111120.GF1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2016 at 05:56:27PM +0000, Ard Biesheuvel wrote:
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
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/fpsimd.c | 64 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 394c61db5566..c19363775436 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -220,45 +220,73 @@ void fpsimd_flush_task_state(struct task_struct *t)
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
> +	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
>  		/*
>  		 * Save the userland FPSIMD state if we have one and if we
>  		 * haven't done so already. Clear fpsimd_last_state to indicate
>  		 * that there is no longer userland FPSIMD state in the
>  		 * registers.
>  		 */
> -		preempt_disable();
> -		if (current->mm &&
> -		    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> -			fpsimd_save_state(&current->thread.fpsimd_state);
> +		if (current->mm) {
> +			unsigned long flags;
> +
> +			local_irq_save(flags);

For non-SVE hardware (i.e., all hardware for now), this raises mean IRQ
latency if KERNEL_MODE_NEON is used, to fix a bug that doesn't exist.

For SVE hardware, we would be disabling interrupts around typically a
few KB of stores.  I don't know what the actual hardware numbers would
look like, but this feels like a disproportionate cost to the problem
being solved...

After all, why do this here...

> +			if (!test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> +				fpsimd_save_state(&current->thread.fpsimd_state);
> +			local_irq_restore(flags);
> +		} else {
> +			set_thread_flag(TIF_FOREIGN_FPSTATE);
> +		}
>  		this_cpu_write(fpsimd_last_state, NULL);
>  	}
> +
> +	level = this_cpu_inc_return(kernel_neon_nesting_level);

...and yet go to all this trouble to avoid disabling IRQs for a _nested_
kernel_neon_begin()?


Did I miss something, or does increasing the count around the outermost
case too without IRQ disabling not work, in the non-SVE case?

Cheers
---Dave

> +	BUG_ON(level > 3);
> +
> +	if (level > 1) {
> +		s = this_cpu_ptr(nested_fpsimdstate);
> +
> +		WARN_ON_ONCE(num_regs > 32);
> +		num_regs = min(roundup(num_regs, 2), 32U);
> +
> +		fpsimd_save_partial_state(&s[level - 2], num_regs);
> +	}
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
