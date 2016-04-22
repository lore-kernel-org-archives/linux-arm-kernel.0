From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 22 Apr 2016 08:55:07 +0200
Subject: [PATCH] ARM: EXYNOS: set clock parents of registered clocks on
 power-on
In-Reply-To: <1461270297-31390-1-git-send-email-vz@mleia.com>
References: <1461270297-31390-1-git-send-email-vz@mleia.com>
Message-ID: <5719CACB.2060702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2016 10:24 PM, Vladimir Zapolskiy wrote:
> If any of the clocks from stored on power down list are not registered
> by chance, on power-on the for-loop of reassigning the clock parents
> back from "oscclk" exits and the remaining clocks don't have a chance
> to restore an original parent clock.
> 
> Fixes: 29e5eea06bc1 ("ARM: EXYNOS: Get current parent clock for power domain on/off")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
> Hi Krzysztof,
> 
> this is a functional and _untested_ change, but I hope it is okay,
> please review. Here "if (a) break; if (a) continue;" code is quite
> confusing.
> 
>  arch/arm/mach-exynos/pm_domains.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index 7c21760..6a9993e 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -90,9 +90,6 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
>  	if (power_on) {
>  		for (i = 0; i < MAX_CLK_PER_DOMAIN; i++) {
>  			if (IS_ERR(pd->clk[i]))
> -				break;
> -
> -			if (IS_ERR(pd->clk[i]))
>  				continue; /* Skip on first power up */

Nice finding! It looks like my mistake during rebasing (automatic
conflict resolution). Anyway I am pretty sure that idea was here to
continue on pd->pclk (not clk) error.

I will confirm this and send appropriate patch with your reported-by.

Best regards,
Krzysztof
