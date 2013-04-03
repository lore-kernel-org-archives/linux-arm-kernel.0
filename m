From: robherring2@gmail.com (Rob Herring)
Date: Wed, 03 Apr 2013 08:28:47 -0500
Subject: [PATCH] clocksource: tegra: enable arch_timer
In-Reply-To: <1364988750-25058-1-git-send-email-josephl@nvidia.com>
References: <1364988750-25058-1-git-send-email-josephl@nvidia.com>
Message-ID: <515C2E8F.1030802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 06:32 AM, Joseph Lo wrote:
> Architected timer is the local timer for Cortex-A15. Adding the support
> for Tegra.
> 
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>

My patch series to add CLOCKSOURCE_OF_DECLARE support to arch timer and
sched_clock enhancements will make this unnecessary:

http://www.spinics.net/lists/arm-kernel/msg234597.html

Testing would be appreciated.

Rob

> ---
>  drivers/clocksource/tegra20_timer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
> index ae877b0..e443f44 100644
> --- a/drivers/clocksource/tegra20_timer.c
> +++ b/drivers/clocksource/tegra20_timer.c
> @@ -30,6 +30,7 @@
>  #include <asm/mach/time.h>
>  #include <asm/smp_twd.h>
>  #include <asm/sched_clock.h>
> +#include <asm/arch_timer.h>
>  
>  #define RTC_SECONDS            0x08
>  #define RTC_SHADOW_SECONDS     0x0c
> @@ -200,8 +201,6 @@ static void __init tegra20_init_timer(struct device_node *np)
>  		WARN(1, "Unknown clock rate");
>  	}
>  
> -	setup_sched_clock(tegra_read_sched_clock, 32, 1000000);
> -
>  	if (clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
>  		"timer_us", 1000000, 300, 32, clocksource_mmio_readl_up)) {
>  		pr_err("Failed to register clocksource\n");
> @@ -218,6 +217,10 @@ static void __init tegra20_init_timer(struct device_node *np)
>  	tegra_clockevent.irq = tegra_timer_irq.irq;
>  	clockevents_config_and_register(&tegra_clockevent, 1000000,
>  					0x1, 0x1fffffff);
> +	if (arch_timer_of_register())
> +		setup_sched_clock(tegra_read_sched_clock, 32, 1000000);
> +	else
> +		arch_timer_sched_clock_init();
>  }
>  CLOCKSOURCE_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
>  
> 
