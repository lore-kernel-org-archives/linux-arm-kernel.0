From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Aug 2016 13:40:04 +0100
Subject: [PATCH v4 3/4] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1467877572-10817-3-git-send-email-oss@buserror.net>
References: <1467877572-10817-1-git-send-email-oss@buserror.net>
 <1467877572-10817-3-git-send-email-oss@buserror.net>
Message-ID: <20160826134004.7e86e798@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2016 02:46:11 -0500
Scott Wood <oss@buserror.net> wrote:

(+Mark)

> Erratum A-008585 says that the ARM generic timer counter "has the
> potential to contain an erroneous value for a small number of core
> clock cycles every time the timer value changes".  Accesses to TVAL
> (both read and write) are also affected due to the implicit counter
> read.  Accesses to CVAL are not affected.
> 
> The workaround is to reread TVAL and count registers until successive reads
> return the same value, and when writing TVAL to retry until counter
> reads before and after the write return the same value.
> 
> This erratum can be found on LS1043A and LS2080A.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
> v4:
> - Undef ARCH_TIMER_REG_READ after use
> 
> v3:
> - Used cval rather than a loop for the write side of the erratum
> - Added a Kconfig control
> - Moved the device tree binding into its own patch
> - Added erratum to silicon-errata.txt
> - Changed function names to contain the erratum name
> - Factored out the setting of erratum versions of set_next_event
>   to improve readability
> - Added a comment clarifying that the timeout is arbitrary
> 
> v2:
> Significant rework based on feedback, including using static_key,
> disabling VDSO counter access rather than adding the workaround to the
> VDSO, and uninlining the loops.
> 
> Dropped the separate property for indicating that writes to TVAL are
> affected, as I believe that's just a side effect of the implicit
> counter read being corrupted, and thus a chip that is affected by one
> will always be affected by the other.
> 
> Dropped the arm32 portion as it seems there was confusion about whether
> LS1021A is affected.  Currently I am being told that it is not
> affected.
> 
> I considered writing to CVAL rather than looping on TVAL writes, but
> that would still have required separate set_next_event() code for the
> erratum, and adding CVAL to the enum would have required a bunch of
> extra handlers in switch statements (even where unused, due to compiler
> warnings about unhandled enum values) including in an arm32 header.  It
> seemed better to avoid the arm32 interaction and new untested
> accessors.
> ---
>  Documentation/arm64/silicon-errata.txt |   2 +
>  arch/arm64/include/asm/arch_timer.h    |  50 +++++++++++++---
>  drivers/clocksource/Kconfig            |  10 ++++
>  drivers/clocksource/arm_arch_timer.c   | 103 +++++++++++++++++++++++++++++++++
>  4 files changed, 156 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 4da60b4..041e3a9 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -60,3 +60,5 @@ stable kernels.
>  | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456    |
>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A		       |
> +|                |                 |                 |                         |
> +| Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index fbe0ca3..927dc6f 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -23,10 +23,36 @@
>  
>  #include <linux/bug.h>
>  #include <linux/init.h>
> +#include <linux/jump_label.h>
>  #include <linux/types.h>
>  
>  #include <clocksource/arm_arch_timer.h>
>  
> +extern struct static_key_false arch_timer_read_ool_enabled;
> +
> +#define ARCH_TIMER_REG_READ(reg, func) \
> +extern u64 func##_ool(void); \
> +static inline u64 __##func(void) \
> +{ \
> +	u64 val; \
> +	asm volatile("mrs %0, " reg : "=r" (val)); \
> +	return val; \
> +} \
> +static inline u64 _##func(void) \
> +{ \
> +	if (IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) && \
> +	    static_branch_unlikely(&arch_timer_read_ool_enabled)) \
> +		return func##_ool(); \
> +	else \
> +		return __##func(); \
> +}
> +
> +ARCH_TIMER_REG_READ("cntp_tval_el0", arch_timer_get_ptval)
> +ARCH_TIMER_REG_READ("cntv_tval_el0", arch_timer_get_vtval)
> +ARCH_TIMER_REG_READ("cntvct_el0", arch_counter_get_cntvct)
> +
> +#undef ARCH_TIMER_REG_READ
> +
>  /*
>   * These register accessors are marked inline so the compiler can
>   * nicely work out which register we want, and chuck away the rest of
> @@ -58,6 +84,16 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
>  	isb();
>  }
>  
> +static __always_inline void arch_timer_cval_write_cp15(int access, u64 val)
> +{
> +	if (access == ARCH_TIMER_PHYS_ACCESS)
> +		asm volatile("msr cntp_cval_el0, %0" : : "r" (val));
> +	else if (access == ARCH_TIMER_VIRT_ACCESS)
> +		asm volatile("msr cntv_cval_el0, %0" : : "r" (val));
> +
> +	isb();
> +}
> +
>  static __always_inline
>  u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>  {
> @@ -66,19 +102,19 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>  	if (access == ARCH_TIMER_PHYS_ACCESS) {
>  		switch (reg) {
>  		case ARCH_TIMER_REG_CTRL:
> -			asm volatile("mrs %0,  cntp_ctl_el0" : "=r" (val));
> +			asm volatile("mrs %0, cntp_ctl_el0" : "=r" (val));

Spurious change?

>  			break;
>  		case ARCH_TIMER_REG_TVAL:
> -			asm volatile("mrs %0, cntp_tval_el0" : "=r" (val));
> +			val = _arch_timer_get_ptval();
>  			break;
>  		}
>  	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
>  		switch (reg) {
>  		case ARCH_TIMER_REG_CTRL:
> -			asm volatile("mrs %0,  cntv_ctl_el0" : "=r" (val));
> +			asm volatile("mrs %0, cntv_ctl_el0" : "=r" (val));

Here too?

>  			break;
>  		case ARCH_TIMER_REG_TVAL:
> -			asm volatile("mrs %0, cntv_tval_el0" : "=r" (val));
> +			val = _arch_timer_get_vtval();
>  			break;
>  		}
>  	}
> @@ -116,12 +152,8 @@ static inline u64 arch_counter_get_cntpct(void)
>  
>  static inline u64 arch_counter_get_cntvct(void)
>  {
> -	u64 cval;
> -
>  	isb();
> -	asm volatile("mrs %0, cntvct_el0" : "=r" (cval));
> -
> -	return cval;
> +	return _arch_counter_get_cntvct();
>  }
>  
>  static inline int arch_timer_arch_init(void)
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 47352d2..48c6039 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -223,6 +223,16 @@ config ARM_ARCH_TIMER_EVTSTREAM
>  	  This must be disabled for hardware validation purposes to detect any
>  	  hardware anomalies of missing events.
>  
> +config FSL_ERRATUM_A008585
> +	bool "Workaround for Freescale/NXP Erratum A-008585"
> +	default y
> +	depends on ARM_ARCH_TIMER && ARM64
> +	help
> +	  This option enables a workaround for Freescale/NXP Erratum
> +	  A-008585 ("ARM generic timer may contain an erroneous
> +	  value").  The workaround will only be active if the
> +	  fsl,erratum-a008585 property is found in the timer node.
> +
>  config ARM_GLOBAL_TIMER
>  	bool
>  	select CLKSRC_OF if OF
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 4814446..b857027 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -83,6 +83,51 @@ static bool arch_timer_mem_use_virtual;
>   * Architected system timer support.
>   */
>  
> +#ifdef CONFIG_FSL_ERRATUM_A008585
> +DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
> +EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
> +
> +/*
> + * __always_inline is used to ensure that func() is not an actual function
> + * pointer, which would result in the register accesses potentially being too
> + * far apart for the loop to work.
> + *
> + * The timeout is an arbitrary value well beyond the highest number
> + * of iterations the loop has been observed to take.
> + */
> +static __always_inline u64 fsl_a008585_reread_counter(u64 (*func)(void))
> +{
> +	u64 cval_old, cval_new;
> +	int timeout = 200;
> +
> +	do {
> +		isb();
> +		cval_old = func();
> +		cval_new = func();
> +		timeout--;
> +	} while (unlikely(cval_old != cval_new) && timeout);
> +
> +	WARN_ON_ONCE(!timeout);
> +	return cval_new;
> +}
> +
> +u64 arch_counter_get_cntvct_ool(void)
> +{
> +	return fsl_a008585_reread_counter(__arch_counter_get_cntvct);
> +}
> +
> +u64 arch_timer_get_vtval_ool(void)
> +{
> +	return fsl_a008585_reread_counter(__arch_timer_get_vtval);
> +}
> +
> +u64 arch_timer_get_ptval_ool(void)
> +{
> +	return fsl_a008585_reread_counter(__arch_timer_get_ptval);
> +}
> +
> +#endif /* CONFIG_FSL_ERRATUM_A008585 */
> +
>  static __always_inline
>  void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
>  			  struct clock_event_device *clk)
> @@ -232,6 +277,35 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
>  	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
>  }
>  
> +#ifdef CONFIG_FSL_ERRATUM_A008585
> +static __always_inline void fsl_a008585_set_next_event(const int access,
> +		unsigned long evt, struct clock_event_device *clk)
> +{
> +	unsigned long ctrl;
> +	u64 cval = evt + arch_counter_get_cntvct();
> +
> +	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
> +	ctrl |= ARCH_TIMER_CTRL_ENABLE;
> +	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
> +	arch_timer_cval_write_cp15(access, cval);
> +	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
> +}
> +
> +static int fsl_a008585_set_next_event_virt(unsigned long evt,
> +					   struct clock_event_device *clk)
> +{
> +	fsl_a008585_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
> +	return 0;
> +}
> +
> +static int fsl_a008585_set_next_event_phys(unsigned long evt,
> +					   struct clock_event_device *clk)
> +{
> +	fsl_a008585_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
> +	return 0;
> +}
> +#endif /* CONFIG_FSL_ERRATUM_A008585 */
> +
>  static int arch_timer_set_next_event_virt(unsigned long evt,
>  					  struct clock_event_device *clk)
>  {
> @@ -260,6 +334,19 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
>  	return 0;
>  }
>  
> +static void fsl_a008585_set_sne(struct clock_event_device *clk)
> +{
> +#ifdef CONFIG_FSL_ERRATUM_A008585
> +	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
> +		return;
> +
> +	if (arch_timer_uses_ppi == VIRT_PPI)
> +		clk->set_next_event = fsl_a008585_set_next_event_virt;
> +	else
> +		clk->set_next_event = fsl_a008585_set_next_event_phys;
> +#endif
> +}
> +
>  static void __arch_timer_setup(unsigned type,
>  			       struct clock_event_device *clk)
>  {
> @@ -288,6 +375,8 @@ static void __arch_timer_setup(unsigned type,
>  		default:
>  			BUG();
>  		}
> +
> +		fsl_a008585_set_sne(clk);
>  	} else {
>  		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
>  		clk->name = "arch_mem_timer";
> @@ -485,6 +574,15 @@ static void __init arch_counter_register(unsigned type)
>  			arch_timer_read_counter = arch_counter_get_cntvct;
>  		else
>  			arch_timer_read_counter = arch_counter_get_cntpct;
> +
> +#ifdef CONFIG_FSL_ERRATUM_A008585
> +		/*
> +		 * Don't use the vdso fastpath if errata require using
> +		 * the out-of-line counter accessor.
> +		 */
> +		if (static_branch_unlikely(&arch_timer_read_ool_enabled))
> +			clocksource_counter.name = "arch_sys_counter_ool";
> +#endif
>  	} else {
>  		arch_timer_read_counter = arch_counter_get_cntvct_mem;
>  
> @@ -766,6 +864,11 @@ static void __init arch_timer_of_init(struct device_node *np)
>  
>  	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
>  
> +#ifdef CONFIG_FSL_ERRATUM_A008585
> +	if (of_property_read_bool(np, "fsl,erratum-a008585"))
> +		static_branch_enable(&arch_timer_read_ool_enabled);
> +#endif
> +
>  	/*
>  	 * If we cannot rely on firmware initializing the timer registers then
>  	 * we should use the physical timers instead.


I'm still worried that this series doesn't address Xen or KVM guests
that need to be made aware of the broken timers.

At the very least, I'd like a kernel command line option that'd let the
user reliably run its VMs. You can do something along the lines of
46fd5c6b, and have a command line argument like
"clocksource.arm_arch_timer.fsl-a008585=1", which would enable the
workaround.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
