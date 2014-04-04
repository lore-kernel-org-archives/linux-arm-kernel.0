From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Apr 2014 14:23:02 +0530
Subject: [PATCH 06/17] ARM: exynos: cpuidle: Fix S5P_WAKEUP_STAT call
In-Reply-To: <1396597683-6969-7-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
 <1396597683-6969-7-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAKohpo=Tke09Qn=khuSB92mHEs+YEK7ejtkC7g58TvcJZwUW5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 13:17, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> This function should be called only when the powerdown sequence fails.
>
> Even if the current code does not hurt, by moving this line, we have the same
> code than the one in pm.c.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index 9cd1ed9..a1e1882 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -135,11 +135,10 @@ static int exynos_enter_core0_aftr(struct cpuidle_device *dev,
>         if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
>                 tmp |= S5P_CENTRAL_LOWPWR_CFG;
>                 __raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> +               /* Clear wakeup state register */
> +               __raw_writel(0x0, S5P_WAKEUP_STAT);
>         }
>
> -       /* Clear wakeup state register */
> -       __raw_writel(0x0, S5P_WAKEUP_STAT);
> -
>         return index;
>  }

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
