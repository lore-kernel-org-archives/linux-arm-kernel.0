From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Jun 2010 15:08:26 +0100
Subject: [PATCH 1/6] U6/U6715 ARM architecture files
In-Reply-To: <1274948852-9179-2-git-send-email-philippe.langlais@stericsson.com>
References: <1274948852-9179-1-git-send-email-philippe.langlais@stericsson.com>
	<1274948852-9179-2-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20100624140825.GA6523@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 10:27:27AM +0200, Philippe Langlais wrote:
> diff --git a/arch/arm/mach-u67xx/devices.c b/arch/arm/mach-u67xx/devices.c
> new file mode 100644
> index 0000000..0ead380
> --- /dev/null
> +++ b/arch/arm/mach-u67xx/devices.c
> @@ -0,0 +1,95 @@
> +/*
> + * linux/arch/arm/mach-u67xx/devices.c
> + *
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Philippe Langlais <philippe.langlais@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + *
> + * Device specification for the U67XX
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/ioport.h>
> +#include <linux/platform_device.h>
> +#include <linux/fs.h>
> +#include <mach/hardware.h>
> +#include <mach/scon.h>
> +#include <mach/gpio.h>

linux/gpio.h

> +struct gpio_bank u6_gpio_bank[6] = {
> +	{(void __iomem *)GPIOA_PINS_REG, (void __iomem *)SCON_SYSMUX0_REG},
> +	{(void __iomem *)GPIOB_PINS_REG, (void __iomem *)SCON_SYSMUX2_REG},
> +	{(void __iomem *)GPIOC_PINS_REG, (void __iomem *)SCON_SYSMUX4_REG},
> +	{(void __iomem *)GPIOD_PINS_REG, (void __iomem *)SCON_SYSMUX6_REG},
> +	{(void __iomem *)GPIOE_PINS_REG, (void __iomem *)SCON_SYSMUX8_REG},
> +	{(void __iomem *)GPIOF_PINS_REG, (void __iomem *)SCON_SYSMUX10_REG},

Would be nice to get rid of these casts - instead moving them to the
point of definition instead - or maybe doing as other platforms do and
defining an IOMEM() macro which does the cast and using that in the
definitions.

iow, something like:

#define IOMEM(x)	((void __iomem *)(x))

#define GPIOA_PINS_REG	IOMEM(whatever)

and if you need GPIOA_PINS_REG to be usable in assembly, arrange for
the IOMEM() macro to handle that for you.

> diff --git a/arch/arm/plat-u6xxx/include/mach/entry-macro.S b/arch/arm/plat-u6xxx/include/mach/entry-macro.S
> new file mode 100644
> index 0000000..59bb2d2
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/include/mach/entry-macro.S
> @@ -0,0 +1,32 @@
> +/*
> + * linux/arch/arm/plat-u6xxx/include/mach/entry-macro.S
> + *
> + * Low-level IRQ helper macros for U6-based platforms
> + * Copyright (C) ST-Ericsson SA 2010
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <mach/hardware.h>
> +#include <mach/irqs.h>
> +
> +	.macro  arch_ret_to_user, tmp1, tmp2
> +	.endm
> +
> +	.macro	disable_fiq
> +	.endm
> +
> +	.macro  get_irqnr_preamble, base, tmp
> +	.endm

This macro is there to allow you to be a little more efficient - rather
than reloading the base address of the interrupt controller each time
around the interrupt handling loop, you can put it in the above macro
to take it outside the loop.

> +#define hw_raw_local_irq_save       raw_local_irq_save
> +#define hw_raw_local_irq_restore    raw_local_irq_restore

What's the purpose of these additional aliases?

> +/* INTC PRIOMASK_IRQ Register (32 bits) */
> +#define INTC_PRIOMASK_IRQ_OFFSET 0x0
> +#define INTC_PRIOMASK_IRQ_REG  IO_ADDRESS(INTC_BASE + INTC_PRIOMASK_IRQ_OFFSET)
> +
> +/* INTC PRIOMASK_FIQ Register (32 bits) */
> +#define INTC_PRIOMASK_FIQ_OFFSET 0x4
> +#define INTC_PRIOMASK_FIQ_REG  IO_ADDRESS(INTC_BASE + INTC_PRIOMASK_FIQ_OFFSET)
> +
> +/* INTC VECTOR_IRQ Register (32 bits) */
> +#define INTC_VECTOR_IRQ_OFFSET   0x100
> +#define INTC_VECTOR_IRQ_REG      IO_ADDRESS(INTC_BASE + INTC_VECTOR_IRQ_OFFSET)
> +
> +/* INTC VECTOR_FIQ Register (32 bits) */
> +#define INTC_VECTOR_FIQ_OFFSET   0x104
> +#define INTC_VECTOR_FIQ_REG      IO_ADDRESS(INTC_BASE + INTC_VECTOR_FIQ_OFFSET)
> +
> +/* INTC PENDING_* Registers (32 bits) */
> +#define INTC_PENDING_1_OFFSET    0x200
> +#define INTC_PENDING_2_OFFSET    0x204
> +#define INTC_PENDING_3_OFFSET    0x208
> +#define INTC_FEATURES_OFFSET     0x300
> +
> +/* INTC REQUEST 64 Registers (32 bits) */
> +#define INTC_REQUEST1_OFFSET     0x404
> +#define INTC_REQUEST64_OFFSET    0x500
> +
> +/* INTC MOD_ID Register (32 bits) */
> +#define INTC_MOD_ID_OFFSET       0xFFC
> +
> +/* interrupt x [1..64] request configuration */
> +#define INTC_REQUESTx(x)  IO_ADDRESS(INTC_BASE+INTC_REQUEST1_OFFSET+(x-1)*4)
> +
> +/* EXTINTx [0..23] configuration register */
> +#define EXTINT_CFGx(x)    IO_ADDRESS(EXTINT_BASE+(x)*4)

