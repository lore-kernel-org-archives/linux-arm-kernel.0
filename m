From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 16:45:28 +0200
Subject: [PATCH v2 1/2] gpio: Add driver for Zynq GPIO controller
In-Reply-To: <1403091577-10232-1-git-send-email-harinik@xilinx.com>
References: <1403091577-10232-1-git-send-email-harinik@xilinx.com>
Message-ID: <CACRpkdbc=NDmmjLi_FKvXaQ7H6gY+xHWso=Vi=tgubME4JUfyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 1:39 PM, Harini Katakam <harinik@xilinx.com> wrote:

> From: Harini Katakam <harini.katakam@xilinx.com>
>
> Add support for GPIO controller used by Xilinx Zynq.
>
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>
> v2 changes:
>  - convert to pm_runtime_force_(suspend|resume)
>  - add pm_runtime_set_active in probe()
>  - also (un)prepare clocks when they are dis-/enabled
>  - add some missing calls to pm_runtime_get()
>  - use pm_runtime_put() instead of sync variant
>  - remove gpio chip in driver remove()
>  - remove redundant type casts
>  - directly use IO helpers
>  - use BIT macro to set/clear bits
>  - migrate to GPIOLIB_IRQCHIP

This is a great improvement! Only small stuff remains.

> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/gpio.h>

This should be:
#include <linux/gpio/driver.h>

If that doesn't work ... why?

> +/**
> + * struct zynq_gpio - gpio device private data structure
> + * @chip:      instance of the gpio_chip
> + * @base_addr: base address of the GPIO device
> + * @irq:       irq associated with the controller
> + * @clk:       clock resource for this controller
> + */
> +struct zynq_gpio {
> +       struct gpio_chip chip;
> +       void __iomem *base_addr;
> +       int irq;

Why is irq kept around in this struct? It looks like it could just
be a local variable in probe()?

> +       struct clk *clk;
> +};

Apart from that this nitpicking the driver looks very nice.

Yours,
Linus Walleij
