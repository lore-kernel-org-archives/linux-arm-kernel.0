From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 16 Jul 2012 14:29:41 +0200
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <1342363754-30808-2-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <1342363754-30808-2-git-send-email-florian@openwrt.org>
Message-ID: <20120716142941.666d928c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Florian,

Le Sun, 15 Jul 2012 16:49:07 +0200,
Florian Fainelli <florian@openwrt.org> a ?crit :

> diff --git a/arch/arm/mach-mcs814x/Makefile.boot b/arch/arm/mach-mcs814x/Makefile.boot
> new file mode 100644
> index 0000000..414db8b
> --- /dev/null
> +++ b/arch/arm/mach-mcs814x/Makefile.boot
> @@ -0,0 +1,3 @@
> +    zreladdr-y := 0x00008000
> + params_phys-y := 0x00000008
> + initrd_phys-y := 0x00400000

params_phys-y and initrd_phys-y are useless for DT-based platforms, if
I'm correct.

> diff --git a/arch/arm/mach-mcs814x/clock.c b/arch/arm/mach-mcs814x/clock.c
> new file mode 100644
> index 0000000..eb30ae2
> --- /dev/null
> +++ b/arch/arm/mach-mcs814x/clock.c
> @@ -0,0 +1,271 @@
> +/*
> + * Moschip MCS814x clock routines
> + *
> + * Copyright (C) 2012, Florian Fainelli <florian@openwrt.org>
> + *
> + * Licensed under GPLv2
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/export.h>
> +#include <linux/spinlock.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk.h>
> +
> +#include <mach/mcs814x.h>
> +
> +#include "common.h"
> +
> +#define KHZ	1000
> +#define MHZ	(KHZ * KHZ)
> +
> +struct clk_ops {
> +	unsigned long (*get_rate)(struct clk *clk);
> +	int (*set_rate)(struct clk *clk, unsigned long rate);
> +	struct clk *(*get_parent)(struct clk *clk);
> +	int (*enable)(struct clk *clk, int enable);
> +};
> +
> +struct clk {
> +	struct clk *parent;		/* parent clk */
> +	unsigned long rate;		/* clock rate in Hz */
> +	unsigned long divider;		/* clock divider */
> +	u32 usecount;			/* reference count */
> +	struct clk_ops *ops;		/* clock operation */
> +	u32 enable_reg;			/* clock enable register */
> +	u32 enable_mask;		/* clock enable mask */
> +};
> +
> +static unsigned long clk_divide_parent(struct clk *clk)
> +{
> +	if (clk->parent && clk->divider)
> +		return clk_get_rate(clk->parent) / clk->divider;
> +	else
> +		return 0;
> +}
> +
> +static int clk_local_onoff_enable(struct clk *clk, int enable)
> +{
> +	u32 tmp;
> +
> +	/* no enable_reg means the clock is always enabled */
> +	if (!clk->enable_reg)
> +		return 0;
> +
> +	tmp = __raw_readl(mcs814x_sysdbg_base + clk->enable_reg);
> +	if (!enable)
> +		tmp &= ~clk->enable_mask;
> +	else
> +		tmp |= clk->enable_mask;
> +
> +	__raw_writel(tmp, mcs814x_sysdbg_base + clk->enable_reg);
> +
> +	return 0;
> +}
> +
> +static struct clk_ops default_clk_ops = {
> +	.get_rate	= clk_divide_parent,
> +	.enable		= clk_local_onoff_enable,
> +};
> +
> +static DEFINE_SPINLOCK(clocks_lock);
> +
> +static const unsigned long cpu_freq_table[] = {
> +	175000,
> +	300000,
> +	125000,
> +	137500,
> +	212500,
> +	250000,
> +	162500,
> +	187500,
> +	162500,
> +	150000,
> +	225000,
> +	237500,
> +	200000,
> +	262500,
> +	275000,
> +	287500
> +};
> +
> +static struct clk clk_cpu;
> +
> +/* System clock is fixed at 50Mhz */
> +static struct clk clk_sys = {
> +	.rate	= 50 * MHZ,
> +};
> +
> +static struct clk clk_sdram;
> +
> +static struct clk clk_timer0 = {
> +	.parent	= &clk_sdram,
> +	.divider = 2,
> +	.ops	= &default_clk_ops,
> +};
> +
> +static struct clk clk_timer1_2 = {
> +	.parent	= &clk_sys,
> +};
> +
> +/* Watchdog clock is system clock / 128 */
> +static struct clk clk_wdt = {
> +	.parent	= &clk_sys,
> +	.divider = 128,
> +	.ops	= &default_clk_ops,
> +};
> +
> +static struct clk clk_emac = {
> +	.ops		= &default_clk_ops,
> +	.enable_reg	= SYSDBG_SYSCTL,
> +	.enable_mask	= SYSCTL_EMAC,
> +};
> +
> +static struct clk clk_ephy = {
> +	.ops		= &default_clk_ops,
> +	.enable_reg	= SYSDBG_PLL_CTL,
> +	.enable_mask	= ~SYSCTL_EPHY,	/* active low */
> +};
> +
> +static struct clk clk_cipher = {
> +	.ops		= &default_clk_ops,
> +	.enable_reg	= SYSDBG_SYSCTL,
> +	.enable_mask	= SYSCTL_CIPHER,
> +};
> +
> +#define CLK(_dev, _con, _clk)	\
> +{ .dev_id = (_dev), .con_id = (_con), .clk = (_clk) },
> +
> +static struct clk_lookup mcs814x_chip_clks[] = {
> +	CLK("cpu", NULL, &clk_cpu)
> +	CLK("sys", NULL, &clk_sys)
> +	CLK("sdram", NULL, &clk_sdram)
> +	/* 32-bits timer0 */
> +	CLK("timer0", NULL, &clk_timer0)
> +	/* 16-bits timer1 */
> +	CLK("timer1", NULL, &clk_timer1_2)
> +	/* 64-bits timer2, same as timer 1 */
> +	CLK("timer2", NULL, &clk_timer1_2)
> +	CLK(NULL, "wdt", &clk_wdt)
> +	CLK(NULL, "emac", &clk_emac)
> +	CLK(NULL, "ephy", &clk_ephy)
> +	CLK(NULL, "cipher", &clk_cipher)
> +};
> +
> +static void local_clk_disable(struct clk *clk)
> +{
> +	WARN_ON(!clk->usecount);
> +
> +	if (clk->usecount > 0) {
> +		clk->usecount--;
> +
> +		if ((clk->usecount == 0) && (clk->ops->enable))
> +			clk->ops->enable(clk, 0);
> +
> +		if (clk->parent)
> +			local_clk_disable(clk->parent);
> +	}
> +}
> +
> +static int local_clk_enable(struct clk *clk)
> +{
> +	int ret = 0;
> +
> +	if (clk->parent)
> +		ret = local_clk_enable(clk->parent);
> +
> +	if (ret)
> +		return ret;
> +
> +	if ((clk->usecount == 0) && (clk->ops->enable))
> +		ret = clk->ops->enable(clk, 1);
> +
> +	if (!ret)
> +		clk->usecount++;
> +	else if (clk->parent && clk->parent->ops->enable)
> +		local_clk_disable(clk->parent);
> +
> +	return ret;
> +}
> +
> +int clk_enable(struct clk *clk)
> +{
> +	int ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&clocks_lock, flags);
> +	ret = local_clk_enable(clk);
> +	spin_unlock_irqrestore(&clocks_lock, flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(clk_enable);
> +
> +void clk_disable(struct clk *clk)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&clocks_lock, flags);
> +	local_clk_disable(clk);
> +	spin_unlock_irqrestore(&clocks_lock, flags);
> +}
> +EXPORT_SYMBOL(clk_disable);
> +
> +unsigned long clk_get_rate(struct clk *clk)
> +{
> +	if (unlikely(IS_ERR_OR_NULL(clk)))
> +		return 0;
> +
> +	if (clk->rate)
> +		return clk->rate;
> +
> +	if (clk->ops && clk->ops->get_rate)
> +		return clk->ops->get_rate(clk);
> +
> +	return clk_get_rate(clk->parent);
> +}
> +EXPORT_SYMBOL(clk_get_rate);
> +
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	unsigned long flags;
> +
> +	if (unlikely(IS_ERR_OR_NULL(clk)))
> +		return NULL;
> +
> +	if (!clk->ops || !clk->ops->get_parent)
> +		return clk->parent;
> +
> +	spin_lock_irqsave(&clocks_lock, flags);
> +	clk->parent = clk->ops->get_parent(clk);
> +	spin_unlock_irqrestore(&clocks_lock, flags);
> +
> +	return clk->parent;
> +}
> +EXPORT_SYMBOL(clk_get_parent);

