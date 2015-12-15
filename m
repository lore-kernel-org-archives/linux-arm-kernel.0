From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 15 Dec 2015 12:47:59 +0000
Subject: [PATCH v1 02/10] clockevents/drivers: add MPS2 Timer driver
In-Reply-To: <566EC5D2.9050005@linaro.org>
References: <1449048790-25859-1-git-send-email-vladimir.murzin@arm.com>
 <1449048790-25859-3-git-send-email-vladimir.murzin@arm.com>
 <566EC5D2.9050005@linaro.org>
Message-ID: <56700BFF.90001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/12/15 13:36, Daniel Lezcano wrote:
> On 12/02/2015 10:33 AM, Vladimir Murzin wrote:
>> MPS2 platform has simple 32 bits general purpose countdown timers.
>>
>> The driver uses the first detected timer as a clocksource and the rest
>> of the timers as a clockevent
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
> 
> [ ... ]
> 
>> +static void clockevent_mps2_writel(u32 val, struct clock_event_device
>> *c, u32 offset)
>> +{
>> +    writel(val, to_mps2_clkevt(c)->reg + offset);
>> +}
> 
> Is it possible to use writel_relaxed here ?

I think it is possible. I'll update that part.

> 
> [ ... ]
> 
>> +static int mps2_timer_set_periodic(struct clock_event_device *ce)
>> +{
>> +    u32 clock_count_per_tick = to_mps2_clkevt(ce)->clock_count_per_tick;
>> +
>> +    clockevent_mps2_writel(clock_count_per_tick, ce, TIMER_RELOAD);
>> +    clockevent_mps2_writel(clock_count_per_tick, ce, TIMER_VALUE);
>> +    clockevent_mps2_writel(TIMER_CTRL_IE | TIMER_CTRL_ENABLE, ce,
>> TIMER_CTRL);
>> +
>> +    return 0;
>> +}
>> +
>> +static irqreturn_t mps2_timer_interrupt(int irq, void *dev_id)
>> +{
>> +    struct clockevent_mps2 *ce = dev_id;
>> +    u32 status = readl(ce->reg + TIMER_INT);
>> +
>> +    if (!status) {
>> +        pr_warn("spuirous interrupt\n");
> 
> typo: 'spurious'
> 
> [ ... ]
> 
>> +    ce = kzalloc(sizeof(struct clockevent_mps2), GFP_KERNEL);
>> +    if (!ce) {
>> +        ret = -ENOMEM;
>> +        pr_err("failed to allocate clockevent: %d\n", ret);
> 
> There is already a stack trace in the kernel when an allocation fails.
> 
> With the above fixed:
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> 

All above fixed locally.

Thanks
Vladimir
