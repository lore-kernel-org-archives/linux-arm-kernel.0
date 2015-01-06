From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 06 Jan 2015 10:56:01 +0900
Subject: [PATCHv3] clocksource: exynos_mct: Add the support for Exynos
 64bit SoC
In-Reply-To: <1418773571-10834-1-git-send-email-cw00.choi@samsung.com>
References: <1418773571-10834-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <54AB40B1.6020003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gently Ping.

Best Regards,
Chanwoo Choi

On 12/17/2014 08:46 AM, Chanwoo Choi wrote:
> This patch adds the support for Exynos 64bit SoC. The delay_timer is only used
> for Exynos 32bit SoC.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> This patch set is tested on 64-bit Exynos SoC. I send only this patch from
> following patchst[1].
> [1] https://lkml.org/lkml/2014/12/2/134
> 
> Changes from v2:
> - None
> Changes from v1:
> - Use CONFIG_ARM instead of CONFIG_ARM64
> 
>  drivers/clocksource/Kconfig      | 1 -
>  drivers/clocksource/exynos_mct.c | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 9042060..27ef3fa 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -134,7 +134,6 @@ config CLKSRC_METAG_GENERIC
>  
>  config CLKSRC_EXYNOS_MCT
>  	def_bool y if ARCH_EXYNOS
> -	depends on !ARM64
>  	help
>  	  Support for Multi Core Timer controller on Exynos SoCs.
>  
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 9403061..b840ea1 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -223,6 +223,7 @@ static u64 notrace exynos4_read_sched_clock(void)
>  	return exynos4_read_count_32();
>  }
>  
> +#if defined(CONFIG_ARM)
>  static struct delay_timer exynos4_delay_timer;
>  
>  static cycles_t exynos4_read_current_timer(void)
> @@ -231,14 +232,17 @@ static cycles_t exynos4_read_current_timer(void)
>  			 "cycles_t needs to move to 32-bit for ARM64 usage");
>  	return exynos4_read_count_32();
>  }
> +#endif
>  
>  static void __init exynos4_clocksource_init(void)
>  {
>  	exynos4_mct_frc_start();
>  
> +#if defined(CONFIG_ARM)
>  	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
>  	exynos4_delay_timer.freq = clk_rate;
>  	register_current_timer_delay(&exynos4_delay_timer);
> +#endif
>  
>  	if (clocksource_register_hz(&mct_frc, clk_rate))
>  		panic("%s: can't register clocksource\n", mct_frc.name);
> 
