From: vw@iommu.org (Wan Zongshun)
Date: Tue, 5 Jul 2016 16:21:19 +0800
Subject: [PATCH 3/6] Clocksource: add nuc970 clocksource driver
In-Reply-To: <5771827E.1090609@linaro.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <1466851042-22239-4-git-send-email-vw@iommu.org>
 <5771827E.1090609@linaro.org>
Message-ID: <577B6DFF.9000703@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016?06?28? 03:46, Daniel Lezcano wrote:
> On 06/25/2016 12:37 PM, Wan Zongshun wrote:
>> This patch is to add nuc970 clocksource driver support.
>
> Hi Wan,
>
> add a detailed description of how works this timer and its general
> design. If there is a pointer or a reference to a manual that would be
> awesome.

Daniel,

I add a document link to you, and I will update this link in my patch later.

https://github.com/zswan/nuc900-document/blob/master/NUC970_TechnicalReferenceManual_EN_Rev1.30.pdf

>
>
>> Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
>> ---
>>   .../mach-w90x900/include/mach/nuc970-regs-timer.h  |  44 +++++
>>   drivers/clocksource/Kconfig                        |   8 +
>>   drivers/clocksource/Makefile                       |   1 +
>>   drivers/clocksource/timer-nuc900.c                 | 207
>> +++++++++++++++++++++
>>   4 files changed, 260 insertions(+)
>>   create mode 100644
>> arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h
>>   create mode 100644 drivers/clocksource/timer-nuc900.c
>>
>> diff --git a/arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h
>> b/arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h
>> new file mode 100644
>> index 0000000..43d7e8b
>> --- /dev/null
>> +++ b/arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h
>> @@ -0,0 +1,44 @@
>> +/*
>> + * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +#ifndef __ASM_ARCH_REGS_TIMER_H
>> +#define __ASM_ARCH_REGS_TIMER_H
>> +
>> +/* Timer Registers */
>> +
>> +#define TMR_BA            0x0
>> +
>> +#define REG_TMR_TCSR0        (TMR_BA+0x00)
>> +#define REG_TMR_TICR0        (TMR_BA+0x04)
>> +#define REG_TMR_TDR0        (TMR_BA+0x08)
>> +
>> +
>> +#define REG_TMR_TCSR1        (TMR_BA+0x10)
>> +#define REG_TMR_TICR1        (TMR_BA+0x14)
>> +#define REG_TMR_TDR1        (TMR_BA+0x18)
>> +
>> +
>> +#define REG_TMR_TCSR2        (TMR_BA+0x20)
>> +#define REG_TMR_TICR2        (TMR_BA+0x24)
>> +#define REG_TMR_TDR2        (TMR_BA+0x28)
>> +
>> +#define REG_TMR_TCSR3        (TMR_BA+0x30)
>> +#define REG_TMR_TICR3        (TMR_BA+0x34)
>> +#define REG_TMR_TDR3        (TMR_BA+0x38)
>> +
>> +#define REG_TMR_TCSR4        (TMR_BA+0x40)
>> +#define REG_TMR_TICR4        (TMR_BA+0x44)
>> +#define REG_TMR_TDR4        (TMR_BA+0x48)
>> +
>> +#define REG_TMR_TISR        (TMR_BA+0x60)
>
> Are these macros used only in the timer driver or somewhere else ?

They are using by the timer driver, and I will try to move 
mach-w90x900/include/mach/nuc970-regs-timer.h out of mach/ folder.

Do you think I should move those macros into this driver file?

>
>> +#endif /*  __ASM_ARCH_REGS_TIMER_H */
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 47352d2..441c5ee 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -427,4 +427,12 @@ config CLKSRC_ST_LPC
>>         Enable this option to use the Low Power controller timer
>>         as clocksource.
>>
>> +config NUC900_TIMER
>> +        bool "Clocksource timer for nuc900 platform" if COMPILE_TEST
>> +        depends on ARM
>> +        select CLKSRC_OF if OF
>> +        select CLKSRC_MMIO
>> +        help
>> +          Enables the clocksource for the NUC900 platform.
>> +
>>   endmenu
>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> index 473974f..fcc2cc7 100644
>> --- a/drivers/clocksource/Makefile
>> +++ b/drivers/clocksource/Makefile
>> @@ -67,3 +67,4 @@ obj-$(CONFIG_H8300_TMR16)        += h8300_timer16.o
>>   obj-$(CONFIG_H8300_TPU)            += h8300_tpu.o
>>   obj-$(CONFIG_CLKSRC_ST_LPC)        += clksrc_st_lpc.o
>>   obj-$(CONFIG_X86_NUMACHIP)        += numachip.o
>> +obj-$(CONFIG_ARCH_W90X900)        += timer-nuc900.o
>
> obj-$(CONFIG_NUC900_TIMER)

