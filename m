From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Jul 2015 08:37:07 +0900
Subject: [PATCH] ARM: EXYNOS: pd: fix resource deallocation on error path
In-Reply-To: <1438200913-10532-1-git-send-email-vz@mleia.com>
References: <1438200913-10532-1-git-send-email-vz@mleia.com>
Message-ID: <CAJKOXPeWgXR0SuRzZyXHSiewZDuuJXXFmjyWasXDFxDAQUzyqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-30 5:15 GMT+09:00 Vladimir Zapolskiy <vz@mleia.com>:
> The change fixes a bug introduced by 2be2a3ff42a5, memory allocated
> by kstrdup_const() must be always deallocated with kfree_const(),
> otherwise there is a risk of kfree'ing ro memory.

This looks good. Can you provide also Cc-stable and fixes tags?

>
> Also remove unneeded of_node_put(), if for_each_compatible_node() body
> execution is not terminated, this prevents from double kfree() in
> OF_DYNAMIC build.

Each iteration of for_each_compatible_node() has a check:
(dn = of_find_compatible_node(dn, type, compatible))
this increases the references to 'np'. If loop continues then previous
'np' is not of_node_put().

Best regards,
Krzysztof

>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/mach-exynos/pm_domains.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index 6001f1c..4a87e86 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -146,9 +146,8 @@ static __init int exynos4_pm_init_power_domain(void)
>                 pd->base = of_iomap(np, 0);
>                 if (!pd->base) {
>                         pr_warn("%s: failed to map memory\n", __func__);
> -                       kfree(pd->pd.name);
> +                       kfree_const(pd->pd.name);
>                         kfree(pd);
> -                       of_node_put(np);
>                         continue;
>                 }
>
> --
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
