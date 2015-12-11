From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 11 Dec 2015 10:16:47 +0100
Subject: [PATCH RFC 05/27] PM / Domains: remove old power on/off latencies.
In-Reply-To: <1447799871-56374-6-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-6-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAPDyKFpHaUvKnCQBf32=iTKbc7e7jyZyOU6zc-bW2tOv_BSxWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 November 2015 at 23:37, Lina Iyer <lina.iyer@linaro.org> wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
> Now that all known users have been converted to use state latencies,
> we can remove the latency field in the generic_pm_domain structure.

I couldn't see that happen in this patchset.

As arch/arm/mach-imx/gpc.c is still using this, you will break that platform.

Kind regards
Uffe

>
> Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
> ---
>  drivers/base/power/domain.c | 15 ---------------
>  include/linux/pm_domain.h   |  2 --
>  2 files changed, 17 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 3fb4c93..c300293 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1248,21 +1248,6 @@ static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
>                 genpd->states[i].param = st[i].param;
>         }
>
> -       /*
> -        * Copy the latency values To keep compatibility with
> -        * platforms that are not converted to use the multiple states.
> -        * This will be removed once all platforms are converted to use
> -        * multiple states. note that non converted platforms will use the
> -        * default single off state.
> -        */
> -       if (genpd->power_on_latency_ns != 0)
> -               genpd->states[0].power_on_latency_ns =
> -                               genpd->power_on_latency_ns;
> -
> -       if (genpd->power_off_latency_ns != 0)
> -               genpd->states[0].power_off_latency_ns =
> -                               genpd->power_off_latency_ns;
> -
>         genpd->state_count = st_count;
>
>         /* to save memory, Name allocation will happen if debug is enabled */
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 15df24c..108a4b3 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -61,9 +61,7 @@ struct generic_pm_domain {
>         unsigned int prepared_count;    /* Suspend counter of prepared devices */
>         bool suspend_power_off; /* Power status before system suspend */
>         int (*power_off)(struct generic_pm_domain *domain);
> -       s64 power_off_latency_ns;
>         int (*power_on)(struct generic_pm_domain *domain);
> -       s64 power_on_latency_ns;
>         struct gpd_dev_ops dev_ops;
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>         bool max_off_time_changed;
> --
> 2.1.4
>
