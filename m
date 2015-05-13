From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 13 May 2015 17:44:55 +0900
Subject: [PATCH] ARM: EXYNOS: Fix dereference of ERR_PTR returned
 byof_genpd_get_from_provider
In-Reply-To: <1431487072-17567-1-git-send-email-k.kozlowski@samsung.com>
References: <1431487072-17567-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <55530F07.5080503@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/15 12:17, Krzysztof Kozlowski wrote:
> ERR_PTR was dereferenced during sub domain parsing, if parent domain
> could not be obtained (because of invalid phandle or deferred
> registration of parent domain).
> 
> The Exynos power domain code checked whether
> of_genpd_get_from_provider() returned NULL and in that case it skipped
> that power domain node. However this function returns ERR_PTR or valid
> pointer, not NULL.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: <stable@vger.kernel.org>

Maybe [4.0+]? but as you mentioned this patch has a dependency with
Patch "ARM: EXYNOS: Add missing of_node_put() when parsing power domain"
and it means this cannot be applied into stable tree...

So I'll apply this patch firstly then please re-submit them I've missed
before based on samsung tree. I think, it would be better...

> Fixes: 0f7807518fe1 ("ARM: EXYNOS: add support for sub-power domains")
> 
> ---
> 
> The patchset is rebased on top of my fixes for pm_domains.c to avoid the
> conflicts:
> https://lkml.org/lkml/2015/3/27/321
> ---
>  arch/arm/mach-exynos/pm_domains.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index 1a90c5da2fd7..440324c94d28 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -209,7 +209,7 @@ no_clk:
>  		args.np = np;
>  		args.args_count = 0;
>  		child_domain = of_genpd_get_from_provider(&args);
> -		if (!child_domain)
> +		if (IS_ERR(child_domain))
>  			goto next_pd;
>  
>  		if (of_parse_phandle_with_args(np, "power-domains",
> @@ -217,7 +217,7 @@ no_clk:
>  			goto next_pd;
>  
>  		parent_domain = of_genpd_get_from_provider(&args);
> -		if (!parent_domain)
> +		if (IS_ERR(parent_domain))
>  			goto next_pd;
>  
>  		if (pm_genpd_add_subdomain(parent_domain, child_domain))

Applied into fixes with resolving conflict.

Thanks,
Kukjin