You should rather use the new clock framework instead of providing your
own implementation of the clk_*() API. And therefore your clock driver
should be in drivers/clk/ instead.

> +struct cpu_mode {
> +	const char *name;
> +	int gpio_start;
> +	int gpio_end;
> +};
> +
> +static const struct cpu_mode cpu_modes[] = {
> +	{
> +		.name		= "I2S",
> +		.gpio_start	= 4,
> +		.gpio_end	= 8,
> +	},
> +	{
> +		.name		= "UART",
> +		.gpio_start	= 4,
> +		.gpio_end	= 9,
> +	},
> +	{
> +		.name		= "External MII",
> +		.gpio_start	= 0,
> +		.gpio_end	= 16,
> +	},
> +	{
> +		.name		= "Normal",
> +		.gpio_start	= -1,
> +		.gpio_end	= -1,
> +	},
> +};
> +
> +void __init mcs814x_init_machine(void)
> +{
> +	u32 bs2, cpu_mode;
> +	int gpio;
> +
> +	bs2 = __raw_readl(mcs814x_sysdbg_base + SYSDBG_BS2);
> +	cpu_mode = (bs2 >> CPU_MODE_SHIFT) & CPU_MODE_MASK;
> +
> +	pr_info("CPU mode: %s\n", cpu_modes[cpu_mode].name);
> +
> +	/* request the gpios since the pins are muxed for functionnality */
> +	for (gpio = cpu_modes[cpu_mode].gpio_start;
> +		gpio == cpu_modes[cpu_mode].gpio_end; gpio++) {
> +		if (gpio != -1)
> +			gpio_request(gpio, cpu_modes[cpu_mode].name);

I am not sure here, but shouldn't this be done with the pinctrl
subsystem instead?

> +void __init mcs814x_map_io(void)
> +{
> +	iotable_init(mcs814x_io_desc, ARRAY_SIZE(mcs814x_io_desc));
> +
> +	mcs814x_sysdbg_base = ioremap(MCS814X_IO_START + MCS814X_SYSDBG,
> +					MCS814X_SYSDBG_SIZE);
> +	if (!mcs814x_sysdbg_base)
> +		panic("unable to remap sysdbg base");

Any reason to have a static mapping initialized with iotable_init() and
then a dynamic mapping initialized with ioremap() ? I thought that
ioremap() wasn't ready at the ->map_io() time, and it was therefore the
reason we had static mappings.

> diff --git a/arch/arm/mach-mcs814x/include/mach/entry-macro.S b/arch/arm/mach-mcs814x/include/mach/entry-macro.S
> new file mode 100644
> index 0000000..cbad566
> --- /dev/null
> +++ b/arch/arm/mach-mcs814x/include/mach/entry-macro.S
> @@ -0,0 +1,29 @@
> +#include <mach/mcs814x.h>
> +                .macro  disable_fiq
> +                .endm
> +
> +		.macro arch_ret_to_user, tmp1, tmp2
> +		.endm
> +
> +		.macro  get_irqnr_preamble, base, tmp
> +		ldr	\base, =mcs814x_intc_base@ base virtual address of INTC
> +		ldr	\base, [\base]
> +		.endm
> +
> +		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> +		mov	\tmp, #MCS814X_IRQ_STS0	 @ load tmp with STS0 register offset
> +		ldr	\irqstat, [\base, \tmp]	 @ load value at base + tmp
> +		tst	\irqstat, \irqstat       @ test if no active IRQ's
> +		beq	1002f                    @ if no active irqs return with status 0
> +		mov	\irqnr, #0               @ start from irq zero
> +		mov	\tmp,   #1               @ the mask initially 1
> +1001:
> +		tst     \irqstat, \tmp           @ and with mask
> +		addeq   \irqnr, \irqnr, #1       @ if  zero then add one to nr
> +		moveq   \tmp,   \tmp, lsl #1     @ shift mask one to left
> +		beq     1001b                    @ if  zero then loop again
> +		mov     \irqstat, \tmp           @ save the return mask
> +		mov	\tmp, #MCS814X_IRQ_STS0  @ load tmp with ICR offset
> +		str     \irqstat,  [\base, \tmp] @ clear irq with selected mask
> +1002:
> +                .endm

Hum, you should instead use the MULTI_IRQ_HANDLER feature so that this
can be written in C.

> diff --git a/arch/arm/mach-mcs814x/include/mach/hardware.h b/arch/arm/mach-mcs814x/include/mach/hardware.h
> new file mode 100644
> index 0000000..529f648
> --- /dev/null
> +++ b/arch/arm/mach-mcs814x/include/mach/hardware.h
> @@ -0,0 +1,16 @@
> +/*
> + * Copyright (C) 2003 Artec Design Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __ASM_ARCH_HARDWARE_H
> +#define __ASM_ARCH_HARDWARE_H

This #define name no longer looks consistent with where the file is
located.

> +#include "mcs814x.h"
> +
> +#endif
> +
> diff --git a/arch/arm/mach-mcs814x/include/mach/irqs.h b/arch/arm/mach-mcs814x/include/mach/irqs.h
> new file mode 100644
> index 0000000..78021d1
> --- /dev/null
> +++ b/arch/arm/mach-mcs814x/include/mach/irqs.h
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2003 Artec Design Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __ASM_ARCH_IRQS_H
> +#define __ASM_ARCH_IRQS_H
> +
> +#define FIQ_START	0
> +
> +#define NR_IRQS		32

I think this shouldn't be needed if you use SPARSE_IRQ support.

> +#define IRQ_PCI_INTA            22
> +#define IRQ_PCI_INTB            23
> +#define IRQ_PCI_INTC            24
> +#define IRQ_PCI_INTD            26

And these probably belong to the DT somehow?

> diff --git a/arch/arm/mach-mcs814x/timer.c b/arch/arm/mach-mcs814x/timer.c
> new file mode 100644
> index 0000000..e8408e4
> --- /dev/null
> +++ b/arch/arm/mach-mcs814x/timer.c
> @@ -0,0 +1,133 @@
> +/*
> + * Moschip MCS814x timer routines
> + *
> + * Copyright (C) 2012, Florian Fainelli <florian@openwrt.org>
> + *
> + * Licensed under GPLv2
> + */
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/time.h>
> +#include <linux/timex.h>
> +#include <linux/irq.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#include <asm/mach/time.h>
> +#include <mach/mcs814x.h>
> +
> +/* Timer block registers */
> +#define TIMER_VAL	0x00
> +#define TIMER_CTL	0x04
> +
> +static u32 last_reload;
> +static u32 timer_correct;
> +static u32 clock_rate;
> +static u32 timer_reload_value;
> +static void __iomem *mcs814x_timer_base;
> +
> +static inline unsigned long ticks2usecs(u32 x)
> +{
> +	return x / (clock_rate / 1000000);
> +}
> +
> +/*
> + * Returns number of ms since last clock interrupt.  Note that interrupts
> + * will have been disabled by do_gettimeoffset()
> + */
> +static unsigned long mcs814x_gettimeoffset(void)
> +{
> +	u32 ticks = __raw_readl(mcs814x_timer_base + TIMER_VAL);
> +
> +	if (ticks < last_reload)
> +		return ticks2usecs(ticks + (u32)(0xffffffff - last_reload));
> +	else
> +		return ticks2usecs(ticks - last_reload);
> +}
> +
> +
> +static irqreturn_t mcs814x_timer_interrupt(int irq, void *dev_id)
> +{
> +	u32 count = __raw_readl(mcs814x_timer_base + TIMER_VAL);
> +
> +	/* take into account delay up to this moment */
> +	last_reload = count + timer_correct + timer_reload_value;
> +
> +	if (last_reload < timer_reload_value)
> +		last_reload = timer_reload_value;
> +	else if (timer_correct == 0)
> +		timer_correct = __raw_readl(mcs814x_timer_base + TIMER_VAL) -
> +					count;
> +
> +	__raw_writel(last_reload, mcs814x_timer_base + TIMER_VAL);
> +
> +	timer_tick();
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction mcs814x_timer_irq = {
> +	.name		= "mcs814x-timer",
> +	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> +	.handler	= mcs814x_timer_interrupt,
> +};
> +
> +static struct of_device_id mcs814x_timer_ids[] = {
> +	{ .compatible = "moschip,mcs814x-timer" },
> +	{ /* sentinel */ },
> +};
> +
> +static void __init mcs814x_of_timer_init(void)
> +{
> +	struct device_node *np;
> +	const unsigned int *intspec;
> +
> +	np = of_find_matching_node(NULL, mcs814x_timer_ids);
> +	if (!np)
> +		panic("unable to find compatible timer node in dtb");
> +
> +	mcs814x_timer_base = of_iomap(np, 0);
> +	if (!mcs814x_timer_base)
> +		panic("unable to remap timer cpu registers");
> +
> +	intspec = of_get_property(np, "interrupts", NULL);
> +	if (!intspec)
> +		panic("no interrupts property for timer");
> +
> +	mcs814x_timer_irq.irq = be32_to_cpup(intspec);
> +}
> +
> +static void __init mcs814x_timer_init(void)
> +{
> +	struct clk *clk;
> +
> +	clk = clk_get_sys("timer0", NULL);
> +	if (IS_ERR_OR_NULL(clk))
> +		panic("unable to get timer0 clock");
> +
> +	clock_rate = clk_get_rate(clk);
> +	clk_put(clk);
> +
> +	mcs814x_of_timer_init();
> +
> +	pr_info("Timer frequency: %d (kHz)\n", clock_rate / 1000);
> +
> +	timer_reload_value = 0xffffffff - (clock_rate / HZ);
> +
> +	/* disable timer */
> +	__raw_writel(0, mcs814x_timer_base + TIMER_CTL);
> +	__raw_writel(timer_reload_value, mcs814x_timer_base + TIMER_VAL);
> +	last_reload = timer_reload_value;
> +
> +	setup_irq(mcs814x_timer_irq.irq, &mcs814x_timer_irq);
> +	/* enable timer, stop timer in debug mode */
> +	__raw_writel(0x03, mcs814x_timer_base + TIMER_CTL);
> +}
> +
> +struct sys_timer mcs814x_timer = {
> +	.init	= mcs814x_timer_init,
> +	.offset	= mcs814x_gettimeoffset,
> +};

I am surprised that this doesn't use the clocksource and clockevents
infrastructure. It probably should, and be implemented in
drivers/clocksource/.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
