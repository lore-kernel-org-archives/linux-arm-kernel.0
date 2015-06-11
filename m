From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Thu, 11 Jun 2015 21:33:53 +0900
Subject: [PATCH] PM / Domains: Try power off masters in error path of
 __pm_genpd_poweron()
In-Reply-To: <1434023511-4263-1-git-send-email-ulf.hansson@linaro.org>
References: <1434023511-4263-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <55798031.50205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 11.06.2015 o 20:51, Ulf Hansson pisze:
> While powering up a genpd, its domain masters are first being powered up.
> In the error path of __pm_genpd_poweron(), we didn't care to try power off
> these domain masters. Let's deal with that to avoid leaving unused PM
> domains powered.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2327613..32dcb80 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -235,6 +235,18 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
>  }
>  
>  /**
> + * genpd_queue_power_off_work - Queue up the execution of pm_genpd_poweroff().
> + * @genpd: PM domait to power off.
> + *
> + * Queue up the execution of pm_genpd_poweroff() unless it's already been done
> + * before.
> + */
> +static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
> +{
> +	queue_work(pm_wq, &genpd->power_off_work);
> +}
> +
> +/**
>   * __pm_genpd_poweron - Restore power to a given PM domain and its masters.
>   * @genpd: PM domain to power up.
>   *
> @@ -315,8 +327,12 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>  	return 0;
>  
>   err:
> -	list_for_each_entry_continue_reverse(link, &genpd->slave_links, slave_node)
> +	list_for_each_entry_continue_reverse(link,
> +					&genpd->slave_links,
> +					slave_node) {
>  		genpd_sd_counter_dec(link->master);
> +		genpd_queue_power_off_work(link->master);

It looks sensible to revert work already done however I wonder if this
is necessary for each slave. The first successful call to
pm_genpd_poweroff() will also walk through slave_links and queue the work.

Best regards,
Krzysztof


> +	}
>  
>  	return ret;
>  }
> @@ -490,18 +506,6 @@ static bool genpd_abort_poweroff(struct generic_pm_domain *genpd)
>  }
>  
>  /**
> - * genpd_queue_power_off_work - Queue up the execution of pm_genpd_poweroff().
> - * @genpd: PM domait to power off.
> - *
> - * Queue up the execution of pm_genpd_poweroff() unless it's already been done
> - * before.
> - */
> -static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
> -{
> -	queue_work(pm_wq, &genpd->power_off_work);
> -}
> -
> -/**
>   * pm_genpd_poweroff - Remove power from a given PM domain.
>   * @genpd: PM domain to power down.
>   *
> 
