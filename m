From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 13 May 2014 11:10:01 +0200
Subject: [PATCH v3 1/6] clocksource: Add support for the Mediatek SoCs
In-Reply-To: <20140513055405.GA3348@lukather>
References: <1399938570-11356-1-git-send-email-matthias.bgg@gmail.com>
 <1399938570-11356-2-git-send-email-matthias.bgg@gmail.com>
 <20140513055405.GA3348@lukather>
Message-ID: <CABuKBeKboKT7WdJYGj73uNT-Nc+0UEn5kQE1-9G5uxQJvB+FGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-05-13 7:54 GMT+02:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> On Tue, May 13, 2014 at 01:49:25AM +0200, Matthias Brugger wrote:
>> This patch adds a clock source and clock event for the timer found
>> on the Mediatek SoCs.
>>
>> The Mediatek General Porpose Timer block provides five 32 bit timers and
>> one 64 bit timer.
>>
>> Two 32 bit timers are used:
>> TIMER1: clock events supporting periodic and oneshot events
>> TIMER2: clock source configured as a free running counter
>>
>> The General Porpose Timer block can be run with two clocks. A 13 MHz system
>> clock and the RTC clock running at 32 KHz. This implementation uses the system
>> clock.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>  drivers/clocksource/Kconfig     |   4 +
>>  drivers/clocksource/Makefile    |   1 +
>>  drivers/clocksource/mtk_timer.c | 263 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 268 insertions(+)
>>  create mode 100644 drivers/clocksource/mtk_timer.c
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 96918e1..1f73740 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -144,6 +144,10 @@ config VF_PIT_TIMER
>>  config SYS_SUPPORTS_SH_CMT
>>          bool
>>
>> +config MTK_TIMER
>> +     select CLKSRC_MMIO
>> +     bool
>> +
>>  config SYS_SUPPORTS_SH_MTU2
>>          bool
>>
>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> index 98cb6c5..619d302 100644
>> --- a/drivers/clocksource/Makefile
>> +++ b/drivers/clocksource/Makefile
>> @@ -33,6 +33,7 @@ obj-$(CONFIG_CLKSRC_EXYNOS_MCT)     += exynos_mct.o
>>  obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)     += samsung_pwm_timer.o
>>  obj-$(CONFIG_VF_PIT_TIMER)   += vf_pit_timer.o
>>  obj-$(CONFIG_CLKSRC_QCOM)    += qcom-timer.o
>> +obj-$(CONFIG_MTK_TIMER)              += mtk_timer.o
>>
>>  obj-$(CONFIG_ARM_ARCH_TIMER)         += arm_arch_timer.o
>>  obj-$(CONFIG_ARM_GLOBAL_TIMER)               += arm_global_timer.o
>> diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
>> new file mode 100644
>> index 0000000..4b88065
>> --- /dev/null
>> +++ b/drivers/clocksource/mtk_timer.c
>> @@ -0,0 +1,263 @@
>> +/*
>> + * Mediatek SoCs General-Purpose Timer handling.
>> + *
>> + * Copyright (C) 2014 Matthias Brugger
>> + *
>> + * Matthias Brugger <matthias.bgg@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clockchips.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqreturn.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/slab.h>
>> +
>> +#define GPT_IRQ_EN_REG               0x00
>> +#define GPT_IRQ_ENABLE(val)  BIT(val-1)
>> +#define GPT_IRQ_ST_REG               0x04
>> +#define GPT_IRQ_ACK_REG              0x08
>> +#define GPT_IRQ_ACK(val)     BIT(val-1)
>> +
>> +#define TIMER_CTRL_REG(val)  (0x10 * val)
>> +#define TIMER_CTRL_OP(val)   (((val) & 0x3) << 4)
>> +#define TIMER_CTRL_OP_ONESHOT        (0)
>> +#define TIMER_CTRL_OP_REPEAT (1)
>> +#define TIMER_CTRL_OP_KEEPGO (2)
>> +#define TIMER_CTRL_OP_FREERUN        (3)
>> +#define TIMER_CTRL_CLEAR     (2)
>> +#define TIMER_CTRL_ENABLE    (1)
>> +#define TIMER_CTRL_DISABLE   (0)
>> +
>> +#define TIMER_CLK_REG(val)   (0x04 + (0x10 * val))
>> +#define TIMER_CLK_SRC(val)   (((val) & 0x1) << 4)
>> +#define TIMER_CLK_SRC_SYS13M (0)
>> +#define TIMER_CLK_SRC_RTC32K (1)
>> +#define TIMER_CLK_DIV1               (0x0)
>> +#define TIMER_CLK_DIV2               (0x1)
>> +#define TIMER_CLK_DIV3               (0x2)
>> +#define TIMER_CLK_DIV4               (0x3)
>> +#define TIMER_CLK_DIV5               (0x4)
>> +#define TIMER_CLK_DIV6               (0x5)
>> +#define TIMER_CLK_DIV7               (0x6)
>> +#define TIMER_CLK_DIV8               (0x7)
>> +#define TIMER_CLK_DIV9               (0x8)
>> +#define TIMER_CLK_DIV10              (0x9)
>> +#define TIMER_CLK_DIV11              (0xA)
>> +#define TIMER_CLK_DIV12              (0xB)
>> +#define TIMER_CLK_DIV13              (0xC)
>> +#define TIMER_CLK_DIV16              (0xD)
>> +#define TIMER_CLK_DIV32              (0xE)
>> +#define TIMER_CLK_DIV64              (0xF)
>> +
>> +#define TIMER_CNT_REG(val)   (0x08 + (0x10 * val))
>> +#define TIMER_CMP_REG(val)   (0x0C + (0x10 * val))
>> +
>> +#define GPT_CLK_EVT  1
>> +#define GPT_CLK_SRC  2
>> +
>> +
>> +
>> +struct mtk_clock_event_device {
>> +     void __iomem *gpt_base;
>> +     u32 ticks_per_jiffy;
>> +     struct clock_event_device dev;
>> +};
>> +
>> +static inline struct mtk_clock_event_device *to_mtk_clk(
>> +                             struct clock_event_device *c)
>> +{
>> +     return container_of(c, struct mtk_clock_event_device, dev);
>> +}
>> +
>> +static void mtk_clkevt_time_stop(struct mtk_clock_event_device *evt, u8 timer)
>> +{
>> +     u32 val = readl(evt->gpt_base + TIMER_CTRL_REG(timer));
>> +     writel(val & ~TIMER_CTRL_ENABLE, evt->gpt_base +
>> +                     TIMER_CTRL_REG(timer));
>> +}
>> +
>> +static void mtk_clkevt_time_setup(struct mtk_clock_event_device *evt,
>> +                             unsigned long delay, u8 timer)
>> +{
>> +     writel(delay, evt->gpt_base + TIMER_CMP_REG(timer));
>> +}
>> +
>> +static void mtk_clkevt_time_start(struct mtk_clock_event_device *evt,
>> +             bool periodic, u8 timer)
>> +{
>> +     u32 val;
>> +
>> +     /* Acknowledge interrupt */
>> +     writel(GPT_IRQ_ACK(timer), evt->gpt_base + GPT_IRQ_ACK_REG);
>> +
>> +     val = readl(evt->gpt_base + TIMER_CTRL_REG(timer));
>> +
>> +     /* Clear 2 bit timer operation mode field */
>> +     val &= ~TIMER_CTRL_OP(0x3);
>> +
>> +     if (periodic)
>> +             val |= TIMER_CTRL_OP(TIMER_CTRL_OP_REPEAT);
>> +     else
>> +             val |= TIMER_CTRL_OP(TIMER_CTRL_OP_ONESHOT);
>> +
>> +     writel(val | TIMER_CTRL_ENABLE | TIMER_CTRL_CLEAR,
>> +            evt->gpt_base + TIMER_CTRL_REG(timer));
>> +}
>> +
>> +static void mtk_clkevt_mode(enum clock_event_mode mode,
>> +                             struct clock_event_device *clk)
>> +{
>> +     struct mtk_clock_event_device *evt = to_mtk_clk(clk);
>> +
>> +     mtk_clkevt_time_stop(evt, GPT_CLK_EVT);
>> +
>> +     switch (mode) {
>> +     case CLOCK_EVT_MODE_PERIODIC:
>> +             mtk_clkevt_time_setup(evt, evt->ticks_per_jiffy, GPT_CLK_EVT);
>> +             mtk_clkevt_time_start(evt, true, GPT_CLK_EVT);
>> +             break;
>> +     case CLOCK_EVT_MODE_ONESHOT:
>> +             mtk_clkevt_time_start(evt, false, GPT_CLK_EVT);
>> +             break;
>> +     case CLOCK_EVT_MODE_UNUSED:
>> +     case CLOCK_EVT_MODE_SHUTDOWN:
>> +     default:
>> +             /* No more interrupts will occur as source is disabled */
>> +             break;
>> +     }
>> +}
>> +
>> +static int mtk_clkevt_next_event(unsigned long event,
>> +                                struct clock_event_device *clk)
>> +{
>> +     struct mtk_clock_event_device *evt = to_mtk_clk(clk);
>> +
>> +     mtk_clkevt_time_stop(evt, GPT_CLK_EVT);
>> +     mtk_clkevt_time_setup(evt, event, GPT_CLK_EVT);
>> +     mtk_clkevt_time_start(evt, false, GPT_CLK_EVT);
>> +
>> +     return 0;
>> +}
>> +
>> +static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
>> +{
>> +     struct mtk_clock_event_device *evt = dev_id;
>> +
>> +     /* Acknowledge timer0 irq */
>> +     writel(GPT_IRQ_ACK(GPT_CLK_EVT), evt->gpt_base + GPT_IRQ_ACK_REG);
>> +     evt->dev.event_handler(&evt->dev);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static void mtk_timer_global_reset(struct mtk_clock_event_device *evt)
>> +{
>> +     /* Disable all interrupts */
>> +     writel(0x0, evt->gpt_base + GPT_IRQ_EN_REG);
>> +     /* Acknowledge all interrupts */
>> +     writel(0x3f, evt->gpt_base + GPT_IRQ_ACK_REG);
>> +}
>> +
>> +static void mtk_timer_reset(struct mtk_clock_event_device *evt, u8 timer)
>> +{
>> +     writel(TIMER_CTRL_CLEAR | TIMER_CTRL_DISABLE,
>> +             evt->gpt_base + TIMER_CTRL_REG(timer));
>> +     writel(0x0, evt->gpt_base + TIMER_CMP_REG(timer));
>> +}
>> +
>> +static void __init mtk_timer_init(struct device_node *node)
>> +{
>> +     struct mtk_clock_event_device *evt;
>> +     struct resource res;
>> +     unsigned long rate = 0;
>> +     struct clk *clk;
>> +     int ret;
>> +     u32 val;
>> +
>> +     evt = kzalloc(sizeof(*evt), GFP_KERNEL);
>> +     if (!evt)
>> +             panic("Can't allocate mtk clock event driver struct");
>> +
>> +     evt->dev.name = "mtk_tick";
>> +     evt->dev.rating = 300;
>> +     evt->dev.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>> +     evt->dev.set_mode = mtk_clkevt_mode;
>> +     evt->dev.set_next_event = mtk_clkevt_next_event;
>> +     evt->dev.cpumask = cpu_all_mask;
>
> cpu_possible_mask would probably be a better fit. And you still forgot
> to set the irq field of this struct.

I set the irq field when parsing the irq from the dts. Or do you refer
to a different field I'm not aware of?

Cheers,
Matthias

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com



-- 
motzblog.wordpress.com
