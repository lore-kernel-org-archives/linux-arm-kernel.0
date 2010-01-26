From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:03:01 +0000
Subject: [PATCH] ARM: S3C64XX: Merge s3c6400-init.c into cpu.c
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-11-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since this file is small, and is compiled for both systems in this
architecture merge it into the cpu support file and remove the original
instead of moving it.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/Kconfig        |    2 --
 arch/arm/mach-s3c64xx/cpu.c          |    6 ++++++
 arch/arm/plat-s3c64xx/Kconfig        |    6 ------
 arch/arm/plat-s3c64xx/Makefile       |    1 -
 arch/arm/plat-s3c64xx/s3c6400-init.c |   29 -----------------------------
 5 files changed, 6 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/plat-s3c64xx/s3c6400-init.c

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 15e065e..495b6e3 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -7,14 +7,12 @@
 
 config CPU_S3C6400
 	bool
-	select CPU_S3C6400_INIT
 	select CPU_S3C6400_CLOCK
 	help
 	  Enable S3C6400 CPU support
 
 config CPU_S3C6410
 	bool
-	select CPU_S3C6400_INIT
 	select CPU_S3C6400_CLOCK
 	help
 	  Enable S3C6410 CPU support
diff --git a/arch/arm/mach-s3c64xx/cpu.c b/arch/arm/mach-s3c64xx/cpu.c
index 410d688..374e45e 100644
--- a/arch/arm/mach-s3c64xx/cpu.c
+++ b/arch/arm/mach-s3c64xx/cpu.c
@@ -129,6 +129,12 @@ static struct sys_device s3c64xx_sysdev = {
 	.cls	= &s3c64xx_sysclass,
 };
 
+/* uart registration process */
+
+void __init s3c6400_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	s3c24xx_init_uartdevs("s3c6400-uart", s3c64xx_uart_resources, cfg, no);
+}
 
 /* read cpu identification code */
 
diff --git a/arch/arm/plat-s3c64xx/Kconfig b/arch/arm/plat-s3c64xx/Kconfig
index 4edb580..6998f85 100644
--- a/arch/arm/plat-s3c64xx/Kconfig
+++ b/arch/arm/plat-s3c64xx/Kconfig
@@ -30,12 +30,6 @@ if PLAT_S3C64XX
 
 # Configuration options shared by all S3C64XX implementations
 
-config CPU_S3C6400_INIT
-	bool
-	help
-	  Common initialisation code for the S3C6400 that is shared
-	  by other CPUs in the series, such as the S3C6410.
-
 config CPU_S3C6400_CLOCK
 	bool
 	help
diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index 60d7990..1d9513c 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -12,7 +12,6 @@ obj-				:=
 
 # CPU support
 
-obj-$(CONFIG_CPU_S3C6400_INIT)	+= s3c6400-init.o
 obj-$(CONFIG_CPU_S3C6400_CLOCK)	+= s3c6400-clock.o
 obj-$(CONFIG_CPU_FREQ_S3C64XX)  += cpufreq.o
 
diff --git a/arch/arm/plat-s3c64xx/s3c6400-init.c b/arch/arm/plat-s3c64xx/s3c6400-init.c
deleted file mode 100644
index e64caa4..0000000
--- a/arch/arm/plat-s3c64xx/s3c6400-init.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/* linux/arch/arm/plat-s3c64xx/s3c6400-init.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C6400 - CPU initialisation (common with other S3C64XX chips)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <mach/s3c6400.h>
-#include <mach/s3c6410.h>
-
-/* uart registration process */
-
-void __init s3c6400_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	s3c24xx_init_uartdevs("s3c6400-uart", s3c64xx_uart_resources, cfg, no);
-}
-- 
1.6.0.4
