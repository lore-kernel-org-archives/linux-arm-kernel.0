From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 09:58:06 +0100
Subject: [PATCH 4/6] pinctrl: aramda-37xx: Add irqchip support
In-Reply-To: <20161222172501.16121-5-gregory.clement@free-electrons.com>
References: <20161222172501.16121-1-gregory.clement@free-electrons.com>
 <20161222172501.16121-5-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdbR-WRT0rJp2CuN6CkZF=J35JUgGHjW7beyaimipz0ehw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 6:24 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> The Armada 37xx SoCs can handle interrupt through GPIO. However it can
> only manage the edge ones.
>
> The way the interrupt are managed are classical so we can use the generic
> interrupt chip model.
>
> The only unusual "feature" is that many interrupts are connected to the
> parent interrupt controller. But we do not take advantage of this and use
> the chained irq with all of them.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

So this is very simple and should use GPIOLIB_IRQCHIP.

Begin with select GPIOLIB_IRQCHIP in your Kconfig and then look
at conversions such as commit 85ae9e512f437cd09bf61564bdba29ab88bab3e3
("pinctrl: bcm2835: switch to GPIOLIB_IRQCHIP")
for inspiration.

> @@ -64,6 +71,8 @@ struct armada_37xx_pinctrl {
>         struct armada_37xx_pin_data     *data;
>         struct device                   *dev;
>         struct gpio_chip                gpio_chip;
> +       struct irq_chip                 irq_chip;
> +       struct irq_domain               *domain;

You don't need a domain when using GPIOLIB_IRQCHIP

> +static int armada_37xx_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
> +
> +       return irq_create_mapping(info->domain, offset);
> +}

Nor this.

The irqchip code should be pretty much the same but you need to
dereference gpio_chip from chip data and pick the irqchip from
there.

Yours,
Linus Walleij
