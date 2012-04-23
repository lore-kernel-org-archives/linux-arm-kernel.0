From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 23 Apr 2012 17:43:45 +0200
Subject: [PATCHv8 02/10] I2C: OMAP: Fix the mismatch of pm_runtime enable
 and disable
In-Reply-To: <1334842101-20670-3-git-send-email-shubhrajyoti@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-3-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120423154345.GA27321@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 06:58:13PM +0530, Shubhrajyoti D wrote:
> Currently the i2c driver calls the pm_runtime_enable and never
> the disable. This may cause a warning when pm_runtime_enable
> checks for the count match.Attempting to fix the same by calling
> pm_runtime_disable in the error and the remove path.

Why "attempting"?

> 
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 4f4188d..c851672 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1090,6 +1090,7 @@ err_unuse_clocks:
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(dev->dev);
>  	iounmap(dev->base);
> +	pm_runtime_disable(&pdev->dev);
>  err_free_mem:
>  	platform_set_drvdata(pdev, NULL);
>  	kfree(dev);
> @@ -1110,6 +1111,7 @@ omap_i2c_remove(struct platform_device *pdev)
>  	free_irq(dev->irq, dev);
>  	i2c_del_adapter(&dev->adapter);
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +	pm_runtime_disable(&pdev->dev);
>  	iounmap(dev->base);
>  	kfree(dev);
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120423/31f10c4f/attachment.sig>
