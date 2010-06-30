From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 17:56:03 +0200
Subject: [PATCH 07/33] Removing dead CPU_S3C2400
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <5faaae77335d035246d1985c4c6c46830188d85e.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU_S3C2400 doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-s3c2410/include/mach/gpio-fns.h  |    5 ----
 arch/arm/mach-s3c2410/include/mach/regs-gpio.h |    4 ---
 arch/arm/plat-s3c24xx/cpu.c                    |   15 -----------
 arch/arm/plat-s3c24xx/include/plat/s3c2400.h   |   31 ------------------------
 4 files changed, 0 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/s3c2400.h

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-fns.h b/arch/arm/mach-s3c2410/include/mach/gpio-fns.h
index f453c4f..fdee4be 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-fns.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-fns.h
@@ -52,11 +52,6 @@ extern unsigned int s3c2410_gpio_getcfg(unsigned int pin);
 
 extern int s3c2410_gpio_getirq(unsigned int pin);
 
-#ifdef CONFIG_CPU_S3C2400
-
-extern int s3c2400_gpio_getirq(unsigned int pin);
-
-#endif /* CONFIG_CPU_S3C2400 */
 
 /* s3c2410_gpio_irqfilter
  *
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
index a0a89d4..d4a3ad7 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
@@ -16,11 +16,7 @@
 
 #include <mach/gpio-nrs.h>
 
-#ifdef CONFIG_CPU_S3C2400
-#define S3C24XX_MISCCR		S3C2400_MISCCR
-#else
 #define S3C24XX_MISCCR		S3C24XX_GPIOREG2(0x80)
-#endif /* CONFIG_CPU_S3C2400 */
 
 /* general configuration options */
 
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 76d0858..edbbbe7 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -46,7 +46,6 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
-#include <plat/s3c2400.h>
 #include <plat/s3c2410.h>
 #include <plat/s3c2412.h>
 #include <plat/s3c2416.h>
@@ -55,7 +54,6 @@
 
 /* table of supported CPUs */
 
-static const char name_s3c2400[]  = "S3C2400";
 static const char name_s3c2410[]  = "S3C2410";
 static const char name_s3c2412[]  = "S3C2412";
 static const char name_s3c2416[]  = "S3C2416/S3C2450";
@@ -157,15 +155,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= s3c2443_init,
 		.name		= name_s3c2443,
 	},
-	{
-		.idcode		= 0x0,   /* S3C2400 doesn't have an idcode */
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2400_map_io,
-		.init_clocks	= s3c2400_init_clocks,
-		.init_uarts	= s3c2400_init_uarts,
-		.init		= s3c2400_init,
-		.name		= name_s3c2400
-	},
 };
 
 /* minimal IO mapping */
@@ -200,11 +189,7 @@ static unsigned long s3c24xx_read_idcode_v5(void)
 
 static unsigned long s3c24xx_read_idcode_v4(void)
 {
-#ifndef CONFIG_CPU_S3C2400
 	return __raw_readl(S3C2410_GSTATUS1);
-#else
-	return 0UL;
-#endif
 }
 
 /* Hook for arm_pm_restart to ensure we execute the reset code
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2400.h b/arch/arm/plat-s3c24xx/include/plat/s3c2400.h
deleted file mode 100644
index b3feaea..0000000
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2400.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* linux/include/asm-arm/plat-s3c24xx/s3c2400.h
- *
- * Copyright (c) 2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for S3C2400 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Modifications:
- *     09-Fev-2006 LCVR  First version, based on s3c2410.h
-*/
-
-#ifdef CONFIG_CPU_S3C2400
-
-extern  int s3c2400_init(void);
-
-extern void s3c2400_map_io(void);
-
-extern void s3c2400_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c2400_init_clocks(int xtal);
-
-#else
-#define s3c2400_init_clocks NULL
-#define s3c2400_init_uarts NULL
-#define s3c2400_map_io NULL
-#define s3c2400_init NULL
-#endif
-- 
1.7.0.4
