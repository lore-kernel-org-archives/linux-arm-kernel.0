From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Feb 2014 14:25:15 +0000
Subject: [PATCH v2 1/4] arm64: add abstractions for FPSIMD state
 manipulation
In-Reply-To: <1391620418-3999-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1391620418-3999-1-git-send-email-ard.biesheuvel@linaro.org>
 <1391620418-3999-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140221142515.GC25351@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 05:13:35PM +0000, Ard Biesheuvel wrote:
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 4aef42a04bdc..eeb003f54ad0 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -34,6 +34,10 @@
>  #define FPEXC_IXF	(1 << 4)
>  #define FPEXC_IDF	(1 << 7)
>  
> +/* defined in entry-fpsimd.S but only used in this unit */
> +void fpsimd_save_state(struct fpsimd_state *state);
> +void fpsimd_load_state(struct fpsimd_state *state);

This functions still make sense for some situations where
fpsimd_get_task_state() is confusing.

> +
>  /*
>   * Trapped FP/ASIMD access.
>   */
> @@ -87,6 +91,33 @@ void fpsimd_flush_thread(void)
>  	preempt_enable();
>  }
>  
> +/*
> + * Sync the saved FPSIMD context with the FPSIMD register file
> + */
> +struct fpsimd_state *fpsimd_get_task_state(void)
> +{
> +	fpsimd_save_state(&current->thread.fpsimd_state);
> +	return &current->thread.fpsimd_state;
> +}
> +
> +/*
> + * Load a new FPSIMD state into the FPSIMD register file.
> + */
> +void fpsimd_set_task_state(struct fpsimd_state *state)
> +{
> +	fpsimd_load_state(state);
> +}

Maybe s/task/current/. But in general I see a "get" function as not
having side-effects while here it populates the fpsimd_state. I don't
think the code gets clearer.

> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 1c0a9be2ffa8..bfa8214f92d1 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -199,7 +199,7 @@ void release_thread(struct task_struct *dead_task)
>  
>  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  {
> -	fpsimd_save_state(&current->thread.fpsimd_state);
> +	fpsimd_get_task_state();

That's where get vs save looks strange to me.

> @@ -746,24 +745,29 @@ static int compat_vfp_set(struct task_struct *target,
>  			  unsigned int pos, unsigned int count,
>  			  const void *kbuf, const void __user *ubuf)
>  {
> -	struct user_fpsimd_state *uregs;
> +	struct user_fpsimd_state newstate;
>  	compat_ulong_t fpscr;
>  	int ret;
>  
>  	if (pos + count > VFP_STATE_SIZE)
>  		return -EIO;
>  
> -	uregs = &target->thread.fpsimd_state.user_fpsimd;
> +	/*
> +	 * We will not overwrite the entire FPSIMD state, so we need to
> +	 * initialize 'newstate' with sane values.
> +	 */
> +	newstate = *fpsimd_get_user_state(target);
>  
> -	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, uregs, 0,
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newstate, 0,
>  				 VFP_STATE_SIZE - sizeof(compat_ulong_t));
>  
>  	if (count && !ret) {
>  		ret = get_user(fpscr, (compat_ulong_t *)ubuf);
> -		uregs->fpsr = fpscr & VFP_FPSCR_STAT_MASK;
> -		uregs->fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
> +		newstate.fpsr = fpscr & VFP_FPSCR_STAT_MASK;
> +		newstate.fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
>  	}
>  
> +	fpsimd_set_user_state(target, &newstate);
>  	return ret;
>  }

What's the reason for this change? The patch is aimed at adding
abstractions but it does some more. Now you save half KB on the stack as
user_fpsimd_state. What if at some point we grow this structure?

-- 
Catalin
