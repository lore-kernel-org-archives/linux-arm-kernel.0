From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 29 Nov 2014 01:22:45 +0100
Subject: [PATCH V3 1/3] PM / Domains: Initial PM clock support for genpd
In-Reply-To: <1417163403-7070-2-git-send-email-ulf.hansson@linaro.org>
References: <1417163403-7070-1-git-send-email-ulf.hansson@linaro.org>
 <1417163403-7070-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <10683450.1AReCcVW08@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 28, 2014 09:30:01 AM Ulf Hansson wrote:
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
> It's not every users of genpd that are keen on using PM clocks, thus we
> need to provide this a configuration option for genpd. Therefore let's
> add flag field in the genpd struct to keep this information and define
> a new GENDP_PM_CLK bit for it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v3:
> 	Moved define out of struct definition.
> 	Don't use bitops.h
> 	Rename define to GENDP_PM_CLK.
> 	
> Changes in v2:
> 	Set ->start() callback to pm_clk_resume() and fixed comment.
> 
> ---
>  drivers/base/power/domain.c | 7 +++++++
>  include/linux/pm_domain.h   | 4 ++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 735c473..a2424a7 100644
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
> @@ -1928,6 +1929,12 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  	genpd->domain.ops.complete = pm_genpd_complete;
>  	genpd->dev_ops.save_state = pm_genpd_default_save_state;
>  	genpd->dev_ops.restore_state = pm_genpd_default_restore_state;
> +
> +	if (genpd->flags & GENPD_PM_CLK) {
> +		genpd->dev_ops.stop = pm_clk_suspend;
> +		genpd->dev_ops.start = pm_clk_resume;
> +	}
> +
>  	mutex_lock(&gpd_list_lock);
>  	list_add(&genpd->gpd_list_node, &gpd_list);
>  	mutex_unlock(&gpd_list_lock);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 8cbd32e..173cc67 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -17,6 +17,9 @@
>  #include <linux/notifier.h>
>  #include <linux/cpuidle.h>
>  
> +/* Defines used for the flags field in the struct generic_pm_domain */
> +#define GENPD_PM_CLK		(1U << 0) /* PM domain uses PM clk */

I'd prefer GENPD_FLAG_PM_CLK to indicate in the name that this is, well, a flag.

Otherwise it looks OK to me.

If you want me to apply [2-3/3] too, ACKs from the ARM/shmobile maintainers
are needed.

> +
>  enum gpd_status {
>  	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
>  	GPD_STATE_WAIT_MASTER,	/* PM domain's master is being waited for */
> @@ -76,6 +79,7 @@ struct generic_pm_domain {
>  			  struct device *dev);
>  	void (*detach_dev)(struct generic_pm_domain *domain,
>  			   struct device *dev);
> +	unsigned int flags;		/* Bit field of configs for genpd */
>  };
>  
>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
