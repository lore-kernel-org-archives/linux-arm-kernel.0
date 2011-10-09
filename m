From: jamie@jamieiles.com (Jamie Iles)
Date: Sun, 9 Oct 2011 18:22:32 +0100
Subject: [PATCH 2/9] ARM: SPMP8000: Add machine base files
In-Reply-To: <1318178172-7965-3-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-3-git-send-email-zoss@devai.org>
Message-ID: <20111009172232.GB18424@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zoltan,

A couple of minor comments inline but this looks really good!

Jamie

On Sun, Oct 09, 2011 at 06:36:05PM +0200, Zoltan Devai wrote:
[...]
> diff --git a/arch/arm/mach-spmp8000/Makefile b/arch/arm/mach-spmp8000/Makefile
> new file mode 100644
> index 0000000..9d35cca
> --- /dev/null
> +++ b/arch/arm/mach-spmp8000/Makefile
> @@ -0,0 +1,11 @@
> +#
> +# Makefile for the linux kernel.
> +#

Nit: I don't think this comment adds a great deal of value.

> +obj-y 			:= core.o
> +obj-y			+= timer.o
> +obj-y			+= pinmux.o
> +obj-y			+= clock.o
> +obj-y			+= clkdev.o
> +obj-y			+= board_letcool.o
> +obj-y			+= adc.o
> +obj-y			+= pwm.o
> diff --git a/arch/arm/mach-spmp8000/core.c 
> b/arch/arm/mach-spmp8000/core.c
> new file mode 100644
> index 0000000..ba05614
> --- /dev/null
> +++ b/arch/arm/mach-spmp8000/core.c
> @@ -0,0 +1,103 @@
> +/*
> + * SPMP8000 machines core functions
> + *
> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <asm/mach/map.h>
> +#include <asm/hardware/vic.h>
> +#include <mach/hardware.h>
> +#include <mach/scu.h>
> +
> +/* Static mappings:
> + * SCU: timer needs clk support which is inited in init_early
> + * UART: needed for earlyprintk
> + */
> +static struct map_desc io_desc[] __initdata = {
> +	{
> +		.virtual	= IO_ADDRESS(SPMP8000_SCU_A_BASE),
> +		.pfn		= __phys_to_pfn(SPMP8000_SCU_A_BASE),
> +		.length		= SPMP8000_SCU_A_SIZE,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= IO_ADDRESS(SPMP8000_SCU_B_BASE),
> +		.pfn		= __phys_to_pfn(SPMP8000_SCU_B_BASE),
> +		.length		= SPMP8000_SCU_B_SIZE,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= IO_ADDRESS(SPMP8000_SCU_C_BASE),
> +		.pfn		= __phys_to_pfn(SPMP8000_SCU_C_BASE),
> +		.length		= SPMP8000_SCU_C_SIZE,
> +		.type		= MT_DEVICE,
> +	},
> +#ifdef CONFIG_DEBUG_LL
> +	{
> +		.virtual	= IO_ADDRESS(SPMP8000_UARTC0_BASE),
> +		.pfn		= __phys_to_pfn(SPMP8000_UARTC0_BASE),
> +		.length		= SPMP8000_UARTC0_SIZE,
> +		.type		= MT_DEVICE,
> +	},
> +#endif
> +};
> +
> +#define IO_PTR(x)	((void __iomem *)IO_ADDRESS(x))

