From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Aug 2013 16:05:30 +0200
Subject: [PATCH v4] gpio: Add MOXA ART GPIO driver
In-Reply-To: <1375103161-12460-1-git-send-email-jonas.jensen@gmail.com>
References: <1374053693-6166-1-git-send-email-jonas.jensen@gmail.com>
 <1375103161-12460-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <CACRpkdZ9wukeXmVbLSNYanWMUOouKduhmxgNyJ=iq-pCTQSAtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 3:06 PM, Jonas Jensen <jonas.jensen@gmail.com> wrote:

> Add GPIO driver for MOXA ART SoCs.
>
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
(...)
> +++ b/Documentation/devicetree/bindings/gpio/moxa,moxart-gpio.txt

This needs to be copied to devicetree at vger.kernel.org and I want
an ACK from some DT maintainer as well.

> @@ -0,0 +1,23 @@
> +MOXA ART GPIO Controller
> +
> +Required properties:
> +
> +- #gpio-cells : Should be 2
> +- compatible : Must be "moxa,moxart-gpio"
> +- reg : Should contain registers location and length
> +       index 0 : input, output, and direction control
> +       index 1 : enable/disable individual pins, pin 0-31

What? Why is the same block deploying these things in two
totally different places in memory?? Random HW engineer
having fun at work or...?

> +- gpio-ready-led : ready LED gpio, with zero flags
> +- gpio-reset-switch : reset switch gpio, with zero flags

This does not belong in the GPIO node, or in the GPIO
driver for that matter. This shall be handled by e.g. connecting
drivers/leds/leds-gpio.c to a GPIO using device tree by
selecting that driver in your config and do like this in your
device tree:

        leds {
                compatible = "gpio-leds";
                user-led {
                        label = "user_led";
                        gpios = <&gpio0 2 0x1>;
                        default-state = "off";
                        linux,default-trigger = "heartbeat";
                };
        };

(Gives a headtbeat trigger as well, skip that if you don't
want it.)

We have a generic reset-over-gpio driver as well, see
drivers/power/reset/gpio-poweroff.c

> +++ b/drivers/gpio/gpio-moxart.c
> @@ -0,0 +1,189 @@
> +/*
> + * MOXA ART SoCs GPIO driver.
> + *
> + * Copyright (C) 2013 Jonas Jensen
> + *
> + * Jonas Jensen <jonas.jensen@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/delay.h>
> +#include <linux/timer.h>
> +
> +#define GPIO_DATA_OUT          0x00
> +#define GPIO_DATA_IN           0x04
> +#define GPIO_PIN_DIRECTION     0x08
> +
> +static void __iomem *moxart_pincontrol_base;
> +static void __iomem *moxart_gpio_base;
> +
> +void moxart_gpio_enable(u32 gpio)
> +{
> +       writel(readl(moxart_pincontrol_base) | gpio, moxart_pincontrol_base);
> +}
> +
> +void moxart_gpio_disable(u32 gpio)
> +{
> +       writel(readl(moxart_pincontrol_base) & ~gpio, moxart_pincontrol_base);
> +}
> +
> +static int moxart_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> +       moxart_gpio_enable(1 << offset);

Do this:
#include <linux/bitops.h>

moxart_gpio_enable(BIT(offset));

Repeat the comment for every similar instance below.

> +static void moxart_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> +{
> +       void __iomem *ioaddr = moxart_gpio_base + GPIO_DATA_OUT;
> +       u32 reg = readl(ioaddr);
> +
> +       (value) ?       writel(reg | (1 << offset), ioaddr) :
> +                       writel(reg & ~(1 << offset), ioaddr);

Isn't that a bit hard to read?

if (value)
  reg |= BIT(offset);
else
  reg &= ~BIT(offset);
writel(reg, ioaddr);


> +static int moxart_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +       u32 ret = readl(moxart_gpio_base + GPIO_PIN_DIRECTION);
> +
> +       if (ret & (1 << offset))
> +               ret = readl(moxart_gpio_base + GPIO_DATA_OUT) & (1 << offset);
> +       else
> +               ret = readl(moxart_gpio_base + GPIO_DATA_IN) & (1 << offset);


Use this construct:

if (ret & BIT(offset)
   return !!(readl(moxart_gpio_base + GPIO_DATA_OUT) & BIT(offset));
return !!(readl(moxart_gpio_base + GPIO_DATA_IN) & BIT(offset));

> +       ret = gpiochip_add(&moxart_gpio_chip);
> +       if (ret)
> +               dev_err(dev, "%s: gpiochip_add failed\n",
> +                       dev->of_node->full_name);

You need to bail out here, right? Not continue to do
dangerous stuff.

> +       gpio_ready_led = of_get_named_gpio(dev->of_node,
> +                                          "gpio-ready-led", 0);
> +       if (!gpio_is_valid(gpio_ready_led)) {
> +               dev_err(dev, "invalid gpio (gpio-ready-led): %d\n",
> +                       gpio_ready_led);
> +               return gpio_ready_led;
> +       }
> +
> +       gpio_reset_switch = of_get_named_gpio(dev->of_node,
> +                                             "gpio-reset-switch", 0);
> +       if (!gpio_is_valid(gpio_reset_switch)) {
> +               dev_err(dev, "invalid gpio (gpio-reset-switch): %d\n",
> +                       gpio_reset_switch);
> +               return gpio_reset_switch;
> +       }

Please get rid of this. Use standard drivers as described above.


> +static int __init moxart_gpio_init(void)
> +{
> +       return platform_driver_register(&moxart_gpio_driver);
> +}
> +
> +postcore_initcall(moxart_gpio_init);

Do you really need to have them this early?

Yours,
Linus Walleij
