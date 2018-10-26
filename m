From: pza@pengutronix.de (Philipp Zabel)
Date: Fri, 26 Oct 2018 13:08:50 +0200
Subject: [PATCH v2 3/3] reset: reset-zynqmp: Adding support for Xilinx
 zynqmp reset controller.
In-Reply-To: <20181026122424.30831-4-nava.manne@xilinx.com>
References: <20181026122424.30831-1-nava.manne@xilinx.com>
 <20181026122424.30831-4-nava.manne@xilinx.com>
Message-ID: <20181026110850.y3jivrbgjtivndvi@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 05:54:24PM +0530, Nava kishore Manne wrote:
[...]
> +static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
> +	int val, err;
> +
> +	err = priv->eemi_ops->reset_get_status(ZYNQMP_RESET_ID + id, &val);
> +	if (!err)
> +		return err;

This should be:

	if (err)
		return err;

instead. Otherwise you end up always returning 0 on success ...

> +
> +	return val;

... and uninitialized val on error.

regards
Philipp
