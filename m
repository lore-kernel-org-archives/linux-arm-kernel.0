From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 19 Nov 2014 09:25:01 -0800
Subject: [PATCH 1/3] PM / Domains: Initial PM clock support for genpd
In-Reply-To: <1416405638-18812-2-git-send-email-ulf.hansson@linaro.org>
References: <1416405638-18812-1-git-send-email-ulf.hansson@linaro.org>
 <1416405638-18812-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20141119172501.GA37989@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 03:00:36PM +0100, Ulf Hansson wrote:
> It's quite common for PM domains to use PM clocks. Typically from SOC
> specific code, the per device PM clock list is created and
> pm_clk_suspend|resume() are invoked to handle clock gating/ungating.
> 
> A step towards consolidation is to integrate PM clock support into
> genpd, which is what this patch does.
> 
> In this initial step, the calls to the pm_clk_suspend|resume() are
> handled within genpd, but the per device PM clock list still needs to
> be created from SOC specific code. It seems reasonable to have gendp to
> handle that as well, but that left to future patches to address.
> 
> It's not every users of genpd that are keen on using PM clocks thus we
> need to provide this a configuration option for genpd. Therefore let's
> add flag field in the genpd struct to keep this information and define
> a new PM_DOMAIN_PM_CLK bit can then be set at initialization.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 7 +++++++
>  include/linux/pm_domain.h   | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 3989eb6..42e328c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -12,6 +12,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
> +#include <linux/pm_clock.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/sched.h>
> @@ -1948,6 +1949,12 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  	genpd->domain.ops.complete = pm_genpd_complete;
>  	genpd->dev_ops.save_state = pm_genpd_default_save_state;
>  	genpd->dev_ops.restore_state = pm_genpd_default_restore_state;
> +
> +	if (genpd->flags & PM_DOMAIN_PM_CLK) {
> +		genpd->dev_ops.stop = pm_clk_suspend;
> +		genpd->dev_ops.start = pm_clk_suspend;

The 2nd one is wrong.

> +	}
> +
>  	mutex_lock(&gpd_list_lock);
>  	list_add(&genpd->gpd_list_node, &gpd_list);
>  	mutex_unlock(&gpd_list_lock);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9d254e2..44c6931 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -14,6 +14,7 @@
>  #include <linux/pm.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <linux/bitops.h>
>  #include <linux/notifier.h>
>  #include <linux/cpuidle.h>
>  
> @@ -76,6 +77,8 @@ struct generic_pm_domain {
>  			  struct device *dev);
>  	void (*detach_dev)(struct generic_pm_domain *domain,
>  			   struct device *dev);
> +	unsigned int flags;		/* Bit field of configs for genpd */
> +#define PM_DOMAIN_PM_CLK	BIT(0)	/* PM domain use PM clk */

s/use/uses ?

Are you planning on adding a separate flag for collecting clocks from OF
on attach/detach?

>  };
>  
>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
