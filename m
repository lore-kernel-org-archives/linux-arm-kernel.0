From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 20 Aug 2013 10:46:36 +0200
Subject: [PATCH v2 1/3] can: mcp251x: Replace power callbacks with
 regulator API
In-Reply-To: <1376912361-22133-1-git-send-email-shc_work@mail.ru>
References: <1376912361-22133-1-git-send-email-shc_work@mail.ru>
Message-ID: <52132CEC.2030100@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 01:39 PM, Alexander Shiyan wrote:
> This patch replaces power callbacks to the regulator API. To improve
> the readability of the code, helper for the regulator enable/disable
> was added.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-pxa/icontrol.c         |  3 --
>  arch/arm/mach-pxa/zeus.c             | 46 ++++++++++----------
>  drivers/net/can/mcp251x.c            | 81 +++++++++++++++++++-----------------
>  include/linux/can/platform/mcp251x.h | 13 +-----
>  4 files changed, 69 insertions(+), 74 deletions(-)
> 
[...]

> diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
> index 8cda23b..3df83f8 100644
> --- a/drivers/net/can/mcp251x.c
> +++ b/drivers/net/can/mcp251x.c

[...]

> @@ -1163,15 +1170,14 @@ static int mcp251x_can_suspend(struct device *dev)
>  		netif_device_detach(net);
>  
>  		mcp251x_hw_sleep(spi);
> -		if (pdata->transceiver_enable)
> -			pdata->transceiver_enable(0);
> +		mcp251x_power_enable(priv->transceiver, 0);
>  		priv->after_suspend = AFTER_SUSPEND_UP;
>  	} else {
>  		priv->after_suspend = AFTER_SUSPEND_DOWN;
>  	}
>  
> -	if (pdata->power_enable) {
> -		pdata->power_enable(0);
> +	if (!IS_ERR(priv->power))
                                ^^^

There's a '{' missing.

> +		regulator_disable(priv->power);
>  		priv->after_suspend |= AFTER_SUSPEND_POWER;
>  	}
>  
> @@ -1185,12 +1191,11 @@ static int mcp251x_can_resume(struct device *dev)
>  	struct mcp251x_priv *priv = spi_get_drvdata(spi);
>  
>  	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
> -		pdata->power_enable(1);
> +		mcp251x_power_enable(priv->power, 1);
>  		queue_work(priv->wq, &priv->restart_work);
>  	} else {
>  		if (priv->after_suspend & AFTER_SUSPEND_UP) {
> -			if (pdata->transceiver_enable)
> -				pdata->transceiver_enable(1);
> +			mcp251x_power_enable(priv->transceiver, 1);
>  			queue_work(priv->wq, &priv->restart_work);
>  		} else {
>  			priv->after_suspend = 0;

And I see the following warnings:

> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/mcp251x.c: In function 'mcp251x_can_suspend':
> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/mcp251x.c:1156:32: warning: unused variable 'pdata' [-Wunused-variable]
> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/mcp251x.c: In function 'mcp251x_can_resume':
> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/mcp251x.c:1187:32: warning: unused variable 'pdata' [-Wunused-variable]

I've fixed the problems and applied the patch to linux-can/testing.

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
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130820/3579fa09/attachment.sig>
