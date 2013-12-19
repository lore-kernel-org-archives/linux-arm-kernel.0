From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 13:54:11 +0800
Subject: [PATCH 4/4] PM / OPP: export symbol find_device_opp
In-Reply-To: <1387410656-36053-4-git-send-email-john.tobias.ph@gmail.com>
References: <1387410656-36053-1-git-send-email-john.tobias.ph@gmail.com>
 <1387410656-36053-4-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <20131219055410.GV6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 03:50:56PM -0800, John Tobias wrote:
> imx6q-cpufreq.c need to have access to find_device_opp function, in order
> to verify if the platform supplied an OPP table or not.

I think we can figure it out by checking the return of
dev_pm_opp_get_opp_count() call, so that we can save this patch
completely.

Note, imx6q-cpufreq driver already calls dev_pm_opp_get_opp_count().
You need to change the way how it handles the return.

Shawn

> 
> As an example here are the imx6q and imx6sl.
> imx6q supplied the opp table due to some board specific requirement.
> While, imx6sl doesn't have an opp table defined.
> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  drivers/base/power/opp.c | 3 ++-
>  include/linux/pm_opp.h   | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index fa41874..d758e42 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -116,7 +116,7 @@ static DEFINE_MUTEX(dev_opp_list_lock);
>   * is a RCU protected pointer. This means that device_opp is valid as long
>   * as we are under RCU lock.
>   */
> -static struct device_opp *find_device_opp(struct device *dev)
> +struct device_opp *find_device_opp(struct device *dev)
>  {
>  	struct device_opp *tmp_dev_opp, *dev_opp = ERR_PTR(-ENODEV);
>  
> @@ -134,6 +134,7 @@ static struct device_opp *find_device_opp(struct device *dev)
>  
>  	return dev_opp;
>  }
> +EXPORT_SYMBOL_GPL(find_device_opp);
>  
>  /**
>   * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an available opp
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 5151b00..cd13385 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -27,6 +27,8 @@ enum dev_pm_opp_event {
>  
>  #if defined(CONFIG_PM_OPP)
>  
> +struct device_opp *find_device_opp(struct device *dev);
> +
>  unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
>  
>  unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
> @@ -52,6 +54,11 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq);
>  
>  struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev);
>  #else
> +static inline struct device_opp *find_device_opp(struct device *dev)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  {
>  	return 0;
> -- 
> 1.8.3.2
> 
