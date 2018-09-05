From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 05 Sep 2018 12:29:55 +0200
Subject: [RFC PATCH v3 3/3] reset: reset-zynqmp: Adding support for
 Xilinx zynqmp reset controller.
In-Reply-To: <1536131342-28041-4-git-send-email-nava.manne@xilinx.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
 <1536131342-28041-4-git-send-email-nava.manne@xilinx.com>
Message-ID: <1536143395.4084.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

thank you for the patch. I have a few comments below:

On Wed, 2018-09-05 at 12:39 +0530, Nava kishore Manne wrote:
> Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
> The zynqmp reset-controller has the ability to reset lines
> connected to different blocks and peripheral in the Soc.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-None.
> Changes for v2:
> 		-Moved eemi_ops into a priv struct as suggested
> 		 by philipp.
> 
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-zynqmp.c | 115 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 drivers/reset/reset-zynqmp.c
> 
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index c1261dc..27e4a33 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -21,4 +21,5 @@ obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
> +obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
>  
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> new file mode 100644
> index 0000000..f908492
> --- /dev/null
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Xilinx, Inc.
> + *
> + */
> +
> +#include <linux/io.h>

I think including io.h is not necessary.

[...]
> +static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
> +	int val, err;
> +
> +	err = priv->eemi_ops->reset_get_status(ZYNQMP_RESET_ID + id, &val);
> +	if (!err)
> +		return -EINVAL;

This looks like it should be

	if (err)
		return err;

instead.

[...]
> +static struct reset_control_ops zynqmp_reset_ops = {

static const struct reset_control_ops zynqmp_reset_ops = {

> +	.reset = zynqmp_reset_reset,
> +	.assert = zynqmp_reset_assert,
> +	.deassert = zynqmp_reset_deassert,
> +	.status = zynqmp_reset_status,
> +};
> +
> +static int zynqmp_reset_probe(struct platform_device *pdev)
> +{
> +	struct zynqmp_reset_data *priv;
> +
> +	priv = devm_kzalloc(&pdev->dev,
> +			    sizeof(*priv), GFP_KERNEL);

This should fit on one line.

regards
Philipp
