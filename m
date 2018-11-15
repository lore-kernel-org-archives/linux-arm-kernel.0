From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2018 10:56:22 +0100
Subject: [PATCH 3/3] gpio: add driver for sama5d2 PIOBU pins
In-Reply-To: <1541603580-17448-4-git-send-email-andrei.stefanescu@microchip.com>
References: <1541603580-17448-1-git-send-email-andrei.stefanescu@microchip.com>
 <1541603580-17448-4-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <CACRpkda6NLv_HrzygJ5J082jrWwVH3Ljt-5bqJv1kvoax5wWWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrei,

thanks for your patch!

On Wed, Nov 7, 2018 at 4:12 PM <Andrei.Stefanescu@microchip.com> wrote:

> PIOBU pins do not lose their voltage during Backup/Self-refresh.
> This patch adds a simple GPIO controller for them.
>
> This driver adds support for using the pins as GPIO
> offering the possibility to read/set the voltage.
>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>

(...)
> +config GPIO_SAMA5D2_PIOBU
> +       tristate "SAMA5D2 PIOBU GPIO support"
> +       depends on GPIO_SYSCON

Should it not be:
depends on MFD_SYSCON
select GPIO_SYSCON

> +#include <linux/gpio.h>

Drivers should only
#include <linux/gpio/driver.h>

Also add:
#include <linux/bits.h>
because you use BIT() macros.

> +#define PIOBU_NUM 8
> +#define PIOBU_REG_SIZE 4

Isnt register size 4 implied by syscon, I think it is hardwired
to 32 bits.

> +/*
> + * sama5d2_piobu_setup_pin - prepares a pin for sama5d2_piobu_set_direction call
> + *
> + * Do not consider pin for intrusion detection (normal and backup modes)
> + * Do not consider pin as intrusion wakeup interrupt source

Intrusion ... sounds like some burglar alarm :D

> +/*
> + * sama5d2_piobu_get_direction - gpiochip get_direction
> + */

Check all your kerneldoc comments please,

/**
 * this_is_a_function() - This is a function
 */

See
Documentation/doc-guide/kernel-doc.rst

> +static int sama5d2_piobu_get_direction(struct gpio_chip *chip,
> +                                      unsigned int pin)
> +{
> +       int ret = sama5d2_piobu_read_value(chip, pin, PIOBU_DIRECTION);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       return (ret == PIOBU_IN) ? GPIOF_DIR_IN : GPIOF_DIR_OUT;

Please do not use these flags in drivers: they are for consumers.
Just return 0/1.

> +static int sama5d2_piobu_get(struct gpio_chip *chip, unsigned int pin)
> +{
> +       /* if pin is input, read value from PDS else read from SOD */
> +       int ret = sama5d2_piobu_get_direction(chip, pin);
> +
> +       if (ret == GPIOF_DIR_IN)
> +               ret = sama5d2_piobu_read_value(chip, pin, PIOBU_PDS);
> +       else if (ret == GPIOF_DIR_OUT)
> +               ret = sama5d2_piobu_read_value(chip, pin, PIOBU_SOD);

Dito.

> +static void sama5d2_piobu_set(struct gpio_chip *chip, unsigned int pin,
> +                             int value)
> +{
> +       value = (value == 0) ? PIOBU_LOW : PIOBU_HIGH;

That looks unorthodox. Just use an if() statement.

> +const struct gpio_chip sama5d2_piobu_template_chip = {
> +       .owner = THIS_MODULE,
> +       .get_direction = sama5d2_piobu_get_direction,
> +       .direction_input = sama5d2_piobu_direction_input,
> +       .direction_output = sama5d2_piobu_direction_output,
> +       .get = sama5d2_piobu_get,
> +       .set = sama5d2_piobu_set,
> +       .base = -1,
> +       .ngpio = PIOBU_NUM,
> +       .can_sleep = 0,
(...)
> +       piobu->chip = sama5d2_piobu_template_chip;
> +       piobu->chip.label = pdev->name;
> +       piobu->chip.parent = &pdev->dev;
> +       piobu->chip.of_node = pdev->dev.of_node;

This is just overcomplicating things. Instead of assigning the template
just assign all function here in the probe() code, get rid of the
templaye. It's easier to follow.

> +       piobu->regmap =
> +               syscon_regmap_lookup_by_compatible("microchip,sama5d2-piobu");

So maybe just put this inside your syscon node and use:
syscon_node_to_regmap(pdev->dev.parent->of_node);

I might have more comments on the next version, but keep at it!

Yours,
Linus Walleij
