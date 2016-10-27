From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 27 Oct 2016 12:42:21 +0200
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <CACRpkdZR8T8W5WMmEJVhPR0sUQyfPzgHpjhDiRsyXvybKDYJWQ@mail.gmail.com>
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
 <CACRpkdba_iaOK61KiQGvJZYuz7-PiBgtN4vxv__tJLsZ8ZVL=w@mail.gmail.com>
 <1477491816.2482.160.camel@baylibre.com>
 <CACRpkdZR8T8W5WMmEJVhPR0sUQyfPzgHpjhDiRsyXvybKDYJWQ@mail.gmail.com>
Message-ID: <1477564941.2482.240.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-10-26 at 16:44 +0200, Linus Walleij wrote:
> On Wed, Oct 26, 2016 at 4:23 PM, Jerome Brunet <jbrunet@baylibre.com>
> wrote:
> > 
> > [Me]
> > > 
> > > We usually refer to the local numberspace on the GPIO controller
> > > as "offsets", so line offsets 0...31 on a gpiochip with 31 lines.
> > > 
> > > The ngpio in struct gpio_chip is the number of lines on that
> > > controller,
> > > and should nominally map 1:1 to hwirq sources.
> > 
> > Indeed it should be the the case, and for meson, it is pretty
> > close.
> > The irqchip controller provide a number of hwirq. Each hwirq maps
> > to
> > one, and only one, pin. But since not every pins are connected to
> > the
> > irqchip controller, the opposite is not true.
> > 
> > Taking an example with 16 gpios, here is what it could look like
> > with
> > the exception we have on meson :
> > 
> > gpio offset [ 0??1??2??3??4??5??6??7??8??9??10 11 12 13 14 15 ]
> > hwirq num???[ 0??1??2??3] NC NC[4??5??6??7??8??9??10]NC NC NC
> > 
> > Like gpio offset are used (internally) in the driver to find
> > appropriate gpio registers and bit, the hwirq has a meaning too.
> > It is the setting you put in the channel multiplexer of the
> > controller
> > to select the proper pin to spy on.
> > 
> > In the end, these gpio offset and hwirq number are different. I
> > would
> > prefer to have hwirq == gpio and go your way, it would make my life
> > easier, but I don't see how it would work.
> > 
> > The irqchip controller cares only about the hwirq number. You can
> > actually request an interrupt directly to the controller by asking
> > the
> > proper hwirq number (in DT for example), without involving the gpio
> > driver (tested).
> > 
> > The relation between the pins and the interrupt number is provided
> > by
> > the manufacturer in the Datasheet [1], in the section GPIO
> > Interrupt.
> 
> I think I kind of get it.
> 
> This reminds me of recent patches to the generic GPIOLIB_IRQCHIP
> where we made it possible to "mask" set of IRQ lines, saying
> "these are in the irqdomain, but you cannot map them".
> 
> See
> commit 79b804cb6af4f128b2c53f0887c02537a7eb5824
> "gpiolib: Make it possible to exclude GPIOs from IRQ domain"
> commit 96b2cca64fa3e1a31b573bb308b2944c802aacf3
> "gpio: stmpe: forbid unused lines to be mapped as IRQs"
> 
> So what we do in the generic case is put a linear map over all
> the lines/offsets, then punch holes in that map and say
> "this and this and this can not be mapped as IRQ".
> 
> As you can see in _gpiochip_irqchip_add() we pre-map all
> except those with irq_create_mapping().
> 
> Does this scheme fit with your usecase? I would guess so,
> just that your domain is hierarchic, not simple/linear.

Thanks for pointing this out, however I don't think this solve my
issue. I'll try to be as clear as possible but feel free to ask me
question if needed:

Ressource issue : When you create an irq mapping, in case of hierarchic
domain, it calls the "alloc" function of the domain, which will
eventually call the "alloc" function of the parent domain ... until you
reach the "root" domain (here the gic).

The particular HW at hand (meson gpio interrupt controller) is a set of
8 muxes (or channels). Each channel output its signal on 1 specific GIC
input. Its the HW wiring, not programmable.
The inputs are the all pad that can be seen by the controller (*almost*
all the SoC gpio, but not all, as explain earlier). When you call
"alloc", the driver find an available channel, set the mux input to
forward the appropriate signal to the GIC.

As you may understand, the driver can accept only 8 mappings at a time
before being out of GIC irqs, and returning -ENOSPC.

If we were trying the use the punch hole method, we would have to know
at boot time the only eight pin we want, and this for every platform.
Also there not might be 8 available to the gpio subsys, since someone
could request an irq directly to controller, w/o going through the gpio
subsys. This would be putting restriction on the gpio because of an
issue in the controller. This looks very complicated to setup, static
and platform specific. That's not really what we were aiming for.

We are looking to create mapping "on-demand" to make the best use of
the little number of interrupts we have. To catch request of drivers,
like gpio-keys, which use gpio_to_irq, it looks the only viable place
is the to_irq callback (at the moment).

Drivers using gpio_to_irq in their probe function expect that this will
give them the corresponding virq, so create the mapping if need be.

However, I now get why you don't want that, it seems we have 2 types of
platforms in the kernel right now:?

1. The one creating the mapping in the to_irq callback. It might be
because they just copy/paste from another driver doing it, or they may
have a good reason for it (like I think we do)

2. the one which call gpio_to_irq in interrupt handlers. Honestly I did
not know that one could that, but they are in the mainline too, and
probably have a good reason for doing it.

irq_find_mapping looks safe in interrupt handler, I does not seem to
sleep (please correct me if I'm wrong).
irq_create_mapping definitely isn't, because of the irq_domain mutex.

We probably got into this situation because it wasn't clear enough
whether to_irq was fast or slow (at least it took me a few mails to
understand this ...)
The two platform groups are most likely exclusive so nobody is sleeping
in irq, everybody is happy. As a maintainer, I understand that you
can't allow a dangerous situation like this to continue.

To fix the situation we could add a few things in the gpio subsys:
- Make it clear that to_irq is fast (like you just did)
- add a new callback (to_irq_slow ? provide_irq ? something else) which
would be allowed to sleep and create mappings.
- in gpio_to_irq function keeps calling to_irq like it does but also
call to_irq_slow only if we are not in an interrupt context and a
mapping could not be found. We could maybe use "in_interrupt()" for
this ?

This way, we could keep the existing drivers working as they are (even
if they are wrong) and slowly fix things up.

What do you think about this ? Do you have something else in mind ?
I'd be happy to help on this.

Sorry, it was kind of long explanation but I hope things are more clear
now.

> 
> Maybe the takeaway is that your map does not need to
> be "dense", i.e. every hwirq is in use. It can be sparse.
> It is stored in a radix tree anyways.
> 
> > 
> > Looking at other gpio drivers, it is not uncommon to have some
> > simple
> > calculation to get from gpio offset to the hwirq number. I don't
> > get
> > what is the specific problem here ?
> 
> It's OK to use the offset vs hwirq.
> 
> I just misunderstand it as the global GPIO number, that is
> not OK.

Ok. Just to be clear, you are ok with the function
"meson_gpio_to_hwirq" which just does this translation, right ?

> 
> Yours,
> Linus Walleij


Cheers
Jerome
