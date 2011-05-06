From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 May 2011 14:33:12 +0900
Subject: [PATCH] arm: exynos4: PM Bugfix for not waking up from
	suspend-to-RAM
In-Reply-To: <1303706457-20936-1-git-send-email-myungjoo.ham@samsung.com>
References: <1303706457-20936-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <00fe01cc0baf$192b9250$4b82b6f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> Exynos4210 EVT1 (s5pc210-evt1) has an issue of not waking up from
> suspend-to-RAM WAKEUP_MASK register's 31'b is not cleared before
> entering a suspend. This patch clears every undocumented bits of
> WAKEUP_MASK before entering a suspend and enabled sleep/wake in the
> specified chip.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos4/pm.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
> index 10d917d..1cef195 100644
> --- a/arch/arm/mach-exynos4/pm.c
> +++ b/arch/arm/mach-exynos4/pm.c
> @@ -326,6 +326,10 @@ static void exynos4_pm_prepare(void)
>  	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
>  	s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
> 
> +	/* EVT1 issues with undocumented S5P_WAKEUP_MASK bits. */
> +	tmp = __raw_readl(S5P_WAKEUP_MASK);
> +	__raw_writel(0x000fffff & tmp, S5P_WAKEUP_MASK);

Hmm, according to your above description about 31th bit, should be 'tmp &=
~(1 << 31); then write'?
Or do we _really_ need to clear other 11bits [30:20] like your comments,
every undocumented bits?

As I know, NO.

In addition, to clear 31th bit is added s3c_pm_arch_prepare_irqs() of
arch/arm/mach-exynos4/include/mach/pm-core.h and it is called before
entering suspend mode.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
