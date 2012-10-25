From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Oct 2012 13:55:16 +0300
Subject: [PATCH 2/2] i2c: omap: make reset a seperate function
In-Reply-To: <1351160586-12306-3-git-send-email-shubhrajyoti@ti.com>
References: <1351160586-12306-1-git-send-email-shubhrajyoti@ti.com>
 <1351160586-12306-3-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121025105516.GH21217@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 25, 2012 at 03:53:06PM +0530, Shubhrajyoti D wrote:
> Implement reset as a seperate function.
> This will enable us to make sure that we don't do the
> calculation again on every transfer.
> Also at probe the reset is not added as the hwmod is doing that
> for us.

since you're touching registers which supposedly only hwmod should
touch, you ought to Cc Benoit to make sure he knows what's you're doing
here. I'm adding him to Cc

> @@ -592,7 +597,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	if (timeout == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		ret = -ETIMEDOUT;
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		goto out;
>  	}
>  
> @@ -603,7 +609,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  			|| (dev->cmd_err & OMAP_I2C_STAT_ROVR)
>  			|| (dev->cmd_err & OMAP_I2C_STAT_XUDF)) {
>  		ret = -EIO;
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		goto out;
>  	}
>  
> @@ -621,7 +628,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  			return 0;
>  
>  		ret = -EREMOTEIO;
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);

eventually we need to try to forcefully trigger these errors above
(nack, overflow, underflow and arbitration lost) and try to make sure if
actually need to reset the controller all the time. I find it really odd
that we're always resetting the IP in every error condition without
actually trying to figure out what's wrong with the driver (if there is
something wrong with the driver, of course).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/f4080bc0/attachment.sig>