Does it really make sense to export all these definitions to the entire
kernel?

> diff --git a/arch/arm/plat-u6xxx/include/mach/memory.h b/arch/arm/plat-u6xxx/include/mach/memory.h
> new file mode 100644
> index 0000000..0fa6cea
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/include/mach/memory.h
> @@ -0,0 +1,24 @@
> +/*
> + * linux/arch/arm/plat-u6xxx/include/mach/memory.h
> + *
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Philippe Langlais <philippe.langlais@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#ifndef __ASM_ARCH_MEMORY_H
> +#define __ASM_ARCH_MEMORY_H
> +
> +/*
> + * Physical DRAM offset.
> + */
> +#define PHYS_OFFSET		UL(0x20000000)
> +#define BOOT_PARAMS_OFFSET	(PHYS_OFFSET + 0x100)

Does it make sense to export this to the world?

> +
> +/**
> + * CONSISTENT_DMA_SIZE: Size of DMA-consistent memory region.
> + * Must be multiple of 2M,between 2MB and 14MB inclusive
> + */
> +#define CONSISTENT_DMA_SIZE (SZ_2M)

It defaults to 2MB, so this definition is redundant.

> diff --git a/arch/arm/plat-u6xxx/include/mach/platform.h b/arch/arm/plat-u6xxx/include/mach/platform.h
> new file mode 100644
> index 0000000..5265ccd
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/include/mach/platform.h
> @@ -0,0 +1,15 @@
> +/*
> + * linux/arch/arm/plat-u6xxx/include/mach/platform.h
> + *
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Philippe Langlais <philippe.langlais@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#ifndef __ASM_ARCH_PLATFORM_H
> +#define __ASM_ARCH_PLATFORM_H                     1
> +
> +#include <linux/types.h>
> +#include <mach/hardware.h>
> +
> +#endif  /* __ASM_ARCH_PLATFORM_H */

If there's nothing required in this file, it doesn't need to exist.

> diff --git a/arch/arm/plat-u6xxx/include/mach/timer.h b/arch/arm/plat-u6xxx/include/mach/timer.h
> new file mode 100644
> index 0000000..049e72d
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/include/mach/timer.h
> @@ -0,0 +1,24 @@
> +/*
> + *  linux/arch/arm/plat-u6xxx/include/mach/timer.h
> + *
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Philippe Langlais <philippe.langlais@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#ifndef __PLAT_TIMER_H
> +#define __PLAT_TIMER_H
> +#ifdef U6_TIMER_C
> +#define PUBLIC
> +#else
> +#define PUBLIC extern
> +#endif

Err, no - there's really no need for such hacks in C, and I can't find
anywhere which defines U6_TIMER_C.

> +
> +struct sys_timer;
> +
> +PUBLIC struct sys_timer u6_timer;
> +
> +PUBLIC void __init u6_timer_init(void);
> +
> +#undef PUBLIC
> +#endif

> diff --git a/arch/arm/plat-u6xxx/include/mach/vmalloc.h b/arch/arm/plat-u6xxx/include/mach/vmalloc.h
> new file mode 100644
> index 0000000..583033f
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/include/mach/vmalloc.h
> @@ -0,0 +1,10 @@
> +/*
> + * linux/arch/arm/plat-u6/include/mach/vmalloc.h
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Philippe Langlais <philippe.langlais@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + *
> + * Virtual memory allocations
> + * End must be above the I/O registers and on an even 2MiB boundary.
> + */
> +#define VMALLOC_END       (PAGE_OFFSET + 0x28000000)

