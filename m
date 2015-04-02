From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 02 Apr 2015 14:29:31 +0200
Subject: [PATCH 1/2] ARM: EXYNOS: Get current parent clock for power domain
 on/off
In-Reply-To: <1427961979-29477-1-git-send-email-k.kozlowski@samsung.com>
References: <1427961979-29477-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <551D362B.90901@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/02/2015 10:06 AM, Krzysztof Kozlowski wrote:
> Using a fixed (by DTS) parent for clocks when turning on the power domain
> may introduce issues in other drivers. For example when such driver
> changes the parent during runtime and expects that he is the only place
> of such change.
> 
> Do not rely entirely on DTS providing the fixed parent for such clocks.
> Instead if "pclkN" clock name is missing, grab a current parent of clock
> with clk_get_parent().
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/arm/exynos/power_domain.txt | 8 +++++---
>  arch/arm/mach-exynos/pm_domains.c                             | 9 ++++++---
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> index 5da38c5ed476..0fc1312f6fd5 100644
> --- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> +++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> @@ -19,9 +19,11 @@ Optional Properties:
>  	domains.
>  - clock-names: The following clocks can be specified:
>  	- oscclk: Oscillator clock.
> -	- pclkN, clkN: Pairs of parent of input clock and input clock to the
> -		devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
> -		are supported currently.
> +	- pclkN, clkN: Input clocks (clkN) to the devices in this power domain.
> +		Optionally with parrents (pclkN). If such parent is provided
> +		it will be used for reparenting the given clock when domain
> +		is turned on. Otherwise the parent before power down will be
> +		used. Maximum of 4 pairs (N = 0 to 3) are supported currently.
>  	- asbN: Clocks required by asynchronous bridges (ASB) present in
>  		the power domain. These clock should be enabled during power
>  		domain on/off operations.
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index cbe56b35aea0..c55bcf52a6ad 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -37,6 +37,7 @@ struct exynos_pm_domain {
>  	struct clk *oscclk;
>  	struct clk *clk[MAX_CLK_PER_DOMAIN];
>  	struct clk *pclk[MAX_CLK_PER_DOMAIN];
> +	unsigned int pclk_dynamic:MAX_CLK_PER_DOMAIN;
>  	struct clk *asb_clk[MAX_CLK_PER_DOMAIN];
>  };
>  
> @@ -62,6 +63,9 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
>  		for (i = 0; i < MAX_CLK_PER_DOMAIN; i++) {
>  			if (IS_ERR(pd->clk[i]))
>  				break;
> +			/* If parent was not set in DT, save current parent */
> +			if (pd->pclk_dynamic & (1 << i))

Small nit: I personally think that using the BIT(i) macro for shifting bits
is more readable but I guess is a matter of personal taste.

> +				pd->pclk[i] = clk_get_parent(pd->clk[i]);
>  			if (clk_set_parent(pd->clk[i], pd->oscclk))
>  				pr_err("%s: error setting oscclk as parent to clock %d\n",
>  						pd->name, i);
> @@ -164,9 +168,8 @@ static __init int exynos4_pm_init_power_domain(void)
>  			snprintf(clk_name, sizeof(clk_name), "pclk%d", i);
>  			pd->pclk[i] = clk_get(dev, clk_name);
>  			if (IS_ERR(pd->pclk[i])) {
> -				clk_put(pd->clk[i]);
> -				pd->clk[i] = ERR_PTR(-EINVAL);
> -				break;
> +				pd->pclk_dynamic |= (1 << i);
> +				pd->pclk[i] = clk_get_parent(pd->clk[i]);
>  			}
>  		}
>  
> 

Patch looks good to me:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

I tested $subject along with 2/2 on an Exynos5420 Peach Pit and I see
that display comes up correctly on boot. Also after disabling the display:

$ echo 1 > /sys/devices/platform/exynos-drm/graphics/fb0/blank

the DISP1 power domain is off in /sys/kernel/debug/pm_genpd/pm_genpd_summary
and after enabling it again with:

$ echo 0 > /sys/devices/platform/exynos-drm/graphics/fb0/blank

the DISP1 power domain is on again and the display is working correctly.

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
