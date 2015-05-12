From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 May 2015 12:55:04 +0200
Subject: [PATCH 2/3] gpio: Add GPIO support for Broadcom STB SoCs
In-Reply-To: <1430901477-10678-3-git-send-email-gregory.0xf0@gmail.com>
References: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
 <1430901477-10678-3-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CACRpkdbzjdmtiou0gURKBRV2QEQqnbrdTA1523Q5ZkYxA-vpYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 6, 2015 at 10:37 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

> This adds support for the GPIO IP "UPG GIO" used on Broadcom STB SoCs
> (BCM7XXX and some others).  Uses basic_mmio_gpio to instantiate a
> gpio_chip for each bank.  The driver assumes that it handles the base
> set of GPIOs on the system and that it can start its numbering sequence
> from 0, so any GPIO expanders used with it must dynamically assign GPIO
> numbers after this driver has finished registering its GPIOs.
>
> Does not implement the interrupt-controller portion yet, will be done in a
> future commit.
>
> List-usage-fixed-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>

(...)
>  arch/arm/mach-bcm/Kconfig   |    1 +
(...)
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -144,6 +144,7 @@ config ARCH_BRCMSTB
>         select BRCMSTB_GISB_ARB
>         select BRCMSTB_L2_IRQ
>         select BCM7120_L2_IRQ
> +       select ARCH_WANT_OPTIONAL_GPIOLIB

Please remove this from this patch. I don't want to patch around
in the platforms from the GPIO tree. Take this oneliner through
ARM SoC.

> +config GPIO_BRCMSTB
> +       tristate "BRCMSTB GPIO support"
> +       default y if ARCH_BRCMSTB
> +       depends on OF_GPIO && (ARCH_BRCMSTB || COMPILE_TEST)
> +       select GPIO_GENERIC

Nice.

> +++ b/drivers/gpio/gpio-brcmstb.c
(...)
> +
> +#include <linux/bitops.h>
> +#include <linux/gpio.h>

#include <linux/gpio/driver.h>

should be sufficient.

> +struct brcmstb_gpio_bank {
> +       struct list_head node;
> +       int id;
> +       struct bgpio_chip bgc;
> +       u32 imask;  /* irq mask shadow register */

Why? Is it a write-only register that can't be read back?

> +       struct brcmstb_gpio_priv *parent_priv;  /* used in interrupt handler */

...and this patch does not enable IRQs...

> +struct brcmstb_gpio_priv {
> +       struct list_head bank_list;
> +       void __iomem *reg_base;
> +       int num_banks;
> +       struct platform_device *pdev;
> +       int gpio_base;

Usually we don't like it when you hardcode gpio_base, and this
field should anyway be present inside the bgpio_chip.gc.base
isn't it?

> +#define GPIO_PER_BANK           32
> +#define GPIO_BANK(gpio)         ((gpio) >> 5)
> +/* assumes GPIO_PER_BANK is a multiple of 2 */
> +#define GPIO_BIT(gpio)          ((gpio) & (GPIO_PER_BANK - 1))

But this macro and GPIO_PER_BANK does not respect the DT binding
stating the number of used lines.

You need to call these MAX_GPIO_PER_BANK or something.

> +static int brcmstb_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       void __iomem *reg_base;
> +       struct brcmstb_gpio_priv *priv;
> +       struct resource *res;
> +       struct property *prop;
> +       const __be32 *p;
> +       u32 bank_width;
> +       int err;
> +       static int gpio_base;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       reg_base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(reg_base))
> +               return PTR_ERR(reg_base);
> +
> +       priv->gpio_base = gpio_base;
> +       priv->reg_base = reg_base;
> +       priv->pdev = pdev;
> +
> +       INIT_LIST_HEAD(&priv->bank_list);
> +       if (brcmstb_gpio_sanity_check_banks(dev, np, res))
> +               return -EINVAL;
> +
> +       of_property_for_each_u32(np, "brcm,gpio-bank-widths", prop, p,
> +                       bank_width) {
> +               struct brcmstb_gpio_bank *bank;
> +               struct bgpio_chip *bgc;
> +               struct gpio_chip *gc;
> +
> +               bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
> +               if (!bank) {
> +                       err = -ENOMEM;
> +                       goto fail;
> +               }
> +
> +               bank->parent_priv = priv;
> +               bank->id = priv->num_banks;
> +
> +               /*
> +                * Regs are 4 bytes wide, have data reg, no set/clear regs,
> +                * and direction bits have 0 = output and 1 = input
> +                */
> +               bgc = &bank->bgc;
> +               err = bgpio_init(bgc, dev, 4,
> +                               reg_base + GIO_DATA(bank->id),
> +                               NULL, NULL, NULL,
> +                               reg_base + GIO_IODIR(bank->id), 0);
> +               if (err) {
> +                       dev_err(dev, "bgpio_init() failed\n");
> +                       goto fail;
> +               }
> +
> +               gc = &bgc->gc;
> +               gc->of_node = np;
> +               gc->owner = THIS_MODULE;
> +               gc->label = np->full_name;
> +               gc->base = gpio_base;

I strongly suggest that you try using -1 as base here instead
for dynamic assignment of GPIO numbers.

> +               gc->of_gpio_n_cells = 2;
> +               gc->of_xlate = brcmstb_gpio_of_xlate;
> +
> +               if (bank_width <= 0 || bank_width > GPIO_PER_BANK) {
> +                       gc->ngpio = GPIO_PER_BANK;
> +                       dev_warn(dev, "Invalid bank width %d, assume %d\n",
> +                                       bank_width, gc->ngpio);

I wonder if this should not simply return an error.
If that number is wrong the DTS is completely screwed up.

> +               } else {
> +                       gc->ngpio = bank_width;
> +               }
> +
> +               bank->imask =
> +                       bgc->read_reg(reg_base + GIO_MASK(bank->id));

And this mask also mask the unused pins as GIO_MASK()
does not respect bank_width.

> +               err = gpiochip_add(gc);
> +               if (err) {
> +                       dev_err(dev, "Could not add gpiochip for bank %d\n",
> +                                       bank->id);
> +                       goto fail;
> +               }
> +               gpio_base += gc->ngpio;

This complicates things. Use -1 as base for dynamic assignment
of GPIO numbers.

Yours,
Linus Walleij