Is the upper limit of vmalloc space is dependent on PAGE_OFFSET?  If
not, then it shouldn't be using a calculation based upon that value.

> diff --git a/arch/arm/plat-u6xxx/timer.c b/arch/arm/plat-u6xxx/timer.c
> new file mode 100644
> index 0000000..62f13f5
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/timer.c
> @@ -0,0 +1,679 @@
> +/*
> + * linux/arch/arm/plat-u6xxx/timer.c
> + *
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Vincent Guittot <vincent.guittot@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +
> +#include <asm/mach/time.h>
> +
> +#include <mach/hardware.h>
> +
> +#include <asm/mach/irq.h>
> +#include <linux/interrupt.h>
> +#include <mach/irqs.h>
> +
> +#include <linux/clk.h>
> +
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>

linux/ includes before asm/ includes.  asm/ includes before mach/ includes
please.

> +#undef U6_TIMER_DEBUG
> +#if defined(U6_TIMER_DEBUG)
> +#define debug(fmt, args...)                                          \
> +	printk(PKMOD fmt, ## args)
> +#else
> +#define debug(fmt, args...)
> +#endif

You could use pr_debug() instead, and define 'DEBUG' at the top of the
file you want debug messages from.

> +static irqreturn_t
> +u6_mmtu_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	uint8_t status, enable;
> +	struct mmtu_ctxt *mmtu;
> +
> +	mmtu = u6_mmtu_get_context(0);
> +
> +	status = readl((mmtu->base + MMTU_INT_OFFSET + MMTU_INT_STATUS_IDX));
> +	enable = readl((mmtu->base + MMTU_INT_OFFSET + MMTU_INT_ENABLE_IDX));
> +
> +	debug("mmtu_timer_interrupt %d\n", status);
> +
> +	if (status & enable & MMTU_IRQ_MASK) {
> +		struct clock_event_device *evt = &clockevent_mmtu;
> +
> +		writel(MMTU_IRQ_MASK, (mmtu->base + MMTU_INT_OFFSET
> +					+ MMTU_INT_CLR_STAT_IDX));
> +
> +		if (mmtu->autoreload)
> +			u6_mmtu_timer_start(mmtu->compvalue, 0);

If your hardware doesn't do reloadable timers, you're not supposed to
emulate it.  The generic time infrastructure contains all the code
that's required to handle periodic timer interrupts with timers only
capable of one-shot mode.


> +		else
> +			writel(MMTU_IRQ_MASK,
> +			       (mmtu->base + MMTU_INT_OFFSET +
> +				MMTU_INT_CLR_ENA_IDX));
> +
> +		if (evt->event_handler)
> +			evt->event_handler(evt);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction u6_mmtu_timer_irq = {
> +	.name = "U6 MMTU timer Tick",
> +	.flags = IRQF_DISABLED,
> +	.handler = (irq_handler_t) u6_mmtu_timer_interrupt,
> +};
> +
> +static inline void u6_mmtu_clk_enable(int id)
> +{
> +	struct mmtu_ctxt *mmtu = u6_mmtu_get_context(id);
> +
> +	/* Clock Multimedia Timer Unit.
> +	 */
> +	if ((mmtu->clk != NULL) && (mmtu->mode == 0)) {
> +		debug("mmtu_clk_enable\n");
> +		mmtu->mode = 1;
> +		clk_enable(mmtu->clk);
> +	}
> +}
> +
> +static inline void u6_mmtu_clk_disable(int id)
> +{
> +	struct mmtu_ctxt *mmtu = u6_mmtu_get_context(id);
> +
> +	/* Clock Multimedia Timer Unit.
> +	 */
> +	if ((mmtu->clk != NULL) && (mmtu->mode == 1)) {
> +		debug("mmtu_clk_disable\n");
> +		clk_disable(mmtu->clk);
> +		mmtu->mode = 0;
> +	}
> +}
> +
> +static inline int u6_mmtu_timer_start(unsigned long cycles, int id)
> +{
> +	struct mmtu_ctxt *mmtu = u6_mmtu_get_context(id);
> +
> +	debug("mmtu_timer_start %d\n", cycles);
> +	u6_mmtu_clk_enable(id);
> +
> +	/* MMTU limitation : can't set a value smaller or equal to tcval + 1 */
> +	cycles = cycles < 2 ? 2 : cycles;
> +
> +	mmtu->compvalue = cycles;
> +
> +	mmtu->endvalue = mmtu->compvalue
> +		+ readl((mmtu->base + MMTU_TCVAL_IDX));
> +
> +	writel(MMTU_IRQ_MASK,
> +	       (mmtu->base + MMTU_INT_OFFSET + MMTU_INT_CLR_STAT_IDX));
> +
> +	writel(mmtu->endvalue, (mmtu->base + MMTU_USED_MATCH_IDX));
> +
> +	writel(MMTU_IRQ_MASK,
> +	       (mmtu->base + MMTU_INT_OFFSET + MMTU_INT_SET_ENA_IDX));
> +
> +	/* the value has already expired */
> +	if ((mmtu->endvalue <= readl((mmtu->base + MMTU_TCVAL_IDX)))
> +	    && (mmtu->endvalue > mmtu->compvalue)
> +	    && !(readl((mmtu->base + MMTU_INT_OFFSET
> +				    + MMTU_INT_STATUS_IDX)) & MMTU_IRQ_MASK))
> +		writel(MMTU_IRQ_MASK, (mmtu->base + MMTU_INT_OFFSET
> +					+ MMTU_INT_SET_STAT_IDX));
> +
> +	return 0;
> +}
> +
> +static int u6_mmtu_timer_init(int id, unsigned long reload,
> +			     unsigned long prescale, int over_it)
> +{
> +
> +	struct mmtu_ctxt *mmtu = u6_mmtu_get_context(id);
> +
> +	debug("mmtu_timer_init %d\n", id);
> +
> +	/* Enable clock */
> +/*
> +	u6_mmtu_clk_enable(id);
> +	clk mngt not available yet
> +	directly enable it
> +*/
> +	{
> +		unsigned long flags;
> +		unsigned long reg;
> +		hw_raw_local_irq_save(flags);
> +		reg = readl(CGU_GATESC2_REG);
> +		reg |= 0x1 << 2;
> +		writel(reg, CGU_GATESC2_REG);
> +		hw_raw_local_irq_restore(flags);
> +	}
> +
> +	/* Reset timer */
> +	/* reset control register */
> +	writel(0x0000, (mmtu->base + MMTU_CON_IDX));
> +	writel(0x0002, (mmtu->base + MMTU_CON_IDX));
> +	/* reset control register */
> +	writel(0x0000, (mmtu->base + MMTU_CON_IDX));
> +
> +	/* clear whole enable irq register */
> +	writel(0xFF, (mmtu->base + MMTU_INT_OFFSET + MMTU_INT_CLR_ENA_IDX));
> +	/* clear whole status register */
> +	writel(0xFF, (mmtu->base + MMTU_INT_OFFSET + MMTU_INT_CLR_STAT_IDX));
> +
> +	/* reset pre-scaler reload register */
> +	writel(0x00000000, (mmtu->base + MMTU_PRESCALER_IDX));
> +
> +	/* reset match control register */
> +	writel(0x0000, (mmtu->base + MMTU_MATCH_CON_IDX));
> +	/* reset match 0 register */
> +	writel(0x00000000, (mmtu->base + MMTU_MATCH0_IDX));
> +	/* reset match 1 register */
> +	writel(0x00000000, (mmtu->base + MMTU_MATCH1_IDX));
> +
> +	/* Initialize timer */
> +	writel(prescale - 1, (mmtu->base + MMTU_PRESCALER_IDX));
> +	/* power of 2 system clock */
> +	writel(reload, (mmtu->base + MMTU_MATCH0_IDX));
> +
> +	/* enable counter register */
> +	writel(0x0001, (mmtu->base + MMTU_CON_IDX));
> +
> +	/* clear whole status register */
> +	writel(0xFF, (mmtu->base + MMTU_INT_OFFSET + MMTU_INT_CLR_STAT_IDX));
> +
> +	if (id == 0)
> +		setup_irq(IRQ_MMTU, &u6_mmtu_timer_irq);
> +
> +	/* Disable clock */
> +#ifndef U6_MMTU_CLOCK_SOURCE
> +	u6_mmtu_clk_disable(id);
> +#endif
> +	return 0;
> +}
> +
> +/*** MMTU Clock event device ***/
> +
> +static int u6_mmtu_set_next_event(unsigned long cycles,
> +				 struct clock_event_device *evt)
> +{
> +	debug("mmtu_set_next_event %d\n", cycles);
> +	u6_mmtu_timer_start(cycles, 0);
> +
> +	return 0;
> +}
> +
> +static void u6_mmtu_set_mode(enum clock_event_mode mode,
> +			    struct clock_event_device *evt)
> +{
> +	struct mmtu_ctxt *mmtu = u6_mmtu_get_context(0);
> +	unsigned long reg;
> +
> +	debug("mmtu_set_mode %d\n", mode);
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_UNUSED:
> +		writel(MMTU_IRQ_MASK,
> +		       (mmtu->base + MMTU_INT_OFFSET + MMTU_INT_CLR_ENA_IDX));
> +		writel(MMTU_IRQ_MASK,
> +		       (mmtu->base + MMTU_INT_OFFSET + MMTU_INT_CLR_STAT_IDX));
> +
> +		reg = readl((mmtu->base + MMTU_TCVAL_IDX));
> +		writel(reg - 1, (mmtu->base + MMTU_USED_MATCH_IDX));
> +
> +#ifndef U6_MMTU_CLOCK_SOURCE
> +		u6_mmtu_clk_disable(0);
> +
> +		if (mmtu->clk != NULL)
> +			clk_put(mmtu->clk);
> +#endif
> +		mmtu->autoreload = 0;
> +		break;
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +		mmtu->autoreload = 0;
> +
> +		if (mmtu->clk == NULL) {
> +			mmtu->clk = clk_get(0, "MMTU");
> +			if (IS_ERR(mmtu->clk))
> +				mmtu->clk = NULL;
> +		}
> +
> +		writel(MMTU_IRQ_MASK,
> +		       (mmtu->base + MMTU_INT_OFFSET + MMTU_INT_CLR_STAT_IDX));
> +		writel(MMTU_IRQ_MASK,
> +		       (mmtu->base + MMTU_INT_OFFSET + MMTU_INT_SET_ENA_IDX));
> +	case CLOCK_EVT_MODE_ONESHOT:
> +	case CLOCK_EVT_MODE_RESUME:
> +		mmtu->autoreload = 0;
> +		break;
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		writel(MMTU_IRQ_MASK,
> +		       (mmtu->base + MMTU_INT_OFFSET + MMTU_INT_SET_ENA_IDX));
> +		mmtu->autoreload = 1;
> +		break;
> +	}
> +}
> +
> +static void u6_clockevent_init_mmtu(void)
> +{
> +	printk(PKMOD "clockevent_init_mmtu\n");
> +
> +	/* prescale 13Mhz -> 1Mhz */
> +#ifndef U6_MMTU_CLOCK_SOURCE
> +	u6_mmtu_timer_init(0, 0, (MMTU_SYS_FRQ / MMTU_ROOT_FRQ), 0);
> +#endif
> +
> +/* issue it is shorter than reality and generates spurious irq */
> +/*      clockevent_mmtu.mult = div_sc(MMTU_ROOT_FRQ, NSEC_PER_SEC,
> + *      clockevent_mmtu.shift) + 1;*/
> +	clockevent_mmtu.mult =
> +	    div_sc(MMTU_ROOT_FRQ, NSEC_PER_SEC, clockevent_mmtu.shift);
> +
> +/*      clockevent_mmtu.max_delta_ns = div_sc(RELOAD_COUNTER_MMTU,
> + *      clockevent_mmtu.mult, clockevent_mmtu.shift);*/
> +/*  In fact it is wider than the 32bits variable !!! */
> +	clockevent_mmtu.max_delta_ns = 0xFFFFFFFF;
> +
> +/*  MMTU HW limitation: match register can't be set w/ tcval+1 */
> +/*      clockevent_mmtu.min_delta_ns = div_sc(1, clockevent_mmtu.mult,
> + *      clockevent_mmtu.shift)+1;*/
> +	clockevent_mmtu.min_delta_ns =
> +	    div_sc(2, clockevent_mmtu.mult, clockevent_mmtu.shift) + 1;
> +	/* avoid to much timer interrupt with 10us min between 2 irq */
> +	if (clockevent_mmtu.min_delta_ns < 10000)
> +		clockevent_mmtu.min_delta_ns = 10000;
> +	else if (clockevent_mmtu.max_delta_ns < 10000)
> +		clockevent_mmtu.min_delta_ns = clockevent_mmtu.max_delta_ns>>1;
> +
> +	clockevent_mmtu.cpumask = get_cpu_mask(0);
> +	clockevents_register_device(&clockevent_mmtu);
> +
> +	u6_mmtu_set_next_event(MMTU_ROOT_FRQ / HZ, &clockevent_mmtu);
> +}
> +
> +/*** MMTU Clock source device ***/
> +#ifdef U6_MMTU_CLOCK_SOURCE
> +
> +static cycle_t u6_mmtu_read(struct clocksource *source)
> +{
> +	struct mmtu_ctxt *mmtu = u6_mmtu_get_context(0);
> +
> +	return readl((mmtu->base + MMTU_TCVAL_IDX)) & source->mask;
> +}

