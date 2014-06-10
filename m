From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 10 Jun 2014 21:45:11 +0200
Subject: [PATCH v5 2/2] i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface)
 controller support
In-Reply-To: <1402408036-5235-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1402408036-5235-1-git-send-email-boris.brezillon@free-electrons.com>
 <1402408036-5235-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140610194511.GC3122@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

compiling this driver gives me:

drivers/i2c/busses/i2c-sun6i-p2wi.c: In function 'p2wi_probe':
drivers/i2c/busses/i2c-sun6i-p2wi.c:272:2: error: implicit declaration of function 'devm_reset_control_get' [-Werror=implicit-function-declaration]
drivers/i2c/busses/i2c-sun6i-p2wi.c:272:13: warning: assignment makes pointer from integer without a cast [enabled by default]

> diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
> new file mode 100644
> index 0000000..4f7b93f
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
> @@ -0,0 +1,356 @@
> +/*
> + * P2WI (Push-Pull Two Wire Interface) bus driver.
> + *
> + * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + *
> + * The P2WI controller looks like an SMBus controller which only supports byte
> + * data transfers. But, it differs from standard SMBus protocol on several
> + * aspects:
> + * - it supports only one slave device, and thus drop the address field
> + * - it adds a parity bit every 8bits of data
> + * - only one read access is required to read a byte (instead of a write
> + *   followed by a read access in standard SMBus protocol)
> + * - there's no Ack bit after each byte transfer
> + *
> + * This means this bus cannot be used to interface with standard SMBus
> + * devices (the only known device to support this interface is the AXP221
> + * PMIC).
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>

Unneeded. Please check other includes, too.

> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +

...

> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	p2wi->regs = devm_ioremap_resource(dev, r);
> +	if (IS_ERR(p2wi->regs)) {
> +		ret = PTR_ERR(p2wi->regs);
> +		return ret;
> +	}

return PTR_ERR(...)?

> +
> +	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), pdev->name);
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "failed to retrieve irq: %d\n", ret);
> +		return irq;
> +	}
> +
> +	p2wi->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(p2wi->clk)) {
> +		ret = PTR_ERR(p2wi->clk);
> +		dev_err(dev, "failed to retrieve clk: %d\n",
> +			ret);

dangling ret.

> +		return ret;
> +	}
> +

...

> +MODULE_AUTHOR("Boris BREZILLON <boris.brezillon@free-electrons.com>");
> +MODULE_DESCRIPTION("Allwinner P2WI driver");
> +MODULE_LICENSE("GPL");

"GPL v2"

Thanks,

   Wolfram
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140610/28722f8e/attachment.sig>
