From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Dec 2011 10:44:09 +0900
Subject: [PATCH 12/12] ARM: restart: S3C24XX: use new restart hook
In-Reply-To: <1324385316-6052-13-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <1324385316-6052-13-git-send-email-kgene.kim@samsung.com>
Message-ID: <05e001ccbf82$089359f0$19ba0dd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> And adds local header file, common.h in arch/arm/mach-s3c2410/ and
> arch/arm/mach-s3c2440/ directories.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s3c2410/common.h                    |   17 +++++++++++++
>  arch/arm/mach-s3c2410/include/mach/system-reset.h |   27 ---------------------
>  arch/arm/mach-s3c2410/include/mach/system.h       |    2 -
>  arch/arm/mach-s3c2410/mach-amlm5900.c             |    3 ++
>  arch/arm/mach-s3c2410/mach-bast.c                 |    2 +
>  arch/arm/mach-s3c2410/mach-h1940.c                |    3 ++
>  arch/arm/mach-s3c2410/mach-n30.c                  |    4 +++
>  arch/arm/mach-s3c2410/mach-otom.c                 |    3 ++
>  arch/arm/mach-s3c2410/mach-qt2410.c               |    5 ++-
>  arch/arm/mach-s3c2410/mach-smdk2410.c             |    5 ++-
>  arch/arm/mach-s3c2410/mach-tct_hammer.c           |    3 ++
>  arch/arm/mach-s3c2410/mach-vr1000.c               |    2 +
>  arch/arm/mach-s3c2410/s3c2410.c                   |    9 +++++++
>  arch/arm/mach-s3c2440/common.h                    |   17 +++++++++++++
>  arch/arm/mach-s3c2440/mach-anubis.c               |    3 ++
>  arch/arm/mach-s3c2440/mach-at2440evb.c            |    3 ++
>  arch/arm/mach-s3c2440/mach-gta02.c                |    2 +
>  arch/arm/mach-s3c2440/mach-mini2440.c             |    3 ++
>  arch/arm/mach-s3c2440/mach-nexcoder.c             |    3 ++
>  arch/arm/mach-s3c2440/mach-osiris.c               |    3 ++
>  arch/arm/mach-s3c2440/mach-rx1950.c               |    3 ++
>  arch/arm/mach-s3c2440/mach-rx3715.c               |    3 ++
>  arch/arm/mach-s3c2440/mach-smdk2440.c             |    3 ++
>  arch/arm/mach-s3c2440/s3c2440.c                   |    9 +++++++
>  arch/arm/plat-s3c24xx/cpu.c                       |    2 -
>  25 files changed, 104 insertions(+), 35 deletions(-)
>  create mode 100644 arch/arm/mach-s3c2410/common.h
>  delete mode 100644 arch/arm/mach-s3c2410/include/mach/system-reset.h
>  create mode 100644 arch/arm/mach-s3c2440/common.h
> 
> diff --git a/arch/arm/mach-s3c2410/common.h b/arch/arm/mach-s3c2410/common.h
> new file mode 100644
> index 0000000..f65dc80
> --- /dev/null
> +++ b/arch/arm/mach-s3c2410/common.h
> @@ -0,0 +1,17 @@
> +/*
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Common Header for S3C2410 machines
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_S3C2410_COMMON_H
> +#define __ARCH_ARM_MACH_S3C2410_COMMON_H
> +
> +void s3c2410_restart(char mode, const char *cmd);
> +
> +#endif /* __ARCH_ARM_MACH_S3C2410_COMMON_H */
> diff --git a/arch/arm/mach-s3c2410/include/mach/system-reset.h b/arch/arm/mach-
> s3c2410/include/mach/system-reset.h
> deleted file mode 100644
> index 1e495f3..0000000
> --- a/arch/arm/mach-s3c2410/include/mach/system-reset.h
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -/* arch/arm/mach-s3c2410/include/mach/system-reset.h
> - *
> - * Copyright (c) 2008 Simtec Electronics
> - *	Ben Dooks <ben@simtec.co.uk>
> - *
> - * S3C2410 - System define for arch_reset() function
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#include <mach/hardware.h>
> -#include <plat/watchdog-reset.h>
> -
> -static void
> -arch_reset(char mode, const char *cmd)
> -{
> -	if (mode == 's') {
> -		soft_restart(0);
> -	}
> -
> -	arch_wdt_reset();
> -
> -	/* we'll take a jump through zero as a poor second */
> -	soft_restart(0);
> -}
> diff --git a/arch/arm/mach-s3c2410/include/mach/system.h b/arch/arm/mach-s3c2410/include/mach/system.h
> index eef8f24..5e215c1 100644
> --- a/arch/arm/mach-s3c2410/include/mach/system.h
> +++ b/arch/arm/mach-s3c2410/include/mach/system.h
> @@ -52,5 +52,3 @@ static void arch_idle(void)
>  	else
>  		s3c24xx_default_idle();
>  }
> -
> -#include <mach/system-reset.h>
> diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
> index 7983894..4220cc6 100644
> --- a/arch/arm/mach-s3c2410/mach-amlm5900.c
> +++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
> @@ -63,6 +63,8 @@
>  #include <linux/mtd/map.h>
>  #include <linux/mtd/physmap.h>
> 
> +#include "common.h"
> +
>  static struct resource amlm5900_nor_resource = {
>  		.start = 0x00000000,
>  		.end   = 0x01000000 - 1,
> @@ -241,4 +243,5 @@ MACHINE_START(AML_M5900, "AML_M5900")
>  	.init_irq	= s3c24xx_init_irq,
>  	.init_machine	= amlm5900_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2410_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
> index a20ae1a..c6133c6 100644
> --- a/arch/arm/mach-s3c2410/mach-bast.c
> +++ b/arch/arm/mach-s3c2410/mach-bast.c
> @@ -66,6 +66,7 @@
> 
>  #include "usb-simtec.h"
>  #include "nor-simtec.h"
> +#include "common.h"
> 
>  #define COPYRIGHT ", Copyright 2004-2008 Simtec Electronics"
> 
> @@ -662,4 +663,5 @@ MACHINE_START(BAST, "Simtec-BAST")
>  	.init_irq	= s3c24xx_init_irq,
>  	.init_machine	= bast_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2410_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
> index 05a7d16..ad9d865 100644
> --- a/arch/arm/mach-s3c2410/mach-h1940.c
> +++ b/arch/arm/mach-s3c2410/mach-h1940.c
> @@ -70,6 +70,8 @@
> 
>  #include <sound/uda1380.h>
> 
> +#include "common.h"
> +
>  #define H1940_LATCH		((void __force __iomem *)0xF8000000)
> 
>  #define H1940_PA_LATCH		S3C2410_CS2
> @@ -751,4 +753,5 @@ MACHINE_START(H1940, "IPAQ-H1940")
>  	.init_irq	= h1940_init_irq,
>  	.init_machine	= h1940_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2410_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
> index 1dc3e32..383d00c 100644
> --- a/arch/arm/mach-s3c2410/mach-n30.c
> +++ b/arch/arm/mach-s3c2410/mach-n30.c
> @@ -51,6 +51,8 @@
>  #include <plat/s3c2410.h>
>  #include <plat/udc.h>
> 
> +#include "common.h"
> +
>  static struct map_desc n30_iodesc[] __initdata = {
>  	/* nothing here yet */
>  };
> @@ -591,6 +593,7 @@ MACHINE_START(N30, "Acer-N30")
>  	.init_machine	= n30_init,
>  	.init_irq	= s3c24xx_init_irq,
>  	.map_io		= n30_map_io,
> +	.restart	= s3c2410_restart,
>  MACHINE_END
> 
>  MACHINE_START(N35, "Acer-N35")
> @@ -601,4 +604,5 @@ MACHINE_START(N35, "Acer-N35")
>  	.init_machine	= n30_init,
>  	.init_irq	= s3c24xx_init_irq,
>  	.map_io		= n30_map_io,
> +	.restart	= s3c2410_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2410/mach-otom.c b/arch/arm/mach-s3c2410/mach-otom.c
> index f03f3fd..5f1e0ee 100644
> --- a/arch/arm/mach-s3c2410/mach-otom.c
> +++ b/arch/arm/mach-s3c2410/mach-otom.c
> @@ -38,6 +38,8 @@
>  #include <plat/iic.h>
>  #include <plat/cpu.h>
> 
> +#include "common.h"
> +
>  static struct map_desc otom11_iodesc[] __initdata = {
>    /* Device area */
>  	{ (u32)OTOM_VA_CS8900A_BASE, OTOM_PA_CS8900A_BASE, SZ_16M, MT_DEVICE },
> @@ -121,4 +123,5 @@ MACHINE_START(OTOM, "Nex Vision - Otom 1.1")
>  	.init_machine	= otom11_init,
>  	.init_irq	= s3c24xx_init_irq,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2410_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
> index 4518521..58f2c17 100644
> --- a/arch/arm/mach-s3c2410/mach-qt2410.c
> +++ b/arch/arm/mach-s3c2410/mach-qt2410.c
> @@ -62,6 +62,8 @@
>  #include <plat/cpu.h>
>  #include <plat/pm.h>
> 
> +#include "common.h"
> +
>  static struct map_desc qt2410_iodesc[] __initdata = {
>  	{ 0xe0000000, __phys_to_pfn(S3C2410_CS3+0x01000000), SZ_1M, MT_DEVICE }
>  };
> @@ -350,6 +352,5 @@ MACHINE_START(QT2410, "QT2410")
>  	.init_irq	= s3c24xx_init_irq,
>  	.init_machine	= qt2410_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2410_restart,
>  MACHINE_END
> -
> -
> diff --git a/arch/arm/mach-s3c2410/mach-smdk2410.c b/arch/arm/mach-s3c2410/mach-smdk2410.c
> index 99c9dfd..bdc27e7 100644
> --- a/arch/arm/mach-s3c2410/mach-smdk2410.c
> +++ b/arch/arm/mach-s3c2410/mach-smdk2410.c
> @@ -54,6 +54,8 @@
> 
>  #include <plat/common-smdk.h>
> 
> +#include "common.h"
> +
>  static struct map_desc smdk2410_iodesc[] __initdata = {
>    /* nothing here yet */
>  };
> @@ -116,6 +118,5 @@ MACHINE_START(SMDK2410, "SMDK2410") /* @TODO: request a new identifier and switc
>  	.init_irq	= s3c24xx_init_irq,
>  	.init_machine	= smdk2410_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2410_restart,
>  MACHINE_END
> -
> -
> diff --git a/arch/arm/mach-s3c2410/mach-tct_hammer.c b/arch/arm/mach-s3c2410/mach-tct_hammer.c
> index e0d0b6f..1114666 100644
> --- a/arch/arm/mach-s3c2410/mach-tct_hammer.c
> +++ b/arch/arm/mach-s3c2410/mach-tct_hammer.c
> @@ -54,6 +54,8 @@
>  #include <linux/mtd/map.h>
>  #include <linux/mtd/physmap.h>
> 
> +#include "common.h"
> +
>  static struct resource tct_hammer_nor_resource = {
>  		.start = 0x00000000,
>  		.end   = 0x01000000 - 1,
> @@ -151,4 +153,5 @@ MACHINE_START(TCT_HAMMER, "TCT_HAMMER")
>  	.init_irq	= s3c24xx_init_irq,
>  	.init_machine	= tct_hammer_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2410_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2410/mach-vr1000.c b/arch/arm/mach-s3c2410/mach-vr1000.c
> index df47e8e..cc7032b 100644
> --- a/arch/arm/mach-s3c2410/mach-vr1000.c
> +++ b/arch/arm/mach-s3c2410/mach-vr1000.c
> @@ -53,6 +53,7 @@
> 
>  #include "usb-simtec.h"
>  #include "nor-simtec.h"
> +#include "common.h"
> 
>  /* macros for virtual address mods for the io space entries */
>  #define VA_C5(item) ((unsigned long)(item) + BAST_VAM_CS5)
> @@ -405,4 +406,5 @@ MACHINE_START(VR1000, "Thorcom-VR1000")
>  	.init_machine	= vr1000_init,
>  	.init_irq	= s3c24xx_init_irq,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2410_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2410/s3c2410.c b/arch/arm/mach-s3c2410/s3c2410.c
> index 3d7ebc5..c3044cd 100644
> --- a/arch/arm/mach-s3c2410/s3c2410.c
> +++ b/arch/arm/mach-s3c2410/s3c2410.c
> @@ -42,6 +42,7 @@
>  #include <plat/clock.h>
>  #include <plat/pll.h>
>  #include <plat/pm.h>
> +#include <plat/watchdog-reset.h>
> 
>  #include <plat/gpio-core.h>
>  #include <plat/gpio-cfg.h>
> @@ -183,3 +184,11 @@ int __init s3c2410a_init(void)
>  	s3c2410_sysdev.cls = &s3c2410a_sysclass;
>  	return s3c2410_init();
>  }
> +
> +void s3c2410_restart(char mode, const char *cmd)
> +{
> +	if (mode != 's')
> +		arch_wdt_reset();
> +
> +	soft_restart(0);
> +}
> diff --git a/arch/arm/mach-s3c2440/common.h b/arch/arm/mach-s3c2440/common.h
> new file mode 100644
> index 0000000..db8a98a
> --- /dev/null
> +++ b/arch/arm/mach-s3c2440/common.h
> @@ -0,0 +1,17 @@
> +/*
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Common Header for S3C2440 machines
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_S3C2440_COMMON_H
> +#define __ARCH_ARM_MACH_S3C2440_COMMON_H
> +
> +void s3c2440_restart(char mode, const char *cmd);
> +
> +#endif /* __ARCH_ARM_MACH_S3C2440_COMMON_H */
> diff --git a/arch/arm/mach-s3c2440/mach-anubis.c b/arch/arm/mach-s3c2440/mach-anubis.c
> index 74f92fc..121ff8d 100644
> --- a/arch/arm/mach-s3c2440/mach-anubis.c
> +++ b/arch/arm/mach-s3c2440/mach-anubis.c
> @@ -55,6 +55,8 @@
>  #include <plat/cpu.h>
>  #include <plat/audio-simtec.h>
> 
> +#include "common.h"
> +
>  #define COPYRIGHT ", Copyright 2005-2009 Simtec Electronics"
> 
>  static struct map_desc anubis_iodesc[] __initdata = {
> @@ -503,4 +505,5 @@ MACHINE_START(ANUBIS, "Simtec-Anubis")
>  	.init_machine	= anubis_init,
>  	.init_irq	= s3c24xx_init_irq,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2440_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
> index 38887ee..b7e334f 100644
> --- a/arch/arm/mach-s3c2440/mach-at2440evb.c
> +++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
> @@ -49,6 +49,8 @@
>  #include <plat/cpu.h>
>  #include <plat/mci.h>
> 
> +#include "common.h"
> +
>  static struct map_desc at2440evb_iodesc[] __initdata = {
>  	/* Nothing here */
>  };
> @@ -238,4 +240,5 @@ MACHINE_START(AT2440EVB, "AT2440EVB")
>  	.init_machine	= at2440evb_init,
>  	.init_irq	= s3c24xx_init_irq,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2440_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
> index de1e0ff..5859e60 100644
> --- a/arch/arm/mach-s3c2440/mach-gta02.c
> +++ b/arch/arm/mach-s3c2440/mach-gta02.c
> @@ -90,6 +90,7 @@
>  #include <plat/iic.h>
>  #include <plat/ts.h>
> 
> +#include "common.h"
> 
>  static struct pcf50633 *gta02_pcf;
> 
> @@ -600,4 +601,5 @@ MACHINE_START(NEO1973_GTA02, "GTA02")
>  	.init_irq	= s3c24xx_init_irq,
>  	.init_machine	= gta02_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2440_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
> index 91fe0b4..437322f 100644
> --- a/arch/arm/mach-s3c2440/mach-mini2440.c
> +++ b/arch/arm/mach-s3c2440/mach-mini2440.c
> @@ -60,6 +60,8 @@
> 
>  #include <sound/s3c24xx_uda134x.h>
> 
> +#include "common.h"
> +
>  #define MACH_MINI2440_DM9K_BASE (S3C2410_CS4 + 0x300)
> 
>  static struct map_desc mini2440_iodesc[] __initdata = {
> @@ -681,4 +683,5 @@ MACHINE_START(MINI2440, "MINI2440")
>  	.init_machine	= mini2440_init,
>  	.init_irq	= s3c24xx_init_irq,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2440_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2440/mach-nexcoder.c b/arch/arm/mach-s3c2440/mach-nexcoder.c
> index 61c0bf1..40eaf84 100644
> --- a/arch/arm/mach-s3c2440/mach-nexcoder.c
> +++ b/arch/arm/mach-s3c2440/mach-nexcoder.c
> @@ -47,6 +47,8 @@
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
> 
> +#include "common.h"
> +
>  static struct map_desc nexcoder_iodesc[] __initdata = {
>  	/* nothing here yet */
>  };
> @@ -156,4 +158,5 @@ MACHINE_START(NEXCODER_2440, "NexVision - Nexcoder 2440")
>  	.init_machine	= nexcoder_init,
>  	.init_irq	= s3c24xx_init_irq,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2440_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2440/mach-osiris.c b/arch/arm/mach-s3c2440/mach-osiris.c
> index dc142eb..e795715 100644
> --- a/arch/arm/mach-s3c2440/mach-osiris.c
> +++ b/arch/arm/mach-s3c2440/mach-osiris.c
> @@ -54,6 +54,8 @@
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
> 
> +#include "common.h"
> +
>  /* onboard perihperal map */
> 
>  static struct map_desc osiris_iodesc[] __initdata = {
> @@ -452,4 +454,5 @@ MACHINE_START(OSIRIS, "Simtec-OSIRIS")
>  	.init_irq	= s3c24xx_init_irq,
>  	.init_machine	= osiris_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2440_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
> index 0d3453b..1c50d3e 100644
> --- a/arch/arm/mach-s3c2440/mach-rx1950.c
> +++ b/arch/arm/mach-s3c2440/mach-rx1950.c
> @@ -62,6 +62,8 @@
> 
>  #include <sound/uda1380.h>
> 
> +#include "common.h"
> +
>  #define LCD_PWM_PERIOD 192960
>  #define LCD_PWM_DUTY 127353
> 
> @@ -832,4 +834,5 @@ MACHINE_START(RX1950, "HP iPAQ RX1950")
>  	.init_irq = s3c24xx_init_irq,
>  	.init_machine = rx1950_init_machine,
>  	.timer = &s3c24xx_timer,
> +	.restart	= s3c2440_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
> index e19499c..4d20a01 100644
> --- a/arch/arm/mach-s3c2440/mach-rx3715.c
> +++ b/arch/arm/mach-s3c2440/mach-rx3715.c
> @@ -51,6 +51,8 @@
>  #include <plat/cpu.h>
>  #include <plat/pm.h>
> 
> +#include "common.h"
> +
>  static struct map_desc rx3715_iodesc[] __initdata = {
>  	/* dump ISA space somewhere unused */
> 
> @@ -224,4 +226,5 @@ MACHINE_START(RX3715, "IPAQ-RX3715")
>  	.init_irq	= rx3715_init_irq,
>  	.init_machine	= rx3715_init_machine,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2440_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
> index 36eeb41..1deb60d 100644
> --- a/arch/arm/mach-s3c2440/mach-smdk2440.c
> +++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
> @@ -47,6 +47,8 @@
> 
>  #include <plat/common-smdk.h>
> 
> +#include "common.h"
> +
>  static struct map_desc smdk2440_iodesc[] __initdata = {
>  	/* ISA IO Space map (memory space selected by A24) */
> 
> @@ -181,4 +183,5 @@ MACHINE_START(S3C2440, "SMDK2440")
>  	.map_io		= smdk2440_map_io,
>  	.init_machine	= smdk2440_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s3c2440_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c2440/s3c2440.c b/arch/arm/mach-s3c2440/s3c2440.c
> index 37f8cc6..01a8dc8 100644
> --- a/arch/arm/mach-s3c2440/s3c2440.c
> +++ b/arch/arm/mach-s3c2440/s3c2440.c
> @@ -35,6 +35,7 @@
>  #include <plat/cpu.h>
>  #include <plat/s3c244x.h>
>  #include <plat/pm.h>
> +#include <plat/watchdog-reset.h>
> 
>  #include <plat/gpio-core.h>
>  #include <plat/gpio-cfg.h>
> @@ -73,3 +74,11 @@ void __init s3c2440_map_io(void)
>  	s3c24xx_gpiocfg_default.set_pull = s3c24xx_gpio_setpull_1up;
>  	s3c24xx_gpiocfg_default.get_pull = s3c24xx_gpio_getpull_1up;
>  }
> +
> +void s3c2440_restart(char mode, const char *cmd)
> +{
> +	if (mode != 's')
> +		arch_wdt_reset();
> +
> +	soft_restart(0);
> +}
> diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
> index 3c63353..48fb8d8 100644
> --- a/arch/arm/plat-s3c24xx/cpu.c
> +++ b/arch/arm/plat-s3c24xx/cpu.c
> @@ -38,8 +38,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> 
> -#include <mach/system-reset.h>
> -
>  #include <mach/regs-gpio.h>
>  #include <plat/regs-serial.h>
> 
> --
> 1.7.4.4

From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH V2 11/12] ARM: restart: S3C24XX: use new restart hook

Hook these platforms restart code into the new restart hook rather
than using arch_reset().
And adds local header file, common.h in arch/arm/mach-s3c2410/ and
arch/arm/mach-s3c2440/ directories.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
 - changed inclusion of <mach/system-reset.h> to <plat/system-reset.h>
   which can be used commonly on Samsung SoCs.

 arch/arm/mach-s3c2410/common.h                    |   17 +++++++++++++
 arch/arm/mach-s3c2410/include/mach/system-reset.h |   27 ---------------------
 arch/arm/mach-s3c2410/include/mach/system.h       |    2 +-
 arch/arm/mach-s3c2410/mach-amlm5900.c             |    3 ++
 arch/arm/mach-s3c2410/mach-bast.c                 |    2 +
 arch/arm/mach-s3c2410/mach-h1940.c                |    3 ++
 arch/arm/mach-s3c2410/mach-n30.c                  |    4 +++
 arch/arm/mach-s3c2410/mach-otom.c                 |    3 ++
 arch/arm/mach-s3c2410/mach-qt2410.c               |    5 ++-
 arch/arm/mach-s3c2410/mach-smdk2410.c             |    5 ++-
 arch/arm/mach-s3c2410/mach-tct_hammer.c           |    3 ++
 arch/arm/mach-s3c2410/mach-vr1000.c               |    2 +
 arch/arm/mach-s3c2410/s3c2410.c                   |    9 +++++++
 arch/arm/mach-s3c2440/common.h                    |   17 +++++++++++++
 arch/arm/mach-s3c2440/mach-anubis.c               |    3 ++
 arch/arm/mach-s3c2440/mach-at2440evb.c            |    3 ++
 arch/arm/mach-s3c2440/mach-gta02.c                |    2 +
 arch/arm/mach-s3c2440/mach-mini2440.c             |    3 ++
 arch/arm/mach-s3c2440/mach-nexcoder.c             |    3 ++
 arch/arm/mach-s3c2440/mach-osiris.c               |    3 ++
 arch/arm/mach-s3c2440/mach-rx1950.c               |    3 ++
 arch/arm/mach-s3c2440/mach-rx3715.c               |    3 ++
 arch/arm/mach-s3c2440/mach-smdk2440.c             |    3 ++
 arch/arm/mach-s3c2440/s3c2440.c                   |    9 +++++++
 arch/arm/plat-s3c24xx/cpu.c                       |    3 +-
 arch/arm/plat-samsung/include/plat/system-reset.h |    2 +-
 26 files changed, 107 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/mach-s3c2410/common.h
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/system-reset.h
 create mode 100644 arch/arm/mach-s3c2440/common.h

diff --git a/arch/arm/mach-s3c2410/common.h b/arch/arm/mach-s3c2410/common.h
new file mode 100644
index 0000000..f65dc80
--- /dev/null
+++ b/arch/arm/mach-s3c2410/common.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Common Header for S3C2410 machines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_S3C2410_COMMON_H
+#define __ARCH_ARM_MACH_S3C2410_COMMON_H
+
+void s3c2410_restart(char mode, const char *cmd);
+
+#endif /* __ARCH_ARM_MACH_S3C2410_COMMON_H */
diff --git a/arch/arm/mach-s3c2410/include/mach/system-reset.h b/arch/arm/mach-s3c2410/include/mach/system-reset.h
deleted file mode 100644
index 1e495f3..0000000
--- a/arch/arm/mach-s3c2410/include/mach/system-reset.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/system-reset.h
- *
- * Copyright (c) 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - System define for arch_reset() function
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <mach/hardware.h>
-#include <plat/watchdog-reset.h>
-
-static void
-arch_reset(char mode, const char *cmd)
-{
-	if (mode == 's') {
-		soft_restart(0);
-	}
-
-	arch_wdt_reset();
-
-	/* we'll take a jump through zero as a poor second */
-	soft_restart(0);
-}
diff --git a/arch/arm/mach-s3c2410/include/mach/system.h b/arch/arm/mach-s3c2410/include/mach/system.h
index eef8f24..ebc2ec1 100644
--- a/arch/arm/mach-s3c2410/include/mach/system.h
+++ b/arch/arm/mach-s3c2410/include/mach/system.h
@@ -53,4 +53,4 @@ static void arch_idle(void)
 		s3c24xx_default_idle();
 }
 
-#include <mach/system-reset.h>
+#include <plat/system-reset.h>
diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
index 7983894..4220cc6 100644
--- a/arch/arm/mach-s3c2410/mach-amlm5900.c
+++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
@@ -63,6 +63,8 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/physmap.h>
 
+#include "common.h"
+
 static struct resource amlm5900_nor_resource = {
 		.start = 0x00000000,
 		.end   = 0x01000000 - 1,
@@ -241,4 +243,5 @@ MACHINE_START(AML_M5900, "AML_M5900")
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= amlm5900_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index a20ae1a..c6133c6 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -66,6 +66,7 @@
 
 #include "usb-simtec.h"
 #include "nor-simtec.h"
+#include "common.h"
 
 #define COPYRIGHT ", Copyright 2004-2008 Simtec Electronics"
 
@@ -662,4 +663,5 @@ MACHINE_START(BAST, "Simtec-BAST")
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= bast_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 05a7d16..ad9d865 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -70,6 +70,8 @@
 
 #include <sound/uda1380.h>
 
+#include "common.h"
+
 #define H1940_LATCH		((void __force __iomem *)0xF8000000)
 
 #define H1940_PA_LATCH		S3C2410_CS2
@@ -751,4 +753,5 @@ MACHINE_START(H1940, "IPAQ-H1940")
 	.init_irq	= h1940_init_irq,
 	.init_machine	= h1940_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 1dc3e32..383d00c 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -51,6 +51,8 @@
 #include <plat/s3c2410.h>
 #include <plat/udc.h>
 
+#include "common.h"
+
 static struct map_desc n30_iodesc[] __initdata = {
 	/* nothing here yet */
 };
@@ -591,6 +593,7 @@ MACHINE_START(N30, "Acer-N30")
 	.init_machine	= n30_init,
 	.init_irq	= s3c24xx_init_irq,
 	.map_io		= n30_map_io,
+	.restart	= s3c2410_restart,
 MACHINE_END
 
 MACHINE_START(N35, "Acer-N35")
@@ -601,4 +604,5 @@ MACHINE_START(N35, "Acer-N35")
 	.init_machine	= n30_init,
 	.init_irq	= s3c24xx_init_irq,
 	.map_io		= n30_map_io,
+	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2410/mach-otom.c b/arch/arm/mach-s3c2410/mach-otom.c
index f03f3fd..5f1e0ee 100644
--- a/arch/arm/mach-s3c2410/mach-otom.c
+++ b/arch/arm/mach-s3c2410/mach-otom.c
@@ -38,6 +38,8 @@
 #include <plat/iic.h>
 #include <plat/cpu.h>
 
+#include "common.h"
+
 static struct map_desc otom11_iodesc[] __initdata = {
   /* Device area */
 	{ (u32)OTOM_VA_CS8900A_BASE, OTOM_PA_CS8900A_BASE, SZ_16M, MT_DEVICE },
@@ -121,4 +123,5 @@ MACHINE_START(OTOM, "Nex Vision - Otom 1.1")
 	.init_machine	= otom11_init,
 	.init_irq	= s3c24xx_init_irq,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index 4518521..58f2c17 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -62,6 +62,8 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
+#include "common.h"
+
 static struct map_desc qt2410_iodesc[] __initdata = {
 	{ 0xe0000000, __phys_to_pfn(S3C2410_CS3+0x01000000), SZ_1M, MT_DEVICE }
 };
@@ -350,6 +352,5 @@ MACHINE_START(QT2410, "QT2410")
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= qt2410_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2410_restart,
 MACHINE_END
-
-
diff --git a/arch/arm/mach-s3c2410/mach-smdk2410.c b/arch/arm/mach-s3c2410/mach-smdk2410.c
index 99c9dfd..bdc27e7 100644
--- a/arch/arm/mach-s3c2410/mach-smdk2410.c
+++ b/arch/arm/mach-s3c2410/mach-smdk2410.c
@@ -54,6 +54,8 @@
 
 #include <plat/common-smdk.h>
 
+#include "common.h"
+
 static struct map_desc smdk2410_iodesc[] __initdata = {
   /* nothing here yet */
 };
@@ -116,6 +118,5 @@ MACHINE_START(SMDK2410, "SMDK2410") /* @TODO: request a new identifier and switc
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= smdk2410_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2410_restart,
 MACHINE_END
-
-
diff --git a/arch/arm/mach-s3c2410/mach-tct_hammer.c b/arch/arm/mach-s3c2410/mach-tct_hammer.c
index e0d0b6f..1114666 100644
--- a/arch/arm/mach-s3c2410/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c2410/mach-tct_hammer.c
@@ -54,6 +54,8 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/physmap.h>
 
+#include "common.h"
+
 static struct resource tct_hammer_nor_resource = {
 		.start = 0x00000000,
 		.end   = 0x01000000 - 1,
@@ -151,4 +153,5 @@ MACHINE_START(TCT_HAMMER, "TCT_HAMMER")
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= tct_hammer_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2410/mach-vr1000.c b/arch/arm/mach-s3c2410/mach-vr1000.c
index df47e8e..cc7032b 100644
--- a/arch/arm/mach-s3c2410/mach-vr1000.c
+++ b/arch/arm/mach-s3c2410/mach-vr1000.c
@@ -53,6 +53,7 @@
 
 #include "usb-simtec.h"
 #include "nor-simtec.h"
+#include "common.h"
 
 /* macros for virtual address mods for the io space entries */
 #define VA_C5(item) ((unsigned long)(item) + BAST_VAM_CS5)
@@ -405,4 +406,5 @@ MACHINE_START(VR1000, "Thorcom-VR1000")
 	.init_machine	= vr1000_init,
 	.init_irq	= s3c24xx_init_irq,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2410/s3c2410.c b/arch/arm/mach-s3c2410/s3c2410.c
index 3d7ebc5..c3044cd 100644
--- a/arch/arm/mach-s3c2410/s3c2410.c
+++ b/arch/arm/mach-s3c2410/s3c2410.c
@@ -42,6 +42,7 @@
 #include <plat/clock.h>
 #include <plat/pll.h>
 #include <plat/pm.h>
+#include <plat/watchdog-reset.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
@@ -183,3 +184,11 @@ int __init s3c2410a_init(void)
 	s3c2410_sysdev.cls = &s3c2410a_sysclass;
 	return s3c2410_init();
 }
+
+void s3c2410_restart(char mode, const char *cmd)
+{
+	if (mode != 's')
+		arch_wdt_reset();
+
+	soft_restart(0);
+}
diff --git a/arch/arm/mach-s3c2440/common.h b/arch/arm/mach-s3c2440/common.h
new file mode 100644
index 0000000..db8a98a
--- /dev/null
+++ b/arch/arm/mach-s3c2440/common.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Common Header for S3C2440 machines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_S3C2440_COMMON_H
+#define __ARCH_ARM_MACH_S3C2440_COMMON_H
+
+void s3c2440_restart(char mode, const char *cmd);
+
+#endif /* __ARCH_ARM_MACH_S3C2440_COMMON_H */
diff --git a/arch/arm/mach-s3c2440/mach-anubis.c b/arch/arm/mach-s3c2440/mach-anubis.c
index 74f92fc..121ff8d 100644
--- a/arch/arm/mach-s3c2440/mach-anubis.c
+++ b/arch/arm/mach-s3c2440/mach-anubis.c
@@ -55,6 +55,8 @@
 #include <plat/cpu.h>
 #include <plat/audio-simtec.h>
 
+#include "common.h"
+
 #define COPYRIGHT ", Copyright 2005-2009 Simtec Electronics"
 
 static struct map_desc anubis_iodesc[] __initdata = {
@@ -503,4 +505,5 @@ MACHINE_START(ANUBIS, "Simtec-Anubis")
 	.init_machine	= anubis_init,
 	.init_irq	= s3c24xx_init_irq,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2440_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index 38887ee..b7e334f 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -49,6 +49,8 @@
 #include <plat/cpu.h>
 #include <plat/mci.h>
 
+#include "common.h"
+
 static struct map_desc at2440evb_iodesc[] __initdata = {
 	/* Nothing here */
 };
@@ -238,4 +240,5 @@ MACHINE_START(AT2440EVB, "AT2440EVB")
 	.init_machine	= at2440evb_init,
 	.init_irq	= s3c24xx_init_irq,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2440_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index de1e0ff..5859e60 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -90,6 +90,7 @@
 #include <plat/iic.h>
 #include <plat/ts.h>
 
+#include "common.h"
 
 static struct pcf50633 *gta02_pcf;
 
@@ -600,4 +601,5 @@ MACHINE_START(NEO1973_GTA02, "GTA02")
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= gta02_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2440_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index 91fe0b4..437322f 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -60,6 +60,8 @@
 
 #include <sound/s3c24xx_uda134x.h>
 
+#include "common.h"
+
 #define MACH_MINI2440_DM9K_BASE (S3C2410_CS4 + 0x300)
 
 static struct map_desc mini2440_iodesc[] __initdata = {
@@ -681,4 +683,5 @@ MACHINE_START(MINI2440, "MINI2440")
 	.init_machine	= mini2440_init,
 	.init_irq	= s3c24xx_init_irq,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2440_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-nexcoder.c b/arch/arm/mach-s3c2440/mach-nexcoder.c
index 61c0bf1..40eaf84 100644
--- a/arch/arm/mach-s3c2440/mach-nexcoder.c
+++ b/arch/arm/mach-s3c2440/mach-nexcoder.c
@@ -47,6 +47,8 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
+#include "common.h"
+
 static struct map_desc nexcoder_iodesc[] __initdata = {
 	/* nothing here yet */
 };
@@ -156,4 +158,5 @@ MACHINE_START(NEXCODER_2440, "NexVision - Nexcoder 2440")
 	.init_machine	= nexcoder_init,
 	.init_irq	= s3c24xx_init_irq,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2440_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-osiris.c b/arch/arm/mach-s3c2440/mach-osiris.c
index dc142eb..e795715 100644
--- a/arch/arm/mach-s3c2440/mach-osiris.c
+++ b/arch/arm/mach-s3c2440/mach-osiris.c
@@ -54,6 +54,8 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
+#include "common.h"
+
 /* onboard perihperal map */
 
 static struct map_desc osiris_iodesc[] __initdata = {
@@ -452,4 +454,5 @@ MACHINE_START(OSIRIS, "Simtec-OSIRIS")
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= osiris_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2440_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 0d3453b..1c50d3e 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -62,6 +62,8 @@
 
 #include <sound/uda1380.h>
 
+#include "common.h"
+
 #define LCD_PWM_PERIOD 192960
 #define LCD_PWM_DUTY 127353
 
@@ -832,4 +834,5 @@ MACHINE_START(RX1950, "HP iPAQ RX1950")
 	.init_irq = s3c24xx_init_irq,
 	.init_machine = rx1950_init_machine,
 	.timer = &s3c24xx_timer,
+	.restart	= s3c2440_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index e19499c..4d20a01 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -51,6 +51,8 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
+#include "common.h"
+
 static struct map_desc rx3715_iodesc[] __initdata = {
 	/* dump ISA space somewhere unused */
 
@@ -224,4 +226,5 @@ MACHINE_START(RX3715, "IPAQ-RX3715")
 	.init_irq	= rx3715_init_irq,
 	.init_machine	= rx3715_init_machine,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2440_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index 36eeb41..1deb60d 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -47,6 +47,8 @@
 
 #include <plat/common-smdk.h>
 
+#include "common.h"
+
 static struct map_desc smdk2440_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
 
@@ -181,4 +183,5 @@ MACHINE_START(S3C2440, "SMDK2440")
 	.map_io		= smdk2440_map_io,
 	.init_machine	= smdk2440_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2440_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/s3c2440.c b/arch/arm/mach-s3c2440/s3c2440.c
index 37f8cc6..01a8dc8 100644
--- a/arch/arm/mach-s3c2440/s3c2440.c
+++ b/arch/arm/mach-s3c2440/s3c2440.c
@@ -35,6 +35,7 @@
 #include <plat/cpu.h>
 #include <plat/s3c244x.h>
 #include <plat/pm.h>
+#include <plat/watchdog-reset.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
@@ -73,3 +74,11 @@ void __init s3c2440_map_io(void)
 	s3c24xx_gpiocfg_default.set_pull = s3c24xx_gpio_setpull_1up;
 	s3c24xx_gpiocfg_default.get_pull = s3c24xx_gpio_getpull_1up;
 }
+
+void s3c2440_restart(char mode, const char *cmd)
+{
+	if (mode != 's')
+		arch_wdt_reset();
+
+	soft_restart(0);
+}
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 3c63353..f7e8f44 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -38,10 +38,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/system-reset.h>
-
 #include <mach/regs-gpio.h>
 #include <plat/regs-serial.h>
+#include <plat/system-reset.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
diff --git a/arch/arm/plat-samsung/include/plat/system-reset.h b/arch/arm/plat-samsung/include/plat/system-reset.h
index 1d14d6f..0257e23 100644
--- a/arch/arm/plat-samsung/include/plat/system-reset.h
+++ b/arch/arm/plat-samsung/include/plat/system-reset.h
@@ -5,7 +5,7 @@
  *
  * Based on arch/arm/mach-s3c2410/include/mach/system-reset.h
  *
- * S5P - System define for arch_reset()
+ * System define for arch_reset()
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
