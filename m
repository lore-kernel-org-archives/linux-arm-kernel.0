From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Oct 2016 16:44:33 +0200
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <1477491816.2482.160.camel@baylibre.com>
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
Message-ID: <CACRpkdZR8T8W5WMmEJVhPR0sUQyfPzgHpjhDiRsyXvybKDYJWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 4:23 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> [Me]
>> We usually refer to the local numberspace on the GPIO controller
>> as "offsets", so line offsets 0...31 on a gpiochip with 31 lines.
>>
>> The ngpio in struct gpio_chip is the number of lines on that
>> controller,
>> and should nominally map 1:1 to hwirq sources.
>
> Indeed it should be the the case, and for meson, it is pretty close.
> The irqchip controller provide a number of hwirq. Each hwirq maps to
> one, and only one, pin. But since not every pins are connected to the
> irqchip controller, the opposite is not true.
>
> Taking an example with 16 gpios, here is what it could look like with
> the exception we have on meson :
>
> gpio offset [ 0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 ]
> hwirq num   [ 0  1  2  3] NC NC[4  5  6  7  8  9  10]NC NC NC
>
> Like gpio offset are used (internally) in the driver to find
> appropriate gpio registers and bit, the hwirq has a meaning too.
> It is the setting you put in the channel multiplexer of the controller
> to select the proper pin to spy on.
>
> In the end, these gpio offset and hwirq number are different. I would
> prefer to have hwirq == gpio and go your way, it would make my life
> easier, but I don't see how it would work.
>
> The irqchip controller cares only about the hwirq number. You can
> actually request an interrupt directly to the controller by asking the
> proper hwirq number (in DT for example), without involving the gpio
> driver (tested).
>
> The relation between the pins and the interrupt number is provided by
> the manufacturer in the Datasheet [1], in the section GPIO Interrupt.

I think I kind of get it.

This reminds me of recent patches to the generic GPIOLIB_IRQCHIP
where we made it possible to "mask" set of IRQ lines, saying
"these are in the irqdomain, but you cannot map them".

See
commit 79b804cb6af4f128b2c53f0887c02537a7eb5824
"gpiolib: Make it possible to exclude GPIOs from IRQ domain"
commit 96b2cca64fa3e1a31b573bb308b2944c802aacf3
"gpio: stmpe: forbid unused lines to be mapped as IRQs"

So what we do in the generic case is put a linear map over all
the lines/offsets, then punch holes in that map and say
"this and this and this can not be mapped as IRQ".

As you can see in _gpiochip_irqchip_add() we pre-map all
except those with irq_create_mapping().

Does this scheme fit with your usecase? I would guess so,
just that your domain is hierarchic, not simple/linear.

Maybe the takeaway is that your map does not need to
be "dense", i.e. every hwirq is in use. It can be sparse.
It is stored in a radix tree anyways.

> Looking at other gpio drivers, it is not uncommon to have some simple
> calculation to get from gpio offset to the hwirq number. I don't get
> what is the specific problem here ?

It's OK to use the offset vs hwirq.

I just misunderstand it as the global GPIO number, that is
not OK.

Yours,
Linus Walleij
