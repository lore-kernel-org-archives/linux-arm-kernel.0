From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Jan 2016 12:22:14 +0100
Subject: pinctrl: mediatek: questions about gpio/pinctrl/eint
In-Reply-To: <1453948541.14802.38.camel@mhfsdcap03>
References: <1453948541.14802.38.camel@mhfsdcap03>
Message-ID: <CACRpkdbhY9Rt-DD3BgiG8u5JrW+6XcZn0JWWE2Q39wQp38GjXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 3:35 AM, biao huang <biao.huang@mediatek.com> wrote:

>         First, when user call GPIO API to control medaitek gpio, they should
> call pinctrl API to set pinmux to mode 0 ahead, so this pin is function
> as gpio. And this makes things a little complicated. Is there any simple
> API can solve this problem? How about add pinmux setting in
> gpio_request?

This is what the
pinctrl_request_gpio, pinctrl_free_gpio, pinctrl_gpio_direction_input
andpinctrl_gpio_direction_output calls are for.

Look for example in drivers/gpio/gpio-pl061.c:

      if (of_property_read_bool(dev->of_node, "gpio-ranges")) {
                chip->gc.request = gpiochip_generic_request;
                chip->gc.free = gpiochip_generic_free;
        }

What does that do:

/**
 * gpiochip_generic_request() - request the gpio function for a pin
 * @chip: the gpiochip owning the GPIO
 * @offset: the offset of the GPIO to request for GPIO function
 */
int gpiochip_generic_request(struct gpio_chip *chip, unsigned offset)
{
        return pinctrl_request_gpio(chip->base + offset);
}
EXPORT_SYMBOL_GPL(gpiochip_generic_request);

/**
 * gpiochip_generic_free() - free the gpio function from a pin
 * @chip: the gpiochip to request the gpio function for
 * @offset: the offset of the GPIO to free from GPIO function
 */
void gpiochip_generic_free(struct gpio_chip *chip, unsigned offset)
{
        pinctrl_free_gpio(chip->base + offset);
}
EXPORT_SYMBOL_GPL(gpiochip_generic_free);

Yes....

Your pinctrl driver needs to implement the
.gpio_request_enable()
.gpio_disable_free()
.gpio_set_direction()
callbacks in struct pinmux_ops.

Also read in Documentation/pinctrl.txt about pinctrl/GPIO interaction.

>         Second, here is our request_irq flow in mkd eint driver:
> request_irq --> mtk_pinctrl_irq_request_resources--> mtk_pmx_set_mode,
> Normally, it'll set pinmux to eint mode (usually is mode 0) in
> mtk_pmx_set_mode function. But for special case, such as iddig (connect
> to usb), when iddig request_irq, it should set pinmux to iddig mode
> (mode 2 in mt8163).
>         Is there a better way than changing
>         MTK_PIN(
>                 PINCTRL_PIN(16, "IDDIG"),
>                 NULL, "mt8173",
>                 MTK_EINT_FUNCTION(0, 16),
>                 MTK_FUNCTION(0, "GPIO16"),
>                 MTK_FUNCTION(1, "IDDIG"),
>                 MTK_FUNCTION(2, "CMFLASH"),
>                 MTK_FUNCTION(4, "PWM5")
>         ),
>         to
>         MTK_PIN(
>                 PINCTRL_PIN(16, "IDDIG"),
>                 NULL, "mt8173",
>                 MTK_EINT_FUNCTION(2, 16),
>                 MTK_FUNCTION(0, "GPIO16"),
>                 MTK_FUNCTION(1, "IDDIG"),
>                 MTK_FUNCTION(2, "CMFLASH"),
>                 MTK_FUNCTION(4, "PWM5")
>         ),
>         in drivers/pinctrl/mediatek/pinctrl-mtk-mt8163.h?

This is the mediatek driver internals, I don't understand that.
Your guess is as good as mine, ask help from the other
driver authors is my hint, I can only help with the framework...

Yours,
Linus Walleij
