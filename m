From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 28 Feb 2017 19:01:23 +0100
Subject: [PATCH v3 04/25] clocksource: Add Owl timer
In-Reply-To: <20170228173950.GD30601@mai>
References: <20170228063535.32069-1-afaerber@suse.de>
 <20170228063535.32069-5-afaerber@suse.de> <20170228164745.GC30601@mai>
 <1994faec-7936-aa96-87b4-df48f75f179b@suse.de> <20170228173950.GD30601@mai>
Message-ID: <1e3b84be-12f5-bde7-a54d-e9ce835e4001@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.02.2017 um 18:39 schrieb Daniel Lezcano:
> On Tue, Feb 28, 2017 at 06:08:06PM +0100, Andreas F?rber wrote:
>>> Instead of computing again and again the base, why not just precompute:
>>>
>>> 	owl_clksrc_base = owl_timer_base + owl_timer_info->timer_offset[OWL_TIMER0]
>>> 	owl_clkevt_base = owl_timer_base + owl_timer_info->timer_offset[OWL_TIMER1]
>>>
>>>   at init time.
>>>
>>> And use these variables directly in the functions.
>>
>> Either that, or revert to previous simpler behavior...
> 
> Not sure to get what the 'previous simpler behavior' is,

v2. :)

> but until it does not
> recompute the offset each time, I'm fine with that.

>>>> +}
>>>> +
>>>> +static inline void owl_timer_reset(unsigned index)
>>>> +{
>>>> +	void __iomem *base;
>>>> +
>>>> +	base = owl_timer_get_base(index);
>>>> +	if (!base)
>>>> +		return;
>>>
>>> Same here, this test is pointless.
>>
>> Seems like you didn't look at the following patch yet. It sets two S500
>> offsets as -1, i.e. non-existant, which then results in NULL here.
> 
> May be I missed something, but so far, the base addresses must be setup before
> reset is called, no?

They are known in advance, yes. Where/how we set them up is the culprit.

>>> static inline int owl_timer_set_state_disable(struct clock_event_device *evt)
>>> {
>>> 	return writel(0, owl_clkevt_base + OWL_Tx_CTL);
>>> }
>>
>> That I don't like. Disabling is just setting a bit. We save a readl by
>> just writing where we know it's safe. An API like this is not safe.
> 
> I don't get the point. Writing this simple function has the benefit to give the
> reader the information about the disabling register. Even if it does make sense
> for you, for me it has its purpose when I try to factor out different drivers
> code.

I mean a proper _disable() function would need to do:

val = readl()
val &= ~bit;
writel(val)

Not just writel(0), overwriting any other bits. Therefore an inline
write would be faster - your concern elsewhere. I'll happily implement
the proper API if you prefer.

>>>> +static int owl_timer_set_state_shutdown(struct clock_event_device *evt)
>>>> +{
>>>> +	writel(0, owl_timer_get_base(0) + OWL_Tx_CTL);
>>>
>>> 	return owl_timer_set_state_disable(evt);
>>>
>>>> +
>>>> +	return 0;
>>>> +}

>>>> +static int owl_timer_set_next_event(unsigned long evt,
>>>> +				    struct clock_event_device *ev)
>>>> +{
>>>> +	void __iomem *base = owl_timer_get_base(1);
>>>> +
>>>> +	writel(0, base + OWL_Tx_CTL);
>>>> +
>>>> +	writel(0, base + OWL_Tx_VAL);
>>>
>>
>> Are you suggesting a while line here? The point was disable first, then
>> initialize (2x), then activate. Maybe add comments instead?
> 
> I meant, base + OWL_Tx_CTL and base + OWL_Tx_VAL are set to zero since the
> beginning. If their values do not change, it is not necessary to set their
> values to zero again.

This is a callback, which I thought is re-entrant. VAL changes when the
timer is running, and CTL changes every time we enable the timer. We
could call _reset() here, but then we would be initializing CMP twice,
which again would be less performant then just setting the registers to
their final values directly.

>>>> +	writel(evt, base + OWL_Tx_CMP);
>>>> +
>>>> +	writel(OWL_Tx_CTL_EN | OWL_Tx_CTL_INTEN, base + OWL_Tx_CTL);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static struct clock_event_device owl_clockevent = {
>>>> +	.name			= "owl_tick",
>>>> +	.rating			= 200,
>>>> +	.features		= CLOCK_EVT_FEAT_ONESHOT |
>>>> +				  CLOCK_EVT_FEAT_DYNIRQ,
>>>> +	.set_state_shutdown	= owl_timer_set_state_shutdown,
>>>> +	.set_state_oneshot	= owl_timer_set_state_oneshot,
>>>> +	.tick_resume		= owl_timer_tick_resume,
>>>> +	.set_next_event		= owl_timer_set_next_event,
>>>> +};
>>>> +
>>>> +static irqreturn_t owl_timer1_interrupt(int irq, void *dev_id)
>>>> +{
>>>> +	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
>>>> +
>>>> +	writel(OWL_Tx_CTL_PD, owl_timer_get_base(1) + OWL_Tx_CTL);
>>>> +
>>>> +	evt->event_handler(evt);
>>
>> Is there any guideline as to whether to clear such flag before or after?
> 
> Mmh, good question. I'm not sure it makes a different.
> 
>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
