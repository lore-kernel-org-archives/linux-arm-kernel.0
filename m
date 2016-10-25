From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 25 Oct 2016 17:31:18 +0200
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <bbc268c8-35c3-206a-46b1-62cebef174b2@arm.com>
References: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
 <1476871709-8359-5-git-send-email-jbrunet@baylibre.com>
 <CACRpkdaCZPS45t3eTcjJExOu=YT_YkjNkdpg09jQqvLQOJH=Qw@mail.gmail.com>
 <1477040798.15560.96.camel@baylibre.com>
 <CACRpkdYUVXny57AC9rKX3VRAyooEk_2XLvqe9jOuT3rOaE75rg@mail.gmail.com>
 <ec7c6cc5-cf9a-9c75-4b07-e337064c7d6e@arm.com>
 <1477400900.2482.51.camel@baylibre.com>
 <dee26f0b-e175-f8a0-2b73-08e8e324841c@arm.com>
 <1477405332.2482.87.camel@baylibre.com>
 <bbc268c8-35c3-206a-46b1-62cebef174b2@arm.com>
Message-ID: <1477409478.2482.113.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-10-25 at 15:47 +0100, Marc Zyngier wrote:
>?
> > > But why are those number different? Why don't you use the same
> > > namespace? If gpio == hwirq, all your problems are already
> > > solved. If
> > > you don't find the mapping in the irqdomain, then there is no
> > > irq,
> > > end
> > > of story. What am I missing?
> > > 
> > 
> > There is a few problems to guarantee that gpio == hwirq.
> > 1. We have 2 instances of pinctrl, to guarantee that the linux gpio
> > number == hwirq, we would have to guarantee the order in which they
> > are
> > probed. At least this my understanding?
> 
> Maybe I wasn't clear enough, and my use of gpio is probably wrong. So
> Linux has a gpio number, which is obviously an abstract number (just
> like the Linux irq number). But the pad number, in the context of
> given
> SoC, is constant. So we have:
> 
> 	pad->gpio
> 	hwirq->irq
> 
> Why can't you have pad == hwirq, always? This is already what you
> have
> in the irqchip driver. This would simplify a lot of things.

The meson pinctrl driver is designed so that, the pad numbering (or the
equivalent), is linear within a bank. This makes the code simpler for a
lot of things in the meson-pinctrl driver (like finding the appropriate
register and bit). Because of this, and the fact that some gpio might
not have an irq, pad == hwirq cannot hold.

In addition the pad numbering starts from 0 on each gpiochip.

The solution for that is to have the first and last irq number (which
is actually the mux setting of the controller) in the data of each gpio
bank, as described in the Datasheet.

> 
> > 
> > 2. Inside each instance, we may have banks that can't have irq. We
> > even
> > have a bank on meson8b which has a mixed state (the last pins don't
> > have irqs, while the first ones do). those banks/pins are still
> > valid
> > gpios with gpio numbers. This introduce a shift between the gpio
> > numbering and the hwirq.
> > 
> > The point of this calculation is take the offset given to the
> > 'to_irq'
> > callback, remove the gpio bank base number and add irq base number.
> > There is a few trick added to handled the case in 2.
> 
> You seem to assume linear mappings, which is pretty dangerous.

That's the way the meson pinctrl driver works (linear numbering in each
banks) and the HW is described in DS. Why would it be dangerous ?

> 
> > 
> > 
> > In addition, to call 'irq_find_mapping', we would first have to
> > create
> > the mapping, in the probe I suppose. This would call the allocate
> > callback of the domain, in which we can allocate only 8 interrupts.
> > 
> > That's why I create the mapping in the .to_irq callback.
> 
> Is gpio_to_irq() supposed to allocate an interrupt? Or merely to
> report
> the existence of a mapping?

Linus, please correct me if I'm wrong,
.to_irq gets the linux gpio number and returns the linux virtual irq
numbers, 0 if there is no interrupt.

So could either find or create the mapping.
   A. With the hardware at hand, and the limited upstream interrupt
      number, i don't see how we could create the mapping beforehand.?

> 
> > 
> > 
> > > 
> > > > 
> > > > 
> > > > 
> > > > Even if I implement an another irqdomain at the gpio level, I
> > > > would
> > > > still have to perform this kind of calculation, one way or the
> > > > other.
> > > > 
> > > > > 
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > Which is problematic since quite a few GPIO drivers now
> > > > > > need to use them.
> > > > > > 
> > > > > > I will review his slides, in the meantime I would say:
> > > > > > whatever
> > > > > > Marc ACKs is fine with me. I trust this guy 100%. So I
> > > > > > guess I
> > > > > > could ask that he ACK the entire chain of patches
> > > > > > from GIC->specialchip->GPIO.
> > > > 
> > > > Actually this discussion go me thinking about another issue we
> > > > have
> > > > with this hardware.
> > > > We are looking for a way to implement support for
> > > > IRQ_TYPE_EDGE_BOTH
> > > > (needed for things like gpio-keys or mmc card detect).?
> > > > The controller can do each edge but not both at the same time.
> > > > I'm thinking that implementing another irqdomain at the gpio
> > > > level
> > > > would allow to properly check the pad level in the EOI callback
> > > > then
> > > > set the next expected edge type accordingly (using
> > > > 'irq_chip_set_type_parent')
> > > > 
> > > > Would it be acceptable ?
> > > 
> > > I really don't see what another irqdomain brings to the table.
> > > This
> > > is
> > > not a separate piece of HW, so the hwirq:irq mapping is still the
> > > same.
> > > I fail to see what the benefit is.
> > 
> > The separate piece of hw is the gpio itself.?
> > The irq-controller (in irqchip) can't read the gpio state because
> > it is
> > simply another device.
> > 
> > The domain I'm thinking about wouldn't do much, I reckon.?
> > It would just register an irqchip which would only implement eoi.
> > For everything else, it would rely the parent controller.
> > From your explanation, I understood this is the purpose of
> > hierarchy
> > domains, For each hw in the chain to handle only what it can, and
> > rely
> > on its parent for the rest.
> 
> Right. But that doesn't make it more reliable, see below.
> 
> > 
> > 
> > > 
> > > 
> > > > 
> > > > 
> > > > It looks a few other drivers deal with IRQ_TYPE_EDGE_BOTH in a
> > > > similar
> > > > way (gpio/gpio-omap.c, gpio/gpio-dwapb.c)
> > > 
> > > Being already done doesn't make it reliable. If the line goes low
> > > between latching the rising edge and reprogramming the trigger,
> > > you've
> > > lost at least *two* interrupts (the falling edge and the
> > > following
> > > rising edge).
> > 
> > If a 'usual' controller support IRQ_TYPE_EDGE_BOTH and the line
> > goes
> > low between latching rising edge and handling the interrupt,
> > wouldn't
> > you miss the falling edge anyway ? The signal is just going too
> > fast
> > the HW to handle everything.
> 
> That's the role of the HW to ensure that you don't loose any
> interrupt,
> up to the sampling frequency of the controller. Doing it in SW is
> always
> going to be a wonderful case of "it mostly work".
> 
> > 
> > For the second rising edge, I disagree, it would not be lost, since
> > we
> > would read the pad state, get a low level, and reprogram the
> > controller
> > for another rising edge.
> 
> You always have a race between checking your level and switching the
> configuration, which is likely to be slow anyway. In the meantime,
> the
> level has changed and you're dead.
> 
> Anyway, I suggest you focus on getting something simple up and
> running,
> and postpone the funky (read broken) stuff for later, once you have
> something that looks vaguely sane (because we're not quite there
> yet).
> 
> Thanks,
> 
> 	M.
