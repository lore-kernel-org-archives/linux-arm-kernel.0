From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 21:48:35 +0900
Subject: [PATCH 11/12] ARM: restart: S3C24XX: move SWRST based S3C platforms
 to machine_desc hook
In-Reply-To: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1324385316-6052-12-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko@sntech.de>

S3C2412/S3C2416/S3C2443 use a special register to signal the reset to
the processor and used therefore the s3c24xx_reset_hook mechanism in the
s3c24xx-specific arch reset.

This patch introduces restart functions for these architectures,
moves the board files to them and removes the s3c24xx_reset_hook
infrastructure, as all users are gone.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/include/mach/reset.h        |   22 ---------------------
 arch/arm/mach-s3c2410/include/mach/system-reset.h |    5 ----
 arch/arm/mach-s3c2410/include/mach/system.h       |    2 -
 arch/arm/mach-s3c2412/mach-jive.c                 |    2 +
 arch/arm/mach-s3c2412/mach-smdk2413.c             |    3 ++
 arch/arm/mach-s3c2412/mach-vstms.c                |    1 +
 arch/arm/mach-s3c2412/s3c2412.c                   |   10 +++-----
 arch/arm/mach-s3c2416/mach-smdk2416.c             |    1 +
 arch/arm/mach-s3c2416/s3c2416.c                   |    7 +++--
 arch/arm/mach-s3c2443/mach-smdk2443.c             |    1 +
 arch/arm/mach-s3c2443/s3c2443.c                   |    8 +++---
 arch/arm/plat-samsung/include/plat/s3c2412.h      |    3 ++
 arch/arm/plat-samsung/include/plat/s3c2416.h      |    2 +
 arch/arm/plat-samsung/include/plat/s3c2443.h      |    2 +
 14 files changed, 27 insertions(+), 42 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/reset.h

diff --git a/arch/arm/mach-s3c2410/include/mach/reset.h b/arch/arm/mach-s3c2410/include/mach/reset.h
deleted file mode 100644
index f8c9387..0000000
--- a/arch/arm/mach-s3c2410/include/mach/reset.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/reset.h
- *
- * Copyright (c) 2007 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2410 CPU reset controls
-*/
-
-#ifndef __ASM_ARCH_RESET_H
-#define __ASM_ARCH_RESET_H __FILE__
-
-/* This allows the over-ride of the default reset code
-*/
-
-extern void (*s3c24xx_reset_hook)(void);
-
-#endif /* __ASM_ARCH_RESET_H */
diff --git a/arch/arm/mach-s3c2410/include/mach/system-reset.h b/arch/arm/mach-s3c2410/include/mach/system-reset.h
index 913893d..1e495f3 100644
--- a/arch/arm/mach-s3c2410/include/mach/system-reset.h
+++ b/arch/arm/mach-s3c2410/include/mach/system-reset.h
@@ -13,8 +13,6 @@
 #include <mach/hardware.h>
 #include <plat/watchdog-reset.h>
 
-extern void (*s3c24xx_reset_hook)(void);
-
 static void
 arch_reset(char mode, const char *cmd)
 {
@@ -22,9 +20,6 @@ arch_reset(char mode, const char *cmd)
 		soft_restart(0);
 	}
 
-	if (s3c24xx_reset_hook)
-		s3c24xx_reset_hook();
-
 	arch_wdt_reset();
 
 	/* we'll take a jump through zero as a poor second */
diff --git a/arch/arm/mach-s3c2410/include/mach/system.h b/arch/arm/mach-s3c2410/include/mach/system.h
index a8cbca6..eef8f24 100644
--- a/arch/arm/mach-s3c2410/include/mach/system.h
+++ b/arch/arm/mach-s3c2410/include/mach/system.h
@@ -15,12 +15,10 @@
 
 #include <mach/map.h>
 #include <mach/idle.h>
-#include <mach/reset.h>
 
 #include <mach/regs-clock.h>
 
 void (*s3c24xx_idle)(void);
