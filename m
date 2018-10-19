From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 19 Oct 2018 11:03:13 +0200
Subject: [PATCH 3/3] reset: reset-zynqmp: Adding support for Xilinx
 zynqmp reset controller.
In-Reply-To: <20181020084107.28251-4-nava.manne@xilinx.com>
References: <20181020084107.28251-1-nava.manne@xilinx.com>
 <20181020084107.28251-4-nava.manne@xilinx.com>
Message-ID: <1539939793.3395.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nava,

On Sat, 2018-10-20 at 14:11 +0530, Nava kishore Manne wrote:
> Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
> The zynqmp reset-controller has the ability to reset lines
> connected to different blocks and peripheral in the Soc.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v1:
> 		-None.

I had comments on RFC v3 that are not addressed yet, see below.

> --- /dev/null
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Xilinx, Inc.
> + *
> + */
> +
> +#include <linux/io.h>

Unnecessary.

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

Should return error code, and only if there is an error:

	if (err)
		return err;

> +	return val;
> +}
> +
> +static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
> +
> +	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
> +					    PM_RESET_ACTION_PULSE);
> +}
> +
> +static struct reset_control_ops zynqmp_reset_ops = {

Should be const:

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

Fits on one line:

	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);

regards
Philipp
