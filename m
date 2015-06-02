From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jun 2015 15:12:11 +0200
Subject: [PATCH 05/12] i2c: pxa: Add bus reset functionality
In-Reply-To: <1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CACRpkdaxWsi8t6aUFJK-KCmQF1gEOLiOE8=fgDRxQDSi4G6FgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 3:03 PM, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:

> From: Rob Herring <robh@kernel.org>
>
> Since there is some problematic i2c slave devices on some
> platforms such as dkb (sometimes), it will drop down sda
> and make i2c bus hang, at that time, it need to config
> scl/sda into gpio to simulate "stop" sequence to recover
> i2c bus, so add this interface.
>
> Signed-off-by: Leilei Shang <shangll@marvell.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> [vaibhav.hiremath at linaro.org: Updated Changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

Double signed-off?

(...)
+#include <linux/of_gpio.h>

You should use <linux/gpio/consumer.h> and then use
GPIO descriptors instead.

> @@ -177,6 +179,9 @@ struct pxa_i2c {
>         bool                    highmode_enter;
>         unsigned int            ilcr;
>         unsigned int            iwcr;
> +       struct pinctrl          *pinctrl;
> +       struct pinctrl_state    *pin_i2c;
> +       struct pinctrl_state    *pin_gpio;

Yup that's the right way. I see this is the "default"
state for pin_i2c.

> +static void i2c_bus_reset(struct pxa_i2c *i2c)
> +{
> +       int ret, ccnt, pins_scl, pins_sda;

Use GPIO descriptors.

struct gpio_desc *scl, *sda;

> +       struct device *dev = i2c->adap.dev.parent;
> +       struct device_node *np = dev->of_node;
> +
> +       if (!i2c->pinctrl) {
> +               dev_warn(dev, "could not do i2c bus reset\n");
> +               return;
> +       }
> +
> +       ret = pinctrl_select_state(i2c->pinctrl, i2c->pin_gpio);
> +       if (ret) {
> +               dev_err(dev, "could not set gpio pins\n");
> +               return;
> +       }

Exactly like that yes.

> +       pins_scl = of_get_named_gpio(np, "i2c-gpio", 0);
> +       if (!gpio_is_valid(pins_scl)) {
> +               dev_err(dev, "i2c scl gpio not set\n");
> +               goto err_out;
> +       }
> +       pins_sda = of_get_named_gpio(np, "i2c-gpio", 1);
> +       if (!gpio_is_valid(pins_sda)) {
> +               dev_err(dev, "i2c sda gpio not set\n");
> +               goto err_out;
> +       }

I would suggest just using two GPIOs in the node relying
on index order. With GPIO descriptors:

scl = gpiod_get_index(dev, "i2c-gpio", 0, GPIOD_ASIS);
sda = gpiod_get_index(dev, "i2c-gpio", 1, GPIOD_ASIS);

Then use gpiod* accessors below and...

> +
> +       gpio_request(pins_scl, NULL);
> +       gpio_request(pins_sda, NULL);
> +
> +       gpio_direction_input(pins_sda);
> +       for (ccnt = 20; ccnt; ccnt--) {
> +               gpio_direction_output(pins_scl, ccnt & 0x01);
> +               udelay(5);
> +       }
> +       gpio_direction_output(pins_scl, 0);
> +       udelay(5);
> +       gpio_direction_output(pins_sda, 0);
> +       udelay(5);
> +       /* stop signal */
> +       gpio_direction_output(pins_scl, 1);
> +       udelay(5);
> +       gpio_direction_output(pins_sda, 1);
> +       udelay(5);
> +
> +       gpio_free(pins_scl);
> +       gpio_free(pins_sda);

gpiod_put(scl);
gpiod_put(sda);

> +err_out:
> +       ret = pinctrl_select_state(i2c->pinctrl, i2c->pin_i2c);
> +       if (ret)
> +               dev_err(dev, "could not set default(i2c) pins\n");
> +       return;

Nice.

Overall it looks like a real nice structured workaround using
the API exactly as intended, just need to catch up with
using GPIO descriptors.

Yours,
Linus Walleij
