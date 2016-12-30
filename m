From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 09:51:51 +0100
Subject: [PATCH 3/6] pinctrl: armada-37xx: Add gpio support
In-Reply-To: <20161222172501.16121-4-gregory.clement@free-electrons.com>
References: <20161222172501.16121-1-gregory.clement@free-electrons.com>
 <20161222172501.16121-4-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdY_68=5oBN3TLs_ohc0gc2=yiG3qizg7MGh4F7Z+-ZzSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 6:24 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> GPIO management is pretty simple and is part of the same IP than the pin
> controller for the Armada 37xx SoCs.  This patch adds the GPIO support to
> the pinctrl-armada-37xx.c file, it also allows sharing common functions
> between the gpiolib and the pinctrl drivers.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Some remarks:

> +static int armada_37xx_gpio_get_direction(struct gpio_chip *chip,
> +                                         unsigned int offset)
> +{
> +       struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
> +       unsigned int reg = OUTPUT_EN;
> +       unsigned int val, mask;
> +
> +       if (offset >= GPIO_PER_REG) {
> +               offset -= GPIO_PER_REG;
> +               reg += sizeof(u32);
> +       }

Add a comment saying we never have more than two registers?
If there would be three registers this would fail, right?

> +       mask = BIT(offset);
> +
> +       regmap_read(info->regmap, reg, &val);
>
> +       return (val & mask) == 0;

Use this:

return !(val & mask);

> +static int armada_37xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
> +       unsigned int reg = INPUT_VAL;
> +       unsigned int val, mask;
> +
> +       if (offset >= GPIO_PER_REG) {
> +               offset -= GPIO_PER_REG;
> +               reg += sizeof(u32);
> +       }
> +       mask = BIT(offset);

This code is repeating. Break out a static (inline?) helper to do this.

> +static int armada_37xx_gpiolib_register(struct platform_device *pdev,
> +                                       struct armada_37xx_pinctrl *info)

Nit: gpiochip_register or so is more to the point.

> +       ret = gpiochip_add_pin_range(&info->gpio_chip, dev_name(dev), 0,
> +                                    pinbase, info->data->nr_pins);
> +       if (ret)
> +               return ret;

Why do you do this?

Why not just put the ranges into the device tree? We already support
this in the gpiolib core and it is helpful.

See Documentation/devicetree/bindings/gpio/gpio.txt
and other DTS files for gpio-ranges.

Yours,
Linus Walleij
