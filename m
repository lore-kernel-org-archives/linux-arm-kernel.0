From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon, 18 Dec 2017 10:44:38 +0100
Subject: [PATCH 2/4] clocksource: stm32: use prescaler to adjust the
 resolution
In-Reply-To: <4e57bec8-a52b-9574-5f6e-985457d44147@linaro.org>
References: <20171215085247.14946-1-benjamin.gaignard@st.com>
 <20171215085247.14946-3-benjamin.gaignard@st.com>
 <4e57bec8-a52b-9574-5f6e-985457d44147@linaro.org>
Message-ID: <CA+M3ks5qBNzwjDimVYUS1sHzDDHD+Y44OtyT9L=imbQoNbsnFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-12-18 10:26 GMT+01:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 15/12/2017 09:52, Benjamin Gaignard wrote:
>> Rather than use fixed prescaler values compute it to get a clock
>> as close as possible of 10KHz and a resolution of 0.1ms.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  drivers/clocksource/timer-stm32.c | 23 ++++++++++++++++-------
>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
>> index 23a321cca45b..de721d318065 100644
>> --- a/drivers/clocksource/timer-stm32.c
>> +++ b/drivers/clocksource/timer-stm32.c
>> @@ -37,6 +37,11 @@
>>
>>  #define TIM_EGR_UG   BIT(0)
>>
>> +#define MAX_TIM_PSC  0xFFFF
>> +
>> +/* Target a 10KHz clock to get a resolution of 0.1 ms */
>> +#define TARGETED_CLK_RATE 10000
>> +
>>  static int stm32_clock_event_shutdown(struct clock_event_device *evt)
>>  {
>>       struct timer_of *to = to_timer_of(evt);
>> @@ -83,7 +88,7 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
>>  static void __init stm32_clockevent_init(struct timer_of *to)
>>  {
>>       unsigned long max_delta;
>> -     int prescaler;
>> +     unsigned long prescaler;
>>
>>       to->clkevt.name = "stm32_clockevent";
>>       to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC;
>> @@ -96,13 +101,17 @@ static void __init stm32_clockevent_init(struct timer_of *to)
>>       /* Detect whether the timer is 16 or 32 bits */
>>       writel_relaxed(~0U, timer_of_base(to) + TIM_ARR);
>>       max_delta = readl_relaxed(timer_of_base(to) + TIM_ARR);
>> -     if (max_delta == ~0U) {
>> -             prescaler = 1;
>> +     to->clkevt.rating = 50;
>> +     if (max_delta == ~0U)
>>               to->clkevt.rating = 250;
>> -     } else {
>> -             prescaler = 1024;
>> -             to->clkevt.rating = 50;
>> -     }
>> +
>> +     /*
>> +      * Get the highest possible prescaler value to be as close
>> +      * as possible of TARGETED_CLK_RATE
>> +      */
>> +     prescaler = DIV_ROUND_CLOSEST(timer_of_rate(to), TARGETED_CLK_RATE);
>
> With a 90MHz or 125MHz, the prescaler will be 9000 or 12500, so much
> more than the 1024 we have today for 16b, and 1 for 32b.
>
> Shouldn't the computation be weighted with the bits width ?

My goal was to get the same resolution (0.1ms) for all the timers so
the wrap will depend of the number of bits like you describe below.

>
> Otherwise the timer will wrap like:
>
> 32bits:
>
> before: (2^32 / 90e6) x 1 = 47.72 seconds
> after:  (2^32 / 90e6) x 9000 = 119.3 *hours* ~= 5days
>
> 16bits:
>
> before: (2^16 / 90e6) x 1024 = 0.745 seconds
> after:  (2^16 / 90e6) x 9000 = 6.55 seconds
>
> The patch is ok to target the 10KHz timer rate for 16b with a 1ms
> resolution wrapping up after 6.55 seconds. But not for the 32bits timer.
> Furthermore, we can't tell anymore the 32bits timers have a rating of
> 250 after this patch.

What is the link between rating and resolution (or wrap) ?
Is it a problem to get a long wrap ?

>
> Leave the 32bits part as it is and compute the prescaler only in case of
> 16bits with the target rate, which sounds a reasonable approach.
>
>> +     if (prescaler > MAX_TIM_PSC)
>> +             prescaler = MAX_TIM_PSC;
>
> That can happen only if the clock rate is greater than ~655MHz, that
> could not happen today as far as I can tell regarding the DT. So if we
> hit this condition, we should speak up in the log (pr_warn).

It is to be futur proof for next possible SoC but even if prescaler
reach this limit
it is not a problem the only consequence would be that resolution and
wrap change.

>
>>       writel_relaxed(0, timer_of_base(to) + TIM_ARR);
>>       writel_relaxed(prescaler - 1, timer_of_base(to) + TIM_PSC);
>
> Can you fix this prescaler - 1 in order to be consistent with the
> computation with 16b ? (32b prescaler = 0, 16b prescaler = clk_rate /
> target ).

In the hardware the clock is divise by " TIM_PSC value  1" so to be coherent
with that I need to do prescaler -1.

Benjamin

>
> Thanks.
>
>   -- Daniel
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
