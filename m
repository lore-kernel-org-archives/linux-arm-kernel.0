From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Aug 2012 00:08:45 +0200
Subject: [PATCH] GPIO: Add support for GPIO on CLPS711X-target platform
In-Reply-To: <1345635383-12224-1-git-send-email-shc_work@mail.ru>
References: <1345635383-12224-1-git-send-email-shc_work@mail.ru>
Message-ID: <CACRpkdZrcBLz+sg-AwWnBD0SA697uWQzocUYnbC1nPYG14LYyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 1:36 PM, Alexander Shiyan <shc_work@mail.ru> wrote:

> The CLPS711X CPUs provide some GPIOs for use in the system. This
> driver provides support for these via gpiolib. Due to platform
> limitations, driver does not support interrupts, only inputs and
> outputs.

OK...

(...)
> +#include <mach/hardware.h>

> +struct clps711x_gpio {
> +       struct gpio_chip        chip[CLPS711X_GPIO_PORTS];
> +       struct mutex            lock;
> +};

That lock is just protecting a few register reads/writes. Use a
spinlock instead, it's more apropriate.

(...)
> +static int gpio_clps711x_get(struct gpio_chip *chip, unsigned offset)
> +{
> +       int ret;
> +       struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
> +
> +       mutex_lock(&gpio->lock);
> +       ret = clps_readb(gpio_clps711x_port_dataaddr(chip)) & (1 << offset);
> +       mutex_unlock(&gpio->lock);
> +
> +       return !!ret;
> +}

Please get rid of this clps_readb() business. I can see it's just this:
#define clps_readb(off)         readb(CLPS711X_VIRT_BASE + (off))

This makes stuff hard to understand, please pass the virtual base as
a memory resource to the platform device, store it in the state holder
and just use readb() in the driver from that offset.

(...)
> +static int __devinit gpio_clps711x_probe(struct platform_device *pdev)

This should just be __init, you have made it very certain that this
cannot be loaded and unloaded at runtime. (No remove function!)
and its a bool in the Kconfig.

Yours,
Linus Walleij
