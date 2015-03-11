From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 11 Mar 2015 18:56:22 +0900
Subject: [PATCH v2] ARM: EXYNOS: Use platform device name as power domain
 name
In-Reply-To: <1426067672-21589-1-git-send-email-k.kozlowski@samsung.com>
References: <1426067672-21589-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <55001146.3040304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2015 06:54 PM, Krzysztof Kozlowski wrote:
> The power domain nodes in DTS may be very generic (e.g. "power-domain"
> for Exynos 5420) making it very hard to debug:
> 
> $ cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>     domain                      status         slaves
> power-domain                    on
> 
> Use platform device name instead so the names will be a little more user
> friendly:
>     domain                      status         slaves
> 100440e0.power-domain           on
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Notes:
>     Changes since v1:
>     1. Add Javier's reviewed-by.
> 
>  arch/arm/mach-exynos/pm_domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index 37266a826437..84e1d9f4d76c 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -125,7 +125,7 @@ static __init int exynos4_pm_init_power_domain(void)
>  			return -ENOMEM;
>  		}
>  
> -		pd->pd.name = kstrdup(np->name, GFP_KERNEL);
> +		pd->pd.name = kstrdup(dev_name(dev), GFP_KERNEL);
>  		pd->name = pd->pd.name;
>  		pd->base = of_iomap(np, 0);
>  		pd->pd.power_off = exynos_pd_power_off;
> 

Looks good to me. This patch is very useful for debug.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
