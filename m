From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 25 Jul 2013 13:19:06 +0200
Subject: [PATCH] ARM: EXYNOS: cpuidle: Skip C1 cpuidle state for exynos5440
In-Reply-To: <1374659615-29447-1-git-send-email-amit.daniel@samsung.com>
References: <0e7d01ce8840$82f79070$88e6b150$@org>
 <1374659615-29447-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <9315698.l6JrEAGWLQ@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[ added Daniel and linux-pm to cc: ]

Hi,

On Wednesday, July 24, 2013 03:23:35 PM Amit Daniel Kachhap wrote:
> This patch skips the deep C1(AFTR -Arm off top running) state for exynos5440
> soc as this soc does not support this state. All the cpu's only allows the basic
> C0 state.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  arch/arm/mach-exynos/cpuidle.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index 17a18ff..9a776a1 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -210,7 +210,7 @@ static int __init exynos4_init_cpuidle(void)
>  		device->cpu = cpu_id;
>  
>  		/* Support IDLE only */
> -		if (cpu_id != 0)
> +		if (soc_is_exynos5440() || cpu_id != 0)
>  			device->state_count = 1;
>  
>  		ret = cpuidle_register_device(device);

This may not achieve what you are intending to do and conflicts with
Daniel's patch (which removes code that you're modifying). Please see:

	http://marc.info/?l=linux-arm-kernel&m=137467935712513&w=2

How's about changing exynos4_idle_driver.state_count for EXYNOS5540
at the beginning of exynos4_init_cpuidle() instead?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
