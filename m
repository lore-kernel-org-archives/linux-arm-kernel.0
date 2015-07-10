From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 11:17:54 +0900
Subject: [PATCH v2 1/7] opp: add dev_pm_opp_get_turbo_mode_setting() helper
In-Reply-To: <1436456621-29839-2-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <559F2B52.4060903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.07.2015 00:43, Bartlomiej Zolnierkiewicz wrote:
> Add dev_pm_opp_get_turbo_mode_setting() helper for getting turbo
> mode setting for a given opp.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/base/power/opp.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h   |  7 +++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index e24502a2..6b34b2a 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -287,6 +287,37 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
>  
>  /**
> + * dev_pm_opp_get_turbo_mode_setting() - Gets the turbo setting
> + * @opp:	opp for which turbo mode setting has to be returned for
> + *
> + * Return: turbo mode setting corresponding to the opp (true or false)
> + *
> + * Locking: This function must be called under rcu_read_lock(). opp is a rcu
> + * protected pointer. This means that opp which could have been fetched by
> + * opp_find_freq_{exact,ceil,floor} functions is valid as long as we are
> + * under RCU lock. The pointer returned by the opp_find_freq family must be
> + * used in the same section as the usage of this function with the pointer
> + * prior to unlocking with rcu_read_unlock() to maintain the integrity of the
> + * pointer.
> + */
> +bool dev_pm_opp_get_turbo_mode_setting(struct dev_pm_opp *opp)

It is just true or false, so maybe dev_pm_opp_is_turbo_mode()?

Everything else looks good to me.

Best regards,
Krzysztof

> +{
> +	struct dev_pm_opp *tmp_opp;
> +	bool f = false;
> +
> +	opp_rcu_lockdep_assert();
> +
> +	tmp_opp = rcu_dereference(opp);
> +	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
> +		pr_err("%s: Invalid parameters\n", __func__);
> +	else
> +		f = tmp_opp->turbo;
> +
> +	return f;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_turbo_mode_setting);
> +
> +/**
>   * dev_pm_opp_get_max_clock_latency() - Get max clock latency in nanoseconds
>   * @dev:	device for which we do this operation
>   *
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index bb52fae..7856baf 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -30,6 +30,8 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
>  
>  unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
>  
> +bool dev_pm_opp_get_turbo_mode_setting(struct dev_pm_opp *opp);
> +
>  int dev_pm_opp_get_opp_count(struct device *dev);
>  unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
>  
> @@ -63,6 +65,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  	return 0;
>  }
>  
> +static inline bool dev_pm_opp_get_turbo_mode_setting(struct dev_pm_opp *opp)
> +{
> +	return false;
> +}
> +
>  static inline int dev_pm_opp_get_opp_count(struct device *dev)
>  {
>  	return 0;
> 
