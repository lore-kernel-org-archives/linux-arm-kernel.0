From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 14 Jul 2014 09:58:57 +0200
Subject: [PATCH v2 3/4] can: flexcan: switch on clocks before accessing
 ecr register
In-Reply-To: <3901272074d5a3e680a7ecfda3ffbfca4c544a86.1405322992.git.stefan@agner.ch>
References: <cover.1405322992.git.stefan@agner.ch>
 <3901272074d5a3e680a7ecfda3ffbfca4c544a86.1405322992.git.stefan@agner.ch>
Message-ID: <53C38DC1.30000@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2014 09:48 AM, Stefan Agner wrote:
> Reported-by: Ashutosh Singh <ashuleapyear@gmail.com>
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> [stefan at agner.ch: added return check for clk_enable_prepare]
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/net/can/flexcan.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index f425ec2..4c598c9 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -383,11 +383,25 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
>  {
>  	const struct flexcan_priv *priv = netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs = priv->base;
> -	u32 reg = flexcan_read(&regs->ecr);
> +	u32 reg, err;
> +
> +	err = clk_prepare_enable(priv->clk_ipg);
> +	if (err)
> +		return err;
> +
> +	err = clk_prepare_enable(priv->clk_per);
> +	if (err)
> +		goto out_disable_ipg;
> +
> +	reg = flexcan_read(&regs->ecr);
>  
>  	bec->txerr = (reg >> 0) & 0xff;
>  	bec->rxerr = (reg >> 8) & 0xff;
>  
> +	clk_disable_unprepare(priv->clk_per);
> + out_disable_ipg:
> +	clk_disable_unprepare(priv->clk_ipg);
> +
>  	return 0;

You should return an error in case of an error.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/bdeb5094/attachment-0001.sig>
