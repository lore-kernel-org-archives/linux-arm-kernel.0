From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 18 Oct 2017 14:25:18 +0200
Subject: [PATCH v5 2/4] clocksource: stm32: only use 32 bits timers
In-Reply-To: <78e4bf06-7e95-d863-3b3d-c7362643da90@arm.com>
References: <1508312614-27750-1-git-send-email-benjamin.gaignard@linaro.org>
 <1508312614-27750-3-git-send-email-benjamin.gaignard@linaro.org>
 <78e4bf06-7e95-d863-3b3d-c7362643da90@arm.com>
Message-ID: <CA+M3ks5wA08zyt-Z9PPyuEXjayL3LVY+=GWn6A1RBOUU+Qff5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-18 10:21 GMT+02:00 Julien Thierry <julien.thierry@arm.com>:
>
>
> On 18/10/17 08:43, Benjamin Gaignard wrote:
>>
>> 16 bits hardware are not enough accure to be used.
>> Do no allow them to be probed by tested max counter value.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>> ---
>>   drivers/clocksource/timer-stm32.c | 23 +++++++++--------------
>>   1 file changed, 9 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-stm32.c
>> b/drivers/clocksource/timer-stm32.c
>> index abff21c..f7e4eec 100644
>> --- a/drivers/clocksource/timer-stm32.c
>> +++ b/drivers/clocksource/timer-stm32.c
>> @@ -81,9 +81,9 @@ static irqreturn_t stm32_clock_event_handler(int irq,
>> void *dev_id)
>>   static int __init stm32_clockevent_init(struct device_node *node)
>>   {
>>         struct reset_control *rstc;
>> -       unsigned long max_delta;
>> -       int ret, bits, prescaler = 1;
>> +       unsigned long max_arr;
>>         struct timer_of *to;
>> +       int ret;
>>         to = kzalloc(sizeof(*to), GFP_KERNEL);
>>         if (!to)
>> @@ -113,26 +113,21 @@ static int __init stm32_clockevent_init(struct
>> device_node *node)
>>         /* Detect whether the timer is 16 or 32 bits */
>>         writel_relaxed(~0U, timer_of_base(to) + TIM_ARR);
>> -       max_delta = readl_relaxed(timer_of_base(to) + TIM_ARR);
>> -       if (max_delta == ~0U) {
>> -               prescaler = 1;
>> -               bits = 32;
>> -       } else {
>> -               prescaler = 1024;
>> -               bits = 16;
>> +       max_arr = readl_relaxed(timer_of_base(to) + TIM_ARR);
>> +       if (max_arr != ~0U) {
>> +               pr_err("32 bits timer is needed\n");
>> +               return -EINVAL;
>
>
> Same as with previous patch, I think "to" should get freed.

Yes I could solve that in the first patch

>
> Also, why is there no function to undo what timer_of_init did? Shouldn't we
> be able to free the irqs and unmap the timer io base here?

timer-of doesn't provide deinit function since I will have to do a new version
I will add it.

Benjamin
>
> Cheers,
>
> --
> Julien Thierry
