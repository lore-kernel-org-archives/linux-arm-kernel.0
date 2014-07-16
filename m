From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 Jul 2014 18:39:53 +0200
Subject: [PATCH v3 01/12] reset: add the Berlin reset controller driver
In-Reply-To: <1405499166-6726-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405499166-6726-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140716163953.GJ9858@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 10:25:55AM +0200, Antoine T?nart wrote:
> Add a reset controller for Marvell Berlin SoCs which is used by the
> USB PHYs drivers (for now).
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-berlin.c | 131 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 drivers/reset/reset-berlin.c
> 
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 60fed3d7820b..157d421f755b 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_RESET_CONTROLLER) += core.o
>  obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
> +obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
>  obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_ARCH_STI) += sti/
> diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
> new file mode 100644
> index 000000000000..7b894047a81d
> --- /dev/null
> +++ b/drivers/reset/reset-berlin.c
> @@ -0,0 +1,131 @@
> +/*
> + * Copyright (C) 2014 Marvell Technology Group Ltd.
> + *
> + * Antoine T?nart <antoine.tenart@free-electrons.com>
> + * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#define BERLIN_MAX_RESETS	32
> +
> +#define to_berlin_reset_priv(p)		\
> +	container_of((p), struct berlin_reset_priv, rcdev)
> +
> +struct berlin_reset_priv {
> +	void __iomem			*base;
> +	unsigned int			size;
> +	struct reset_controller_dev	rcdev;
> +};
> +
> +static int berlin_reset_reset(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct berlin_reset_priv *priv = to_berlin_reset_priv(rcdev);
> +	int offset = id >> 8;
> +	int mask = BIT(id & 0xff);

nit: 

The parameter to BIT() should be 0-31. So you want to & with 5. Given
your xlate function, it should never happen that it is greater than
31. Hence it is only a nit. If you need to respin, you can change
this, but don't bother to respin just because of this.

    Andrew
