From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Mon, 16 Dec 2013 15:58:03 +0200
Subject: [PATCH 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <52AAAF7A.2020102@linaro.org>
References: <1386784830-15863-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1386784830-15863-2-git-send-email-ivan.khoronzhuk@ti.com>
 <52A9DB78.1040805@linaro.org> <52A9F433.8020003@ti.com>
 <52AAAF7A.2020102@linaro.org>
Message-ID: <52AF06EB.7040506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2013 08:55 AM, Daniel Lezcano wrote:
> On 12/12/2013 06:36 PM, ivan.khoronzhuk wrote:
>> On 12/12/2013 05:51 PM, Daniel Lezcano wrote:
>>> On 12/11/2013 07:00 PM, Ivan Khoronzhuk wrote:
>>>> Add broadcast clock-event device for the Keystone arch.
>>>>
>>>> The timer can be configured as a general-purpose 64-bit timer,
>>>> dual general-purpose 32-bit timers. When configured as dual 32-bit
>>>> timers, each half can operate in conjunction (chain mode) or
>>>> independently (unchained mode) of each other.
>>>>
>>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>>> ---
>>>>    drivers/clocksource/Makefile         |    1 +
>>>>    drivers/clocksource/timer-keystone.c |  223
>>>> ++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 224 insertions(+)
>>>>    create mode 100644 drivers/clocksource/timer-keystone.c
>>>>
>>>> diff --git a/drivers/clocksource/Makefile 
>>>> b/drivers/clocksource/Makefile
>>>> index 33621ef..2acf3fc 100644
>>>> --- a/drivers/clocksource/Makefile
>>>> +++ b/drivers/clocksource/Makefile
>>>> @@ -36,3 +36,4 @@ obj-$(CONFIG_ARM_ARCH_TIMER)        += 
>>>> arm_arch_timer.o
>>>>    obj-$(CONFIG_ARM_GLOBAL_TIMER)        += arm_global_timer.o
>>>>    obj-$(CONFIG_CLKSRC_METAG_GENERIC)    += metag_generic.o
>>>>    obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)    += dummy_timer.o
>>>> +obj-$(CONFIG_ARCH_KEYSTONE)        += timer-keystone.o
>>>> diff --git a/drivers/clocksource/timer-keystone.c
>>>> b/drivers/clocksource/timer-keystone.c
>>>> new file mode 100644
>>>> index 0000000..4a8083a
>>>> --- /dev/null
>>>> +++ b/drivers/clocksource/timer-keystone.c
>>>> @@ -0,0 +1,223 @@
>>>> +/*
>>>> + * Keystone broadcast clock-event
>>>> + *
>>>> + * Copyright 2013 Texas Instruments, Inc.
>>>> + *
>>>> + * Author: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or 
>>>> modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + *
>>>> + */
>>>> +
>>>> +#include <linux/clk.h>
>>>> +#include <linux/clockchips.h>
>>>> +#include <linux/clocksource.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/of_address.h>
>>>> +#include <linux/of_irq.h>
>>>> +
>>>> +#define TIMER_NAME            "timer64-event"
>>>> +
>>>> +/* Timer register offsets */
>>>> +#define TIM12                0x10
>>>> +#define TIM34                0x14
>>>> +#define PRD12                0x18
>>>> +#define PRD34                0x1c
>>>> +#define TCR                0x20
>>>> +#define TGCR                0x24
>>>> +#define INTCTLSTAT            0x44
>>>> +
>>>> +/* Timer register bitfields */
>>>> +#define TCR_ENAMODE_MASK        0xC0
>>>> +#define TCR_ENAMODE_ONESHOT_MASK    0x40
>>>> +#define TCR_ENAMODE_PERIODIC_MASK    0x80
>>>> +
>>>> +#define TGCR_TIM_UNRESET_MASK        0x03
>>>> +#define INTCTLSTAT_ENINT_MASK        0x01
>>>> +
>>>> +/**
>>>> + * struct keystone_timer: holds timer's data
>>>> + * @base: timer memory base address
>>>> + * @clk_rate: source clock rate
>>>> + * @irqacrion: interrupt action descriptor
>>>> + * @event_dev: event device based on timer
>>>> + */
>>>> +static struct keystone_timer {
>>>> +    void __iomem *base;
>>>> +    unsigned long clk_rate;
>>>> +    struct irqaction irqaction;
>>>> +    struct clock_event_device event_dev;
>>>> +} timer;
>>>> +
>>>> +static inline u32 keystone_timer_readl(unsigned long rg)
>>>> +{
>>>> +    return readl(timer.base + rg);
>>>> +}
>>>> +
>>>> +static inline void keystone_timer_writel(u32 val, unsigned long rg)
>>>> +{
>>>> +    writel(val, timer.base + rg);
>>>> +}
>>>> +
>>>> +/**
>>>> + * keystone_timer_config: configures timer to work in
>>>> oneshot/periodic modes, in
>>>> + * other cases disables timer.
>>>> + * @ mode: mode to configure
>>>> + * @ period: cycles number to configure for
>>>> + */
>>>> +static int keystone_timer_config(u64 period, enum clock_event_mode 
>>>> mode)
>>>> +{
>>>> +    u32 tcr;
>>>> +
>>>> +    tcr = keystone_timer_readl(TCR);
>>>> +
>>>> +    /* disable timer */
>>>> +    tcr &= ~(TCR_ENAMODE_MASK);
>>>> +    keystone_timer_writel(tcr, TCR);
>>>
>>> Please move this write after the switch (cf. linked comment below)
>>>
>>
>> See below
>>
>>>> +    /* set enable mode or leave disabled timer */
>>>> +    switch (mode) {
>>>> +    case CLOCK_EVT_MODE_ONESHOT:
>>>> +        tcr |= TCR_ENAMODE_ONESHOT_MASK;
>>>> +        break;
>>>> +    case CLOCK_EVT_MODE_PERIODIC:
>>>> +        tcr |= TCR_ENAMODE_PERIODIC_MASK;
>>>> +        break;
>>>> +    default:
>>>> +        return 0;
>>>
>>> Shouldn't you return an error ?
>>>
>>
>> It returns value only for convenient usage in keystone_set_next_event(),
>> see [1].
>>
>> In general, this function is used to configure the timer.
>> The procedure is that we need to stop the timer then set it.
>> If timer needs to be disabled (shutdown mode), function disables it 
>> and returns.
>>
>>>> +    }
>>>> +
>>>> +    /* reset counter to zero, set new period */
>>>> +    keystone_timer_writel(0, TIM12);
>>>> +    keystone_timer_writel(0, TIM34);
>>>> +    keystone_timer_writel(period & 0xffffffff, PRD12);
>>>> +    keystone_timer_writel(period >> 32, PRD34);
>>>> +
>>>> +    /* enable timer */
>>>> +    keystone_timer_writel(tcr, TCR);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static irqreturn_t keystone_timer_interrupt(int irq, void *dev_id)
>>>> +{
>>>> +    struct clock_event_device *evt = &timer.event_dev;
>>>> +
>>>> +    evt->event_handler(evt);
>>>> +    return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static int keystone_set_next_event(unsigned long cycles,
>>>> +                  struct clock_event_device *evt)
>>>> +{
>>>> +    return keystone_timer_config(cycles, evt->mode);
>>
>> [1]
>>
>>>> +}
>>>> +
>>>> +static void keystone_set_mode(enum clock_event_mode mode,
>>>> +                 struct clock_event_device *evt)
>>>> +{
>>>> +    u64 period;
>>>> +
>>>> +    switch (mode) {
>>>> +    case CLOCK_EVT_MODE_PERIODIC:
>>>> +        period = timer.clk_rate / (HZ);
>>>> +        keystone_timer_config(period, CLOCK_EVT_MODE_PERIODIC);
>>>> +        break;
>>>> +    case CLOCK_EVT_MODE_UNUSED:
>>>> +    case CLOCK_EVT_MODE_SHUTDOWN:
>>>> +    case CLOCK_EVT_MODE_ONESHOT:
>>>> +        keystone_timer_config(0, CLOCK_EVT_MODE_SHUTDOWN);
>>>
>>> I don't really this code assuming the side effect of specifying a
>>> unsupported mode will disable the timer.
>>>
>>
>> In case of an unsupported mode the function does nothing.
>> Is it not correct?
>>
>> It disables the timer only in 3 cases.
>> CLOCK_EVT_MODE_UNUSED
>> CLOCK_EVT_MODE_SHUTDOWN
>> CLOCK_EVT_MODE_ONESHOT
>>
>> For CLOCK_EVT_MODE_ONESHOT,
>> It is supposed that then keystone_set_next_even() will re-enable the 
>> timer.
> 
> The code looks like is doing what is expected. It is not about a bug but 
> a coding style issue. I am not in favor of passing the 
> CLOCK_EVT_MODE_SHUTDOWN which default in keystone_timer_config on 
> returning no error. The caller assumes the function will exit without 
> re-enabling the timer. It is correct from an implementation POV but IMO 
> it is a bit subtle and prone to errors for the future modifications.
> 
> If keystone_timer_config(period, __A_VALUE_FROM_SPACE__) is called, it 
> will return no error and disables the timer.
> 
> IMO, for the sake of clarity, defining the different modes in the switch 
> and returning an error on default would be more convenient.
> 
> For this reason, you shouldn't disable the timer before checking the 
> correctness of the mode, thus the comment about moving the timer 
> disabling after the switch.
> 

Ok,
I'll add separate function "keystone_timer_disable()" for using in keystone_set_mode().
The keystone_timer_config() will not be used for disabling the timer any more.
In case of an unsupported mode the keystone_timer_config() will return -1.


-- 
Regards,
Ivan Khoronzhuk
