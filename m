From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 9 Feb 2015 10:06:33 +0100
Subject: [PATCH] exynos: pmu: use PS_HOLD based poweroff for all supported
 SoCs
In-Reply-To: <1423466741-11421-1-git-send-email-m.szyprowski@samsung.com>
References: <1423466741-11421-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAJKOXPeeUjcwO6qBdHA8DJaviPxRwjAsSe7ciyGDFOUoNhZvcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-09 8:25 GMT+01:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> PS_HOLD based power off procedure is common for all Exynos SoCs, so use
> it for every Exynos SoC.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mach-exynos/pmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I tried this on Trats2 board (Exynos 4412) and message "Power down
failed, please power off system manually." appears. Is it expected? Or
am I missing some patches (I applied this on top of next-20150129)?

Best regards,
Krzysztof

>
> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
> index c15761ca2f18..e812c1c85624 100644
> --- a/arch/arm/mach-exynos/pmu.c
> +++ b/arch/arm/mach-exynos/pmu.c
> @@ -681,7 +681,7 @@ static unsigned int const exynos5420_list_disable_pmu_reg[] = {
>         EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,
>  };
>
> -static void exynos5_power_off(void)
> +static void exynos_power_off(void)
>  {
>         unsigned int tmp;
>
> @@ -872,8 +872,6 @@ static void exynos5420_pmu_init(void)
>                         EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI);
>
>         pmu_raw_writel(0x1, EXYNOS5420_UP_SCHEDULER);
> -
> -       pm_power_off = exynos5_power_off;
>         pr_info("EXYNOS5420 PMU initialized\n");
>  }
>
> @@ -984,6 +982,8 @@ static int exynos_pmu_probe(struct platform_device *pdev)
>         if (ret)
>                 dev_warn(dev, "can't register restart handler err=%d\n", ret);
>
> +       pm_power_off = exynos_power_off;
> +
>         dev_dbg(dev, "Exynos PMU Driver probe done\n");
>         return 0;
>  }
> --
> 1.9.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
