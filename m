From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 20 May 2014 15:04:17 +0900
Subject: [PATCH 1/3] gpio: Add APM X-Gene SoC GPIO controller support
In-Reply-To: <1400263432-922-2-git-send-email-fkan@apm.com>
References: <1400263432-922-1-git-send-email-fkan@apm.com>
 <1400263432-922-2-git-send-email-fkan@apm.com>
Message-ID: <CAAVeFu+TOfjfvisinv3oJ9PobdV9HcNJhr+3VYneSJ54uGwiAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 17, 2014 at 3:03 AM, Feng Kan <fkan@apm.com> wrote:
> Add APM X-Gene SoC gpio controller driver.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/gpio/Kconfig      |   9 ++
>  drivers/gpio/Makefile     |   1 +
>  drivers/gpio/gpio-xgene.c | 264 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 274 insertions(+)
>  create mode 100644 drivers/gpio/gpio-xgene.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index a86c49a..8f89643 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -324,6 +324,15 @@ config GPIO_TZ1090_PDC
>         help
>           Say yes here to support Toumaz Xenif TZ1090 PDC GPIOs.
>
> +config GPIO_XGENE
> +       bool "APM X-Gene GPIO controller support"
> +       depends on ARM64 && OF_GPIO
> +       help
> +         This driver is to support the GPIO block within the APM X-Gene
> +         platform's generic flash controller. The GPIO pins are muxed with
> +         the generic flash controller's address and data pins. Say yes
> +         here to enable the GFC GPIO functionality.
> +
>  config GPIO_XILINX
>         bool "Xilinx GPIO support"
>         depends on PPC_OF || MICROBLAZE || ARCH_ZYNQ
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 6309aff..f0f2830 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -98,6 +98,7 @@ obj-$(CONFIG_GPIO_VX855)      += gpio-vx855.o
>  obj-$(CONFIG_GPIO_WM831X)      += gpio-wm831x.o
>  obj-$(CONFIG_GPIO_WM8350)      += gpio-wm8350.o
>  obj-$(CONFIG_GPIO_WM8994)      += gpio-wm8994.o
> +obj-$(CONFIG_GPIO_XGENE)       += gpio-xgene.o
>  obj-$(CONFIG_GPIO_XILINX)      += gpio-xilinx.o
>  obj-$(CONFIG_GPIO_XTENSA)      += gpio-xtensa.o
>  obj-$(CONFIG_GPIO_ZEVIO)       += gpio-zevio.o
> diff --git a/drivers/gpio/gpio-xgene.c b/drivers/gpio/gpio-xgene.c
> new file mode 100644
> index 0000000..5c26a19
> --- /dev/null
> +++ b/drivers/gpio/gpio-xgene.c
> @@ -0,0 +1,264 @@
> +/*
> + * AppliedMicro X-Gene SoC GPIO Driver
> + *
> + * Copyright (c) 2014, Applied Micro Circuits Corporation
> + * Author: Feng Kan <fkan@apm.com>.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of.h>
> +#include <linux/gpio.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +
> +#define GPIO_MASK(x)           (1U << ((x) % 32))

BIT((x) % 32) maybe? (same below where it applies)

> +#define GPIO_MUX_SEL(x)                (3U << ((x * 2) % 32))
> +#define GPIO_SET_MASK(x)       (1U << ((x + 16) % 32))
> +
> +#define GPIO_SET_DR            0x0c
> +#define GPIO_SET_DR_OFFSET     0x0c
> +#define GPIO_DATA              0x14
> +#define GPIO_DATA_OFFSET       0x0c
> +#define GPIO_OD                        0x30
> +#define GPIO_OD_OFFSET         0x04
> +#define GPIO_MUX               0x10
> +#define GPIO_MUX_OFFSET                0x0c
> +
> +#define XGENE_GPIO_MAX_PORTS           3
> +
> +struct xgene_gpio;
> +
> +struct xgene_gpio_bank {
> +       struct gpio_chip        chip;
> +       void __iomem            *data;
> +       void __iomem            *set_dr;
> +       void __iomem            *od;
> +       void __iomem            *mux;
> +       struct xgene_gpio       *gpio;
> +       spinlock_t              lock;
> +};
> +
> +struct xgene_gpio {
> +       struct  device          *dev;
> +       void __iomem            *regs;
> +       struct xgene_gpio_bank  *banks;
> +       unsigned int            nr_banks;
> +};

At first sight it really looks like the gpio_chip should belong to the
xgene_gpio struct. What is the purpose of having the driver
instanciated once per bank?

> +
> +static int xgene_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       struct xgene_gpio_bank *bank =
> +                       container_of(gc, struct xgene_gpio_bank, chip);
> +
> +       return (ioread32(bank->data) & GPIO_MASK(gpio));

Since you are using ioread32, wouldn't the member be better defined as
"u32 __iomem *data" ?

> +}
> +
> +static void xgene_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +       struct xgene_gpio_bank *bank =
> +                       container_of(gc, struct xgene_gpio_bank, chip);
> +       unsigned long flags;
> +       u32 data;
> +
> +       spin_lock_irqsave(&bank->lock, flags);
> +
> +       data = ioread32(bank->set_dr);
> +       data = val ? data | GPIO_SET_MASK(gpio) : data & ~GPIO_SET_MASK(gpio);

Couldn't you use set_bit() / clear_bit() instead here?

> +       iowrite32(data, bank->set_dr);
> +
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +}
> +
> +static void xgene_gpio_muxcfg(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       struct xgene_gpio_bank *bank =
> +                       container_of(gc, struct xgene_gpio_bank, chip);
> +       u32 data;
> +
> +       data = ioread32(bank->mux);
> +       data |= GPIO_MUX_SEL(gpio);
> +       iowrite32(data, bank->mux);
> +}
> +
> +static int xgene_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       struct xgene_gpio_bank *bank =
> +                       container_of(gc, struct xgene_gpio_bank, chip);
> +       unsigned long flags;
> +       u32 data;
> +
> +       spin_lock_irqsave(&bank->lock, flags);
> +
> +       data = ioread32(bank->set_dr);
> +       data |= GPIO_MASK(gpio);
> +       iowrite32(data, bank->set_dr);
> +       xgene_gpio_muxcfg(gc, gpio);
> +
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int xgene_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +       struct xgene_gpio_bank *bank =
> +                       container_of(gc, struct xgene_gpio_bank, chip);
> +       unsigned long flags;
> +       u32 data;
> +
> +       spin_lock_irqsave(&bank->lock, flags);
> +       data = ioread32(bank->set_dr);
> +       data = data & ~GPIO_MASK(gpio);
> +       iowrite32(data, bank->set_dr);
> +       xgene_gpio_muxcfg(gc, gpio);
> +
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int xgene_gpio_add_bank(struct xgene_gpio *gpio,
> +                              struct device_node *bank_np,
> +                              unsigned int offs)
> +{
> +       struct xgene_gpio_bank *bank;
> +       u32 bank_idx, ngpio, odcfg;
> +       int err;
> +
> +       if (of_property_read_u32(bank_np, "bank", &bank_idx) ||
> +               bank_idx >= XGENE_GPIO_MAX_PORTS) {
> +               dev_err(gpio->dev, "missing/invalid bank index for %s index %d\n",
> +                               bank_np->full_name, bank_idx);
> +               return -EINVAL;

Could you return the error returned by of_property_read_u32() instead?

> +       }
> +
> +       bank = &gpio->banks[offs];
> +       bank->gpio = gpio;
> +       spin_lock_init(&bank->lock);
> +
> +       if (of_property_read_u32(bank_np, "ngpios", &ngpio))
> +               ngpio = 16;

Here I think you want to distinguish between "property not defined"
(-EINVAL) and "property has no value" (-ENODATA) and other possible
errors. In the later cases you will want to signal the error and
return from here.

> +
> +       if ((ngpio > 16) || (ngpio < 1)) {
> +               dev_info(gpio->dev, "Incorrect number of gpio specified: %s\n",
> +                        bank_np->full_name);
> +               return -EINVAL;
> +       }
> +
> +       bank->data = gpio->regs + GPIO_DATA + (bank_idx * GPIO_DATA_OFFSET);
> +       bank->od = gpio->regs + GPIO_OD + (bank_idx * GPIO_OD_OFFSET);
> +       bank->mux = gpio->regs + GPIO_MUX + (bank_idx * GPIO_MUX_OFFSET);
> +       bank->set_dr = gpio->regs + GPIO_SET_DR
> +                               + (bank_idx * GPIO_SET_DR_OFFSET);
> +
> +       bank->chip.direction_input = xgene_gpio_dir_in;
> +       bank->chip.direction_output = xgene_gpio_dir_out;
> +       bank->chip.get = xgene_gpio_get;
> +       bank->chip.set = xgene_gpio_set;
> +
> +       if (!of_property_read_u32(bank_np, "odcfg", &odcfg))
> +               iowrite32(odcfg, bank->od);
> +
> +       bank->chip.ngpio = ngpio;
> +       bank->chip.of_node = bank_np;
> +       bank->chip.base = bank_idx * ngpio;
> +
> +       err = gpiochip_add(&bank->chip);
> +       if (err)
> +               dev_err(gpio->dev, "failed to register gpiochip for %s\n",
> +                       bank_np->full_name);
> +
> +       return err;
> +}
> +
> +static int xgene_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct resource *res;
> +       struct xgene_gpio *gpio;
> +       int err;
> +       unsigned int offs = 0;
> +
> +       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> +       if (!gpio)
> +               return -ENOMEM;
> +       gpio->dev = &pdev->dev;
> +
> +       gpio->nr_banks = of_get_child_count(pdev->dev.of_node);
> +       if (!gpio->nr_banks) {
> +               err = -EINVAL;
> +               goto err;
> +       }

Might be worth checking whether nr_banks >= XGENE_GPIO_MAX_PORTS and
return an error here.

> +
> +       gpio->banks = devm_kzalloc(&pdev->dev, gpio->nr_banks *
> +                                  sizeof(*gpio->banks), GFP_KERNEL);
> +       if (!gpio->banks) {
> +               err = -ENOMEM;
> +               goto err;
> +       }

I'm fine with printing the error status the way you do, but could you
also do the same for the first kzalloc too?

Or maybe you could put your banks member at the end of the xgene_gpio
struct as a flexible array member and perform only one kzalloc of size
(sizeof(*gpio) + (sizeof(*gpio->banks) * gpio->nr_banks))?

> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       gpio->regs = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(gpio->regs)) {
> +               err = PTR_ERR(gpio->regs);
> +               goto err;
> +       }
> +
> +       for_each_child_of_node(pdev->dev.of_node, np) {
> +               err = xgene_gpio_add_bank(gpio, np, offs++);
> +               if (err)
> +                       goto err;
> +       }
> +
> +       platform_set_drvdata(pdev, gpio);
> +
> +       dev_info(&pdev->dev, "X-Gene GPIO driver registered\n");
> +       return 0;
> +err:
> +       dev_err(&pdev->dev, "X-Gene GPIO driver registration failed\n");
> +       return err;
> +}
> +
> +static const struct of_device_id xgene_gpio_of_match[] = {
> +       { .compatible = "apm,xgene-gpio", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, xgene_gpio_of_match);
> +
> +static struct platform_driver xgene_gpio_driver = {
> +       .driver = {
> +               .name = "xgene-gpio",
> +               .owner = THIS_MODULE,
> +               .of_match_table = xgene_gpio_of_match,
> +       },
> +       .probe = xgene_gpio_probe,
> +};
> +
> +static int __init xgene_gpio_init(void)
> +{
> +       return platform_driver_register(&xgene_gpio_driver);
> +}
> +postcore_initcall(xgene_gpio_init);
> +
> +MODULE_AUTHOR("AppliedMicro");
> +MODULE_DESCRIPTION("APM X-Gene GPIO driver");
> +MODULE_LICENSE("GPL");
> --
> 1.9.1
>

Globally the driver looks well-written, but I don't understand the
need to have one gpio_chip per bank. Could you elaborate on the
reasons for this design?

Alex.
