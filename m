From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Dec 2016 15:50:55 +0000
Subject: [PATCH v2] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <1481105648-19775-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1481105648-19775-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161208155051.GA35383@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Wed, Dec 07, 2016 at 10:14:08AM +0000, Ard Biesheuvel wrote:
>  void kernel_neon_begin_partial(u32 num_regs)
>  {
> -	if (in_interrupt()) {
> -		struct fpsimd_partial_state *s = this_cpu_ptr(
> -			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> +	struct fpsimd_partial_state *s;
> +	int level;
> +
> +	preempt_disable();
> +
> +	level = this_cpu_read(kernel_neon_nesting_level);
> +	BUG_ON(level > 2);
> +
> +	if (level > 0) {
> +		s = this_cpu_ptr(nested_fpsimdstate);
>  
> -		BUG_ON(num_regs > 32);
> -		fpsimd_save_partial_state(s, roundup(num_regs, 2));
> +		WARN_ON_ONCE(num_regs > 32);
> +		num_regs = min(roundup(num_regs, 2), 32U);
> +
> +		fpsimd_save_partial_state(&s[level - 1], num_regs);
>  	} else {
>  		/*
>  		 * Save the userland FPSIMD state if we have one and if we
> @@ -241,24 +256,29 @@ void kernel_neon_begin_partial(u32 num_regs)
>  		 * that there is no longer userland FPSIMD state in the
>  		 * registers.
>  		 */
> -		preempt_disable();
>  		if (current->mm &&
>  		    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
>  			fpsimd_save_state(&current->thread.fpsimd_state);
>  		this_cpu_write(fpsimd_last_state, NULL);
>  	}
> +	this_cpu_write(kernel_neon_nesting_level, level + 1);
>  }

I'm slightly confused with the potential race with an interrupt here.
Let's say the above is running in the process context, sets the
TIF_FOREIGN_FPSTATE but is interrupted before fpsimd_save_state(). The
interrupt handler calling kernel_neon_begin_partial() is seeing level 0
and TIF_FOREIGN_FPSTATE and decides that it is safe to corrupt the Neon
state without any further saving.

I think the kernel_neon_nesting_level should be incremented early on in
this function.

-- 
Catalin
