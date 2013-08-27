From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 27 Aug 2013 12:19:05 +0100
Subject: [PATCH v4 3/5] ARM64: arch_timer: add support to configure and
 enable event stream
In-Reply-To: <1377274749-6196-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1377274749-6196-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1377274749-6196-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <20130827111905.GF19897@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 05:19:07PM +0100, Sudeep KarkadaNagesha wrote:
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 00b09d0..0f57158 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -97,21 +97,53 @@ static inline u32 arch_timer_get_cntfrq(void)
>  	return val;
>  }
>  
> -static inline void arch_counter_set_user_access(void)
> +static inline u32 arch_timer_get_cntkctl(void)
>  {
>  	u32 cntkctl;
> -
>  	asm volatile("mrs	%0, cntkctl_el1" : "=r" (cntkctl));
> +	return cntkctl;
> +}
> +
> +static inline void arch_timer_set_cntkctl(u32 cntkctl)
> +{
> +	asm volatile("msr	cntkctl_el1, %0" : : "r" (cntkctl));
> +}
> +
> +static inline void arch_counter_set_user_access(void)
> +{
> +	u32 cntkctl = arch_timer_get_cntkctl();
>  
>  	/* Disable user access to the timers and the physical counter. */
>  	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
>  			| ARCH_TIMER_USR_VT_ACCESS_EN
>  			| ARCH_TIMER_USR_PCT_ACCESS_EN);
>  
> -	/* Enable user access to the virtual counter. */
> +	/* Enable user access to the virtual counter */

This change isn't needed here. Just move it to the first patch which
adds the comment.

>  	cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
>  
> -	asm volatile("msr	cntkctl_el1, %0" : : "r" (cntkctl));
> +	arch_timer_set_cntkctl(cntkctl);
> +}
> +
> +static inline void arch_timer_evtstrm_config(bool enable, int divider)
> +{
> +	u32 cntkctl = arch_timer_get_cntkctl();
> +	if (enable) {
> +		cntkctl &= ~ARCH_TIMER_EVT_TRIGGER_MASK;
> +		/* Set the divider and enable virtual event stream */
> +		cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
> +				| ARCH_TIMER_VIRT_EVT_EN;
> +	} else {
> +		cntkctl &= ~ARCH_TIMER_VIRT_EVT_EN; /* disable event stream */
> +	}
> +	arch_timer_set_cntkctl(cntkctl);
> +}
> +
> +static inline void arch_timer_set_hwcap_evtstrm(void)
> +{
> +	elf_hwcap |= HWCAP_EVTSTRM;
> +#ifdef CONFIG_COMPAT
> +	compat_dyn_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
> +#endif
>  }
>  
>  static inline u64 arch_counter_get_cntvct(void)
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 6d4482f..022d771 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -30,6 +30,7 @@
>  #define COMPAT_HWCAP_IDIVA	(1 << 17)
>  #define COMPAT_HWCAP_IDIVT	(1 << 18)
>  #define COMPAT_HWCAP_IDIV	(COMPAT_HWCAP_IDIVA|COMPAT_HWCAP_IDIVT)
> +#define COMPAT_HWCAP_EVTSTRM	(1 << 21)
>  
>  #ifndef __ASSEMBLY__
>  /*
> @@ -37,11 +38,15 @@
>   * instruction set this cpu supports.
>   */
>  #define ELF_HWCAP		(elf_hwcap)
> +#ifdef CONFIG_COMPAT
>  #define COMPAT_ELF_HWCAP	(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
>  				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
>  				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_VFP|\
>  				 COMPAT_HWCAP_VFPv3|COMPAT_HWCAP_VFPv4|\
> -				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV)
> +				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV|\
> +				 compat_dyn_elf_hwcap)
> +extern unsigned int compat_dyn_elf_hwcap;
> +#endif

Can we just have a compat_elf_hwcap which is initialised to all the
above and avoid compat_dyn_elf_hwcap?

-- 
Catalin
