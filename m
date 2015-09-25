From: caesar.upstream@gmail.com (Caesar Wang)
Date: Fri, 25 Sep 2015 10:18:08 +0800
Subject: [PATCH v1 1/3] clocksource: rockchip: Make the driver more
 readability and compatible
In-Reply-To: <56049476.1040605@linaro.org>
References: <1442566271-10695-1-git-send-email-wxt@rock-chips.com>
 <1442566271-10695-2-git-send-email-wxt@rock-chips.com>
 <5455510.kk9S3OIaU9@diego> <56016275.4080704@rock-chips.com>
 <56049476.1040605@linaro.org>
Message-ID: <5604AEE0.5000300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

? 2015?09?25? 08:25, Daniel Lezcano ??:
>
> Hi Caesar,
>
> so thinking a bit more about this patch. I would like to split it into 
> two. One fixing the NO_IRQ and another fixing the dsb().
>
> IIUC, the ARMv8 support is not yet ready and dsb() is not necessary as 
> a fix for the previous kernel version. However, the timer is used with 
> the ARMv7 boards and the NO_IRQ should be merged into tip-urgent.
>
> I already done the fix and I am ready to submit it (for the timer 
> keystone also). So I suggest your resend the dsb() fix only.
>
> Regarding the indentation, I prefer you do that in a separate patch by 
> cleaning up the macros (if relevant) or send the patch to trivial@
>

I know the indentation is trivial for this driver, but I just send the 
patch v2.

