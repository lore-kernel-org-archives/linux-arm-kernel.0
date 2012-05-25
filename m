From: khilman@ti.com (Kevin Hilman)
Date: Fri, 25 May 2012 14:57:24 -0700
Subject: [PATCHv9 02/10] I2C: OMAP: Fix the mismatch of pm_runtime enable
 and disable
In-Reply-To: <1335969135-20858-3-git-send-email-shubhrajyoti@ti.com>
 (Shubhrajyoti D.'s message of "Wed, 2 May 2012 20:02:07 +0530")
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
 <1335969135-20858-3-git-send-email-shubhrajyoti@ti.com>
Message-ID: <87wr3zkjp7.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Currently the i2c driver calls the pm_runtime_enable and never
> the disable. This may cause a warning when pm_runtime_enable
> checks for the count match.Attempting to fix the same by calling
> pm_runtime_disable in the error and the remove path.

Looks right.

Can you be more specific in the changelog about when the errors/warning
happens?  e.g. why pm_runtime_enable() is called again?  Is this on
module unload/reload?

Other than that

Acked-by: Kevin Hilman <khilman@ti.com>


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