-void (*s3c24xx_reset_hook)(void);
 
 void s3c24xx_default_idle(void)
 {
diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
index 286ef17..ae73ba3 100644
--- a/arch/arm/mach-s3c2412/mach-jive.c
+++ b/arch/arm/mach-s3c2412/mach-jive.c
@@ -48,6 +48,7 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
+#include <plat/s3c2412.h>
 #include <plat/gpio-cfg.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
@@ -661,4 +662,5 @@ MACHINE_START(JIVE, "JIVE")
 	.map_io		= jive_map_io,
 	.init_machine	= jive_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2412_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2412/mach-smdk2413.c b/arch/arm/mach-s3c2412/mach-smdk2413.c
index f1eec1b..b11451b 100644
--- a/arch/arm/mach-s3c2412/mach-smdk2413.c
+++ b/arch/arm/mach-s3c2412/mach-smdk2413.c
@@ -134,6 +134,7 @@ MACHINE_START(S3C2413, "S3C2413")
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2412_restart,
 MACHINE_END
 
 MACHINE_START(SMDK2412, "SMDK2412")
@@ -145,6 +146,7 @@ MACHINE_START(SMDK2412, "SMDK2412")
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2412_restart,
 MACHINE_END
 
 MACHINE_START(SMDK2413, "SMDK2413")
@@ -156,4 +158,5 @@ MACHINE_START(SMDK2413, "SMDK2413")
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2412_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2412/mach-vstms.c b/arch/arm/mach-s3c2412/mach-vstms.c
index 1bbb1ef..94bfaa1 100644
--- a/arch/arm/mach-s3c2412/mach-vstms.c
+++ b/arch/arm/mach-s3c2412/mach-vstms.c
@@ -162,4 +162,5 @@ MACHINE_START(VSTMS, "VSTMS")
 	.init_machine	= vstms_init,
 	.map_io		= vstms_map_io,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2412_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2412/s3c2412.c b/arch/arm/mach-s3c2412/s3c2412.c
index 57a1e01..867ce2e 100644
--- a/arch/arm/mach-s3c2412/s3c2412.c
+++ b/arch/arm/mach-s3c2412/s3c2412.c
@@ -32,7 +32,6 @@
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
 
-#include <mach/reset.h>
 #include <mach/idle.h>
 
 #include <plat/cpu-freq.h>
@@ -131,8 +130,11 @@ static void s3c2412_idle(void)
 	cpu_do_idle();
 }
 
