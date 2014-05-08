From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Thu, 8 May 2014 16:08:37 +0000
Subject: [PATCH 2/2] dmaengine: sa11x0: remove broken #ifdef
In-Reply-To: <1399560990-1402858-2-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-2-git-send-email-arnd@arndb.de>
Message-ID: <1399565317.9018.4.camel@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-05-08 at 16:56 +0200, Arnd Bergmann wrote:
> The sa11x0_dma_pm_ops unconditionally reference sa11x0_dma_resume
> and sa11x0_dma_suspend, which currently breaks if CONFIG_PM_SLEEP
> is disabled.
> 
> There is probably a better way to remove the reference in this
> case, but the safe choice is to have the suspend/resume code always
> built in the driver.

Maybe you could create a macro in pm.h for *_noirq version of
suspend/resume? However, like we discussed with Vinod it's much better
to use suspend_late/resume_early for DMAC device drivers, though I have
no idea if it works for sa11x0.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: dmaengine at vger.kernel.org
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dma/sa11x0-dma.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
> index ab26d46..5ebdfbc 100644
> --- a/drivers/dma/sa11x0-dma.c
> +++ b/drivers/dma/sa11x0-dma.c
> @@ -113,11 +113,9 @@ struct sa11x0_dma_phy {
>  	struct sa11x0_dma_desc	*txd_load;
>  	unsigned		sg_done;
>  	struct sa11x0_dma_desc	*txd_done;
> -#ifdef CONFIG_PM_SLEEP
>  	u32			dbs[2];
>  	u32			dbt[2];
>  	u32			dcsr;
> -#endif
>  };
>  
>  struct sa11x0_dma_dev {
> @@ -984,7 +982,6 @@ static int sa11x0_dma_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int sa11x0_dma_suspend(struct device *dev)
>  {
>  	struct sa11x0_dma_dev *d = dev_get_drvdata(dev);
> @@ -1054,7 +1051,6 @@ static int sa11x0_dma_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct dev_pm_ops sa11x0_dma_pm_ops = {
>  	.suspend_noirq = sa11x0_dma_suspend,


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
