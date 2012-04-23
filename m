From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 23 Apr 2012 19:10:09 +0200
Subject: [PATCHv8 04/10] I2C: OMAP: Fix the error handling
In-Reply-To: <1334842101-20670-5-git-send-email-shubhrajyoti@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-5-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120423171009.GI27321@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The subject is too generic. (I don't want to be negative always: The
following description of the problem is good :))

On Thu, Apr 19, 2012 at 06:58:15PM +0530, Shubhrajyoti D wrote:
> Currently in probe
>       pm_runtime_put(dev->dev);

Indentation wrong.

> 
> ...
>         /* i2c device drivers may be active on return from add_adapter() */
>         adap->nr = pdev->id;
>         r = i2c_add_numbered_adapter(adap);
>         if (r) {
>                 dev_err(dev->dev, "failure adding adapter\n");
>                 goto err_free_irq;
>         }
> ...
> 
>         return 0;
> 
> err_free_irq:
>         free_irq(dev->irq, dev);
> err_unuse_clocks:
>         omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>         pm_runtime_put(dev->dev);
> 
> This may access the i2c registers without the clocks.
> Attempting to fix the same by moving the pm_rintime_put after the error check.

Drop "Attempting".

> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index bf07ffd..1777d79 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1061,8 +1061,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
>  		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
>  
> -	pm_runtime_put(dev->dev);
> -
>  	adap = &dev->adapter;
>  	i2c_set_adapdata(adap, dev);
>  	adap->owner = THIS_MODULE;
> @@ -1082,6 +1080,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  
>  	of_i2c_register_devices(adap);
>  
> +	pm_runtime_put(dev->dev);
> +
>  	return 0;
>  
>  err_free_irq:
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120423/31f1c682/attachment.sig>