>   -- Daniel
>
> On 09/22/2015 07:15 AM, Caesar Wang wrote:
>> Hi  Heiko,
>>
>> ? 2015?09?22? 22:00, Heiko St?bner ??:
>>> Hi Caesar,
>>>
>>> Am Freitag, 18. September 2015, 16:51:09 schrieb Caesar Wang:
>>>> Build the arm64 SoCs (e.g.: RK3368) on Rockchip platform,
>>>> There are some failure with build up on timer driver for rockchip.
>>>>
>>>> logs:
>>>> ...
>>>> drivers/clocksource/rockchip_timer.c:156:13: error: 'NO_IRQ' 
>>>> undeclared
>>>> /tmp/ccdAnNy5.s:47: Error: missing immediate expression at operand 
>>>> 1 --
>>>> `dsb`
>>>> ...
>>>>
>>>> The problem was different semantics of dsb on btw arm32 and arm64,
>>>> Here we can convert the dsb with insteading of dsb(sy).
>>>>
>>>> NO_IRQ definition is missing for ARM64, since NO_IRQ being -1 is a
>>>> legacy thing for ARM - all ARM drivers are supposed to be converted to
>>>> use <= 0 or == 0 to detect invalid IRQs, and _eventually_ once all 
>>>> users
>>>> are gone, NO_IRQ deleted. Modern drivers should _all_ be using !irq to
>>>> detect invalid IRQs, and not using NO_IRQ.
>>>>
>>>> Meanwhile, I change a bit to make the code more readability for driver
>>>> when I check the code style.
>>>>
>>>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>>> ---
>>>>
>>>> Changes in v1:
>>>> - As Russell, Thomas, Daniel comments, let's replace NO_IRQ by '!irq'.
>>>>
>>>>   drivers/clocksource/rockchip_timer.c | 29
>>>> +++++++++++++++--------------
>>>>   1 file changed, 15 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/clocksource/rockchip_timer.c
>>>> b/drivers/clocksource/rockchip_timer.c index bb2c2b0..e1af449 100644
>>>> --- a/drivers/clocksource/rockchip_timer.c
>>>> +++ b/drivers/clocksource/rockchip_timer.c
>>>> @@ -17,16 +17,16 @@
>>>>
>>>>   #define TIMER_NAME "rk_timer"
>>>>
>>>> -#define TIMER_LOAD_COUNT0 0x00
>>>> -#define TIMER_LOAD_COUNT1 0x04
>>>> -#define TIMER_CONTROL_REG 0x10
>>>> -#define TIMER_INT_STATUS 0x18
>>>> +#define TIMER_LOAD_COUNT0    0x00
>>>> +#define TIMER_LOAD_COUNT1    0x04
>>>> +#define TIMER_CONTROL_REG    0x10
>>>> +#define TIMER_INT_STATUS    0x18
>>>>
>>>> -#define TIMER_DISABLE 0x0
>>>> -#define TIMER_ENABLE 0x1
>>>> -#define TIMER_MODE_FREE_RUNNING (0 << 1)
>>>> -#define TIMER_MODE_USER_DEFINED_COUNT (1 << 1)
>>>> -#define TIMER_INT_UNMASK (1 << 2)
>>>> +#define TIMER_DISABLE            (0 << 0)
>>>> +#define TIMER_ENABLE            (1 << 0)
>>>> +#define TIMER_MODE_FREE_RUNNING        (0 << 1)
>>>> +#define TIMER_MODE_USER_DEFINED_COUNT    (1 << 1)
>>>> +#define TIMER_INT_UNMASK        (1 << 2)
>>> not sure how Daniel sees this, but those could count as "unrelated
>>> change", as
>>> they have nothing to do with the arm64 build-fixes.
>>
>> Yep, it's no related to the arm64 uild fixes.
>> I only make the code more readability for driver.
>>
>>>
>>>>   struct bc_timer {
>>>>       struct clock_event_device ce;
>>>> @@ -49,14 +49,14 @@ static inline void __iomem *rk_base(struct
>>>> clock_event_device *ce) static inline void rk_timer_disable(struct
>>>> clock_event_device *ce) {
>>>>       writel_relaxed(TIMER_DISABLE, rk_base(ce) + TIMER_CONTROL_REG);
>>>> -    dsb();
>>>> +    dsb(sy);
>>>>   }
>>>>
>>>>   static inline void rk_timer_enable(struct clock_event_device *ce, 
>>>> u32
>>>> flags) {
>>>>       writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
>>>>                  rk_base(ce) + TIMER_CONTROL_REG);
>>>> -    dsb();
>>>> +    dsb(sy);
>>>>   }
>>>>
>>>>   static void rk_timer_update_counter(unsigned long cycles,
>>>> @@ -64,13 +64,13 @@ static void rk_timer_update_counter(unsigned long
>>>> cycles, {
>>>>       writel_relaxed(cycles, rk_base(ce) + TIMER_LOAD_COUNT0);
>>>>       writel_relaxed(0, rk_base(ce) + TIMER_LOAD_COUNT1);
>>>> -    dsb();
>>>> +    dsb(sy);
>>>>   }
>>>>
>>>>   static void rk_timer_interrupt_clear(struct clock_event_device *ce)
>>>>   {
>>>>       writel_relaxed(1, rk_base(ce) + TIMER_INT_STATUS);
>>>> -    dsb();
>>>> +    dsb(sy);
>>>>   }
>>>>
>>>>   static inline int rk_timer_set_next_event(unsigned long cycles,
>>>> @@ -148,7 +148,7 @@ static void __init rk_timer_init(struct
>>>> device_node *np)
>>>> bc_timer.freq = clk_get_rate(timer_clk);
>>>>
>>>>       irq = irq_of_parse_and_map(np, 0);
>>>> -    if (irq == NO_IRQ) {
>>>> +    if (!irq) {
>>>>           pr_err("Failed to map interrupts for '%s'\n", TIMER_NAME);
>>>>           return;
>>>>       }
>>>> @@ -173,4 +173,5 @@ static void __init rk_timer_init(struct
>>>> device_node *np)
>>>>
>>>>       clockevents_config_and_register(ce, bc_timer.freq, 1, UINT_MAX);
>>>>   }
>>>> +
>>> unnecessary addition of a blank line (same reasons as above)
>>
>> It's the same reason with the above.
>>
>> CHECK: Please use a blank line after function/struct/union/enum
>> declarations
>> #176: FILE: rockchip_timer.c:176:
>> +}
>> +CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer", 
>> rk_timer_init);
>>
>> I know, we can ignore the above warning.
>> That's a bit better, I thnik.
>>
>>
>>>>   CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer",
>>>> rk_timer_init);
>>>
>>> Heiko
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
>>
>
>
>
> -- 
> Thanks,
> Caesar
