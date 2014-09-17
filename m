From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 17 Sep 2014 11:12:55 +0200
Subject: [PATCH] can: at91_can: prepare and unprepare the clock
In-Reply-To: <1410944721-32325-1-git-send-email-davidcdueck@googlemail.com>
References: <1410944721-32325-1-git-send-email-davidcdueck@googlemail.com>
Message-ID: <54195097.1000106@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2014 11:05 AM, David Dueck wrote:
> This prevents a warning.

Which warning?

Can you please check the return value of clock_prepare_enbale().

Marc

BTW: Please add linux-can at vger.kernel.org on Cc for CAN related patches.

> Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> Signed-off-by: Anthony Harivel <anthony.harivel@emtrion.de>
> ---
>  drivers/net/can/at91_can.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index f07fa89..7dcb790 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -1123,7 +1123,7 @@ static int at91_open(struct net_device *dev)
>  	struct at91_priv *priv = netdev_priv(dev);
>  	int err;
>  
> -	clk_enable(priv->clk);
> +	clk_prepare_enable(priv->clk);
>  
>  	/* check or determine and set bittime */
>  	err = open_candev(dev);
> @@ -1149,7 +1149,7 @@ static int at91_open(struct net_device *dev)
>   out_close:
>  	close_candev(dev);
>   out:
> -	clk_disable(priv->clk);
> +	clk_disable_unprepare(priv->clk);
>  
>  	return err;
>  }
> @@ -1166,7 +1166,7 @@ static int at91_close(struct net_device *dev)
>  	at91_chip_stop(dev, CAN_STATE_STOPPED);
>  
>  	free_irq(dev->irq, dev);
> -	clk_disable(priv->clk);
> +	clk_disable_unprepare(priv->clk);
>  
>  	close_candev(dev);
>  
> 


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140917/e395fcfd/attachment-0001.sig>