Sure, changed.
>
>> diff --git a/drivers/clocksource/timer-nuc900.c
>> b/drivers/clocksource/timer-nuc900.c
>> new file mode 100644
>> index 0000000..6ba025c
>> --- /dev/null
>> +++ b/drivers/clocksource/timer-nuc900.c
>> @@ -0,0 +1,207 @@
>> +/*
>> + * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/irq.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/clockchips.h>
>> +#include <linux/types.h>
>> +#include <linux/clk.h>
>> +
>> +#include <linux/io.h>
>> +#include <asm/mach/time.h>
>> +
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +
>> +#include <mach/mfp.h>
>> +#include <mach/map.h>
>> +#include <mach/nuc970-regs-timer.h>
>> +#include <mach/hardware.h>
>> +#include <mach/regs-clock.h>
>
> Please do a cleanup with these headers.

Ok.

>
>> +#define RESETINT    0x1f
>> +#define PERIOD        (0x01 << 27)
>
> PERIODIC

Ok.
>
>> +#define ONESHOT        (0x00 << 27)
>> +#define COUNTEN        (0x01 << 30)
>> +#define INTEN        (0x01 << 29)
>> +
>> +#define TICKS_PER_SEC    100
>> +/* Divider = prescale + 1 */
>> +#define PRESCALE    0x63
>> +
>> +#define    TDR_SHIFT    24
>> +#define    TDR_MASK    ((1 << TDR_SHIFT) - 1)
>> +
>> +static unsigned int timer0_load;
>> +static void __iomem *tmr_base;
>> +
>
> Structure and container_of:
>
> struct nuc970_clockevents {
>      struct clock_event_device clkevt;
>      unsigned int timer0_load;
>      void __iomem *tmr_base;
> };
>
> struct nuc970_clockevents *clkevt_to_nuc970(
>      struct clock_event_device *ced)
> {
>      return container_of(ced, struct nuc970_clockevents, clkevt);
> }

Looks better, thanks.

>
>> +static int nuc970_clockevent_set_oneshot(struct clock_event_device *evt)
>> +{
>> +    unsigned int val;
>
>      struct nuc970_clockevents *nuc = clkevt_to_nuc970(evt);
>
>      val = __raw_readl(nuc->tmr_base + REG_TMR_TCSR0);
>> +
>> +
>> +    val &= ~(0x03 << 27);
>
> (0x03 << 27)  ==> #define BLABLA_MASK (0x03 << 27)
Ok.
>
>> +
>> +    val |= (ONESHOT | COUNTEN | INTEN | PRESCALE);
>> +
>> +    __raw_writel(val, tmr_base + REG_TMR_TCSR0);
>> +    return 0;
>> +}
>> +
>> +static int nuc970_clockevent_set_periodic(struct clock_event_device
>> *evt)
>> +{
>> +    unsigned int val;
>> +
>> +    val = __raw_readl(tmr_base + REG_TMR_TCSR0);
>> +    val &= ~(0x03 << 27);
>> +
>> +    __raw_writel(timer0_load, tmr_base + REG_TMR_TICR0);
>> +    val |= (PERIOD | COUNTEN | INTEN | PRESCALE);
>> +
>> +    __raw_writel(val, tmr_base + REG_TMR_TCSR0);
>> +
>> +    return 0;
>> +}
>
> May be you can factour out:
>
> static int nuc970_clockevent_set(bool periodic, void __iomem *addr)
> {
>      unsigned int val;
>
>      val = __raw_readl(addr + REG_TMR_TCSR0);
>      val &= ULTRA_MASK;
>
>      val |= (COUNTEN | INTEN | PRESCALE);
>      val |= periodic ? PERIODIC : ONESHOT;
>
>      return __raw_writel(timer0_load, tmr_base + REG_TMR_TICR0);
> }

Ok, will change.

