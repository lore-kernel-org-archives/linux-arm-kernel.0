From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Dec 2010 22:55:55 +0000
Subject: [PATCH] ARM: S5PV310: Implement kernel timers using MCT
In-Reply-To: <1293017221-31037-1-git-send-email-kgene.kim@samsung.com>
References: <1293017221-31037-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20101222225555.GH14693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 22, 2010 at 08:27:01PM +0900, Kukjin Kim wrote:
> From: Changhwan Youn <chaos.youn@samsung.com>
> 
> The Multi-Core Timer(MCT) of S5PV310 is designed for implementing
> clock source timer and clock event timers. This patch implements
> 1 clock source timer with 64 bit free running counter of MCT and
> 2 clock event timers with two of 31-bit tick counters.
> 
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv310/Kconfig                 |    7 +
>  arch/arm/mach-s5pv310/Makefile                |    8 +-
>  arch/arm/mach-s5pv310/include/mach/regs-mct.h |   47 ++++
>  arch/arm/mach-s5pv310/mct.c                   |  365 +++++++++++++++++++++++++
>  4 files changed, 426 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-mct.h
>  create mode 100644 arch/arm/mach-s5pv310/mct.c
> 
> diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
> index e0cef3f..02d7b4d 100644
> --- a/arch/arm/mach-s5pv310/Kconfig
> +++ b/arch/arm/mach-s5pv310/Kconfig
> @@ -14,6 +14,13 @@ config CPU_S5PV310
>  	help
>  	  Enable S5PV310 CPU support
>  
> +config S5PV310_MCT
> +	bool "Kernel timer support by MCT"
> +	depends on !LOCAL_TIMERS
> +	help
> +	  Use MCT (Multi Core Timer) as kernel timers
> +	  NOTE: Can not choose this with LOCAL_TIMERS
> +
>  config S5PV310_DEV_PD
>  	bool
>  	help
> diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
> index e310609..08158e3 100644
> --- a/arch/arm/mach-s5pv310/Makefile
> +++ b/arch/arm/mach-s5pv310/Makefile
> @@ -13,7 +13,13 @@ obj-				:=
>  # Core support for S5PV310 system
>  
>  obj-$(CONFIG_CPU_S5PV310)	+= cpu.o init.o clock.o irq-combiner.o
> -obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o gpiolib.o irq-eint.o
> +obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o gpiolib.o irq-eint.o
> +
> +ifeq ($(CONFIG_S5PV310_MCT),y)
> +obj-y				+= mct.o
> +else
> +obj-y				+= time.o
> +endif
>  
>  obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
>  obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
> diff --git a/arch/arm/mach-s5pv310/include/mach/regs-mct.h b/arch/arm/mach-s5pv310/include/mach/regs-mct.h
> new file mode 100644
> index 0000000..1480e2a
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/include/mach/regs-mct.h
> @@ -0,0 +1,47 @@
> +/* arch/arm/mach-s5pv310/include/mach/regs-mct.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * S5PV310 MCT(Multi-Core Timer) configutation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_REGS_MCT_H
> +#define __ASM_ARCH_REGS_MCT_H __FILE__
> +
> +#include <mach/map.h>
> +
> +#define S5PV310_MCTREG(x)		(S5P_VA_SYSTIMER + (x))
> +
> +#define S5PV310_MCT_G_CNT_L		S5PV310_MCTREG(0x100)
> +#define S5PV310_MCT_G_CNT_U		S5PV310_MCTREG(0x104)
> +#define S5PV310_MCT_G_CNT_WSTAT		S5PV310_MCTREG(0x110)
> +
> +#define S5PV310_MCT_G_TCON		S5PV310_MCTREG(0x240)
> +
> +#define S5PV310_MCT_G_WSTAT		S5PV310_MCTREG(0x24C)
> +
> +#define S5PV310_MCT_L0_TCNTB		S5PV310_MCTREG(0x300)
> +#define S5PV310_MCT_L0_ICNTB		S5PV310_MCTREG(0x308)
> +#define S5PV310_MCT_L0_TCON		S5PV310_MCTREG(0x320)
> +
> +#define S5PV310_MCT_L0_INT_CSTAT	S5PV310_MCTREG(0x330)
> +#define S5PV310_MCT_L0_INT_ENB		S5PV310_MCTREG(0x334)
> +#define S5PV310_MCT_L0_WSTAT		S5PV310_MCTREG(0x340)
> +
> +#define S5PV310_MCT_L1_TCNTB		S5PV310_MCTREG(0x400)
> +#define S5PV310_MCT_L1_ICNTB		S5PV310_MCTREG(0x408)
> +#define S5PV310_MCT_L1_TCON		S5PV310_MCTREG(0x420)
> +#define S5PV310_MCT_L1_INT_CSTAT	S5PV310_MCTREG(0x430)
> +#define S5PV310_MCT_L1_INT_ENB		S5PV310_MCTREG(0x434)
> +#define S5PV310_MCT_L1_WSTAT		S5PV310_MCTREG(0x440)
> +
> +#define MCT_L_TCON_INTERVAL_MODE	(1 << 2)
> +#define MCT_L_TCON_INT_START		(1 << 1)
> +#define MCT_L_TCON_TIMER_START		(1 << 0)
> +
> +#endif /* __ASM_ARCH_REGS_MCT_H */
> diff --git a/arch/arm/mach-s5pv310/mct.c b/arch/arm/mach-s5pv310/mct.c
> new file mode 100644
> index 0000000..2fe189c
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/mct.c
> @@ -0,0 +1,365 @@
> +/* linux/arch/arm/mach-s5pv310/mct.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * S5PV310 MCT(Multi-Core Timer) support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/sched.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +
> +#include <mach/map.h>
> +#include <mach/regs-mct.h>
> +#include <asm/mach/time.h>
> +
> +static unsigned long clk_cnt_per_tick;
> +static unsigned long clk_rate;
> +
> +enum mct_tick_type {
> +	MCT_TICK0,
> +	MCT_TICK1,
> +};
> +
> +static void s5pv310_mct_write(unsigned int value, void *addr)
> +{
> +	void __iomem *stat_addr;
> +	u32 mask;
> +	u32 i;
> +
> +	__raw_writel(value, addr);
> +
> +	switch ((u32) addr) {
> +	case (u32) S5PV310_MCT_G_TCON:
> +		stat_addr = S5PV310_MCT_G_WSTAT;
> +		mask = 1 << 16;		/* G_WSTAT_TCON_STAT */
> +		break;
> +
> +	case (u32) S5PV310_MCT_G_CNT_L:
> +		stat_addr = S5PV310_MCT_G_CNT_WSTAT;
> +		mask = 1 << 0;		/* G_CNT_L_STAT */
> +		break;
> +
> +	case (u32) S5PV310_MCT_G_CNT_U:
> +		stat_addr = S5PV310_MCT_G_CNT_WSTAT;
> +		mask = 1 << 1;		/* G_CNT_U_STAT */
> +		break;
> +
> +	case (u32) S5PV310_MCT_L0_TCON:
> +		stat_addr = S5PV310_MCT_L0_WSTAT;
> +		mask = 1 << 3;		/* L_TCON_STAT */
> +		break;
> +
> +	case (u32) S5PV310_MCT_L1_TCON:
> +		stat_addr = S5PV310_MCT_L1_WSTAT;
> +		mask = 1 << 3;		/* L_TCON_STAT */
> +		break;
> +
> +	case (u32) S5PV310_MCT_L0_TCNTB:
> +		stat_addr = S5PV310_MCT_L0_WSTAT;
> +		mask = 1 << 0;		/* L_TCNTB_STAT	*/
> +		break;
> +
> +	case (u32) S5PV310_MCT_L1_TCNTB:
> +		stat_addr = S5PV310_MCT_L1_WSTAT;
> +		mask = 1 << 0;		/* L_TCNTB_STAT	*/
> +		break;
> +
> +	case (u32) S5PV310_MCT_L0_ICNTB:
> +		stat_addr = S5PV310_MCT_L0_WSTAT;
> +		mask = 1 << 1;		/* L_ICNTB_STAT */
> +		break;
> +
> +	case (u32) S5PV310_MCT_L1_ICNTB:
> +		stat_addr = S5PV310_MCT_L1_WSTAT;
> +		mask = 1 << 1;		/* L_ICNTB_STAT */
> +		break;
> +
> +	default:
> +		return;
> +	}
> +
> +	/* Wait maximum 1 ms until written values are applied */
> +	for (i = 0; i < loops_per_jiffy / 1000 * HZ; i++)
> +		if (__raw_readl(stat_addr) & mask) {
> +			__raw_writel(mask, stat_addr);
> +			return;
> +		}
> +
> +	panic("MCT hangs after writing %d (addr:0x%08x)\n", value, (u32)addr);
> +}
> +
> +static void s5pv310_mct_tick_stop(enum mct_tick_type type)
> +{
> +	unsigned long tmp;
> +	void __iomem *addr;
> +
> +	if (type == MCT_TICK0)
> +		addr = S5PV310_MCT_L0_TCON;
> +	else
> +		addr = S5PV310_MCT_L1_TCON;
> +
> +	tmp = __raw_readl(addr);
> +	tmp &= ~(MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START);
> +	s5pv310_mct_write(tmp, addr);
> +}
> +
> +static void s5pv310_mct_tick_start(enum mct_tick_type type,
> +				   unsigned long cycles)
> +{
> +	unsigned long tmp;
> +	unsigned int tmp1, tmp2;
> +	void __iomem *addr;
> +
> +	s5pv310_mct_tick_stop(type);
> +
> +	tmp1 = (1 << 31) | cycles;	/* MCT_L_UPDATE_ICNTB */
> +	tmp2 = 1 << 0;			/* L_INT_ENB_CNTIE */
> +
> +	if (type == MCT_TICK0) {
> +		s5pv310_mct_write(tmp1, S5PV310_MCT_L0_ICNTB);
> +		s5pv310_mct_write(tmp2, S5PV310_MCT_L0_INT_ENB);
> +
> +		addr = S5PV310_MCT_L0_TCON;
> +	} else {
> +		s5pv310_mct_write(tmp1, S5PV310_MCT_L1_ICNTB);
> +		s5pv310_mct_write(tmp2, S5PV310_MCT_L1_INT_ENB);
> +
> +		addr = S5PV310_MCT_L1_TCON;
> +	}
> +
> +	tmp = __raw_readl(addr);
> +	tmp |= MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START |
> +	       MCT_L_TCON_INTERVAL_MODE;
> +	s5pv310_mct_write(tmp, addr);
> +}
> +
> +static inline int s5pv310_tick_set_next_event(enum mct_tick_type type,
> +					      unsigned long cycles)
> +{
> +	s5pv310_mct_tick_start(type, cycles);
> +
> +	return 0;
> +}
> +
> +static inline void s5pv310_tick_set_mode(enum mct_tick_type type,
> +					 enum clock_event_mode mode)
> +{
> +	s5pv310_mct_tick_stop(type);
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		s5pv310_mct_tick_start(type, clk_cnt_per_tick);
> +		break;
> +
> +	case CLOCK_EVT_MODE_ONESHOT:
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +	case CLOCK_EVT_MODE_RESUME:
> +		break;
> +	}
> +}
> +
> +static int s5pv310_tick0_set_next_event(unsigned long cycles,
> +					struct clock_event_device *evt)
> +{
> +	return s5pv310_tick_set_next_event(MCT_TICK0, cycles);
> +}
> +
> +static int s5pv310_tick1_set_next_event(unsigned long cycles,
> +					struct clock_event_device *evt)
> +{
> +	return s5pv310_tick_set_next_event(MCT_TICK1, cycles);
> +}
> +
> +static void s5pv310_tick0_set_mode(enum clock_event_mode mode,
> +				   struct clock_event_device *evt)
> +{
> +	s5pv310_tick_set_mode(MCT_TICK0, mode);
> +}
> +
> +static void s5pv310_tick1_set_mode(enum clock_event_mode mode,
> +				   struct clock_event_device *evt)
> +{
> +	s5pv310_tick_set_mode(MCT_TICK1, mode);
> +}
> +
> +static struct clock_event_device mct_tick0_device = {
> +	.name		= "mct-tick0",
> +	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +	.rating		= 450,
> +	.shift		= 20,
> +	.set_next_event	= s5pv310_tick0_set_next_event,
> +	.set_mode	= s5pv310_tick0_set_mode,
> +};
> +
> +static struct clock_event_device mct_tick1_device = {
> +	.name		= "mct-tick1",
> +	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +	.rating		= 450,
> +	.shift		= 20,
> +	.set_next_event	= s5pv310_tick1_set_next_event,
> +	.set_mode	= s5pv310_tick1_set_mode,
> +};
> +
> +irqreturn_t s5pv310_mct0_event_isr(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt;
> +
> +	/* Clear the MCT tick interrupt */
> +
> +	evt = &mct_tick0_device;
> +	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
> +		s5pv310_mct_tick_stop(MCT_TICK0);
> +
> +	s5pv310_mct_write(0x1, S5PV310_MCT_L0_INT_CSTAT);
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t s5pv310_mct1_event_isr(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt;
> +
> +	/* Clear the MCT tick interrupt */
> +
> +	evt = &mct_tick1_device;
> +
> +	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
> +		s5pv310_mct_tick_stop(MCT_TICK1);
> +
> +	s5pv310_mct_write(0x1, S5PV310_MCT_L1_INT_CSTAT);
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction mct_tick0_event_irq = {
> +	.name		= "mct_tick0_irq",
> +	.flags		= IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
> +	.handler	= s5pv310_mct0_event_isr,
> +};
> +
> +static struct irqaction mct_tick1_event_irq = {
> +	.name		= "mct_tick1_irq",
> +	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
> +	.handler	= s5pv310_mct1_event_isr,
> +};
> +
> +static void s5pv310_mct_clockevent_init(struct clock_event_device *dev)
> +{
> +	dev->mult = div_sc(clk_rate / 2, NSEC_PER_SEC, dev->shift);

Best use the helper function to calculate both the multipler and shift,
rather than hard-coding the shift.  As the shift is defined to be '20'
I guess this was copied rather than calculated for the optimal value.

> +
> +	dev->max_delta_ns = clockevent_delta2ns(0xfffffff, dev);
> +	dev->min_delta_ns = clockevent_delta2ns(0xf, dev);
> +}
> +
> +static void __init s5pv310_clockevent0_init(void)
> +{
> +	clk_cnt_per_tick = clk_rate / 2 / HZ;
> +
> +	s5pv310_mct_write(0x1, S5PV310_MCT_L0_TCNTB);
> +	s5pv310_mct_clockevent_init(&mct_tick0_device);
> +	mct_tick0_device.cpumask = cpumask_of(0);
> +	clockevents_register_device(&mct_tick0_device);
> +
> +	setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
> +}
> +
> +static void __init s5pv310_clockevent1_init(void *info)
> +{
> +	s5pv310_mct_write(0x1, S5PV310_MCT_L1_TCNTB);
> +	s5pv310_mct_clockevent_init(&mct_tick1_device);
> +	mct_tick1_device.cpumask = cpumask_of(1);
> +	clockevents_register_device(&mct_tick1_device);
> +
> +	irq_set_affinity(IRQ_MCT1, cpumask_of(1));
> +	setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);

This looks like it's supporting SMP - is there some reason not to use
the localtimer support built into SMP, which also supports hotplug CPU
(the above doesn't because the local clockevents will be automatically
unregistered.)

If you don't have a global timer, then register your boot CPU's clock
event timer as the global timer for the time being - the SMP code needs
tweaking so that a local timer can be registered early for those without
global timers.  Until then, if you have a global timer, I strongly
suggest you register that as a clock event too (it'll automatically
get shutdown when not needed.)

> +}
> +
> +static void s5pv310_mct_frc_start(unsigned int hi, unsigned int lo)
> +{
> +	unsigned int tmp;
> +
> +	s5pv310_mct_write(lo, S5PV310_MCT_G_CNT_L);
> +	s5pv310_mct_write(hi, S5PV310_MCT_G_CNT_U);
> +
> +	tmp = __raw_readl(S5PV310_MCT_G_TCON);
> +	tmp |= (1 << 8);	/* G_TCON_START */
> +	s5pv310_mct_write(tmp, S5PV310_MCT_G_TCON);
> +}
> +
> +/* Clocksource handling */
> +
> +static cycle_t s5pv310_frc_read(struct clocksource *cs)
> +{
> +	unsigned int lo, hi0, hi1;
> +
> +	hi0 = __raw_readl(S5PV310_MCT_G_CNT_U);
> +	lo = __raw_readl(S5PV310_MCT_G_CNT_L);
> +	dsb();
> +	hi1 = __raw_readl(S5PV310_MCT_G_CNT_U);
> +
> +	if (hi0 != hi1) {
> +		lo = __raw_readl(S5PV310_MCT_G_CNT_L);
> +		hi1 = __raw_readl(S5PV310_MCT_G_CNT_U);
> +	}

Are you sure this is safe?  Would it not be better to do this as:

	hi1 = __raw_readl(S5PV310_MCT_G_CNT_U);
	do {
		hi0 = hi1;
		lo = __raw_readl(S5PV310_MCT_G_CNT_L);
		hi1 = __raw_readl(S5PV310_MCT_G_CNT_U);
	} while (hi0 != hi1);

Note that I don't believe you need a dsb() in there either, as device
accesses are ordered with respect to themselves.  I know it's highly
unlikely that we'll see two updates, but I think having it obviously
robust is a good idea.
