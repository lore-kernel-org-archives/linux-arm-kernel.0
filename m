From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Mar 2016 15:56:25 +0100
Subject: [PATCH 10/17] pinctrl: Add PLX Technology OXNAS pinctrl and gpio
 driver
In-Reply-To: <1457005210-18485-11-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-11-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdby7XmbK2ZpwX3zy5J=yr1HRbmfWVab3K0ArcL6wd=oyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2016 at 12:40 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Add pinctrl and gprio control support to PLX Technology OXNAS SoC Family

Be a bit more verbose. Is this MIPS? ARM? How many pins does it have? Etc.

> CC: Ma Haijun <mahaijuns@gmail.com>
> CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

This driver has some way to go, but let's work on it!

> +config PINCTRL_OXNAS
> +       bool
> +       depends on OF
> +       select PINMUX
> +       select PINCONF

Why is it not using GENERIC_PINCONF?

> +       select GPIOLIB
> +       select OF_GPIO

I can already see that this driver should use
select GPIOLIB_IRQCHIP and the existing infrastructure
to manage chained IRQs in the gpiolib core.

The driver need to be rewritten for this: see other drivers
using GPIOLIB_IRQCHIP for examples, both GPIO and pin control
drivers use this so there are plenty of examples.

As a result the code will shrink quite a bit.

> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/io.h>
> +#include <linux/gpio.h>

You should only need to include <linux/gpio/driver.h>

> +#include <linux/pinctrl/machine.h>

Why?

> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +/* Since we request GPIOs from ourself */
> +#include <linux/pinctrl/consumer.h>

So why do you do this? Is this a copy/paste?

> +#include <linux/version.h>

This looks like something from a porting shim that brings this
same driver to a few different kernel versions. This include should
not be needed.

> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include "core.h"
> +
> +#define MAX_NB_GPIO_PER_BANK   32
> +#define MAX_GPIO_BANKS         2
> +
> +struct oxnas_gpio_chip {
> +       struct gpio_chip        chip;
> +       struct pinctrl_gpio_range range;
> +       void __iomem            *regbase;  /* GPIOA/B virtual address */
> +       struct irq_domain       *domain;   /* associated irq domain */

Should not be needed with GPIOLIB_IRQCHIP

> +#define to_oxnas_gpio_chip(c) container_of(c, struct oxnas_gpio_chip, chip)

We nowadays use gpiochip_get_data() to get the state container pointer.
Use this along with gpiochip_add_data(), or even better:
devm_gpiochip_add_data()
which will be merged for v4.6.

> +static struct oxnas_gpio_chip *gpio_chips[MAX_GPIO_BANKS];

Is that really needed? Oh well let's see as we work on this.

> +static int oxnas_dt_node_to_map(struct pinctrl_dev *pctldev,
> +                       struct device_node *np,
> +                       struct pinctrl_map **map, unsigned *num_maps)
> +{

> +       /*
> +        * first find the group of this node and check if we need create
> +        * config maps for pins
> +        */
> +       grp = oxnas_pinctrl_find_group_by_name(info, np->name);
> +       if (!grp) {
> +               dev_err(info->dev, "unable to find group for node %s\n",
> +                       np->name);
> +               return -EINVAL;
> +       }
> +
> +       map_num += grp->npins;
> +       new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num,
> +                              GFP_KERNEL);
> +       if (!new_map)
> +               return -ENOMEM;
> +
> +       *map = new_map;
> +       *num_maps = map_num;

Ugh this looks hairy. Can you not use the utility functions from
pinctrl-utils.h with pinctrl_utils_reserve_map() etc?

> +static void oxnas_dt_free_map(struct pinctrl_dev *pctldev,
> +                               struct pinctrl_map *map, unsigned num_maps)
> +{
> +}

Really? You don't fool me. ;)

pinctrl_utils_dt_free_map() from pinctrl-utils.h should be your friend,
if you follow the pattern from other drivers.

> +static void __iomem *pin_to_gpioctrl(struct oxnas_pinctrl *info,
> +                                unsigned int bank)
> +{
> +       return gpio_chips[bank]->regbase;
> +}
> +
> +static inline int pin_to_bank(unsigned pin)
> +{
> +       return pin / MAX_NB_GPIO_PER_BANK;
> +}
> +
> +static unsigned pin_to_mask(unsigned int pin)
> +{
> +       return 1 << pin;
> +}

Those are a bit simplistic. The last one can be replaced by the
this inline:

+ include <linux/bitops.h>

- pin_to_mask(foo);
+ BIT(foo);

> +static int gpio_irq_type(struct irq_data *d, unsigned type)
> +{
> +       if ((type & IRQ_TYPE_EDGE_BOTH) == 0) {
> +               pr_warn("oxnas: Unsupported type for irq %d\n",
> +                       gpio_to_irq(d->irq));
> +               return -EINVAL;
> +       }
> +       /* seems no way to set trigger type without enable irq,
> +        * so leave it to unmask time
> +        */
> +
> +       return 0;
> +}

This will make your interrupt chip accept level IRQ types
which it obviously does not support.

> +static struct irq_chip gpio_irqchip = {
> +       .name           = "GPIO",
> +       .irq_disable    = gpio_irq_mask,
> +       .irq_mask       = gpio_irq_mask,
> +       .irq_unmask     = gpio_irq_unmask,
> +       .irq_set_type   = gpio_irq_type,
> +};

I think you should implement .irq_ack which will ACK the
IRQ before continuing with the IRQ handler.

> +static void gpio_irq_handler(struct irq_desc *desc)
> +{
> +       struct irq_chip *chip = irq_desc_get_chip(desc);
> +       struct irq_data *idata = irq_desc_get_irq_data(desc);
> +       struct oxnas_gpio_chip *oxnas_gpio = irq_data_get_irq_chip_data(idata);
> +       void __iomem *pio = oxnas_gpio->regbase;
> +       unsigned long isr;
> +       int n;
> +
> +       chained_irq_enter(chip, desc);
> +       for (;;) {
> +               isr = readl_relaxed(pio + IRQ_PENDING);
> +               if (!isr)
> +                       break;
> +
> +               /* acks pending interrupts */
> +               writel_relaxed(isr, pio + IRQ_PENDING);

This should not be done here but in the .irq_ack() function that you
should implement in the irq chip.

See drivers/gpio/gpio-pl061.c for inspiration.

> + * This lock class tells lockdep that GPIO irqs are in a different
> + * category than their parents, so it won't report false recursion.
> + */
> +static struct lock_class_key gpio_lock_class;

This is also handled by GPIOLIB_IRQCHIP.

> +static int oxnas_gpio_irq_map(struct irq_domain *h, unsigned int virq,
> +                             irq_hw_number_t hw)
> +{
> +       struct oxnas_gpio_chip *oxnas_gpio = h->host_data;
> +
> +       irq_set_lockdep_class(virq, &gpio_lock_class);
> +
> +       irq_set_chip_and_handler(virq, &gpio_irqchip, handle_edge_irq);

So you use handle_edge_irq() but do not implement .irq_ack(), that
looks wrong.

> +
> +       irq_set_chip_data(virq, oxnas_gpio);
> +
> +       return 0;
> +}

And this is also handled by GPIOLIB_IRQCHIP by the way.

> +static int oxnas_gpio_irq_domain_xlate(struct irq_domain *d,
> +                                      struct device_node *ctrlr,
> +                                      const u32 *intspec,
> +                                      unsigned int intsize,
> +                                      irq_hw_number_t *out_hwirq,
> +                                      unsigned int *out_type)
> +{
> +       struct oxnas_gpio_chip *oxnas_gpio = d->host_data;
> +       int ret;
> +       int pin = oxnas_gpio->chip.base + intspec[0];
> +
> +       if (WARN_ON(intsize < 2))
> +               return -EINVAL;
> +       *out_hwirq = intspec[0];
> +       *out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
> +
> +       ret = gpio_request(pin, ctrlr->full_name);
> +       if (ret)
> +               return ret;

No, the IRQchip and gpiochip should be orthogonal.
The irqchip will mark lines as used for IRQ though.
Rely on GPIOLIB_IRQCHIP.

> +
> +       ret = gpio_direction_input(pin);
> +       if (ret)
> +               return ret;

Your irqchip code should set up the hardware for IRQ,
not the xlate function.

> +
> +       return 0;
> +}
> +
> +static struct irq_domain_ops oxnas_gpio_ops = {
> +       .map    = oxnas_gpio_irq_map,
> +       .xlate  = oxnas_gpio_irq_domain_xlate,
> +};

And all this goes away with GPIOLIB_IRQCHIP.

> +       names = devm_kzalloc(&pdev->dev, sizeof(char *) * chip->ngpio,
> +                            GFP_KERNEL);
> +
> +       if (!names) {
> +               ret = -ENOMEM;
> +               goto err;
> +       }
> +
> +       for (i = 0; i < chip->ngpio; i++)
> +               names[i] = kasprintf(GFP_KERNEL, "MF_%c%d", alias_idx + 'A', i);
> +
> +       chip->names = (const char *const *)names;

Clever, however we are discussing adding a method for naming the lines
to the device tree bindings, please see these discussions for information.
Do not use this method plese.

There will be more review comments but I look forward to v2 as the first
step, using more library functions and cutting down the code a bit!

Yours,
Linus Walleij
