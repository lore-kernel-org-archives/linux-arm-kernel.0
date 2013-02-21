From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Feb 2013 01:31:49 +0100
Subject: Sunxi GPIO IRQ handling
In-Reply-To: <511E1510.70502@free-electrons.com>
References: <511E1510.70502@free-electrons.com>
Message-ID: <CACRpkdaSSeVzn0rwXPSdoNcGrmntOXSN_GiTTrL=Vmnp_Fsp=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 11:59 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The IP found on these chip is rather unusual, in the sense that not all
> the pins handled by it can trigger an interrupt, but only a small set of
> those (32 on the A10, 23 on the A13).

That's not all that uncommon. The ABx00's have a similar
restriction (but even weirder).

> All these pins are not in the same bank, and have to be muxed to a given
> function (that is different of the GPIO input function).

Not quite following? Is the pin not in something called GPIO
mode when used for IRQ?

> You can find more details about this in the IP datasheet found at
> http://www.henriknordstrom.net/code/A10/A10%20PIO%20Controller.pdf

Hm doesn't seem to be there? I get 404.

> I'm not exactly sure about how to integrate this into the
> pinctrl/gpio/irqchip infrastructure, if that is achievable.
>
> Do you have any idea on how we could do this?

In your gpio_to_irq() function, just return -EINVAL if the
GPIO line does not support generating IRQs.

Check what we do in abx500_gpio_to_irq() in
drivers/pinctrl/pinctrl-abx500.c for example.

In your struct irqchip callbacks, set up any muxing
needed. If this does not need to be exposed to the
outside through the pinctrl muxing API with groups
and stuff, don't do it. However if you need to set up
muxing as part of enabling IRQ on a certain pin, do
that in your .irq_unmask() or similar callback. (But I
think that sounds strange.)

Yours,
Linus Walleij
