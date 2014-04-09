From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 09 Apr 2014 14:17:14 +0200
Subject: [PATCH V3 11/17] ARM: exynos: cpuidle: Move the power sequence
 call in the cpu_pm notifier
In-Reply-To: <1396959579-18268-12-git-send-email-daniel.lezcano@linaro.org>
References: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
 <1396959579-18268-12-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <53453A4A.1000704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 08.04.2014 14:19, Daniel Lezcano wrote:
> The code to initiate and exit the powerdown sequence is the same in pm.c and
> cpuidle.c.
>
> Let's split the common part in the pm.c and reuse it from the cpu_pm notifier.
>
> That is one more step forward to make the cpuidle driver arch indenpendant.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   arch/arm/mach-exynos/cpuidle.c |   21 ---------------------
>   arch/arm/mach-exynos/pm.c      |   22 ++++++++++++++++++----
>   2 files changed, 18 insertions(+), 25 deletions(-)

[snip]

> -static int exynos_pm_suspend(void)
> +static void exynos_pm_central_suspend(void)
>   {
>   	unsigned long tmp;
>
>   	/* Setting Central Sequence Register for power down mode */
> -
>   	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
>   	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
>   	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> +}
> +
> +static int exynos_pm_suspend(void)
> +{
> +	unsigned long tmp;
>

Shouldn't exynos_pm_central_suspend() be called here in place of the 
code being moved to that function?

Best regards,
Tomasz
