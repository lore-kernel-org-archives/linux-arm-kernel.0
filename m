From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 Feb 2015 09:05:07 +0100
Subject: [PATCH] ARM: exynos: Fix wrong hwirq of RTC interrupt for
 Exynos3250 SoC
In-Reply-To: <1423537745-11994-1-git-send-email-cw00.choi@samsung.com>
References: <1423537745-11994-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAJKOXPcaOVC5Rpoi+27Letk4sAuoaW6vheZnCPHJgPktA-RM4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-10 4:09 GMT+01:00 Chanwoo Choi <cw00.choi@samsung.com>:
> This patch fixes wrong hwirq of RTC irq for Exynos3250 SoC. When entering
> suspend state, 'enable_irq_wake fail' happen because of the mismatch of RTC hwirq.
>
>         [ 429.200937] Freezing user space processes ... (elapsed 0.002 seconds) done.
>         [ 429.203383] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>         [ 429.209914] Suspending console(s) (use no_console_suspend to debug)
>         [ 429.370685] wake enabled for irq 65
>         [ 429.370837] wake enabled for irq 64
>         [ 429.370868] wake enabled for irq 79
>         [snip]
>         [  429.372120] s3c-rtc 10070000.rtc: enable_irq_wake failed
>
> Fixes: a4f582f5c5fe3 (ARM: EXYNOS: Add exynos3250 suspend-to-ram support)
> Cc: Kukjin Kim <kgene@kernel.org>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/suspend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Yeah, I remember now Jonghwa's patches back in 2014 August and September :)
https://lkml.org/lkml/2014/8/26/40
https://lkml.org/lkml/2014/9/26/92

Anyway now this looks good:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

>
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index d6feef3..2b8bd67 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -92,8 +92,8 @@ static unsigned int exynos_pmu_spare3;
>  static u32 exynos_irqwake_intmask = 0xffffffff;
>
>  static const struct exynos_wkup_irq exynos3250_wkup_irq[] = {
> -       { 73, BIT(1) }, /* RTC alarm */
> -       { 74, BIT(2) }, /* RTC tick */
> +       { 105, BIT(1) }, /* RTC alarm */
> +       { 106, BIT(2) }, /* RTC tick */
>         { /* sentinel */ },
>  };
>
> --
> 1.8.5.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
