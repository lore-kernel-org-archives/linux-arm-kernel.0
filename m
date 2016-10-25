From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 25 Oct 2016 15:47:46 +0100
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <1477405332.2482.87.camel@baylibre.com>
References: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
 <1476871709-8359-5-git-send-email-jbrunet@baylibre.com>
 <CACRpkdaCZPS45t3eTcjJExOu=YT_YkjNkdpg09jQqvLQOJH=Qw@mail.gmail.com>
 <1477040798.15560.96.camel@baylibre.com>
 <CACRpkdYUVXny57AC9rKX3VRAyooEk_2XLvqe9jOuT3rOaE75rg@mail.gmail.com>
 <ec7c6cc5-cf9a-9c75-4b07-e337064c7d6e@arm.com>
 <1477400900.2482.51.camel@baylibre.com>
 <dee26f0b-e175-f8a0-2b73-08e8e324841c@arm.com>
 <1477405332.2482.87.camel@baylibre.com>
Message-ID: <bbc268c8-35c3-206a-46b1-62cebef174b2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/16 15:22, Jerome Brunet wrote:
> On Tue, 2016-10-25 at 14:38 +0100, Marc Zyngier wrote:
>> On 25/10/16 14:08, Jerome Brunet wrote:
>>>
>>> On Tue, 2016-10-25 at 11:38 +0100, Marc Zyngier wrote:
>>>>
>>>>>
>>>>>
>>>> On 25/10/16 10:14, Linus Walleij wrote:
>>>>>
>>>>>
>>>>> On Fri, Oct 21, 2016 at 11:06 AM, Jerome Brunet <jbrunet@baylib
>>>>> re.c
>>>>> om> wrote:
>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Isn't this usecase (also as described in the cover letter)
>>>>>>> a
>>>>>>> textbook
>>>>>>> example of when you should be using hierarchical irqdomain?
>>>>>>>
>>>>>>> Please check with Marc et al on hierarchical irqdomains.
>>>>>>
>>>>>> Linus,
>>>>>> Do you mean I should create a new hierarchical irqdomains in
>>>>>> each
>>>>>> of
>>>>>> the two pinctrl instances we have in these SoC, these domains
>>>>>> being
>>>>>> stacked on the one I just added for controller in irqchip ?
>>>>>>
>>>>>> I did not understand this is what you meant when I asked you
>>>>>> the
>>>>>> question at ELCE.
>>>>>
>>>>> Honestly, I do not understand when and where to properly use
>>>>> hierarchical irqdomain, even after Marc's talk at ELC-E.
>>>>
>>>> I probably didn't do that good a job explaining it then. Let's
>>>> try
>>>> again. You want to use hierarchical domains when you want to
>>>> describe
>>>> an
>>>> interrupt whose path traverses multiple controllers without ever
>>>> being
>>>> multiplexed with other signals. As long as you have this 1:1
>>>> relationship between controllers, you can use them.
>>>>
>>>
>>> Linus, Marc,
>>>
>>> The calculation is question here is meant to get the appropriate
>>> hwirq
>>> number from a particular gpio (and deal with the gpios that can't
>>> provide an irq at all). 
>>>
>>> If I look at other gpio drivers, many are doing exactly this kind
>>> of
>>> calculation before calling 'irq_create_mapping' in the to_irq
>>> callback.
>>> For example:
>>> - pinctrl/nomadik/pinctrl-abx500.c
>>> - pinctrl/samsung/pinctrl-exynos5440.c
>>>
>>> Some can afford to create all the mappings in the probe and just
>>> call
>>> 'irq_find_mapping' (gpio/gpio_tegra.c) but this would not work
>>> here. We
>>> have only 8 upstream irqs for 130+ pins, so only 8 mappings
>>> possible at
>>> a time. 
>>>
>>> My understanding is that irqdomain provide a way to map hwirq to
>>> linux
>>> virq (and back), not map gpio number to hwirq, right?
>>
>> But why are those number different? Why don't you use the same
>> namespace? If gpio == hwirq, all your problems are already solved. If
>> you don't find the mapping in the irqdomain, then there is no irq,
>> end
>> of story. What am I missing?
>>
> 
> There is a few problems to guarantee that gpio == hwirq.
> 1. We have 2 instances of pinctrl, to guarantee that the linux gpio
> number == hwirq, we would have to guarantee the order in which they are
> probed. At least this my understanding 

