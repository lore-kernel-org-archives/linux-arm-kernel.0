From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 17 Feb 2014 10:42:46 +0100
Subject: [PATCH] can: xilinx CAN controller support.
In-Reply-To: <93c7272e-d8bf-43af-b39b-aaa0e0b70b6f@TX2EHSMHS036.ehs.local>
References: <93c7272e-d8bf-43af-b39b-aaa0e0b70b6f@TX2EHSMHS036.ehs.local>
Message-ID: <5301D996.6040704@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2014 10:23 AM, Kedareswara rao Appana wrote:
> +/**
> + * xcan_get_berr_counter - error counter routine
> + * @ndev:	Pointer to net_device structure
> + * @bec:	Pointer to can_berr_counter structure
> + *
> + * This is the driver error counter routine.
> + * Return: 0 always
> + */
> +static int xcan_get_berr_counter(const struct net_device *ndev,
> +					struct can_berr_counter *bec)
> +{
> +	struct xcan_priv *priv = netdev_priv(ndev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->devclk);
> +	if (ret)
> +		goto err;
> +
> +	ret = clk_prepare_enable(priv->aperclk);
> +	if (ret)
> +		goto err_clk;
> +
> +	bec->txerr = priv->read_reg(priv, XCAN_ECR_OFFSET) & XCAN_ECR_TEC_MASK;
> +	bec->rxerr = ((priv->read_reg(priv, XCAN_ECR_OFFSET) &
> +			XCAN_ECR_REC_MASK) >> XCAN_ESR_REC_SHIFT);

You have to disable the clock when leaving this function. Otherwise the
clocks will be unbalanced.

> +	return 0;
> +
> +err_clk:
> +	clk_disable_unprepare(priv->devclk);
> +err:
> +	return ret;
> +}

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140217/49a3f03b/attachment.sig>
