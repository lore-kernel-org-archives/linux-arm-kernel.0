From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 09:55:25 +0200
Subject: [PATCHv2 6/7] i2c: omap: make reset a seperate function
In-Reply-To: <1352025873-27492-7-git-send-email-shubhrajyoti@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-7-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121105075525.GG32468@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 04, 2012 at 04:14:32PM +0530, Shubhrajyoti D wrote:
> Implement reset as a separate function.
> This will enable us to make sure that we don't do the
> calculation again on every transfer.
> Also at probe the reset is not added as the hwmod is doing that
> for us.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> todo: reprodue the errors and optimise the reset if possible.
> 
>  drivers/i2c/busses/i2c-omap.c |   25 ++++++++++++++++---------
>  1 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index a87c20a..70d43b7 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -299,15 +299,9 @@ static void __omap_i2c_init(struct omap_i2c_dev *dev)
>  		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
>  }
>  
> -static int omap_i2c_init(struct omap_i2c_dev *dev)
> +static int omap_i2c_reset(struct omap_i2c_dev *dev)
>  {
> -	u16 psc = 0, scll = 0, sclh = 0;
> -	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
> -	unsigned long fclk_rate = 12000000;
>  	unsigned long timeout;
> -	unsigned long internal_clk = 0;
> -	struct clk *fclk;
> -
>  	if (dev->rev >= OMAP_I2C_OMAP1_REV_2) {
>  		/* Disable I2C controller before soft reset */
>  		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
> @@ -353,6 +347,17 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			dev->westate = OMAP_I2C_WE_ALL;
>  		}
>  	}
> +	return 0;
> +}
> +
> +static int omap_i2c_init(struct omap_i2c_dev *dev)
> +{
> +	u16 psc = 0, scll = 0, sclh = 0;
> +	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
> +	unsigned long fclk_rate = 12000000;
> +	unsigned long internal_clk = 0;
> +	struct clk *fclk;
> +
>  
>  	if (dev->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
>  		/*
> @@ -592,7 +597,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	dev->buf_len = 0;
>  	if (timeout == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		return -ETIMEDOUT;
>  	}
>  
> @@ -602,7 +608,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	/* We have an error */
>  	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
>  			    OMAP_I2C_STAT_XUDF)) {
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		return -EIO;
>  	}
>  
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/d1d68a8a/attachment.sig>