Clocksource read functions don't require the value masking.

> +
> +static void u6_clocksource_init_mmtu(void)
> +{
> +	printk(PKMOD "clocksource_init_mmtu\n");
> +
> +	if (MMTU_ROOT_FRQ >= 1000000)
> +		clocksource_mmtu.mult =
> +		    clocksource_khz2mult((MMTU_ROOT_FRQ / 1000),
> +					 clocksource_mmtu.shift);
> +	else
> +		clocksource_mmtu.mult = clocksource_hz2mult((MMTU_ROOT_FRQ),
> +				clocksource_mmtu.shift);
> +
> +	u6_mmtu_timer_init(0, 0, (MMTU_SYS_FRQ / MMTU_ROOT_FRQ), 0);
> +
> +	clocksource_register(&clocksource_mmtu);
> +}
> +
> +unsigned long long u6_mmtu_time(void)
> +{
> +	unsigned long long ticks64 = u6_mmtu_read(&clocksource_mmtu);
> +
> +	return (ticks64 * clocksource_mmtu.mult) >> clocksource_mmtu.shift;
> +}

Can you explain the purpose of this function please, and why you export
the ticks and value from this function via sysfs?

> +#endif
> +
> +/*** SysFs interface ***/
> +/***********************/
> +#ifdef CONFIG_U6_POWER_SYSFS
> +
> +/*** Clock event sysfs interface **/
> +
> +#define shows_one_evt(file_name, object)				\
> +static ssize_t show_##file_name##_evt					\
> +(struct kobject *kobj, char *buf)				\
> +{									\
> +	return sprintf(buf, "%s\n", clockevent_mmtu.object);		\
> +}
> +
> +#define showu_one_evt(file_name, object)				\
> +static ssize_t show_##file_name##_evt					\
> +(struct kobject *kobj, char *buf)				\
> +{									\
> +	return sprintf(buf, "%u\n", clockevent_mmtu.object);		\
> +}
> +
> +#define showlu_one_evt(file_name, object)				\
> +static ssize_t show_##file_name##_evt					\
> +(struct kobject *kobj, char *buf)				\
> +{									\
> +	return sprintf(buf, "%lu\n", clockevent_mmtu.object);		\
> +}
> +
> +#define storelu_one_evt(file_name, object)				\
> +static ssize_t store_##file_name##_evt					\
> +(struct kobject *kobj, const char *buf, size_t size)			\
> +{									\
> +	unsigned long object; \
> +	strict_strtoul(buf, 10, &object); \
> +	clockevent_mmtu.object = object; \
> +	return size;		\
> +}
> +
> +#define showx_one_evt(file_name, object)				\
> +static ssize_t show_##file_name##_evt					\
> +(struct kobject *kobj, char *buf)				\
> +{									\
> +	return sprintf(buf, "0x%x\n", clockevent_mmtu.object);		\
> +}
> +
> +shows_one_evt(name, name);
> +showu_one_evt(rating, rating);
> +showlu_one_evt(mult, mult);
> +#ifdef CONFIG_U6_TIMER_TUNE
> +storelu_one_evt(mult, mult);
> +#endif
> +showu_one_evt(shift, shift);
> +showx_one_evt(features, features);
> +showlu_one_evt(min_delta_ns, min_delta_ns);
> +showlu_one_evt(max_delta_ns, max_delta_ns);

Why do you want all these parameters exported to userspace?  Maybe you
should discuss your requirement here with the generic time people
before submitting it?
