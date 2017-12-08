From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 8 Dec 2017 10:25:59 +0100
Subject: [PATCH v8 4/6] clocksource: stm32: only use 32 bits timers
In-Reply-To: <f22fd299-a742-1144-75d0-256a538af619@linaro.org>
References: <1510649563-22975-1-git-send-email-benjamin.gaignard@linaro.org>
 <1510649563-22975-5-git-send-email-benjamin.gaignard@linaro.org>
 <f22fd299-a742-1144-75d0-256a538af619@linaro.org>
Message-ID: <CA+M3ks6Co2LxQ=EPODvwYrxmoRqiiQBr3Li4L3Nx3RY2As58dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-12-08 9:34 GMT+01:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 14/11/2017 09:52, Benjamin Gaignard wrote:
>> The clock driving counters is at 90MHz so the maximum period
>> for 16 bis counters is around 750 ms
>
> 728 us
>
>> which is a short period for a clocksource.
>
> Which clocksource are you talking about ?
>
>> For 32 bits counters this period is close
>> 47 secondes which is more acceptable.
>>
>> This patch remove 16 bits counters support and makes sure that
>> they won't be probed anymore.
>
> Are we talking about clockevent or clocksource?
>
> Is this issue present today ? Or is it if we add the clocksource support
> ? We are talking about clocksource but we change the clockevent code.
>
> All this is very confusing.
>
> I have a rough idea of what is happening, but it is not up to me to
> decode and infer from the changes, you need to describe *clearly* the
> situation.
>
>  - What happens if we use a 16bits timer as a clockevent ?
>  - What happens if we use a 16bits timer as a clocksource ?
>  - Why is it preferable to remove the support of the 16bits timers
> instead of downgrading them with the rating ?

Up to this patch it is only about clockevent, clocksource code is
introduced in patch 5.
For the both cases 16bits counter have a a too short period (728us)
and can't be used
so downgrading the rating is not a solution.

I will change the wording in v9

>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>
>> ---
>>  drivers/clocksource/timer-stm32.c | 26 ++++++++++++--------------
>>  1 file changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
>> index ae41a19..8173bcf 100644
>> --- a/drivers/clocksource/timer-stm32.c
>> +++ b/drivers/clocksource/timer-stm32.c
>> @@ -83,9 +83,9 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
>>  static int __init stm32_clockevent_init(struct device_node *node)
>>  {
>>       struct reset_control *rstc;
>> -     unsigned long max_delta;
>> -     int ret, bits, prescaler = 1;
>> +     unsigned long max_arr;
>>       struct timer_of *to;
>> +     int ret;
>>
>>       to = kzalloc(sizeof(*to), GFP_KERNEL);
>>       if (!to)
>> @@ -115,29 +115,27 @@ static int __init stm32_clockevent_init(struct device_node *node)
>>
>>       /* Detect whether the timer is 16 or 32 bits */
>>       writel_relaxed(~0U, timer_of_base(to) + TIM_ARR);
>> -     max_delta = readl_relaxed(timer_of_base(to) + TIM_ARR);
>> -     if (max_delta == ~0U) {
>> -             prescaler = 1;
>> -             bits = 32;
>> -     } else {
>> -             prescaler = 1024;
>> -             bits = 16;
>> +     max_arr = readl_relaxed(timer_of_base(to) + TIM_ARR);
>> +     if (max_arr != ~0U) {
>> +             pr_err("32 bits timer is needed\n");
>> +             ret = -EINVAL;
>> +             goto deinit;
>>       }
>
> Wrap this in a function:
>
> static bool stm32_timer_is_32bits(struct timer_of *to)
> {
>         return readl_relaxed(timer_of_base(to) + TIM_ARR) == ~0UL;
> }
>
> Then clearly inform the user.
>
> if (!stm32_timer_is_32bits(to)) {
>         pr_warn("Timer %pOF is a 16 bits timer\n", node);
>         /* abort the registration or downgrade the timer's rating */
> }

Ok I will change that in v9

>
>> +
>>       writel_relaxed(0, timer_of_base(to) + TIM_ARR);
>>
>> -     writel_relaxed(prescaler - 1, timer_of_base(to) + TIM_PSC);
>> +     writel_relaxed(0, timer_of_base(to) + TIM_PSC);
>>       writel_relaxed(TIM_EGR_UG, timer_of_base(to) + TIM_EGR);
>>       writel_relaxed(TIM_DIER_UIE, timer_of_base(to) + TIM_DIER);
>>       writel_relaxed(0, timer_of_base(to) + TIM_SR);
>>
>>       clockevents_config_and_register(&to->clkevt,
>> -                                     timer_of_period(to), MIN_DELTA, max_delta);
>> -
>> -     pr_info("%pOF: STM32 clockevent driver initialized (%d bits)\n",
>> -                     node, bits);
>> +                                     timer_of_period(to), MIN_DELTA, ~0U);
>>
>>       return 0;
>>
>> +deinit:
>> +     timer_of_exit(to);
>
> Fix this please (timer_of_cleanup).
>
> In the future, make sure the patches are git-bisect safe.
>
>
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
