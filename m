From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Sun, 29 Sep 2013 01:34:08 -0300
Subject: [PATCH 2/5] clocksource: Add Allwinner SoCs HS timers driver
In-Reply-To: <20130926131329.GQ2954@lukather>
References: <1380117790-19390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1380117790-19390-3-git-send-email-maxime.ripard@free-electrons.com>
 <52437062.5040705@elopez.com.ar> <20130926131329.GQ2954@lukather>
Message-ID: <5247ADC0.5080204@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 26/09/13 10:13, Maxime Ripard escribi?:
> On Wed, Sep 25, 2013 at 08:23:14PM -0300, Emilio L?pez wrote:
>> El 25/09/13 11:03, Maxime Ripard escribi?:
>>> Most of the Allwinner SoCs (at this time, all but the A10) also have a
>>> High Speed timers that are not using the 24MHz oscillator as a source
>>> but rather the AHB clock running much faster.
>>>
>>> The IP is slightly different between the A10s/A13 and the one used in
>>> the A20/A31, since the latter have 4 timers available, while the former
>>> have only 2 of them.
>>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> ---
>>
>> [...]
>>
>>> +static void __init sun5i_timer_init(struct device_node *node)
>>> +{
>>> +	unsigned long rate;
>>> +	struct clk *clk;
>>> +	int ret, irq;
>>> +	u32 val;
>>> +
>>> +	timer_base = of_iomap(node, 0);
>>> +	if (!timer_base)
>>> +		panic("Can't map registers");
>>> +
>>> +	irq = irq_of_parse_and_map(node, 0);
>>> +	if (irq <= 0)
>>> +		panic("Can't parse IRQ");
>>> +
>>> +	clk = of_clk_get(node, 0);
>>> +	if (IS_ERR(clk))
>>> +		panic("Can't get timer clock");
>>
>> I'm not familiar with clocksources, but does this have to be as
>> fatal as it is considering the kernel also supports the slower sun4i
>> timer?
>
> Hmmm, I don't know, one might choose to enable only this timer, in that
> case that would make sense to panic, since it would be the only timer in
> that case.

Fair enough.

>> Also, would any special considerations be needed when adjusting the
>> ahb clock? A future cpufreq driver will most likely need to.
>
> While this will be needed at some point, I don't really see how to
> handle that properly. The clock framework doesn't seem to have any
> callback when it comes to reconfiguring a clock that a device might
> use.

Maybe we should consider using one of the other timers; from a quick 
look at the A20 user manual, it seems they can run at ~200MHz ("PLL6/6" 
as input)

> This will also creates trouble for IPs such as the I2C that have to
> setup internal dividers, and use clk_get_rate to do so.

Not really, because they use APB1 which is not scaled. The manual makes 
it explicit when describing APB1:

"This clock is used for some special module apbclk(twi,uart,
ps2, can, scr). Because these modules need special clock rate
even if the apbclk changed."

Cheers,

Emilio
