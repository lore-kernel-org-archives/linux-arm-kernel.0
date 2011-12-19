From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 19 Dec 2011 13:12:34 +0100
Subject: [PATCH] ARM: restart: S3C64XX: use new restart hook
In-Reply-To: <03dc01ccbe45$80633d30$8129b790$%kim@samsung.com>
References: <03dc01ccbe45$80633d30$8129b790$%kim@samsung.com>
Message-ID: <201112191312.34546.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

will you also do s3c24xx?

I'm asking, as I'm currently also looking at this for the 24xx arches and 
would like to prevent double work on both our sides.

Thanks
Heiko

Am Montag, 19. Dezember 2011, 12:58:20 schrieb Kukjin Kim:
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/common.c                     |   10 ++++++++++
>  arch/arm/mach-s3c64xx/common.h                     |    2 ++
>  arch/arm/mach-s3c64xx/include/mach/system.h        |   12 ------------
>  arch/arm/mach-s3c64xx/mach-anw6410.c               |    1 +
>  arch/arm/mach-s3c64xx/mach-crag6410.c              |    1 +
>  arch/arm/mach-s3c64xx/mach-hmt.c                   |    1 +
>  arch/arm/mach-s3c64xx/mach-mini6410.c              |    1 +
>  arch/arm/mach-s3c64xx/mach-ncp.c                   |    1 +
>  arch/arm/mach-s3c64xx/mach-real6410.c              |    1 +
>  arch/arm/mach-s3c64xx/mach-smartq5.c               |    1 +
>  arch/arm/mach-s3c64xx/mach-smartq7.c               |    1 +
>  arch/arm/mach-s3c64xx/mach-smdk6400.c              |    1 +
>  arch/arm/mach-s3c64xx/mach-smdk6410.c              |    1 +
>  .../arm/plat-samsung/include/plat/watchdog-reset.h |    1 +
>  14 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/common.c
> b/arch/arm/mach-s3c64xx/common.c index 8ae5b16..35182ba 100644
> --- a/arch/arm/mach-s3c64xx/common.c
> +++ b/arch/arm/mach-s3c64xx/common.c
> @@ -44,6 +44,7 @@
>  #include <plat/irq-vic-timer.h>
>  #include <plat/regs-irqtype.h>
>  #include <plat/regs-serial.h>
> +#include <plat/watchdog-reset.h>
> 
>  #include "common.h"
> 
> @@ -373,3 +374,12 @@ static int __init s3c64xx_init_irq_eint(void)
>  	return 0;
>  }
>  arch_initcall(s3c64xx_init_irq_eint);
> +
> +void s3c64xx_restart(char mode, const char *cmd)
> +{
> +	if (mode != 's')
> +		arch_wdt_reset();
> +
> +	/* if all else fails, or mode was for soft, jump to 0 */
> +	soft_restart(0);
> +}
> diff --git a/arch/arm/mach-s3c64xx/common.h
> b/arch/arm/mach-s3c64xx/common.h index 9f523a2..8dc8ab6 100644
> --- a/arch/arm/mach-s3c64xx/common.h
> +++ b/arch/arm/mach-s3c64xx/common.h
> @@ -23,6 +23,8 @@ void s3c64xx_init_io(struct map_desc *mach_desc, int
> size); void s3c64xx_register_clocks(unsigned long xtal, unsigned
> armclk_limit); void s3c64xx_setup_clocks(void);
> 
> +void s3c64xx_restart(char mode, const char *cmd);
> +
>  extern struct syscore_ops s3c64xx_irq_syscore_ops;
>  extern struct sysdev_class s3c64xx_sysclass;
> 
> diff --git a/arch/arm/mach-s3c64xx/include/mach/system.h
> b/arch/arm/mach-s3c64xx/include/mach/system.h index e19c584..353ed43
> 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/system.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/system.h
> @@ -11,21 +11,9 @@
>  #ifndef __ASM_ARCH_SYSTEM_H
>  #define __ASM_ARCH_SYSTEM_H __FILE__
> 
> -#include <plat/watchdog-reset.h>
> -
>  static void arch_idle(void)
>  {
>  	/* nothing here yet */
>  }
> 
> -#error Fix me up
> -static void arch_reset(char mode, const char *cmd)
> -{
> -	if (mode != 's')
> -		arch_wdt_reset();
> -
> -	/* if all else fails, or mode was for soft, jump to 0 */
> -	soft_restart(0);
> -}
> -
>  #endif /* __ASM_ARCH_IRQ_H */
> diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c
> b/arch/arm/mach-s3c64xx/mach-anw6410.c index 4949bcd..a2ea6e5 100644
> --- a/arch/arm/mach-s3c64xx/mach-anw6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
> @@ -240,4 +240,5 @@ MACHINE_START(ANW6410, "A&W6410")
>  	.map_io		= anw6410_map_io,
>  	.init_machine	= anw6410_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c64xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c
> b/arch/arm/mach-s3c64xx/mach-crag6410.c index 954a44e..3615d83 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -715,4 +715,5 @@ MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore
> 6410") .map_io		= crag6410_map_io,
>  	.init_machine	= crag6410_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c64xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c
> b/arch/arm/mach-s3c64xx/mach-hmt.c index b6231d5..8707bee 100644
> --- a/arch/arm/mach-s3c64xx/mach-hmt.c
> +++ b/arch/arm/mach-s3c64xx/mach-hmt.c
> @@ -271,4 +271,5 @@ MACHINE_START(HMT, "Airgoo-HMT")
>  	.map_io		= hmt_map_io,
>  	.init_machine	= hmt_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c64xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c
> b/arch/arm/mach-s3c64xx/mach-mini6410.c index ed02e7e..4fba232 100644
> --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> @@ -349,4 +349,5 @@ MACHINE_START(MINI6410, "MINI6410")
>  	.map_io		= mini6410_map_io,
>  	.init_machine	= mini6410_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c64xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c
> b/arch/arm/mach-s3c64xx/mach-ncp.c index 3e2391a..9ec4d57 100644
> --- a/arch/arm/mach-s3c64xx/mach-ncp.c
> +++ b/arch/arm/mach-s3c64xx/mach-ncp.c
> @@ -103,4 +103,5 @@ MACHINE_START(NCP, "NCP")
>  	.map_io		= ncp_map_io,
>  	.init_machine	= ncp_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c64xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c
> b/arch/arm/mach-s3c64xx/mach-real6410.c index 0456143..0cb7116 100644
> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> @@ -330,4 +330,5 @@ MACHINE_START(REAL6410, "REAL6410")
>  	.map_io		= real6410_map_io,
>  	.init_machine	= real6410_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c64xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c
> b/arch/arm/mach-s3c64xx/mach-smartq5.c index 2044a9f..f1f57bd 100644
> --- a/arch/arm/mach-s3c64xx/mach-smartq5.c
> +++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
> @@ -151,4 +151,5 @@ MACHINE_START(SMARTQ5, "SmartQ 5")
>  	.map_io		= smartq_map_io,
>  	.init_machine	= smartq5_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c64xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c
> b/arch/arm/mach-s3c64xx/mach-smartq7.c index eaf24a3..63117d8 100644
> --- a/arch/arm/mach-s3c64xx/mach-smartq7.c
> +++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
> @@ -167,4 +167,5 @@ MACHINE_START(SMARTQ7, "SmartQ 7")
>  	.map_io		= smartq_map_io,
>  	.init_machine	= smartq7_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c64xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c
> b/arch/arm/mach-s3c64xx/mach-smdk6400.c index bda5e0b..64375d7 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
> @@ -92,4 +92,5 @@ MACHINE_START(SMDK6400, "SMDK6400")
>  	.map_io		= smdk6400_map_io,
>  	.init_machine	= smdk6400_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c64xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> b/arch/arm/mach-s3c64xx/mach-smdk6410.c index 91087da..f239b0a 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -704,4 +704,5 @@ MACHINE_START(SMDK6410, "SMDK6410")
>  	.map_io		= smdk6410_map_io,
>  	.init_machine	= smdk6410_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c64xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/plat-samsung/include/plat/watchdog-reset.h
> b/arch/arm/plat-samsung/include/plat/watchdog-reset.h index
> 40dbb2b..f19aff1 100644
> --- a/arch/arm/plat-samsung/include/plat/watchdog-reset.h
> +++ b/arch/arm/plat-samsung/include/plat/watchdog-reset.h
> @@ -17,6 +17,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/delay.h>
> 
>  static inline void arch_wdt_reset(void)
>  {
