From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 24 Feb 2015 16:42:42 +0100
Subject: [PATCH] ARM: EXYNOS: Handle of_find_device_by_node and kstrdup
 failures
In-Reply-To: <1422984529-17729-1-git-send-email-k.kozlowski@samsung.com>
References: <1422984529-17729-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1424792562.6775.3.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2015-02-03 at 18:28 +0100, Krzysztof Kozlowski wrote:
> Prevent possible NULL pointer dereference of pointer returned by
> of_find_device_by_node(). Handle this by skipping such power domain.
> 
> Additionally fail the init on kstrdup() failure. Such case is actually
> not fatal because the name for power domain allocated by kstrdup() is
> used only in printk. Still as a precaution handle this as an error
> condition.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Hi Kukjin,

What is the status of this patch and the "ARM: EXYNOS: Handle of
of_iomap() failure". The latter should be in your tree but I cannot find
it.

Best regards,
Krzysztof

> ---
>  arch/arm/mach-exynos/pm_domains.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index fd7640a6b503..4c6c29ba58ef 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -116,6 +116,12 @@ static __init int exynos4_pm_init_power_domain(void)
>  		struct device *dev;
>  
>  		pdev = of_find_device_by_node(np);
> +		if (!pdev) {
> +			pr_err("%s: failed to find device for node %s\n",
> +					__func__, np->name);
> +			of_node_put(np);
> +			continue;
> +		}
>  		dev = &pdev->dev;
>  
>  		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> @@ -126,6 +132,12 @@ static __init int exynos4_pm_init_power_domain(void)
>  		}
>  
>  		pd->pd.name = kstrdup(np->name, GFP_KERNEL);
> +		if (!pd->pd.name) {
> +			kfree(pd);
> +			of_node_put(np);
> +			return -ENOMEM;
> +		}
> +
>  		pd->name = pd->pd.name;
>  		pd->base = of_iomap(np, 0);
>  		if (!pd->base) {
