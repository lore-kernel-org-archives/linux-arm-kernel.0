From: balbi@ti.com (Felipe Balbi)
Date: Mon, 29 Oct 2012 21:52:23 +0200
Subject: [PATCHv4 2/2] i2c: omap: make reset a seperate function
In-Reply-To: <1351176199-6479-3-git-send-email-shubhrajyoti@ti.com>
References: <1351176199-6479-1-git-send-email-shubhrajyoti@ti.com>
 <1351176199-6479-3-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121029195223.GC30152@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 08:13:19PM +0530, Shubhrajyoti D wrote:
> Implement reset as a separate function.
> This will enable us to make sure that we don't do the
> calculation again on every transfer.
> Also at probe the reset is not added as the hwmod is doing that
> for us.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

(again, will test tomorrow if I have time)

Next step would be to figure out if it is necessary to reset the IP in
case of error. I don't think so, but only testing will say...

> ---
> some of the errors may not need a reset.
> will check and post separate patch.
> 
>  drivers/i2c/busses/i2c-omap.c |   25 ++++++++++++++++---------
>  1 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 38acf1a..a25b7b0 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -309,15 +309,9 @@ static void __omap_i2c_init(struct omap_i2c_dev *dev)
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
> @@ -363,6 +357,17 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
> @@ -595,7 +600,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	if (timeout == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		ret = -ETIMEDOUT;
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		goto out;
>  	}
>  
> @@ -606,7 +612,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
>  			    OMAP_I2C_STAT_XUDF)) {
>  		ret = -EIO;
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		goto out;
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121029/387812c4/attachment.sig>
