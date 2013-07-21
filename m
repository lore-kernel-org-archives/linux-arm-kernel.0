From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 21 Jul 2013 10:14:20 +0200
Subject: [PATCH 2/5] ARM: bcm4760: Add system timer
In-Reply-To: <20130721002713.813400062@gmail.com>
References: <20130721002320.730568671@gmail.com>
 <20130721002713.813400062@gmail.com>
Message-ID: <201307211014.21161.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Daniel Lezcano

On Sunday 21 July 2013, Domenico Andreoli wrote:

> Index: b/Documentation/devicetree/bindings/timer/brcm,bcm4760-system-timer.txt
> ===================================================================
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/brcm,bcm4760-system-timer.txt
> @@ -0,0 +1,23 @@
> +Broadcom BCM4760 System Timer device tree bindings
> +--------------------------------------------------
> +
> +The BCM4760 Timer peripheral provides either two or four 32-bit timer
> +channels. Three timer blocks are available at 0xba000, 0xbb000 and
> +0xd1000. The first two provide four channels, the last (in the AON -
> +Always ON power domain) provides only two.
> +
> +Required properties:
> +
> +- compatible : should be "brcm,bcm4760-system-timer"
> +- reg : Specifies base physical address and size of the registers.
> +- interrupts : A list of 2 or 4 interrupt sinks; one per timer channel.
> +- clock-frequency : The frequency of the clock that drives the counter, in Hz.

I think the current consensus is that if you have a clock driver (as added in
patch 4), you should use a 'clocks' reference and clk_get_rate() to find the
frequency rather than an explicit clock-frequency property.

I have no comments on the driver, the rest is quoted so Daniel can find it
more easily.

	Arnd

