From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Thu, 21 May 2015 14:40:49 +0300
Subject: [PATCH v2] i2c: designware: Avoid unnecessary resuming during
 system suspend
In-Reply-To: <1432132393-693-1-git-send-email-jszhang@marvell.com>
References: <1432132393-693-1-git-send-email-jszhang@marvell.com>
Message-ID: <20150521114049.GY1490@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Jarkko, just in case he has concerns about this]

On Wed, May 20, 2015 at 10:33:13PM +0800, Jisheng Zhang wrote:
> Commit 1fc2fe204cb9 ("i2c: designware: Add runtime PM hooks") adds
> runtime pm support using the same ops for system pm and runtime pm.
> When suspend to ram, the i2c host may have been runtime suspended, thus
> i2c_dw_disable() hangs.
> 
> Previously, I fixed this issue by separating ops for system pm and
> runtime pm, then in the system suspend/resume path, runtime pm apis are
> used to ensure the device is at correct state.
> 
> But as Mika Westerberg pointed out: it sounds a bit silly to resume the
> device just because you want to call i2c_dw_disable() for it before
> suspending again. He then suggested an elegant solution which keeps the
> device runtime suspended during system suspend with the help of
> 'dev->power.direct_complete'. This patch adopted this solution, and in
> fact Mika provided the main code.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  v2 change:
> 	- adopt Mika's suggestion to make use of direct_complete flag
> 
>  drivers/i2c/busses/i2c-designware-platdrv.c | 33 +++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 0a80e4a..f89650f 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -298,6 +298,22 @@ static const struct of_device_id dw_i2c_of_match[] = {
>  MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
>  #endif
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int dw_i2c_prepare(struct device *dev)
> +{
> +	return pm_runtime_suspended(dev);
> +}
> +
> +static void dw_i2c_complete(struct device *dev)
> +{
> +	if (dev->power.direct_complete)
> +		pm_request_resume(dev);
> +}
> +#else
> +#define dw_i2c_prepare	NULL
> +#define dw_i2c_complete	NULL
> +#endif
> +
>  #ifdef CONFIG_PM
>  static int dw_i2c_suspend(struct device *dev)
>  {
> @@ -322,10 +338,19 @@ static int dw_i2c_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
> -static UNIVERSAL_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_suspend,
> -			    dw_i2c_resume, NULL);
> +static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
> +	.prepare = dw_i2c_prepare,
> +	.complete = dw_i2c_complete,
> +	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_suspend, dw_i2c_resume)
> +	SET_RUNTIME_PM_OPS(dw_i2c_suspend,
> +		dw_i2c_resume, NULL)

No need to wrap here. It will fit into 80 chars limit.

Otherwise looks good to me. I also tested this on Braswell and Skylake
machines where it didn't cause any problems,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> +};
> +
> +#define DW_I2C_DEV_PMOPS (&dw_i2c_dev_pm_ops)
> +#else
> +#define DW_I2C_DEV_PMOPS NULL
> +#endif
>  
>  /* work with hotplug and coldplug */
>  MODULE_ALIAS("platform:i2c_designware");
> @@ -337,7 +362,7 @@ static struct platform_driver dw_i2c_driver = {
>  		.name	= "i2c_designware",
>  		.of_match_table = of_match_ptr(dw_i2c_of_match),
>  		.acpi_match_table = ACPI_PTR(dw_i2c_acpi_match),
> -		.pm	= &dw_i2c_dev_pm_ops,
> +		.pm	= DW_I2C_DEV_PMOPS,
>  	},
>  };
>  
> -- 
> 2.1.4