Maybe I wasn't clear enough, and my use of gpio is probably wrong. So
Linux has a gpio number, which is obviously an abstract number (just
like the Linux irq number). But the pad number, in the context of given
SoC, is constant. So we have:

	pad->gpio
	hwirq->irq

Why can't you have pad == hwirq, always? This is already what you have
in the irqchip driver. This would simplify a lot of things.

> 2. Inside each instance, we may have banks that can't have irq. We even
> have a bank on meson8b which has a mixed state (the last pins don't
> have irqs, while the first ones do). those banks/pins are still valid
> gpios with gpio numbers. This introduce a shift between the gpio
> numbering and the hwirq.
> 
> The point of this calculation is take the offset given to the 'to_irq'
> callback, remove the gpio bank base number and add irq base number.
> There is a few trick added to handled the case in 2.

You seem to assume linear mappings, which is pretty dangerous.

> 
> In addition, to call 'irq_find_mapping', we would first have to create
> the mapping, in the probe I suppose. This would call the allocate
> callback of the domain, in which we can allocate only 8 interrupts.
> 
> That's why I create the mapping in the .to_irq callback.

Is gpio_to_irq() supposed to allocate an interrupt? Or merely to report
the existence of a mapping?

> 
>>>
>>>
>>> Even if I implement an another irqdomain at the gpio level, I would
>>> still have to perform this kind of calculation, one way or the
>>> other.
>>>
>>>>
>>>>>
>>>>> Which is problematic since quite a few GPIO drivers now
>>>>> need to use them.
>>>>>
>>>>> I will review his slides, in the meantime I would say: whatever
>>>>> Marc ACKs is fine with me. I trust this guy 100%. So I guess I
>>>>> could ask that he ACK the entire chain of patches
>>>>> from GIC->specialchip->GPIO.
>>>
>>> Actually this discussion go me thinking about another issue we have
>>> with this hardware.
>>> We are looking for a way to implement support for
>>> IRQ_TYPE_EDGE_BOTH
>>> (needed for things like gpio-keys or mmc card detect). 
>>> The controller can do each edge but not both at the same time.
>>> I'm thinking that implementing another irqdomain at the gpio level
>>> would allow to properly check the pad level in the EOI callback
>>> then
>>> set the next expected edge type accordingly (using
>>> 'irq_chip_set_type_parent')
>>>
>>> Would it be acceptable ?
>>
>> I really don't see what another irqdomain brings to the table. This
>> is
>> not a separate piece of HW, so the hwirq:irq mapping is still the
>> same.
>> I fail to see what the benefit is.
> 
> The separate piece of hw is the gpio itself. 
> The irq-controller (in irqchip) can't read the gpio state because it is
> simply another device.
> 
> The domain I'm thinking about wouldn't do much, I reckon. 
> It would just register an irqchip which would only implement eoi.
> For everything else, it would rely the parent controller.
> From your explanation, I understood this is the purpose of hierarchy
> domains, For each hw in the chain to handle only what it can, and rely
> on its parent for the rest.

Right. But that doesn't make it more reliable, see below.

> 
>>
>>>
>>> It looks a few other drivers deal with IRQ_TYPE_EDGE_BOTH in a
>>> similar
>>> way (gpio/gpio-omap.c, gpio/gpio-dwapb.c)
>>
>> Being already done doesn't make it reliable. If the line goes low
>> between latching the rising edge and reprogramming the trigger,
>> you've
>> lost at least *two* interrupts (the falling edge and the following
>> rising edge).
> 
> If a 'usual' controller support IRQ_TYPE_EDGE_BOTH and the line goes
> low between latching rising edge and handling the interrupt, wouldn't
> you miss the falling edge anyway ? The signal is just going too fast
> the HW to handle everything.

That's the role of the HW to ensure that you don't loose any interrupt,
up to the sampling frequency of the controller. Doing it in SW is always
going to be a wonderful case of "it mostly work".

> For the second rising edge, I disagree, it would not be lost, since we
> would read the pad state, get a low level, and reprogram the controller
> for another rising edge.

You always have a race between checking your level and switching the
configuration, which is likely to be slow anyway. In the meantime, the
level has changed and you're dead.

Anyway, I suggest you focus on getting something simple up and running,
and postpone the funky (read broken) stuff for later, once you have
something that looks vaguely sane (because we're not quite there yet).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
