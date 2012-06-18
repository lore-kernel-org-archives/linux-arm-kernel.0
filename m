From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 18 Jun 2012 17:25:30 +0200
Subject: [PATCHv8 11/13] I2C: OMAP: decrease indentation level on data
 handling
In-Reply-To: <1340029828-20751-12-git-send-email-shubhrajyoti@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-12-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120618152530.GB10768@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 08:00:26PM +0530, Shubhrajyoti D wrote:
> From: Felipe Balbi <balbi@ti.com>
> 
> trivial patch, no functional changes.

This patch seems to be correct, but it is not trivial. In fact, it is
pretty easy to miss a "!" here which can cause subtle bugs.

> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Reviewed-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   63 ++++++++++++++++++++---------------------
>  1 files changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 080193a..0e0ab8f 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -845,22 +845,7 @@ complete:
>  							>> 8) & 0x3F;
>  			}
>  			while (num_bytes--) {
> -				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
> -				if (dev->buf_len) {
> -					*dev->buf++ = w;
> -					dev->buf_len--;
> -					/*
> -					 * Data reg in 2430, omap3 and
> -					 * omap4 is 8 bit wide
> -					 */
> -					if (dev->flags &
> -						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
> -						if (dev->buf_len) {
> -							*dev->buf++ = w >> 8;
> -							dev->buf_len--;
> -						}
> -					}
> -				} else {
> +				if (!dev->buf_len) {
>  					if (stat & OMAP_I2C_STAT_RRDY)
>  						dev_err(dev->dev,
>  							"RRDY IRQ while no data"
> @@ -871,6 +856,21 @@ complete:
>  								" requested\n");
>  					break;
>  				}
> +
> +				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
> +				*dev->buf++ = w;
> +				dev->buf_len--;
> +				/*
> +				 * Data reg in 2430, omap3 and
> +				 * omap4 is 8 bit wide
> +				 */
> +				if (dev->flags &
> +						OMAP_I2C_FLAG_16BIT_DATA_REG) {
> +					if (dev->buf_len) {
> +						*dev->buf++ = w >> 8;
> +						dev->buf_len--;
> +					}
> +				}
>  			}
>  			omap_i2c_ack_stat(dev,
>  				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
> @@ -887,22 +887,7 @@ complete:
>  							& 0x3F;
>  			}
>  			while (num_bytes--) {
> -				w = 0;
> -				if (dev->buf_len) {
> -					w = *dev->buf++;
> -					dev->buf_len--;
> -					/*
> -					 * Data reg in 2430, omap3 and
> -					 * omap4 is 8 bit wide
> -					 */
> -					if (dev->flags &
> -						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
> -						if (dev->buf_len) {
> -							w |= *dev->buf++ << 8;
> -							dev->buf_len--;
> -						}
> -					}
> -				} else {
> +				if (!dev->buf_len) {
>  					if (stat & OMAP_I2C_STAT_XRDY)
>  						dev_err(dev->dev,
>  							"XRDY IRQ while no "
> @@ -914,6 +899,20 @@ complete:
>  					break;
>  				}
>  
> +				w = *dev->buf++;
> +				dev->buf_len--;
> +				/*
> +				 * Data reg in 2430, omap3 and
> +				 * omap4 is 8 bit wide
> +				 */
> +				if (dev->flags &
> +						OMAP_I2C_FLAG_16BIT_DATA_REG) {
> +					if (dev->buf_len) {
> +						w |= *dev->buf++ << 8;
> +						dev->buf_len--;
> +					}
> +				}
> +
>  				if ((dev->errata & I2C_OMAP_ERRATA_I462) &&
>  				    errata_omap3_i462(dev, &stat, &err))
>  					goto complete;
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120618/41392bea/attachment.sig>
