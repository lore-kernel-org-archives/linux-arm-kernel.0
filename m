From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 28 May 2018 11:00:49 +0300
Subject: [PATCH v4 3/6] mfd: at91-usart: added mfd driver for usart
In-Reply-To: <20180525171941.26766-4-radu.pirea@microchip.com>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-4-radu.pirea@microchip.com>
Message-ID: <CAHp75VeeiFhShuMOVzuy2FjxrkfsxxzhyfAnwQNOoeaRwZ103Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 8:19 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
> This mfd driver is just a wrapper over atmel_serial driver and
> spi-at91-usart driver. Selection of one of the drivers is based on a
> property from device tree. If the property is not specified, the default
> driver is atmel_serial.

> +       depends on OF

What makes this driver OF specific?

> +#include <linux/of.h>
> +#include <linux/of_platform.h>

Ditto.

> +#include <linux/pinctrl/pinctrl.h>

How exactly is this used?

> +#include <linux/platform_device.h>

> +#include <linux/slab.h>

Ditto.

> +#include <linux/types.h>

> +static int at91_usart_mode_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct mfd_cell cell;
> +       u32 opmode;
> +       int err;
> +

> +       err = of_property_read_u32(np, "atmel,usart-mode", &opmode);

Check unified device property API.

> +       return mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, &cell, 1,
> +                             NULL, 0, NULL);

No devm_ and no ->remove(). Why to leak resources?

-- 
With Best Regards,
Andy Shevchenko
