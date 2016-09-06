From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 6 Sep 2016 18:31:39 +0100
Subject: [PATCH v2 4/7] arm64: Disable TTBR0_EL1 during normal kernel
 execution
In-Reply-To: <1472828533-28197-5-git-send-email-catalin.marinas@arm.com>
References: <1472828533-28197-1-git-send-email-catalin.marinas@arm.com>
 <1472828533-28197-5-git-send-email-catalin.marinas@arm.com>
Message-ID: <20160906173139.GA13934@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

This generally looks fine, and my comments below are mostly nits. :)

On Fri, Sep 02, 2016 at 04:02:10PM +0100, Catalin Marinas wrote:
>  static inline void
> -switch_mm(struct mm_struct *prev, struct mm_struct *next,
> -	  struct task_struct *tsk)
> +__switch_mm(struct mm_struct *prev, struct mm_struct *next,
> +	    struct task_struct *tsk)

It looks like the comment above this function is now out-of-date, and
has been somewhat misleading for a while. While we're making changes
here, can we remove it entirely?

[...]

> @@ -109,6 +111,34 @@
>  	mrs	x22, elr_el1
>  	mrs	x23, spsr_el1
>  	stp	lr, x21, [sp, #S_LR]
> +
> +#ifdef CONFIG_ARM64_TTBR0_PAN
> +	/*
> +	 * Set the TTBR0 PAN in SPSR. When the exception is taken from EL0,
> +	 * there is no need to check the state of TTBR0_EL1 since accesses are
> +	 * always enabled.

Nit: missing 'bit' from the first sentence?

[...]

> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 536dce22fe76..4a4aaa47f869 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -228,6 +228,14 @@ void __init setup_arch(char **cmdline_p)
>  {
>  	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
>  
> +#ifdef CONFIG_ARM64_TTBR0_PAN
> +	/*
> +	 * uaccess_enable() may be called on the init thread, so make sure
> +	 * the saved TTBR0_EL1 always generates translation faults.
> +	 */
> +	init_thread_info.ttbr0 = virt_to_phys(empty_zero_page);
> +#endif

Just to check, does this need to happen so early? e.g. do we need this
to report exceptions safely? Otherwise, it would be nice if we could
group this with the uninstall of the idmap a little later in setup_arch.

Thanks,
Mark.
