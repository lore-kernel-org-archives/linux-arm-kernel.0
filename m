From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 14 Sep 2011 15:08:18 +0900
Subject: [PATCH] ARM: EXYNOS4: Enable double linefill in PL310 Prefetch
	Control Register
In-Reply-To: <1315894031-9579-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1315894031-9579-1-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <CAH9JG2VFSwL7hCmGpHXx_UKKwK3dbhNRGQB1bwvcD-YC1Qj-AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Siarhei,

Interesting feature, and it's not samsung soc issue, so add the arm
mailing list.
It checked and the see the read performance improvement from 868MiB/s
to 981MiB/s with lmbench.
It's helpful to test other SoC., e.g., OMAP4, STE and so on.

BTW, why do you set the 27-bit? In my PL310 Spec., it's reserved bit
and should be zero (SBZ).

Thank you,
Kyungmin Park

On Tue, Sep 13, 2011 at 3:07 PM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> Setting "Double linefill enable" bit improves memcpy performance
> from ~750 MB/s to ~1150 MB/s when working with large buffers and
> also the performance of just anything which may need good memory
> bandwidth (for example, software rendered graphics).
>
> Additionally setting "Double linefill on WRAP read disable" bit
> compensates most of the random access latency increase.
>
> Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
> ---
> ?arch/arm/mach-exynos4/cpu.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
> index ba503c3..1afd25f 100644
> --- a/arch/arm/mach-exynos4/cpu.c
> +++ b/arch/arm/mach-exynos4/cpu.c
> @@ -238,7 +238,7 @@ static int __init exynos4_l2x0_cache_init(void)
> ? ? ? ?__raw_writel(0x110, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
>
> ? ? ? ?/* L2X0 Prefetch Control */
> - ? ? ? __raw_writel(0x30000007, S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
> + ? ? ? __raw_writel(0x78000007, S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
>
> ? ? ? ?/* L2X0 Power Control */
> ? ? ? ?__raw_writel(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN,
> --
> 1.7.3.4
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>
