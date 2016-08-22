From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Aug 2016 14:37:20 +0100
Subject: [PATCHv2] arm: l2x0: add PMU support
In-Reply-To: <1471602346-26466-1-git-send-email-mark.rutland@arm.com>
References: <1471602346-26466-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160822133720.GI14680@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 11:25:46AM +0100, Mark Rutland wrote:
> The L2C-220 (AKA L220) and L2C-310 (AKA PL310) cache controllers feature
> a Performance Monitoring Unit (PMU), which can be useful for tuning
> and/or debugging. This hardware is always present and the relevant
> registers are accessible to non-secure accesses. Thus, no special
> firmware interface is necessary.
> 
> This patch adds support for the PMU, plugging into the usual perf
> infrastructure. The overflow interrupt is not always available (e.g. on
> RealView PBX A9 it is not wired up at all), and the hardware counters
> saturate, so the driver does not make use of this. Instead, the driver
> periodically polls and reset counters as required to avoid losing
> events due to saturation.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Kim Phillips <kim.phillips@arm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/hardware/cache-l2x0.h |   9 +
>  arch/arm/mm/Kconfig                        |   7 +
>  arch/arm/mm/cache-l2x0.c                   | 554 +++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h                 |   1 +
>  4 files changed, 571 insertions(+)

[...]

> Since v1 [1]
> * Use relaxed IO accessors, per Russell's comment. From testing, this can save
>   3% overhead in an extreme case (idle system and trivial workload).
> * Add Kim's Tested-by.
> 
> Mark.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/449622.html
> 
> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> index 3a5ec1c..e476350 100644
> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> @@ -87,6 +87,15 @@
>  #define L310_CACHE_ID_RTL_R3P2		0x08
>  #define L310_CACHE_ID_RTL_R3P3		0x09
>  
> +#define L2X0_EVENT_CNT_CTRL_ENABLE	BIT(0)
> +
> +#define L2X0_EVENT_CNT_CFG_SRC_SHIFT	2
> +#define L2X0_EVENT_CNT_CFG_SRC_MASK	0xf
> +#define L2X0_EVENT_CNT_CFG_SRC_DISABLED	0
> +#define L2X0_EVENT_CNT_CFG_INT_DISABLED	0
> +#define L2X0_EVENT_CNT_CFG_INT_INCR	1
> +#define L2X0_EVENT_CNT_CFG_INT_OVERFLOW	2
> +
>  /* L2C auxiliary control register - bits common to L2C-210/220/310 */
>  #define L2C_AUX_CTRL_WAY_SIZE_SHIFT		17
>  #define L2C_AUX_CTRL_WAY_SIZE_MASK		(7 << 17)
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index d15a7fe..0e8cbac 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -916,6 +916,13 @@ config CACHE_L2X0
>  	help
>  	  This option enables the L2x0 PrimeCell.
>  
> +config CACHE_L2X0_PMU
> +	bool "L2x0 performance monitor support" if CACHE_L2X0
> +	depends on PERF_EVENTS
> +	help
> +	  This option enables support for the performance monitoring features
> +	  of the L220 and PL310 outer cache controllers.
> +
>  if CACHE_L2X0
>  
>  config PL310_ERRATA_588369
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index cc12905..8e1f008 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -18,9 +18,17 @@
>   */
>  #include <linux/cpu.h>
>  #include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/hrtimer.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/perf_event.h>
> +#include <linux/printk.h>
>  #include <linux/smp.h>
>  #include <linux/spinlock.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
>  #include <linux/log2.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> @@ -57,6 +65,14 @@ static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
>  
>  struct l2x0_regs l2x0_saved_regs;
>  
> +#ifdef CONFIG_CACHE_L2X0_PMU
> +static void l2x0_pmu_suspend(void);
> +static void l2x0_pmu_resume(void);
> +#else
> +static inline void l2x0_pmu_suspend(void) { }
> +static inline void l2x0_pmu_resume(void) { }
> +#endif
> +
>  /*
>   * Common code for all cache controllers.
>   */
> @@ -142,6 +158,8 @@ static void l2c_disable(void)
>  {
>  	void __iomem *base = l2x0_base;
>  
> +	l2x0_pmu_suspend();
> +
>  	outer_cache.flush_all();
>  	l2c_write_sec(0, base, L2X0_CTRL);
>  	dsb(st);
> @@ -159,6 +177,8 @@ static void l2c_resume(void)
>  	/* Do not touch the controller if already enabled. */
>  	if (!(readl_relaxed(base + L2X0_CTRL) & L2X0_CTRL_EN))
>  		l2c_enable(base, l2x0_data->num_lock);
> +
> +	l2x0_pmu_resume();
>  }
>  
>  /*
> @@ -1801,3 +1821,537 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
>  	return __l2c_init(data, aux_val, aux_mask, cache_id, nosync);
>  }
>  #endif
> +
> +#ifdef CONFIG_CACHE_L2X0_PMU
> +#define PMU_NR_COUNTERS 2
> +
> +static struct pmu *l2x0_pmu;
> +static cpumask_t pmu_cpu;
> +
> +static ktime_t l2x0_pmu_poll_period;
> +static struct hrtimer l2x0_pmu_hrtimer;
> +
> +/*
> + * The L220/PL310 PMU has two equivalent counters, Counter1 and Counter0.
> + * Registers controlling these are laid out in pairs, in descending order, i.e.
> + * the register for Counter1 comes first, followed by the register for
> + * Counter0.
> + * We ensure that idx 0 -> Counter0, and idx1 -> Counter1.
> + */
> +static struct perf_event *events[PMU_NR_COUNTERS];
> +
> +/* Find an unused counter */
> +static int l2x0_pmu_find_idx(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < PMU_NR_COUNTERS; i++) {
> +		if (!events[i])
> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
> +/* How many counters are allocated? */
> +static bool l2x0_pmu_num_active_counters(void)
> +{

I know you only have two counters, but using a bool here is perverse!

> +	int i, cnt = 0;
> +
> +	for (i = 0; i < PMU_NR_COUNTERS; i++) {
> +		if (events[i])
> +			cnt++;
> +	}
> +
> +	return cnt;
> +}

[...]

> +static __init int l2x0_pmu_register(void)
> +{
> +	int ret;
> +	const char *name;
> +
> +	if (!l2x0_base)
> +		return 0;
> +
> +	/* Only L220 and PL310 have a PMU */
> +	if (strcmp("L2C-220", l2x0_data->type) == 0)
> +		name = "l2c_220";
> +	if (strcmp("L2C-310", l2x0_data->type) == 0)
> +		name = "l2c_310";
> +	else
> +		return 0;

Turns out that the L210 *does* have a PMU, but it's quite different and
I don't think we should bother supporting it for now. Worth updating the
comment, though.

Will
