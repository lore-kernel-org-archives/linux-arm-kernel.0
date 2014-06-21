From: gnurou@gmail.com (Alexandre Courbot)
Date: Sat, 21 Jun 2014 16:55:28 +0900
Subject: [PATCH V4 1/3] gpio: Add APM X-Gene SoC GPIO controller support
In-Reply-To: <1403136531-20808-2-git-send-email-fkan@apm.com>
References: <1403136531-20808-1-git-send-email-fkan@apm.com>
 <1403136531-20808-2-git-send-email-fkan@apm.com>
Message-ID: <CAAVeFuLEoKM_D5by4tCMG3wkCVF1aaTvUWR8eU6mcJP_GL+iQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 9:08 AM, Feng Kan <fkan@apm.com> wrote:
> Add APM X-Gene SoC gpio controller driver.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/gpio/Kconfig      |   9 ++
>  drivers/gpio/Makefile     |   1 +
>  drivers/gpio/gpio-xgene.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 drivers/gpio/gpio-xgene.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 4a1b511..833996a02 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -334,6 +334,15 @@ config GPIO_TZ1090_PDC
>         help
>           Say yes here to support Toumaz Xenif TZ1090 PDC GPIOs.
>
> +config GPIO_XGENE
> +       bool "APM X-Gene GPIO controller support"
> +       depends on ARM64 && OF_GPIO
> +       help
> +         This driver is to support the GPIO block within the APM X-Gene SoC
> +         platform's generic flash controller. The GPIO pins are muxed with
> +         the generic flash controller's address and data pins. Say yes
> +         here to enable the GFC GPIO functionality.
> +
>  config GPIO_XILINX
>         bool "Xilinx GPIO support"
>         depends on PPC_OF || MICROBLAZE || ARCH_ZYNQ
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index d10f6a9..1bf5f82 100644
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
> index 0000000..3a747cc
> --- /dev/null
> +++ b/drivers/gpio/gpio-xgene.c
> @@ -0,0 +1,252 @@
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
> +#include <linux/platform_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of.h>
> +#include <linux/gpio.h>
> +#include <linux/types.h>
> +#include <linux/clk.h>
> +#include <linux/bitops.h>
> +
> +#define GPIO_SET_DR_OFFSET     0x0C
> +#define GPIO_DATA_OFFSET       0x14
> +#define GPIO_BANK_STRIDE       0x0C
> +
> +#define XGENE_GPIOS_PER_BANK   16
> +#define XGENE_MAX_GPIO_BANKS   3
> +#define XGENE_MAX_GPIOS                (XGENE_GPIOS_PER_BANK * XGENE_MAX_GPIO_BANKS)
> +
> +#define GPIO_BIT_OFFSET(x)     (x % XGENE_GPIOS_PER_BANK)
> +#define GPIO_BANK_OFFSET(x)    ((x / XGENE_GPIOS_PER_BANK) * GPIO_BANK_STRIDE)
> +
> +struct xgene_gpio;
> +
> +struct xgene_gpio {
> +       struct  device          *dev;
> +       struct gpio_chip        chip;
> +       void __iomem            *base;
> +       spinlock_t              lock;
> +#ifdef CONFIG_PM
> +       u32                     set_dr_val[XGENE_MAX_GPIO_BANKS];
> +#endif
> +};
> +
> +static inline struct xgene_gpio *to_xgene_gpio(struct gpio_chip *chip)
> +{
> +       return container_of(chip, struct xgene_gpio, chip);
> +}
> +
> +static int xgene_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +       struct xgene_gpio *chip = to_xgene_gpio(gc);
> +       unsigned long bank_offset;
> +       u32 bit_offset;
> +
> +       bank_offset = GPIO_DATA_OFFSET + GPIO_BANK_OFFSET(offset);
> +       bit_offset = GPIO_BIT_OFFSET(offset);
> +       return !!(ioread32(chip->base + bank_offset) & BIT(bit_offset));
> +}
> +
> +static void __xgene_gpio_set(struct gpio_chip *gc, unsigned int offset, int val)
> +{
> +       struct xgene_gpio *chip = to_xgene_gpio(gc);
> +       unsigned long bank_offset;
> +       u32 setval, bit_offset;
> +
> +       bank_offset = GPIO_SET_DR_OFFSET + GPIO_BANK_OFFSET(offset);
> +       bit_offset = GPIO_BIT_OFFSET(offset) + XGENE_GPIOS_PER_BANK;
> +
> +       setval = ioread32(chip->base + bank_offset);
> +       if (val)
> +               setval |= BIT(bit_offset);
> +       else
> +               setval &= ~BIT(bit_offset);
> +       iowrite32(setval, chip->base + bank_offset);
> +}
> +
> +static void xgene_gpio_set(struct gpio_chip *gc, unsigned int offset, int val)
> +{
> +       struct xgene_gpio *chip = to_xgene_gpio(gc);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&chip->lock, flags);
> +       __xgene_gpio_set(gc, offset, val);
> +       spin_unlock_irqrestore(&chip->lock, flags);
> +}
> +
> +static int xgene_gpio_dir_in(struct gpio_chip *gc, unsigned int offset)
> +{
> +       struct xgene_gpio *chip = to_xgene_gpio(gc);
> +       unsigned long flags, bank_offset;
> +       u32 dirval, bit_offset;
> +
> +       bank_offset = GPIO_SET_DR_OFFSET + GPIO_BANK_OFFSET(offset);
> +       bit_offset = GPIO_BIT_OFFSET(offset);
> +
> +       spin_lock_irqsave(&chip->lock, flags);
> +
> +       dirval = ioread32(chip->base + bank_offset);
> +       dirval |= BIT(bit_offset);
> +       iowrite32(dirval, chip->base + bank_offset);
> +
> +       spin_unlock_irqrestore(&chip->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int xgene_gpio_dir_out(struct gpio_chip *gc,
> +                                       unsigned int offset, int val)
> +{
> +       struct xgene_gpio *chip = to_xgene_gpio(gc);
> +       unsigned long flags, bank_offset;
> +       u32 dirval, bit_offset;
> +
> +       bank_offset = GPIO_SET_DR_OFFSET + GPIO_BANK_OFFSET(offset);
> +       bit_offset = GPIO_BIT_OFFSET(offset);
> +
> +       spin_lock_irqsave(&chip->lock, flags);
> +
> +       dirval = ioread32(chip->base + bank_offset);
> +       dirval &= ~BIT(bit_offset);
> +       iowrite32(dirval, chip->base + bank_offset);
> +       __xgene_gpio_set(gc, offset, val);
> +
> +       spin_unlock_irqrestore(&chip->lock, flags);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int xgene_gpio_suspend(struct device *dev)
> +{
> +       struct xgene_gpio *gpio = dev_get_drvdata(dev);
> +       unsigned long bank_offset;
> +       unsigned int bank;
> +
> +       for (bank = 0; bank < XGENE_MAX_GPIO_BANKS; bank++) {
> +               bank_offset = GPIO_SET_DR_OFFSET + bank * GPIO_BANK_STRIDE;
> +               gpio->set_dr_val[bank] = ioread32(gpio->base + bank_offset);
> +       }
> +       return 0;
> +}
> +
> +static int xgene_gpio_resume(struct device *dev)
> +{
> +       struct xgene_gpio *gpio = dev_get_drvdata(dev);
> +       unsigned long bank_offset;
> +       unsigned int bank;
> +
> +       for (bank = 0; bank < XGENE_MAX_GPIO_BANKS; bank++) {
> +               bank_offset = GPIO_SET_DR_OFFSET + bank * GPIO_BANK_STRIDE;
> +               iowrite32(gpio->set_dr_val[bank], gpio->base + bank_offset);
> +       }
> +       return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(xgene_gpio_pm, xgene_gpio_suspend, xgene_gpio_resume);
> +#define XGENE_GPIO_PM_OPS      (&xgene_gpio_pm)
> +#else
> +#define XGENE_GPIO_PM_OPS      NULL
> +#endif
> +
> +static int xgene_gpio_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       struct xgene_gpio *gpio;
> +       int err = 0;
> +
> +       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> +       if (!gpio) {
> +               err = -ENOMEM;
> +               goto err;
> +       }
> +       gpio->dev = &pdev->dev;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       gpio->base = devm_ioremap_nocache(&pdev->dev, res->start,
> +                                                       resource_size(res));
> +       if (IS_ERR(gpio->base)) {
> +               err = PTR_ERR(gpio->base);
> +               goto err;
> +       }
> +
> +       gpio->chip.ngpio = XGENE_MAX_GPIOS;
> +
> +       gpio->chip.direction_input = xgene_gpio_dir_in;
> +       gpio->chip.direction_output = xgene_gpio_dir_out;
> +       gpio->chip.get = xgene_gpio_get;
> +       gpio->chip.set = xgene_gpio_set;

Actually there are a few things missing here:

- gpio->chip.dev should be set to pdev->dev, especially since you
refer to it below. You can then probably get rid of gpio->dev which
you are not using anyway.
- why don't you set gpio->chip.label?
- gpio->chip.base should be set to -1 so the GPIO framework assigns a
free range.

Taking my reviewed-by back for the moment.