>
>> +
>> +static int nuc970_clockevent_setnextevent(unsigned long evt,
>> +        struct clock_event_device *clk)
>> +{
>> +    unsigned int tcsr, tdelta;
>> +
>> +    tcsr = __raw_readl(tmr_base + REG_TMR_TCSR0);
>> +    tdelta = __raw_readl(tmr_base + REG_TMR_TICR0) -
>> +                 __raw_readl(tmr_base + REG_TMR_TDR0);
>> +
>> +    __raw_writel(evt, tmr_base + REG_TMR_TICR0);
>> +
>> +    if (!(tcsr & COUNTEN) && ((tdelta > 2) || (tdelta == 0)))
>> +        __raw_writel(__raw_readl(tmr_base + REG_TMR_TCSR0) | COUNTEN,
>> +                 tmr_base + REG_TMR_TCSR0);
>> +
>> +    return 0;
>> +}
>> +
>> +static int nuc970_clockevent_shutdown(struct clock_event_device *evt)
>> +{
>> +    unsigned int val = __raw_readl(tmr_base + REG_TMR_TCSR0) &
>> +                       ~(0x03 << 27);
>> +
>> +    __raw_writel(val, tmr_base + REG_TMR_TCSR0);
>> +
>> +    return 0;
>> +}
>> +
>> +static struct clock_event_device nuc970_clockevent_device = {
>> +    .name            = "nuc970-timer0",
>> +    .shift            = 32,
>> +    .features        = CLOCK_EVT_FEAT_PERIODIC |
>> +                  CLOCK_EVT_FEAT_ONESHOT,
>> +    .set_state_shutdown    = nuc970_clockevent_shutdown,
>> +    .set_state_periodic    = nuc970_clockevent_set_periodic,
>> +    .set_state_oneshot    = nuc970_clockevent_set_oneshot,
>> +    .set_next_event        = nuc970_clockevent_setnextevent,
>> +    .tick_resume        = nuc970_clockevent_shutdown,
>> +    .rating            = 300,
>> +};
>> +
>> +/*IRQ handler for the timer*/
>> +static irqreturn_t nuc970_timer0_interrupt(int irq, void *dev_id)
>> +{
>> +    struct clock_event_device *evt = &nuc970_clockevent_device;
>> +
>> +    __raw_writel(0x01, tmr_base + REG_TMR_TISR);
>> +
>> +    evt->event_handler(evt);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static struct irqaction nuc970_timer0_irq = {
>> +    .name        = "nuc970-timer0",
>> +    .flags        = IRQF_TIMER | IRQF_IRQPOLL,
>> +    .handler    = nuc970_timer0_interrupt,
>> +};
>> +
>> +static void __init nuc970_clock_source_event_init(void __iomem *base,
>> int irq,
>> +                          struct clk *clk_timer0,
>> +                          struct clk *clk_timer1)
>> +{
>> +    unsigned int val;
>> +    unsigned int rate = 0;
>> +
>> +    /* Get the timer base address */
>> +    tmr_base = base;
>> +
>> +    /*Clocksource init*/
>> +    WARN_ON(clk_prepare_enable(clk_timer1));
>
> Error check, pr_err, return error

Ok, changed.

>
>> +
>> +    __raw_writel(0x00, tmr_base + REG_TMR_TCSR1);
>> +
>> +    rate = clk_get_rate(clk_timer1) / (PRESCALE + 1);
>
>      rate check ?
>
>> +
>> +    __raw_writel(0xffffffff, tmr_base + REG_TMR_TICR1);
>> +
>> +    val = __raw_readl(tmr_base + REG_TMR_TCSR1);
>> +    val |= (COUNTEN | PERIOD | PRESCALE);
>> +    __raw_writel(val, tmr_base + REG_TMR_TCSR1);
>> +
>> +    clocksource_mmio_init(tmr_base + REG_TMR_TDR1, "nuc970-timer1",
>> +                  rate, 200, TDR_SHIFT,
>> +                  clocksource_mmio_readl_down);
>
> Error check, rollback previous actions and return error
>
>> +
>> +    /*Clockevents init*/
>> +    WARN_ON(clk_prepare_enable(clk_timer0));
>> +
>> +    __raw_writel(0x00, tmr_base + REG_TMR_TCSR0);
>> +
>> +    rate = clk_get_rate(clk_timer0) / (PRESCALE + 1);
>> +
>> +    timer0_load = (rate / TICKS_PER_SEC);
>> +
>> +    __raw_writel(RESETINT, tmr_base + REG_TMR_TISR);
>> +
>> +    setup_irq(irq, &nuc970_timer0_irq);
>
> s/setup_irq/request_irq/

Do you think I should use request_irq instead of setup_irq?

>
>> +    nuc970_clockevent_device.cpumask = cpumask_of(0);
>> +
>> +    clockevents_config_and_register(&nuc970_clockevent_device, rate,
>> +                    0xf, 0xffffffff);
>
>      return 0;
>
>> +}
>> +
>> +static void __init nuc970_timer_of_init(struct device_node *node)
>> +{
>> +    struct clk *clk_timer0, *clk_timer1;
>> +    void __iomem *base;
>> +    int irq;
>> +
>> +    base = of_iomap(node, 0);
>> +    if (!base)
>> +        panic("%s: Unable to map timer base\n", node->full_name);
>
> No panic. Error checking, pr_err and then rollback.
>
> I changed the init functions to return an error and will take care of
> changing this driver but meanwhile please handle the errors and rollback.

Ok.
>
>> +
>> +    clk_timer0 = of_clk_get_by_name(node, "timer0");
>> +    if (IS_ERR(clk_timer0))
>> +        panic("%s: Unable to get clk_timer0\n", node->full_name);
>> +
>> +    clk_timer1 = of_clk_get_by_name(node, "timer1");
>> +    if (IS_ERR(clk_timer1))
>> +        panic("%s: Unable to get clk_timer1\n", node->full_name);
>> +
>> +    irq = irq_of_parse_and_map(node, 0);
>> +    if (irq <= 0)
>> +        panic("%s: Unable to get irq\n", node->full_name);
>> +
>> +    nuc970_clock_source_event_init(base, irq, clk_timer0, clk_timer1);
>> +}
>> +
>> +CLOCKSOURCE_OF_DECLARE(nuc970, "nuvoton,tmr", nuc970_timer_of_init);
>>
>
> Thanks !
>
>    -- Daniel
>
>
