From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jan 2015 10:40:19 +0100
Subject: [PATCH v2 RESEND 1/3] gpio: Add APM X-Gene standby GPIO
 controller driver
In-Reply-To: <1418793050-26927-2-git-send-email-yvo@apm.com>
References: <1418793050-26927-1-git-send-email-yvo@apm.com>
 <1418793050-26927-2-git-send-email-yvo@apm.com>
Message-ID: <CACRpkdZe7Huiruu-iSNU4MWaiLo_qL=QAab1crummuuVOEJ0zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 6:10 AM, Y Vo <yvo@apm.com> wrote:

> Add APM X-Gene standby GPIO controller driver.

Write something about what platform an arch this is and so
on, this is too terse commit message for a new driver.

> Signed-off-by: Y Vo <yvo@apm.com>
(...)

> +config GPIO_XGENE_SB
> +       tristate "APM X-Gene GPIO standby controller support"
> +       depends on ARCH_XGENE && OF_GPIO

select GPIO_GENERIC

see below on why.

> +       help
> +         This driver supports the GPIO block within the APM X-Gene
> +         Standby Domain. Say yes here to enable the GPIO functionality.
> +
>  config GPIO_XILINX
>         bool "Xilinx GPIO support"
>         depends on PPC_OF || MICROBLAZE || ARCH_ZYNQ
> diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
> new file mode 100644
> index 0000000..1248448

(...)
> +++ b/drivers/gpio/gpio-xgene-sb.c
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>

#include <linux/gpio/driver.h>

instead.

> +#include <linux/of_irq.h>
> +#include <linux/acpi.h>

OK, why?

> +#include <linux/efi.h>

Why?

> +#include <linux/string.h>
> +#include <linux/of_address.h>

#include <linux/basic_mmio_gpio.h>
when you start using GENERIC_GPIO

> +
> +#define XGENE_MAX_GPIO_DS              22
> +#define XGENE_MAX_GPIO_DS_IRQ          6
> +
> +#define GPIO_MASK(x)                   (1U << ((x) % 32))
> +#define GPIO_DIR_IN                    0
> +#define GPIO_DIR_OUT                   1
> +
> +#define MPA_GPIO_INT_LVL               0x0290
> +#define MPA_GPIO_OE_ADDR               0x029c
> +#define MPA_GPIO_OUT_ADDR              0x02a0
> +#define MPA_GPIO_IN_ADDR               0x02a4
> +#define MPA_GPIO_SEL_LO                        0x0294
> +#define MPA_GPIO_SEL_HIGH              0x029c
> +
> +struct xgene_gpio_sb {
> +       struct of_mm_gpio_chip mm;
> +       u32 *irq;
> +       u32 nirq;
> +       spinlock_t lock; /* mutual exclusion */
> +};

Add kerneldoc to this struct.

> +static void xgene_gpio_set_bit(void __iomem *reg, u32 gpio, int val)
(...)
> +static int xgene_gpio_sb_get(struct gpio_chip *gc, u32 gpio)

This looks very much like a memory-mapped standard GPIO controller,
use drivers/gpio/gpio-generic.c with some IRQ add-on, compare
to any other driver selecting GPIO_GENERIC for guidance:
drivers/gpio/gpio-74xx-mmio.c, gpio-dwapb.c etc.

> +static int apm_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
> +{
> +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +       struct xgene_gpio_sb *chip = to_xgene_gpio_sb(mm_gc);
> +
> +       if (chip->irq[gpio])
> +               return chip->irq[gpio];
> +
> +       return -ENXIO;
> +}
> +
> +static int xgene_gpio_sb_probe(struct platform_device *pdev)
> +{
> +       struct of_mm_gpio_chip *mm;
> +       struct xgene_gpio_sb *apm_gc;
> +       u32 ret, i;
> +       u32 default_pins[] = {0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D};

Um, pins... call these "lines" instead to avoid confusion with the pin
control subsystem.

> +       struct resource *res;
> +
> +       apm_gc = devm_kzalloc(&pdev->dev, sizeof(*apm_gc), GFP_KERNEL);
> +       if (!apm_gc)
> +               return -ENOMEM;
> +
> +       mm = &apm_gc->mm;
> +       mm->gc.direction_input = xgene_gpio_sb_dir_in;
> +       mm->gc.direction_output = xgene_gpio_sb_dir_out;
> +       mm->gc.get = xgene_gpio_sb_get;
> +       mm->gc.set = xgene_gpio_sb_set;
> +       mm->gc.to_irq = apm_gpio_sb_to_irq;
> +       mm->gc.base = -1;
> +       mm->gc.label = dev_name(&pdev->dev);

gc has a device tree .np node and a .dev struct device *
pointer, assign them here. (Also after you switch to GENERIC_GPIO.)

Yours,
Linus Walleij
