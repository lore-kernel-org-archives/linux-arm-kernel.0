From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 16 Jan 2015 13:47:50 +0100
Subject: [PATCH v3 2/7] ARM: Exynos: add support for sub-power domains
In-Reply-To: <1421243091-10778-3-git-send-email-m.szyprowski@samsung.com>
References: <1421243091-10778-1-git-send-email-m.szyprowski@samsung.com>
 <1421243091-10778-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAPDyKFpOvUBcEfk_DM_r83b2DLNgQv6stMrOhEj0gAMu2R3_2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 January 2015 at 14:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> This patch adds support for making one power domain a sub-domain of
> other domain. This is useful for modeling power dependences for devices
> like TV Mixer or Camera ISP, which needs to have more than one power
> domain enabled to be operational.
>
> Based on previous work by Amit Daniel Kachhap <amit.daniel@samsung.com>
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

I also had a look at the other patches in this patchset from a PM
domain DT point of view. They looks good.

Kind regards
Uffe

> ---
>  .../bindings/arm/exynos/power_domain.txt           |  2 ++
>  arch/arm/mach-exynos/pm_domains.c                  | 28 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> index f4445e5..1e09703 100644
> --- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> +++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> @@ -22,6 +22,8 @@ Optional Properties:
>         - pclkN, clkN: Pairs of parent of input clock and input clock to the
>                 devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
>                 are supported currently.
> +- power-domains: phandle pointing to the parent power domain, for more details
> +                see Documentation/devicetree/bindings/power/power_domain.txt
>
>  Node of a device using power domains must have a power-domains property
>  defined with a phandle to respective power domain.
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index 20f2671..37266a8 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -161,6 +161,34 @@ no_clk:
>                 of_genpd_add_provider_simple(np, &pd->pd);
>         }
>
> +       /* Assign the child power domains to their parents */
> +       for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
> +               struct generic_pm_domain *child_domain, *parent_domain;
> +               struct of_phandle_args args;
> +
> +               args.np = np;
> +               args.args_count = 0;
> +               child_domain = of_genpd_get_from_provider(&args);
> +               if (!child_domain)
> +                       continue;
> +
> +               if (of_parse_phandle_with_args(np, "power-domains",
> +                                        "#power-domain-cells", 0, &args) != 0)
> +                       continue;
> +
> +               parent_domain = of_genpd_get_from_provider(&args);
> +               if (!parent_domain)
> +                       continue;
> +
> +               if (pm_genpd_add_subdomain(parent_domain, child_domain))
> +                       pr_warn("%s failed to add subdomain: %s\n",
> +                               parent_domain->name, child_domain->name);
> +               else
> +                       pr_info("%s has as child subdomain: %s.\n",
> +                               parent_domain->name, child_domain->name);
> +               of_node_put(np);
> +       }
> +
>         return 0;
>  }
>  arch_initcall(exynos4_pm_init_power_domain);
> --
> 1.9.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