> +Example:
> +
> +timer at ba000 {
> +	compatible = "brcm,bcm4760-system-timer";
> +	reg = <0xba000 0x1000>;
> +	interrupts = <4>, <11>;
> +	clock-frequency = <24000000>;
> +};
> Index: b/arch/arm/boot/dts/bcm4760.dtsi
> ===================================================================
> --- a/arch/arm/boot/dts/bcm4760.dtsi
> +++ b/arch/arm/boot/dts/bcm4760.dtsi
> @@ -10,6 +10,14 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		timer at ba000 {
> +			compatible = "brcm,bcm4760-system-timer";
> +			reg = <0xba000 0x1000>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <4>, <11>;
> +			clock-frequency = <24000000>;
> +		};
> +
>  		vic0: interrupt-controller at 80000 {
>  			compatible = "brcm,bcm4760-pl192", "arm,pl192-vic", "arm,primecell";
>  			reg = <0x80000 0x1000>;
> Index: b/drivers/clocksource/Makefile
> ===================================================================
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clk
>  obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
>  obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
>  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
> +obj-$(CONFIG_ARCH_BCM4760)	+= bcm4760_timer.o
>  obj-$(CONFIG_ARCH_MARCO)	+= timer-marco.o
>  obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
>  obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
> Index: b/drivers/clocksource/bcm4760_timer.c
> ===================================================================
> --- /dev/null
> +++ b/drivers/clocksource/bcm4760_timer.c
> @@ -0,0 +1,170 @@
> +/*
> + * Broadcom BCM4760 based ARM11 SoCs system timer
> + *
> + * Copyright (C) 2012 Domenico Andreoli <domenico.andreoli@linux.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/clockchips.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +
> +#define TIMER_LOAD_OFFSET          0x00          /* load */
> +#define TIMER_VALUE_OFFSET         0x04          /* value */
> +#define TIMER_CONTROL_OFFSET       0x08          /* control */
> +#define TIMER_INTCLR_OFFSET        0x0c          /* interrupt clear */
> +#define TIMER_RIS_OFFSET           0x10          /* raw interrupt */
> +#define TIMER_MIS_OFFSET           0x14          /* masked interrupt status */
> +#define TIMER_BGLOAD_OFFSET        0x18          /* background load */
> +
> +#define TIMER_CTRL_ONESHOTMODE     BIT(0)        /* One shot mode */
> +#define TIMER_CTRL_32BIT           BIT(1)        /* 32-bit counter mode */
> +#define TIMER_CTRL_IE              BIT(5)        /* Interrupt enable */
> +#define TIMER_CTRL_PERIODIC        BIT(6)        /* Periodic mode */
> +#define TIMER_CTRL_EN              BIT(7)        /* Timer enable */
> +#define TIMER_CTRL_CLK2            BIT(9)        /* Clock 2 selected */
> +#define TIMER_CTRL_PREBY16         (1 << 2)      /* prescale divide by 16 */
> +#define TIMER_CTRL_PREBY256        (2 << 2)      /* prescale divide by 256 */
> +
> +struct bcm4760_timer {
> +	void __iomem *base;
> +	struct clock_event_device evt;
> +	struct irqaction act;
> +};
> +
> +static inline void __iomem *to_load(struct bcm4760_timer *timer)
> +{
> +	return timer->base + TIMER_LOAD_OFFSET;
> +}
> +
> +static inline void __iomem *to_control(struct bcm4760_timer *timer)
> +{
> +	return timer->base + TIMER_CONTROL_OFFSET;
> +}
> +
> +static inline void __iomem *to_intclr(struct bcm4760_timer *timer)
> +{
> +	return timer->base + TIMER_INTCLR_OFFSET;
> +}
> +
> +static inline void __iomem *to_ris(struct bcm4760_timer *timer)
> +{
> +	return timer->base + TIMER_RIS_OFFSET;
> +}
> +
> +static inline void __iomem *to_mis(struct bcm4760_timer *timer)
> +{
> +	return timer->base + TIMER_MIS_OFFSET;
> +}
> +
> +static void bcm4760_timer_set_mode(enum clock_event_mode mode,
> +	struct clock_event_device *evt_dev)
> +{
> +	struct bcm4760_timer *timer;
> +	u32 val;
> +
> +	timer = container_of(evt_dev, struct bcm4760_timer, evt);
> +	val = TIMER_CTRL_CLK2 | TIMER_CTRL_32BIT |
> +	      TIMER_CTRL_IE | TIMER_CTRL_EN;
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		writel(val | TIMER_CTRL_ONESHOTMODE, to_control(timer));
> +		break;
> +	case CLOCK_EVT_MODE_RESUME:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +		break;
> +	default:
> +		WARN(1, "%s: unhandled event mode %d\n", __func__, mode);
> +		break;
> +	}
> +}
> +
> +static int bcm4760_timer_set_next_event(unsigned long event,
> +	struct clock_event_device *evt_dev)
> +{
> +	struct bcm4760_timer *timer;
> +
> +	timer = container_of(evt_dev, struct bcm4760_timer, evt);
> +	writel(event, to_load(timer));
> +	return 0;
> +}
> +
> +static irqreturn_t bcm4760_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct bcm4760_timer *timer = dev_id;
> +	void (*event_handler)(struct clock_event_device *);
> +
> +	/* check the (masked) interrupt status */
> +	if (!readl_relaxed(to_mis(timer)))
> +		return IRQ_NONE;
> +
> +	/* clear the timer interrupt */
> +	writel_relaxed(1, to_intclr(timer));
> +
> +	event_handler = ACCESS_ONCE(timer->evt.event_handler);
> +	if (event_handler)
> +		event_handler(&timer->evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void __init bcm4760_init_time(struct device_node *node)
> +{
> +	void __iomem *base;
> +	u32 freq;
> +	int irq;
> +	struct bcm4760_timer *timer;
> +
> +	base = of_iomap(node, 0);
> +	if (!base)
> +		panic("Can't remap timer registers");
> +
> +	if (of_property_read_u32(node, "clock-frequency", &freq))
> +		panic("Can't read timer frequency");
> +
> +	/* TODO allow other frequences by using pre-scaling parameters */
> +	if (freq != 24000000)
> +		panic("Invalid timer frequency");
> +
> +	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
> +	if (!timer)
> +		panic("Can't allocate timer struct\n");
> +
> +	irq = irq_of_parse_and_map(node, 0);
> +	if (irq <= 0)
> +		panic("Can't parse timer IRQ");
> +
> +	timer->base = base;
> +	timer->evt.name = node->name;
> +	timer->evt.rating = 300;
> +	timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
> +	timer->evt.set_mode = bcm4760_timer_set_mode;
> +	timer->evt.set_next_event = bcm4760_timer_set_next_event;
> +	timer->evt.cpumask = cpumask_of(0);
> +	timer->act.name = node->name;
> +	timer->act.flags = IRQF_TIMER | IRQF_SHARED;
> +	timer->act.dev_id = timer;
> +	timer->act.handler = bcm4760_timer_interrupt;
> +
> +	if (setup_irq(irq, &timer->act))
> +		panic("Can't set up timer IRQ\n");
> +
> +	clockevents_config_and_register(&timer->evt, freq, 0xf, 0xffffffff);
> +}
> +
> +CLOCKSOURCE_OF_DECLARE(bcm4760, "brcm,bcm4760-system-timer", bcm4760_init_time);
> 
> 
