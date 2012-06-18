From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 18 Jun 2012 17:30:00 +0200
Subject: [PATCHv8 13/13] I2C: OMAP: simplify omap_i2c_ack_stat()
In-Reply-To: <1340029828-20751-14-git-send-email-shubhrajyoti@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-14-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120618153000.GC10768@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 08:00:28PM +0530, Shubhrajyoti D wrote:
> From: Felipe Balbi <balbi@ti.com>
> 
> stat & BIT(1) is the same as BIT(1),

Not true. I'd guess you are missing some context in the patch
description.

> so let's
> simplify things a bit by removing "stat &" from
> all omap_i2c_ack_stat() calls.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Reviewed-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 6a79089..bac6305 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -763,7 +763,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev, u16 *stat, int *err)
>  
>  	while (--timeout && !(*stat & OMAP_I2C_STAT_XUDF)) {
>  		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
> -			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
> +			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
>  							OMAP_I2C_STAT_XDR));
>  			return -ETIMEDOUT;
>  		}
> @@ -824,10 +824,11 @@ complete:
>  		 */
>  		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
>  					OMAP_I2C_STAT_AL)) {
> -			omap_i2c_ack_stat(dev, stat &
> -				(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
> -				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR |
> -				OMAP_I2C_STAT_ARDY));
> +			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
> +						OMAP_I2C_STAT_RDR |
> +						OMAP_I2C_STAT_XRDY |
> +						OMAP_I2C_STAT_XDR |
> +						OMAP_I2C_STAT_ARDY));
>  			omap_i2c_complete_cmd(dev, err);
>  			return IRQ_HANDLED;
>  		}
> @@ -874,8 +875,8 @@ complete:
>  					}
>  				}
>  			}
> -			omap_i2c_ack_stat(dev,
> -				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
> +			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
> +						OMAP_I2C_STAT_RDR));
>  			continue;
>  		}
>  
> @@ -922,8 +923,8 @@ complete:
>  
>  				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
>  			}
> -			omap_i2c_ack_stat(dev,
> -				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> +			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
> +						OMAP_I2C_STAT_XDR));
>  			continue;
>  		}
>  
> -- 
> 1.7.5.4
> 

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120618/fd776f45/attachment-0001.sig>
