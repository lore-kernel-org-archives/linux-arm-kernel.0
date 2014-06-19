From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 19 Jun 2014 11:11:18 +0200
Subject: [PATCH v2] clocksource: exynos-mct: Register the timer for stable
 udelay
In-Reply-To: <1403167145-5267-1-git-send-email-amit.daniel@samsung.com>
References: <1403167145-5267-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <53A2A936.3070109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2014 10:39 AM, Amit Daniel Kachhap wrote:
> This patch register the exynos mct clocksource as the current timer
> as it has constant clock rate. This will generate correct udelay for the
> exynos platform and avoid using unnecessary calibrated jiffies. This change
> has been tested on exynos5420 based board and udelay is very close to
> expected.
>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
> Changes in V2:
> * Added #defines for ARM and ARM64 as pointed by Doug Anderson.
>
> Patches from David Riley confirmed that udelay is broken in exynos5420.
> Link to those patches are,
> 1) https://patchwork.kernel.org/patch/4344911/
> 2) https://patchwork.kernel.org/patch/4344881/
>
>   drivers/clocksource/exynos_mct.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index f71d55f..02927e2 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -195,10 +195,25 @@ static u64 notrace exynos4_read_sched_clock(void)
>   	return exynos4_frc_read(&mct_frc);
>   }
>
> +static struct delay_timer exynos4_delay_timer;
> +
> +static unsigned long exynos4_read_current_timer(void)
> +{
> +#ifdef ARM
> +	return __raw_readl(reg_base + EXYNOS4_MCT_G_CNT_L);
> +#else /* ARM64, etc */
> +	return exynos4_frc_read(&mct_frc);
> +#endif
> +}
> +

There isn't another solution than that ? macros definitions in C file 
are avoided as much as possible.

>   static void __init exynos4_clocksource_init(void)
>   {
>   	exynos4_mct_frc_start();
>
> +	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;

&exynos4_read_current_timer ?

> +	exynos4_delay_timer.freq = clk_rate;
> +	register_current_timer_delay(&exynos4_delay_timer);
> +
>   	if (clocksource_register_hz(&mct_frc, clk_rate))
>   		panic("%s: can't register clocksource\n", mct_frc.name);
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
