From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Oct 2017 16:14:10 +0100
Subject: [PATCH v3 1/2] arm_arch_timer: Expose event stream status
In-Reply-To: <1506682350-9023-2-git-send-email-julien.thierry@arm.com>
References: <1506682350-9023-1-git-send-email-julien.thierry@arm.com>
 <1506682350-9023-2-git-send-email-julien.thierry@arm.com>
Message-ID: <20171011151409.GB14341@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On Fri, Sep 29, 2017 at 11:52:29AM +0100, Julien Thierry wrote:
> The arch timer configuration for a CPU might get reset after suspending
> said CPU.
> 
> In order to reliably use the event stream in the kernel (e.g. for delays),
> we keep track of the state where we can safely concider the event stream as
> properly configured.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/arch_timer.h    |  1 +
>  arch/arm64/include/asm/arch_timer.h  |  1 +
>  drivers/clocksource/arm_arch_timer.c | 20 ++++++++++++++++++--
>  include/clocksource/arm_arch_timer.h |  6 ++++++
>  4 files changed, 26 insertions(+), 2 deletions(-)

The arch-timer bits needs an ack from Marc or Mark.

> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index d4ebf56..0b6e104 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -106,6 +106,7 @@ static inline u32 arch_timer_get_cntkctl(void)
>  static inline void arch_timer_set_cntkctl(u32 cntkctl)
>  {
>  	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
> +	isb();
>  }
> 
>  #endif
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index a652ce0..bdedd8f 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -144,6 +144,7 @@ static inline u32 arch_timer_get_cntkctl(void)
>  static inline void arch_timer_set_cntkctl(u32 cntkctl)
>  {
>  	write_sysreg(cntkctl, cntkctl_el1);
> +	isb();
>  }
> 
>  static inline u64 arch_counter_get_cntpct(void)
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index fd4b7f6..47cf15e 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -77,6 +77,7 @@ struct arch_timer {
>  static bool arch_counter_suspend_stop;
>  static bool vdso_default = true;
> 
> +static cpumask_t evtstrm_available;
>  static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
> 
>  static int __init early_evtstrm_cfg(char *buf)
> @@ -740,6 +741,7 @@ static void arch_timer_evtstrm_enable(int divider)
>  #ifdef CONFIG_COMPAT
>  	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
>  #endif
> +	cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
>  }
> 
>  static void arch_timer_configure_evtstream(void)
> @@ -864,6 +866,11 @@ u32 arch_timer_get_rate(void)
>  	return arch_timer_rate;
>  }
> 
> +bool arch_timer_evtstrm_available(void)
> +{
> +	return !!cpumask_test_cpu(smp_processor_id(), &evtstrm_available);
> +}

I don't think you need the '!!' prefix here.

> +
>  static u64 arch_counter_get_cntvct_mem(void)
>  {
>  	u32 vct_lo, vct_hi, tmp_hi;
> @@ -929,6 +936,8 @@ static int arch_timer_dying_cpu(unsigned int cpu)
>  {
>  	struct clock_event_device *clk = this_cpu_ptr(arch_timer_evt);
> 
> +	cpumask_clear_cpu(smp_processor_id(), &evtstrm_available);
> +
>  	arch_timer_stop(clk);
>  	return 0;
>  }
> @@ -938,10 +947,16 @@ static int arch_timer_dying_cpu(unsigned int cpu)
>  static int arch_timer_cpu_pm_notify(struct notifier_block *self,
>  				    unsigned long action, void *hcpu)
>  {
> -	if (action == CPU_PM_ENTER)
> +	if (action == CPU_PM_ENTER) {
>  		__this_cpu_write(saved_cntkctl, arch_timer_get_cntkctl());
> -	else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT)
> +
> +		cpumask_clear_cpu(smp_processor_id(), &evtstrm_available);
> +	} else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT) {
>  		arch_timer_set_cntkctl(__this_cpu_read(saved_cntkctl));
> +
> +		if (elf_hwcap & HWCAP_EVTSTRM)
> +			cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
> +	}
>  	return NOTIFY_OK;
>  }
> 
> @@ -1017,6 +1032,7 @@ static int __init arch_timer_register(void)
>  	if (err)
>  		goto out_unreg_notify;
> 
> +	cpumask_clear(&evtstrm_available);

This should already be ok by virtue of the mask being static, no?
Alternatively, you could use the CPU_MASK_NONE static initialiser.

Will
