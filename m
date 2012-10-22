From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Oct 2012 16:27:08 +0300
Subject: [RFC/PATCH] mmc: omap_hsmmc: introduce omap_hsmmc_prepare/complete
In-Reply-To: <1350910768-8522-1-git-send-email-balbi@ti.com>
References: <1350910768-8522-1-git-send-email-balbi@ti.com>
Message-ID: <20121022132708.GA14033@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 03:59:28PM +0300, Felipe Balbi wrote:
> prepare() is supposed to prevent new children from
> being registered. On the MMC subsystem, children
> (new cards) registration starts with the card
> detect IRQ.
> 
> Move card detect IRQ disabling to prepare() so that
> no new cards will be registered while we're trying
> to suspend.
> 
> Likewise, move card detect IRQ enabling to complete()
> so we only try to register new children after our MMC
> IP is back up.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Venkat, do you think the patch below makes sense ?

btw, just checked suspend to ram with beagle and panda. We still have
our filesystem after waking up.

ps: you will [1] to test it:

[1] http://marc.info/?l=linux-arm-kernel&m=135090724817604&w=2

> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 54bfd0c..4c8b41e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2022,6 +2022,26 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
>  }
>  
>  #ifdef CONFIG_PM
> +static int omap_hsmmc_prepare(struct device *dev)
> +{
> +	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
> +
> +	if (host->pdata->suspend)
> +		return host->pdata->suspend(dev, host->slot_id);
> +
> +	return 0;
> +}
> +
> +static int omap_hsmmc_complete(struct device *dev)
> +{
> +	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
> +
> +	if (host->pdata->resume)
> +		return host->pdata->resume(dev, host->slot_id);
> +
> +	return 0;
> +}
> +
>  static int omap_hsmmc_suspend(struct device *dev)
>  {
>  	int ret = 0;
> @@ -2035,23 +2055,10 @@ static int omap_hsmmc_suspend(struct device *dev)
>  
>  	pm_runtime_get_sync(host->dev);
>  	host->suspended = 1;
> -	if (host->pdata->suspend) {
> -		ret = host->pdata->suspend(dev, host->slot_id);
> -		if (ret) {
> -			dev_dbg(dev, "Unable to handle MMC board"
> -					" level suspend\n");
> -			host->suspended = 0;
> -			return ret;
> -		}
> -	}
>  	ret = mmc_suspend_host(host->mmc);
>  
>  	if (ret) {
>  		host->suspended = 0;
> -		if (host->pdata->resume) {
> -			if (host->pdata->resume(dev, host->slot_id))
> -				dev_dbg(dev, "Unmask interrupt failed\n");
> -		}
>  		goto err;
>  	}
>  
> @@ -2088,12 +2095,6 @@ static int omap_hsmmc_resume(struct device *dev)
>  	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
>  		omap_hsmmc_conf_bus_power(host);
>  
> -	if (host->pdata->resume) {
> -		ret = host->pdata->resume(dev, host->slot_id);
> -		if (ret)
> -			dev_dbg(dev, "Unmask interrupt failed\n");
> -	}
> -
>  	omap_hsmmc_protect_card(host);
>  
>  	/* Notify the core to resume the host */
> @@ -2109,8 +2110,10 @@ static int omap_hsmmc_resume(struct device *dev)
>  }
>  
>  #else
> +#define omap_hsmmc_prepare	NULL
> +#define omap_hsmmc_complete	NULL
>  #define omap_hsmmc_suspend	NULL
> -#define omap_hsmmc_resume		NULL
> +#define omap_hsmmc_resume	NULL
>  #endif
>  
>  static int omap_hsmmc_runtime_suspend(struct device *dev)
> @@ -2138,6 +2141,8 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
>  static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
>  	.suspend	= omap_hsmmc_suspend,
>  	.resume		= omap_hsmmc_resume,
> +	.prepare	= omap_hsmmc_prepare,
> +	.complete	= omap_hsmmc_complete,
>  	.runtime_suspend = omap_hsmmc_runtime_suspend,
>  	.runtime_resume = omap_hsmmc_runtime_resume,
>  };
> -- 
> 1.8.0.rc0
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121022/88dfd0e5/attachment.sig>
