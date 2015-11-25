From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Nov 2015 16:10:16 +0100
Subject: [RFC PATCH 02/10] clockevents/drivers: add MPS2 Timer driver
In-Reply-To: <5655CADA.1010803@arm.com>
References: <1448447621-17900-1-git-send-email-vladimir.murzin@arm.com>
 <1448447621-17900-3-git-send-email-vladimir.murzin@arm.com>
 <5655BA34.9040207@linaro.org> <5655CADA.1010803@arm.com>
Message-ID: <5655CF58.6030507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2015 03:51 PM, Vladimir Murzin wrote:
> Hi Daniel,
>
> Thanks for you review, I agree on all concerns raised and address them
> in the next version. Just some points to confirm below (I left only
> relevant parts).
>
>>> +static irqreturn_t mps2_timer_interrupt(int irq, void *dev_id)
>>> +{
>>> +    struct clockevent_mps2 *ce = dev_id;
>>> +    u32 status = readl(ce->reg + TIMER_INT);
>>> +
>>> +    if (!status)
>>> +        return IRQ_NONE;
>>
>> Why that could happen ? Add a comment.
>>
>
> Sort of defensive programming, I never seen it happens, but just in case
> of spurious interrupts... Do you prefer to get rid of this check or
>
>      /* spurious interrupt? */
>      if (!status)
>          return IRQ_NONE;
>
> would be fine to you?

Yes, that would be fine, but if it does never happen, we don't really 
need this check. If you prefer to make sure there isn't a spurious 
interrupt and considering it shouldn't happen, a pr_info trace may help 
to spot this misbehavior.

>>> +}
>>> +
>>> +static void __init mps2_timer_init(struct device_node *np)
>>> +{
>>> +    static int clksrc;
>>> +
>>> +    if (!clksrc && !mps2_clocksource_init(np))
>>> +        clksrc = 1;
>>> +    else
>>> +        mps2_clockevents_init(np);
>>
>> That assumes the clocksource is defined before the clockevents in the
>> DT. If it is not the case, the mps2_clocksource_init will fail (and spit
>> errors) and mps2_clockevents_init() won't be called.
>>
>
> Does following (stolen from efm32) look better to you?
>
> static void __init mps2_timer_init(struct device_node *np)
> {
> 	static int has_clocksource, has_clockevent;
> 	int ret;
>
> 	if (!has_clocksource) {
> 		ret = mps2_clocksource_init(np);
> 		if (!ret) {
> 			has_clocksource = 1;
> 			return;
> 		}
> 	}
>
> 	if (!has_clockevent) {
> 		ret = mps2_clockevent_init(np);
> 		if (!ret) {
> 			has_clockevent = 1;
> 			return;
> 		}
> 	}
> }

Yes.

I don't like to have a "CLOCKSOURCE_OF_DECLARE" to initialize a 
clockevent but I can't blame you, this is what is done in the other drivers.

>>> +}
>>> +
>>> +CLOCKSOURCE_OF_DECLARE(mps2_timer, "arm,mps2-timer", mps2_timer_init);
>>>
>>
>>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
