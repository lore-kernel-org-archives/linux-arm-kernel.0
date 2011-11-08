From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 Nov 2011 14:23:36 +0900
Subject: [PATCH 4/5] ARM: restart: s5pv210: use new restart hook XXX WIP
 XXX WHY IS THERE NO LOCAL HEADERS IN arch/arm/mach-exynos4 XXX
In-Reply-To: <E1RN6xJ-0001aZ-3e@rmk-PC.arm.linux.org.uk>
References: <20111106175457.GK12913@n2100.arm.linux.org.uk>
 <E1RN6xJ-0001aZ-3e@rmk-PC.arm.linux.org.uk>
Message-ID: <04f301cc9dd6$9105cb60$b3116220$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  arch/arm/mach-s5pv210/cpu.c           |    6 +-----
>  arch/arm/mach-s5pv210/mach-aquila.c   |    1 +
>  arch/arm/mach-s5pv210/mach-goni.c     |    1 +
>  arch/arm/mach-s5pv210/mach-smdkc110.c |    1 +
>  arch/arm/mach-s5pv210/mach-smdkv210.c |    1 +
>  arch/arm/mach-s5pv210/mach-torbreck.c |    1 +
>  6 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
> index 84ec746..4c7b071 100644
> --- a/arch/arm/mach-s5pv210/cpu.c
> +++ b/arch/arm/mach-s5pv210/cpu.c
> @@ -41,7 +41,6 @@
>  #include <plat/iic-core.h>
>  #include <plat/keypad-core.h>
>  #include <plat/sdhci.h>
> -#include <plat/reset.h>
>  #include <plat/tv-core.h>
> 
>  /* Initial IO mappings */
> @@ -108,7 +107,7 @@ static void s5pv210_idle(void)
>  	local_irq_enable();
>  }
> 
> -static void s5pv210_sw_reset(void)
> +void s5pv210_restart(char mode, const char *cmd)
>  {
>  	__raw_writel(0x1, S5P_SWRESET);
>  }
> @@ -196,8 +195,5 @@ int __init s5pv210_init(void)
>  	/* set idle function */
>  	pm_idle = s5pv210_idle;
> 
> -	/* set sw_reset function */
> -	s5p_reset_hook = s5pv210_sw_reset;
> -
>  	return sysdev_register(&s5pv210_sysdev);
>  }
> diff --git a/arch/arm/mach-s5pv210/mach-aquila.c
b/arch/arm/mach-s5pv210/mach-
> aquila.c
> index 5811a96..68fd31d 100644
> --- a/arch/arm/mach-s5pv210/mach-aquila.c
> +++ b/arch/arm/mach-s5pv210/mach-aquila.c
> @@ -683,4 +683,5 @@ MACHINE_START(AQUILA, "Aquila")
>  	.map_io		= aquila_map_io,
>  	.init_machine	= aquila_machine_init,
>  	.timer		= &s5p_timer,
> +	.restart	= s5pv210_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index 15edcae..1156a5b 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -960,4 +960,5 @@ MACHINE_START(GONI, "GONI")
>  	.init_machine	= goni_machine_init,
>  	.timer		= &s5p_timer,
>  	.reserve	= &goni_reserve,
> +	.restart	= s5pv210_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-
> s5pv210/mach-smdkc110.c
> index f7266bb..a70fa53 100644
> --- a/arch/arm/mach-s5pv210/mach-smdkc110.c
> +++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
> @@ -141,4 +141,5 @@ MACHINE_START(SMDKC110, "SMDKC110")
>  	.map_io		= smdkc110_map_io,
>  	.init_machine	= smdkc110_machine_init,
>  	.timer		= &s5p_timer,
> +	.restart	= s5pv210_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-
> s5pv210/mach-smdkv210.c
> index a9106c3..5e8a775 100644
> --- a/arch/arm/mach-s5pv210/mach-smdkv210.c
> +++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
> @@ -318,4 +318,5 @@ MACHINE_START(SMDKV210, "SMDKV210")
>  	.map_io		= smdkv210_map_io,
>  	.init_machine	= smdkv210_machine_init,
>  	.timer		= &s5p_timer,
> +	.restart	= s5pv210_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-
> s5pv210/mach-torbreck.c
> index 97cc066..49e9c6d 100644
> --- a/arch/arm/mach-s5pv210/mach-torbreck.c
> +++ b/arch/arm/mach-s5pv210/mach-torbreck.c
> @@ -130,4 +130,5 @@ MACHINE_START(TORBRECK, "TORBRECK")
>  	.map_io		= torbreck_map_io,
>  	.init_machine	= torbreck_machine_init,
>  	.timer		= &s5p_timer,
> +	.restart	= s5pv210_restart,
>  MACHINE_END
> --
> 1.7.4.4
