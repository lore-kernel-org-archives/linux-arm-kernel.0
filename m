From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 3 Mar 2016 09:17:31 +0530
Subject: [PATCH 06/14] dma: sirf: use __maybe_unused to hide pm functions
In-Reply-To: <1456934350-1389172-7-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-7-git-send-email-arnd@arndb.de>
Message-ID: <20160303034731.GI11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 04:58:58PM +0100, Arnd Bergmann wrote:
> The sirf dma driver uses #ifdef to check for CONFIG_PM_SLEEP
> for its suspend/resume code but then has no #ifdef for the
> respective runtime PM code, so we get a warning if CONFIG_PM
> is disabled altogether:
> 
> drivers/dma/sirf-dma.c:1000:12: error: 'sirfsoc_dma_runtime_resume' defined but not used [-Werror=unused-function]
> 
> This removes the existing #ifdef and instead uses __maybe_unused
> annotations for all four functions to let the compiler know it
> can silently drop the function definition.

Hi Arnd,

Rather than telling compiler that this maybe used why not add ifdef for it's
suspend/resume as well, what are the demerits of that approach?

-- 
~Vinod

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/sirf-dma.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
> index 22ea2419ee56..e48350e65089 100644
> --- a/drivers/dma/sirf-dma.c
> +++ b/drivers/dma/sirf-dma.c
> @@ -989,7 +989,7 @@ static int sirfsoc_dma_remove(struct platform_device *op)
>  	return 0;
>  }
>  
> -static int sirfsoc_dma_runtime_suspend(struct device *dev)
> +static int __maybe_unused sirfsoc_dma_runtime_suspend(struct device *dev)
>  {
>  	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
>  
> @@ -997,7 +997,7 @@ static int sirfsoc_dma_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int sirfsoc_dma_runtime_resume(struct device *dev)
> +static int __maybe_unused sirfsoc_dma_runtime_resume(struct device *dev)
>  {
>  	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
>  	int ret;
> @@ -1010,8 +1010,7 @@ static int sirfsoc_dma_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int sirfsoc_dma_pm_suspend(struct device *dev)
> +static int __maybe_unused sirfsoc_dma_pm_suspend(struct device *dev)
>  {
>  	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
>  	struct sirfsoc_dma_regs *save = &sdma->regs_save;
> @@ -1062,7 +1061,7 @@ static int sirfsoc_dma_pm_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int sirfsoc_dma_pm_resume(struct device *dev)
> +static int __maybe_unused sirfsoc_dma_pm_resume(struct device *dev)
>  {
>  	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
>  	struct sirfsoc_dma_regs *save = &sdma->regs_save;
> @@ -1121,7 +1120,6 @@ static int sirfsoc_dma_pm_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct dev_pm_ops sirfsoc_dma_pm_ops = {
>  	SET_RUNTIME_PM_OPS(sirfsoc_dma_runtime_suspend, sirfsoc_dma_runtime_resume, NULL)
> -- 
> 2.7.0
> 
