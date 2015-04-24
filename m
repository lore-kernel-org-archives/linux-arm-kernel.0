From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Apr 2015 08:31:57 -0700
Subject: [PATCH 3/5] arm: omap1: remove boilerplate code and use
 USE_PM_CLK_RUNTIME_OPS
In-Reply-To: <1429777993-11702-4-git-send-email-rnayak@codeaurora.org>
References: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
 <1429777993-11702-4-git-send-email-rnayak@codeaurora.org>
Message-ID: <20150424153156.GS18048@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@codeaurora.org> [150423 01:34]:
> USE_PM_CLK_RUNTIME_OPS is introduced so we don't repeat the same code
> to do runtime_suspend and runtime_resume across users of PM clocks.
> Use it to remove the boilerplate code.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap1/pm_bus.c | 37 ++-----------------------------------
>  1 file changed, 2 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
> index c40e209..667c163 100644
> --- a/arch/arm/mach-omap1/pm_bus.c
> +++ b/arch/arm/mach-omap1/pm_bus.c
> @@ -21,48 +21,15 @@
>  
>  #include "soc.h"
>  
> -#ifdef CONFIG_PM
> -static int omap1_pm_runtime_suspend(struct device *dev)
> -{
> -	int ret;
> -
> -	dev_dbg(dev, "%s\n", __func__);
> -
> -	ret = pm_generic_runtime_suspend(dev);
> -	if (ret)
> -		return ret;
> -
> -	ret = pm_clk_suspend(dev);
> -	if (ret) {
> -		pm_generic_runtime_resume(dev);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int omap1_pm_runtime_resume(struct device *dev)
> -{
> -	dev_dbg(dev, "%s\n", __func__);
> -
> -	pm_clk_resume(dev);
> -	return pm_generic_runtime_resume(dev);
> -}
> -
>  static struct dev_pm_domain default_pm_domain = {
>  	.ops = {
> -		.runtime_suspend = omap1_pm_runtime_suspend,
> -		.runtime_resume = omap1_pm_runtime_resume,
> +		USE_PM_CLK_RUNTIME_OPS
>  		USE_PLATFORM_PM_SLEEP_OPS
>  	},
>  };
> -#define OMAP1_PM_DOMAIN (&default_pm_domain)
> -#else
> -#define OMAP1_PM_DOMAIN NULL
> -#endif /* CONFIG_PM */
>  
>  static struct pm_clk_notifier_block platform_bus_notifier = {
> -	.pm_domain = OMAP1_PM_DOMAIN,
> +	.pm_domain = &default_pm_domain,
>  	.con_ids = { "ick", "fck", NULL, },
>  };
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
