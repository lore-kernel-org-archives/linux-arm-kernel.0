From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 14 Jul 2011 20:54:08 -0600
Subject: [PATCH 1/2] i2c/imx: remove init/exit hooks from platform data
In-Reply-To: <1310659425-17499-2-git-send-email-shawn.guo@linaro.org>
References: <1310659425-17499-1-git-send-email-shawn.guo@linaro.org>
	<1310659425-17499-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110715025408.GG2927@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 12:03:44AM +0800, Shawn Guo wrote:
> The init/exit hooks in platform data are being used nowhere, so can
> be removed.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Darius Augulis <augulis.darius@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Yes, I think this is the think to do.  Notifiers provide a generic
mechanism.  There is no need for each driver to open code this
functionality.

g.

> ---
>  arch/arm/plat-mxc/include/mach/i2c.h |    4 ----
>  drivers/i2c/busses/i2c-imx.c         |   21 +++------------------
>  2 files changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/i2c.h b/arch/arm/plat-mxc/include/mach/i2c.h
> index 4a5dc5c..375cdd0 100644
> --- a/arch/arm/plat-mxc/include/mach/i2c.h
> +++ b/arch/arm/plat-mxc/include/mach/i2c.h
> @@ -11,14 +11,10 @@
>  
>  /**
>   * struct imxi2c_platform_data - structure of platform data for MXC I2C driver
> - * @init:	Initialise gpio's and other board specific things
> - * @exit:	Free everything initialised by @init
>   * @bitrate:	Bus speed measured in Hz
>   *
>   **/
>  struct imxi2c_platform_data {
> -	int (*init)(struct device *dev);
> -	void (*exit)(struct device *dev);
>  	int bitrate;
>  };
>  
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 4c2a62b..54d809e 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -466,7 +466,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  {
>  	struct imx_i2c_struct *i2c_imx;
>  	struct resource *res;
> -	struct imxi2c_platform_data *pdata;
> +	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
>  	void __iomem *base;
>  	resource_size_t res_size;
>  	int irq;
> @@ -485,19 +485,11 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	pdata = pdev->dev.platform_data;
> -
> -	if (pdata && pdata->init) {
> -		ret = pdata->init(&pdev->dev);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	res_size = resource_size(res);
>  
>  	if (!request_mem_region(res->start, res_size, DRIVER_NAME)) {
> -		ret = -EBUSY;
> -		goto fail0;
> +		dev_err(&pdev->dev, "request_mem_region failed\n");
> +		return -EBUSY;
>  	}
>  
>  	base = ioremap(res->start, res_size);
> @@ -586,9 +578,6 @@ fail2:
>  	iounmap(base);
>  fail1:
>  	release_mem_region(res->start, resource_size(res));
> -fail0:
> -	if (pdata && pdata->exit)
> -		pdata->exit(&pdev->dev);
>  	return ret; /* Return error number */
>  }
>  
> @@ -611,10 +600,6 @@ static int __exit i2c_imx_remove(struct platform_device *pdev)
>  	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
>  	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>  
> -	/* Shut down hardware */
> -	if (pdata && pdata->exit)
> -		pdata->exit(&pdev->dev);
> -
>  	clk_put(i2c_imx->clk);
>  
>  	iounmap(i2c_imx->base);
> -- 
> 1.7.4.1
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
