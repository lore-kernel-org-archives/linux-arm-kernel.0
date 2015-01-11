From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Jan 2015 23:40:46 +0100
Subject: [PATCH v3 5/8] gpio: Add Fujitsu MB86S7x GPIO driver
In-Reply-To: <1420803212-4350-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1420802369-3840-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1420803212-4350-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <CACRpkdZk3sLN43zmuWM+VYLB7vJdNCSq_goTx6mDSnzHrO=UHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 9, 2015 at 12:33 PM, Vincent Yang
<vincent.yang.fujitsu@gmail.com> wrote:

> From: Jassi Brar <jaswinder.singh@linaro.org>
>
> Driver for Fujitsu MB86S7x SoCs that have a memory mapped GPIO controller.
>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>

(....)
> +++ b/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt

Binding looks good to me.

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 633ec21..699e629 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -197,6 +197,12 @@ config GPIO_F7188X
>           To compile this driver as a module, choose M here: the module will
>           be called f7188x-gpio.
>
> +config GPIO_MB86S7X
> +       bool "GPIO support for Fujitsu MB86S7x Platforms"
> +       depends on ARCH_MB86S7X

|| COMPILE_TEST? So we can test it on a x86_64 compile?

> diff --git a/drivers/gpio/gpio-mb86s7x.c b/drivers/gpio/gpio-mb86s7x.c
> new file mode 100644
> index 0000000..c912585
> --- /dev/null
> +++ b/drivers/gpio/gpio-mb86s7x.c
> @@ -0,0 +1,231 @@
> +/*
> + *  linux/drivers/gpio/gpio-mb86s7x.c
> + *
> + *  Copyright (C) 2015 Fujitsu Semiconductor Limited
> + *  Copyright (C) 2015 Linaro Ltd.
> + *
> + *  This program is free software: you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation, version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/gpio.h>

Nominally a modern driver should just

#include <linux/gpio/driver.h>

instead of <linux/gpio.h>

> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/ioport.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/slab.h>
> +
> +/*
> + * Only first 8bits of a register correspond to each pin,
> + * so there are 4 registers for 32 pins.
> + */
> +#define PDR(x) (0x0 + x / 8 * 4)
> +#define DDR(x) (0x10 + x / 8 * 4)
> +#define PFR(x) (0x20 + x / 8 * 4)

Hm pins ... is this actually a pin controller hardware? Usually I
encourage the concept of "line" over "pin" to distinguish GPIO
lines from pin controller pins.

> +static int mb86s70_gpio_direction_output(struct gpio_chip *gc,
> +                                        unsigned gpio, int value)
> +{
> +       struct mb86s70_gpio_chip *gchip = chip_to_mb86s70(gc);
> +       unsigned long flags;
> +       unsigned char val;
> +
> +       spin_lock_irqsave(&gchip->lock, flags);
> +
> +       val = readl(gchip->base + PDR(gpio));
> +       if (value)
> +               val |= OFFSET(gpio);
> +       else
> +               val &= ~OFFSET(gpio);
> +       writel(val, gchip->base + PDR(gpio));
> +
> +       val = readl(gchip->base + DDR(gpio));
> +       val |= OFFSET(gpio);
> +       writel(val, gchip->base + DDR(gpio));
> +
> +       spin_unlock_irqrestore(&gchip->lock, flags);
> +
> +       return 0;
> +}

First I thought maybe this could use the generic MMIO driver
but it seems you need this double register access for setting
the direction so it won't work.

Otherwise it's sort of close ... have you looks at the option?
Kamlakant did a lot of interesting attempts to migrate some current
drivers to GPIO MMIO (generic GPIO) recently, e.g. this:
http://marc.info/?l=linux-gpio&m=141743574511640&w=2
or this:
http://marc.info/?l=linux-gpio&m=141743574211639&w=2

> +static int __init mb86s70_gpio_init(void)
> +{
> +       return platform_driver_register(&mb86s70_gpio_driver);
> +}
> +subsys_initcall(mb86s70_gpio_init);

We are trying to move away from sybsys_initcall() and rely on
deferred probe. Why do you need this here?

Yours,
Linus Walleij