-static void s3c2412_hard_reset(void)
+void s3c2412_restart(char mode, const char *cmd)
 {
+	if (mode == 's')
+		soft_restart(0);
+
 	/* errata "Watch-dog/Software Reset Problem" specifies that
 	 * this reset must be done with the SYSCLK sourced from
 	 * EXTCLK instead of FOUT to avoid a glitch in the reset
@@ -164,10 +166,6 @@ void __init s3c2412_map_io(void)
 
 	s3c24xx_idle = s3c2412_idle;
 
-	/* set custom reset hook */
-
-	s3c24xx_reset_hook = s3c2412_hard_reset;
-
 	/* register our io-tables */
 
 	iotable_init(s3c2412_iodesc, ARRAY_SIZE(s3c2412_iodesc));
diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
index a9eee53..66b7173 100644
--- a/arch/arm/mach-s3c2416/mach-smdk2416.c
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
@@ -251,4 +251,5 @@ MACHINE_START(SMDK2416, "SMDK2416")
 	.map_io		= smdk2416_map_io,
 	.init_machine	= smdk2416_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2416_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index ee214bc..4606223 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -44,7 +44,6 @@
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
 
-#include <mach/reset.h>
 #include <mach/idle.h>
 #include <mach/regs-s3c2443-clock.h>
 
@@ -76,8 +75,11 @@ static struct sys_device s3c2416_sysdev = {
 	.cls		= &s3c2416_sysclass,
 };
 
-static void s3c2416_hard_reset(void)
+void s3c2416_restart(char mode, const char *cmd)
 {
+	if (mode == 's')
+		soft_restart(0);
+
 	__raw_writel(S3C2443_SWRST_RESET, S3C2443_SWRST);
 }
 
@@ -85,7 +87,6 @@ int __init s3c2416_init(void)
 {
 	printk(KERN_INFO "S3C2416: Initializing architecture\n");
 
-	s3c24xx_reset_hook = s3c2416_hard_reset;
 	/* s3c24xx_idle = s3c2416_idle;	*/
 
 	/* change WDT IRQ number */
diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-s3c2443/mach-smdk2443.c
index bec107e..2092369 100644
--- a/arch/arm/mach-s3c2443/mach-smdk2443.c
+++ b/arch/arm/mach-s3c2443/mach-smdk2443.c
@@ -145,4 +145,5 @@ MACHINE_START(SMDK2443, "SMDK2443")
 	.map_io		= smdk2443_map_io,
 	.init_machine	= smdk2443_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c2443_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2443/s3c2443.c b/arch/arm/mach-s3c2443/s3c2443.c
index a22b771..4568ded 100644
--- a/arch/arm/mach-s3c2443/s3c2443.c
+++ b/arch/arm/mach-s3c2443/s3c2443.c
@@ -31,7 +31,6 @@
 #include <asm/irq.h>
 
 #include <mach/regs-s3c2443-clock.h>
-#include <mach/reset.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
@@ -57,8 +56,11 @@ static struct sys_device s3c2443_sysdev = {
 	.cls		= &s3c2443_sysclass,
 };
 
-static void s3c2443_hard_reset(void)
+void s3c2443_restart(char mode, const char *cmd)
 {
+	if (mode == 's')
+		soft_restart(0);
+
 	__raw_writel(S3C2443_SWRST_RESET, S3C2443_SWRST);
 }
 
@@ -66,8 +68,6 @@ int __init s3c2443_init(void)
 {
 	printk("S3C2443: Initialising architecture\n");
 
-	s3c24xx_reset_hook = s3c2443_hard_reset;
-
 	s3c_nand_setname("s3c2412-nand");
 	s3c_fb_setname("s3c2443-fb");
 
diff --git a/arch/arm/plat-samsung/include/plat/s3c2412.h b/arch/arm/plat-samsung/include/plat/s3c2412.h
index 5bcfd14..cbae50d 100644
--- a/arch/arm/plat-samsung/include/plat/s3c2412.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2412.h
@@ -21,9 +21,12 @@ extern void s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s3c2412_init_clocks(int xtal);
 
 extern  int s3c2412_baseclk_add(void);
+
+extern void s3c2412_restart(char mode, const char *cmd);
 #else
 #define s3c2412_init_clocks NULL
 #define s3c2412_init_uarts NULL
 #define s3c2412_map_io NULL
 #define s3c2412_init NULL
+#define s3c2412_restart NULL
 #endif
diff --git a/arch/arm/plat-samsung/include/plat/s3c2416.h b/arch/arm/plat-samsung/include/plat/s3c2416.h
index a764f85..de2b5bd 100644
--- a/arch/arm/plat-samsung/include/plat/s3c2416.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2416.h
@@ -23,9 +23,11 @@ extern void s3c2416_init_clocks(int xtal);
 
 extern  int s3c2416_baseclk_add(void);
 
+extern void s3c2416_restart(char mode, const char *cmd);
 #else
 #define s3c2416_init_clocks NULL
 #define s3c2416_init_uarts NULL
 #define s3c2416_map_io NULL
 #define s3c2416_init NULL
+#define s3c2416_restart NULL
 #endif
diff --git a/arch/arm/plat-samsung/include/plat/s3c2443.h b/arch/arm/plat-samsung/include/plat/s3c2443.h
index 7fae1a0..dce05b4 100644
--- a/arch/arm/plat-samsung/include/plat/s3c2443.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2443.h
@@ -24,11 +24,13 @@ extern void s3c2443_init_clocks(int xtal);
 
 extern  int s3c2443_baseclk_add(void);
 
+extern void s3c2443_restart(char mode, const char *cmd);
 #else
 #define s3c2443_init_clocks NULL
 #define s3c2443_init_uarts NULL
 #define s3c2443_map_io NULL
 #define s3c2443_init NULL
+#define s3c2443_restart NULL
 #endif
 
 /* common code used by s3c2443 and others.
-- 
1.7.4.4