Generally IO_ADDRESS returns a void __iomem pointer so it would be 
easier if you could have the cast in there (though it may need to be 
enclosed in #ifndef __ASSEMBLY__ conditionals).

> +/* Make the lookup of SCU base and clk enable registers easy for the clk
> + * code, as they are not at the same offset in each controller */
> +struct scu_reg_t scu_regs[3] = {
> +	{	/* SCU_A */
> +		.base = IO_PTR(SPMP8000_SCU_A_BASE),
> +		.clken = IO_PTR(SPMP8000_SCU_A_BASE) + SCU_A_PERI_CLKEN,
> +	},
> +	{	/* SCU_B */
> +		.base = IO_PTR(SPMP8000_SCU_B_BASE),
> +		.clken = IO_PTR(SPMP8000_SCU_B_BASE) + SCU_B_PERI_CLKEN,
> +	},
> +	{	/* SCU_C */
> +		.base = IO_PTR(SPMP8000_SCU_C_BASE),
> +		.clken = IO_PTR(SPMP8000_SCU_C_BASE) + SCU_C_PERI_CLKEN,
> +	},
> +};
> +
> +/* DMA controller names to be used for the filter
> + * function of the DMA-Engine API. */
> +char *spmp8000_dma_controller_names[] = {

const char * const?

> +	"93010000.dma",		/* APBDMA_A */
> +	"92b00000.dma",		/* APBDMA_C */
> +};
> +
> +void __init spmp8000_map_io(void)
> +{
> +	iotable_init(io_desc, ARRAY_SIZE(io_desc));
> +}
> +
> +void __init spmp8000_init_irq(void)
> +{
> +	struct device_node *np;
> +	int ret;
> +
> +	np = of_find_compatible_node(NULL, NULL, "arm,pl192");
> +	if (!np)
> +		panic("Can't find VIC0 interrupt controller\n");
> +
> +	ret = vic_of_init(np, NULL);
> +	if (ret)
> +		panic("Can't init VIC0 interrupt controller\n");
> +
> +	np = of_find_compatible_node(np, NULL, "arm,pl192");
> +	if (!np)
> +		panic("Can't find VIC1 interrupt controller\n");
> +
> +	ret = vic_of_init(np, NULL);
> +	if (ret)
> +		panic("Can't init VIC1 interrupt controller\n");
> +
> +	of_node_put(np);

So with Rob Herring's of_irq_init patches you should be able to reduce 
this to:

	static const struct of_device_id spmp8000_vic_matches[] = {
		{ .compatible = "arm,pl192", .data = vic_of_init },
	};
	
	of_irq_init(spmp8000_vic_matches);

and that will handle both VIC's and ordering.

> +}
> diff --git a/arch/arm/mach-spmp8000/include/mach/core.h b/arch/arm/mach-spmp8000/include/mach/core.h
> new file mode 100644
> index 0000000..fa1d522
> --- /dev/null
> +++ b/arch/arm/mach-spmp8000/include/mach/core.h
> @@ -0,0 +1,29 @@
> +/*
> + * SPMP8000 generic includes
> + *
> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __MACH_SPMP8000_GENERIC_H__
> +#define __MACH_SPMP8000_GENERIC_H__
> +
> +/* core.c */
> +extern void __init spmp8000_map_io(void);
> +extern void __init spmp8000_init_irq(void);

Nit: you don't need the __init attributes in the header files.

> +extern struct sys_timer spmp8000_sys_timer;
> +
> +/* clkdev.c */
> +extern void __init spmp8000_init_clkdev(void);
> +extern void spmp8000_update_arm_freqs(void); /* For cpufreq driver */
> +
> +/* pinmux.c */
> +extern void spmp8000_pinmux_pgc_set(int pc, unsigned int conf);
> +extern unsigned int spmp8000_pinmux_pgc_get(int pc);
> +extern void spmp8000_pinmux_pgs_set(unsigned int pg, unsigned int func);
> +extern int spmp8000_pinmux_pgs_get(int pg);
> +
> +#endif /* __MACH_SPMP8000_GENERIC_H__ */
[...]
> diff --git a/arch/arm/mach-spmp8000/include/mach/dma.h b/arch/arm/mach-spmp8000/include/mach/dma.h
> new file mode 100644
> index 0000000..44bc9f2
> --- /dev/null
> +++ b/arch/arm/mach-spmp8000/include/mach/dma.h
> @@ -0,0 +1,45 @@
> +/*
> + * SPMP8000 dma.h
> + *
> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/module.h>
> +#include <linux/dmaengine.h>

It may be worth splitting the DMA part out into a separate patch unless 
this really is required for basic functionality.

> +
> +#ifndef __MACH_SPMP8000_DMA_H__
> +#define __MACH_SPMP8000_DMA_H__
> +
> +enum spmp8000_dma_controller {
> +	SPMP8000_APBDMA_A	= 0,
> +	SPMP8000_APBDMA_C,
> +};
> +
> +extern char *spmp8000_dma_controller_names[];
> +
> +struct spmp8000_dma_params {
> +	char				*dma_controller;
> +	dma_addr_t			dma_address;
> +	enum dma_slave_buswidth		dma_width;
> +	int				maxburst;
> +};

dmaengine has dma_slave_config that could be used for this, but I don't 
see any of this file being used in this series so perhaps it's worth 
adding in after the core stuff has been merged?

> +
> +/* Driver parameters */
> +#define SPMP8000_APBDMA_MAX_PERIODS	64
> +
> +static bool spmp8000_dma_filter(struct dma_chan *chan, const char *name)
> +{
> +	int ret;
> +
> +	ret = strcmp(dev_name(chan->device->dev), name);
> +
> +	if (ret)
> +		return false;
> +
> +	return true;

I think you can reduce this function to just

	return !strcmp(dev_name(chan->device->dev), name);

and the compiler will do the right thing with int->bool conversion.

> diff --git a/arch/arm/mach-spmp8000/include/mach/gpio.h 
> b/arch/arm/mach-spmp8000/include/mach/gpio.h
> new file mode 100644
> index 0000000..3eafac2
> --- /dev/null
> +++ b/arch/arm/mach-spmp8000/include/mach/gpio.h
> @@ -0,0 +1,21 @@
> +/*
> + * SPMP8000 machines gpio support
> + *
> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __MACH_SPMP8000_GPIO_H__
> +#define __MACH_SPMP8000_GPIO_H__
> +
> +#include <asm-generic/gpio.h>
> +
> +#define gpio_get_value		__gpio_get_value
> +#define gpio_set_value		__gpio_set_value
> +#define gpio_cansleep		__gpio_cansleep
> +#define gpio_to_irq		__gpio_to_irq

Russell has a patch (ARM: gpio: make trivial GPIOLIB implementation the 
default) in for-next that means you shouldn't need these definitions 
anymore.

> diff --git a/arch/arm/mach-spmp8000/include/mach/irqs.h 
> b/arch/arm/mach-spmp8000/include/mach/irqs.h
> new file mode 100644
> index 0000000..7f305d3
> --- /dev/null
> +++ b/arch/arm/mach-spmp8000/include/mach/irqs.h
> @@ -0,0 +1,21 @@
> +/*
> + * SPMP8000 irqs.h
> + *
> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __MACH_SPMP8000_IRQS_H__
> +#define __MACH_SPMP8000_IRQS_H__
> +
> +#define SPMP8000_HW_IRQS		64
> +#define SPMP8000_GPIO_IRQS_START	SPMP8000_HW_IRQS
> +#define SPMP8000_GPIO_IRQS		(16 + 32)
> +#define SPMP8000_TOTAL_IRQS		(SPMP8000_HW_IRQS + SPMP8000_GPIO_IRQS)
> +
> +#define NR_IRQS				SPMP8000_TOTAL_IRQS

I think that if you use my VIC patches then you can actually define 
NR_IRQS to 0 as all IRQ descs are dynamically allocated (otherwise 
you'll be reserving a bunch of irq_descs that never get used).

> diff --git a/arch/arm/mach-spmp8000/include/mach/regs-timer.h 
> b/arch/arm/mach-spmp8000/include/mach/regs-timer.h
> new file mode 100644
> index 0000000..90735df
> --- /dev/null
> +++ b/arch/arm/mach-spmp8000/include/mach/regs-timer.h
> @@ -0,0 +1,32 @@
> +/*
> + * SPMP8000 timer support
> + *
> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * These timer reg definitions are used by the timer and pwm drivers
> + */

If these definitions are only being used inside arch/arm/mach-spmp8000 
then I'd put the headers in there rather than the 
arch/arm/mach-spmp8000/include/mach subdir so that the visibility is 
restricted to the mach code.

> +#ifndef __MACH_SPMP8000_REGS_TIMER_H__
> +#define __MACH_SPMP8000_REGS_TIMER_H__
> +
> +#define SPMP8000_TMRB(tnum)	(tnum * 0x20)
> +#define SPMP8000_TMRB_CTR	0x00
> +#define SPMP8000_TMRB_CTR_TE	BIT(0)
> +#define SPMP8000_TMRB_CTR_IE	BIT(1)
> +#define SPMP8000_TMRB_CTR_OE	BIT(2)
> +#define SPMP8000_TMRB_CTR_PWMON	BIT(3)
> +#define SPMP8000_TMRB_CTR_UD	BIT(4)
> +#define SPMP8000_TMRB_CTR_UDS	BIT(5)
> +#define SPMP8000_TMRB_CTR_OM	BIT(6)
> +#define SPMP8000_TMRB_CTR_ES_SH	8
> +#define SPMP8000_TMRB_CTR_M_SH	10
> +#define SPMP8000_TMRB_PSR	0x04
> +#define SPMP8000_TMRB_LDR	0x08
> +#define SPMP8000_TMRB_VLR	0x08
> +#define SPMP8000_TMRB_ISR	0x0C
> +#define SPMP8000_TMRB_CMP	0x10
> +
> +#endif /* __MACH_SPMP8000_REGS_TIMER_H__ */
> diff --git a/arch/arm/mach-spmp8000/include/mach/scu.h b/arch/arm/mach-spmp8000/include/mach/scu.h
> new file mode 100644
> index 0000000..e3a98d4
> --- /dev/null
> +++ b/arch/arm/mach-spmp8000/include/mach/scu.h

Same here as the timer regs stuff.

> @@ -0,0 +1,146 @@
> +/*
> + * SPMP8000 System Control Unit register definitions
> + * SCUs are a random collection of reset, clock, gpio, pinmux, etc. controllers
> + * so that these definitions are needed at several places.
> + *
> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/bitops.h>
> +#include <mach/hardware.h>
> +
> +#ifndef __MACH_SPMP8000_SCU_H__
> +#define __MACH_SPMP8000_SCU_H__
> +
> +/* Used by to the clock code to directly access the SCU base and clock
> + * enabling registers, without looking up the according registers first.
> + */
> +struct scu_reg_t {

Generally speaking _t isn't used for structs.

> +	void *base;
> +	void *clken;

Shouldn't these be void __iomem *?

> +};
> +
> +extern struct scu_reg_t scu_regs[];
> +
> +#define REG_SCU_BASE(x)		scu_regs[x].base
> +#define REG_SCU_CLKEN(x)	scu_regs[x].clken
> +#define REG_SCU_A_ID		0
> +#define REG_SCU_B_ID		1
> +#define REG_SCU_C_ID		2
> +#define REG_SCU_A(x)		(scu_regs[REG_SCU_A_ID].base + x)
> +#define REG_SCU_B(x)		(scu_regs[REG_SCU_B_ID].base + x)
> +#define REG_SCU_C(x)		(scu_regs[REG_SCU_C_ID].base + x)

macros that assume there is a variable in scope with a given name 
(scu_regs) are generally frowned upon as it's difficult to see what's 
going on and can be a little error prone.

> diff --git a/arch/arm/mach-spmp8000/include/mach/system.h 
> b/arch/arm/mach-spmp8000/include/mach/system.h
> new file mode 100644
> index 0000000..be53ff3
> --- /dev/null
> +++ b/arch/arm/mach-spmp8000/include/mach/system.h
> @@ -0,0 +1,45 @@
> +/*
> + * SPMP8000 system.h
> + *
> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __MACH_SPMP8000_SYSTEM_H__
> +#define __MACH_SPMP8000_SYSTEM_H__
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +
> +#define SPMP8000_WDT_BASE	0x90001000
> +#define SPMP8000_WDT_SIZE	0x1000
> +
> +#define SPMP8000_WDT_CTR	0x00
> +#define SPMP8000_WDT_CTR_TE	BIT(0)
> +#define SPMP8000_WDT_CTR_RE	BIT(3)
> +
> +static inline void arch_idle(void)
> +{
> +	cpu_do_idle();
> +}
> +
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +	void *base;
> +
> +	base = ioremap(SPMP8000_WDT_BASE, SPMP8000_WDT_SIZE);
> +	if (!base) {
> +		pr_err("spmp8000: Can't ioremap watchdog regs for reset. "
> +			"Halt.");
> +		while (1);
> +	}

It may be worth doing the ioremap earlier when the system is in a known 
good state with all functions available rather than at reset time.

> +
> +	/* Trigger a watchdog reset */
> +	writel(SPMP8000_WDT_CTR_RE | SPMP8000_WDT_CTR_TE,
> +			base + SPMP8000_WDT_CTR);
> +}
[...]
> diff --git a/arch/arm/mach-spmp8000/timer.c 
> b/arch/arm/mach-spmp8000/timer.c
> new file mode 100644
> index 0000000..7d5d0eb
> --- /dev/null
> +++ b/arch/arm/mach-spmp8000/timer.c
> @@ -0,0 +1,160 @@
> +/*
> + * SPMP8000 machines timer functions
> + *
> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/clockchips.h>
> +#include <linux/clk.h>
> +#include <asm/mach/time.h>
> +
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/regs-timer.h>
> +#include <mach/irqs.h>
> +
> +static unsigned long clkrate;
> +static const unsigned int tickrate = 1012500;
> +
> +/* The TIMER_B block is used as system timer
> + * T2: Clocksource
> + * T1: Clockevent
> + * T0: PWM for LCD backlight
> + * T3,4: Could be used as additional clockevent devices
> + * Timer constraints:
> + * - WDT: Can't clear the irq directly, only by resetting the whole counter
> + *   in the ISR, which means that IRQs will jitter
> + * - Timer_B: Can't reset the timer value, so at start, the first IRQ
> + *   will happen at some random time.
> + */
> +#define		CS_TIMER	2
> +#define		CE_TIMER	1

Nit: removing the extra spaces between the define and the CS_TIMER...  
might make it easier to grep for.

> +static void __iomem *cs_base;
> +static void __iomem *ce_base;
> +
> +static void tmrb_set_mode(enum clock_event_mode mode,
> +				struct clock_event_device *dev)
> +{
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		writel((tickrate / HZ), ce_base + SPMP8000_TMRB_LDR);
> +		/* Configure as periodic, down counter, IEN, enable timer */
> +		writel(SPMP8000_TMRB_CTR_TE | SPMP8000_TMRB_CTR_IE |
> +				(1 << SPMP8000_TMRB_CTR_M_SH),
> +				ce_base + SPMP8000_TMRB_CTR);
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		BUG();
> +		break;

This case can be folded into the CLOCK_EVT_MODE_RESUME case (and changed 
to be a default case).

> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +	case CLOCK_EVT_MODE_UNUSED:
> +		/* Disable timer */
> +		writel(0, ce_base + SPMP8000_TMRB_CTR);
> +		break;
> +	case CLOCK_EVT_MODE_RESUME:
> +		BUG();
> +		break;
> +	}
> +}
> +
> +static struct clock_event_device tmrb1_clkevt = {
> +	.name		= "tmrb1",
> +	.features	= CLOCK_EVT_FEAT_PERIODIC,
> +	.rating		= 200,
> +	.set_mode	= tmrb_set_mode,
> +};
> +
> +static irqreturn_t tmrb1_isr(int irq, void *dev_id)
> +{
> +	tmrb1_clkevt.event_handler(&tmrb1_clkevt);
> +
> +	/* Clear IRQ */
> +	writel(0, ce_base + SPMP8000_TMRB_ISR);
> +
> +	return IRQ_HANDLED;
> +};
> +
> +static struct irqaction tmrb1_irq = {
> +	.name		= "tmrb1_irq",
> +	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
> +	.handler	= tmrb1_isr,
> +};
> +
> +static void __init spmp8000_sys_timer_init(void)
> +{
> +	struct device_node *np;
> +	unsigned int irq;
> +	struct clk *clk;
> +	void *tmrb_base;
> +
> +	np = of_find_compatible_node(NULL, NULL, "sunplus,spmp8000-timer");
> +	if (!np)
> +		panic("spmp8000: unable to find timer node in dtb\n");
> +
> +	tmrb_base = of_iomap(np, 0);
> +	if (!tmrb_base)
> +		panic("spmp8000: unable to map timer cpu registers\n");
> +
> +	irq = of_irq_to_resource(np, CE_TIMER, NULL);
> +	if (irq == NO_IRQ)
> +		panic("spmp8000: unable to get interrupts of timer\n");
> +
> +	of_node_put(np);
> +
> +	cs_base = tmrb_base + SPMP8000_TMRB(CS_TIMER);
> +	ce_base = tmrb_base + SPMP8000_TMRB(CE_TIMER);
> +
> +	clk = clk_get(NULL, "arm_apb");
> +	if (IS_ERR_OR_NULL(clk))

NULL can actually be a valid clk cookie so this should just be 
IS_ERR(clk).

> +		panic("spmp8000: Can't get clock for timer device");
> +
> +	clk_enable(clk);

Should probably check for success/failure here.

> +	clkrate = clk_get_rate(clk);
> +
> +	/* Clocksource */
> +	/* Disable timer */
> +	writel(0, cs_base + SPMP8000_TMRB_CTR);
> +
> +	/* Reset counter value
> +	 * Not really possible unless setting end-1 LDR value and waiting
> +	 * until the counter reaches that */
> +
> +	/* Prescale timer */
> +	writel((clkrate / tickrate) - 1, cs_base + SPMP8000_TMRB_PSR);
> +
> +	/* Register the clocksource */
> +	clocksource_mmio_init(cs_base + SPMP8000_TMRB_VLR, "tmrb2",
> +				tickrate, 200, 16, clocksource_mmio_readl_up);
> +
> +	/* Configure as free running (0 - 0xFFFF), up counter, enable timer */
> +	writel(SPMP8000_TMRB_CTR_TE | SPMP8000_TMRB_CTR_UD,
> +		cs_base + SPMP8000_TMRB_CTR);
> +
> +	/* Clockevent */
> +	setup_irq(irq, &tmrb1_irq);
> +
> +	/* Disable timer */
> +	writel(0, ce_base + SPMP8000_TMRB_CTR);
> +
> +	/* Prescale timer */
> +	writel((clkrate / tickrate) - 1, ce_base + SPMP8000_TMRB_PSR);
> +
> +	clockevents_register_device(&tmrb1_clkevt);
> +}
> +
> +struct sys_timer spmp8000_sys_timer = {
> +	.init		= spmp8000_sys_timer_init,
> +};
