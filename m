From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 12 Aug 2015 12:50:39 -0700
Subject: [PATCH 2/9] PM / Domains: Remove dev->driver check for runtime PM
In-Reply-To: <1438731339-58317-3-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Tue, 4 Aug 2015 17:35:32 -0600")
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <7hfv3onv5c.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Remove check for driver of a device, for runtime PM. Device may be
> suspended without an explicit driver. This check seems to be vestigial
> and incorrect in the current context.

This one should probably have been RFC.

For a little more context here, this was uncovered when experimenting
with using runtime PM for CPU devices which don't have a dev->driver.

This check might have made sense before PM domains, but with PM domains,
it's entirely possible to have a simple device without a driver and the
PM domain handles all the necesary PM, so I think this check
could/should be removed.

Thoughts?

Kevin

> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/domain.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5fd1306..ef8d19f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -394,8 +394,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>  		if (stat > PM_QOS_FLAGS_NONE)
>  			return -EBUSY;
>  
> -		if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
> -		    || pdd->dev->power.irq_safe))
> +		if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
>  			not_suspended++;
>  	}
