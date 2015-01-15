From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 15 Jan 2015 17:05:53 +0100
Subject: [PATCH v3 6/8] clocksource: atmel-st: properly initialize driver
In-Reply-To: <1421077023-30954-7-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421077023-30954-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421077023-30954-7-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <54B7E561.8090008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2015 04:37 PM, Alexandre Belloni wrote:
> Use clocksource_of_init to initialize the system timer instead of relying on a
> custom function.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/mach-at91/board-dt-rm9200.c | 7 -------
>   arch/arm/mach-at91/generic.h         | 3 ---
>   drivers/clocksource/timer-atmel-st.c | 4 +++-
>   3 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-at91/board-dt-rm9200.c b/arch/arm/mach-at91/board-dt-rm9200.c
> index 76dfe8f9af50..d9a45f49c208 100644
> --- a/arch/arm/mach-at91/board-dt-rm9200.c
> +++ b/arch/arm/mach-at91/board-dt-rm9200.c
> @@ -24,19 +24,12 @@
>
>   #include "generic.h"
>
> -static void __init at91rm9200_dt_timer_init(void)
> -{
> -	of_clk_init(NULL);
> -	at91rm9200_timer_init();
> -}
> -
>   static const char *at91rm9200_dt_board_compat[] __initdata = {
>   	"atmel,at91rm9200",
>   	NULL
>   };
>
>   DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
> -	.init_time      = at91rm9200_dt_timer_init,
>   	.map_io		= at91_map_io,
>   	.init_early	= at91rm9200_dt_initialize,
>   	.dt_compat	= at91rm9200_dt_board_compat,
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> index d53324210adf..fc12f3d4b93c 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -29,9 +29,6 @@ extern void __init at91_dt_initialize(void);
>   extern void __init at91_sysirq_mask_rtc(u32 rtc_base);
>   extern void __init at91_sysirq_mask_rtt(u32 rtt_base);
>
> - /* Timer */
> -extern void at91rm9200_timer_init(void);
> -
>   /* idle */
>   extern void at91sam9_idle(void);
>
> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
> index 522583d6cc78..ed0267f1c892 100644
> --- a/drivers/clocksource/timer-atmel-st.c
> +++ b/drivers/clocksource/timer-atmel-st.c
> @@ -232,7 +232,7 @@ err:
>   /*
>    * ST (system timer) module supports both clockevents and clocksource.
>    */
> -void __init at91rm9200_timer_init(void)
> +static void __init atmel_st_timer_init(struct device_node *node)
>   {
>   	/* For device tree enabled device: initialize here */
>   	of_at91rm9200_st_init();
> @@ -261,3 +261,5 @@ void __init at91rm9200_timer_init(void)
>
>   	arm_pm_restart = at91rm9200_restart;
>   }
> +CLOCKSOURCE_OF_DECLARE(atmel_st_timer, "atmel,at91rm9200-st",
> +		       atmel_st_timer_init);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
