From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Nov 2016 16:03:00 +0100
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <1477564941.2482.240.camel@baylibre.com>
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
 <1477564941.2482.240.camel@baylibre.com>
Message-ID: <CACRpkdZE4iCwQ4EFYFqqRs+wv7HvpR4FP=2xvYtxxpJrto_dpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 12:42 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:

> Ressource issue : When you create an irq mapping, in case of hierarchic
> domain, it calls the "alloc" function of the domain, which will
> eventually call the "alloc" function of the parent domain ... until you
> reach the "root" domain (here the gic).
(...)
> We are looking to create mapping "on-demand" to make the best use of
> the little number of interrupts we have. To catch request of drivers,
> like gpio-keys, which use gpio_to_irq, it looks the only viable place
> is the to_irq callback (at the moment).
>
> Drivers using gpio_to_irq in their probe function expect that this will
> give them the corresponding virq, so create the mapping if need be.

OK what I need to know is the following:

If this was not a gpio chip, just some random hierarchical irqchip
or mux from drivers/irqchip, where would you make the translation?

The answer to that question applies equally to any GPIO controller
that also provides an irqchip. .to_irq() is not the place to do the
translation.

I looked around and for example irq-s3c24xx.c seems to do this
in the irqdomain xlate() callback, which should only be called
when the interrupt is resolved for a consumer.

If that is the code that you partitioned over to drivers/irqchip,
then maybe this is a sign that this code should not be there
at all, but instead inside this gpiochip driver, or atleast accessible
by it so that your gpiochip driver has direct access to the
irqdomain it is using.

> However, I now get why you don't want that, it seems we have 2 types of
> platforms in the kernel right now:
>
> 1. The one creating the mapping in the to_irq callback. It might be
> because they just copy/paste from another driver doing it, or they may
> have a good reason for it (like I think we do)
>
> 2. the one which call gpio_to_irq in interrupt handlers. Honestly I did
> not know that one could that, but they are in the mainline too, and
> probably have a good reason for doing it.

They are probably all bad or legacy. None of this works with a
irqchip from DT like this:

foo: gpio at 0 {
    #gpio-cells = <2>;
    gpio-controller;
    interrupt-cells = <2>;
    interrupt-controller;
}

bar: bar at 1 {
    interrupt-parent = <&foo>;
    interrupt = <4>;
};

Here notice that bar is NOT doing gpios = <&foo 4>;
which is what you would do to get a GPIO and then call
.to_irq() on it. It just uses it as an interrupt controller.

This MUST work, or you cannot put interrupt-controller;
as a keyword on the gpiochip.

> irq_find_mapping looks safe in interrupt handler, I does not seem to
> sleep (please correct me if I'm wrong).
> irq_create_mapping definitely isn't, because of the irq_domain mutex.

Yep.

> We probably got into this situation because it wasn't clear enough
> whether to_irq was fast or slow (at least it took me a few mails to
> understand this ...)

I don't know either. It's just supposed to be a quick helper
to find the corresponding interrupt for a GPIO, it is not supposed
to have semantic side-effects.

> The two platform groups are most likely exclusive so nobody is sleeping
> in irq, everybody is happy. As a maintainer, I understand that you
> can't allow a dangerous situation like this to continue.

It's a mess allright. I need everyone's help to fix the mess.

> To fix the situation we could add a few things in the gpio subsys:
> - Make it clear that to_irq is fast (like you just did)

Sure patches accepted.

> - add a new callback (to_irq_slow ? provide_irq ? something else) which
> would be allowed to sleep and create mappings.
> - in gpio_to_irq function keeps calling to_irq like it does but also
> call to_irq_slow only if we are not in an interrupt context and a
> mapping could not be found. We could maybe use "in_interrupt()" for
> this ?

None of them should be allowed to create mappings because of the
explanation above: gpiochips and irqchips need to be
orthogonal.

> This way, we could keep the existing drivers working as they are (even
> if they are wrong) and slowly fix things up.

It doesn't seem to help with anything.

Instead go back to what I described above: if it was just
two irqchips: forget the fact that one of them is a GPIO chip
for a while, just two irqchips.

How does one irqchip map to another one?

That is what needs to happen, solely using the irqchip
infrastructure, NOT using .to_irq().

> Sorry, it was kind of long explanation but I hope things are more clear
> now.

I think I understand... famous last words.

>> I just misunderstand it as the global GPIO number, that is
>> not OK.
>
> Ok. Just to be clear, you are ok with the function
> "meson_gpio_to_hwirq" which just does this translation, right ?

That seems all right, the problem is relying on gpio_to_irq()
being called for the interrupts to work.

Yours,
Linus Walleij
