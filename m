From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 26 Aug 2013 16:23:03 +0200
Subject: [PATCH V2] ARM: EXYNOS: cpuidle: Skip C1 cpuidle state for
 exynos5440
In-Reply-To: <1377519363-23077-1-git-send-email-amit.daniel@samsung.com>
References: <4070794.XxjluIqBpK@amdc1032>
 <1377519363-23077-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <18873465.YOJHgsXmcz@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 26, 2013 05:46:03 PM Amit Daniel Kachhap wrote:
> This patch skips the deep C1(AFTR -Arm off top running) state for exynos5440
> soc as this soc does not support this state. The cpu's only allows the basic
> C0 state. The C1 state is filtered by re-initialising the driver state_count
> value to 1.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks for fixing this.

> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
> 
> Changes in V2:
> * Used driver state_count variable to filter the C1 state
>  instead of device state count variable. Although this V2 patch is also
>  not complete as there are suggestions to make this driver platform driver.

I'm going to look into making it a platform driver later this week.

>  arch/arm/mach-exynos/cpuidle.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index 225ee84..ac13922 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -200,6 +200,9 @@ static int __init exynos4_init_cpuidle(void)
>  	if (soc_is_exynos5250())
>  		exynos5_core_down_clk();
>  
> +	if (soc_is_exynos5440())
> +		exynos4_idle_driver.state_count = 1;
> +
>  	ret = cpuidle_register_driver(&exynos4_idle_driver);
>  	if (ret) {
>  		printk(KERN_ERR "CPUidle failed to register driver\n");

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
