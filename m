From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Jan 2013 17:12:07 -0800
Subject: [PATCH 2/6] ARM: S3C24XX: Move mach-s3c2410/ pll into mach-s3c24xx/
In-Reply-To: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
References: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1358817131-27169-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves mach-s3c2410/pll into mach-s3c24xx/
and removes arch/arm/mach-s3c2410/ directory in kernel.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/Kconfig                             |   13 -------------
 arch/arm/mach-s3c2410/Makefile                            |   13 -------------
 arch/arm/mach-s3c24xx/Kconfig                             |    7 +++++++
 arch/arm/mach-s3c24xx/Makefile                            |    1 +
 .../{mach-s3c2410/pll.c => mach-s3c24xx/pll-s3c2410.c}    |    5 +----
 5 files changed, 9 insertions(+), 30 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/Kconfig
 delete mode 100644 arch/arm/mach-s3c2410/Makefile
 rename arch/arm/{mach-s3c2410/pll.c => mach-s3c24xx/pll-s3c2410.c} (99%)

diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
deleted file mode 100644
index 910b8d2..0000000
--- a/arch/arm/mach-s3c2410/Kconfig
+++ /dev/null
@@ -1,13 +0,0 @@
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-# cpu frequency scaling support
-
-config S3C2410_PLLTABLE
-	bool
-	depends on S3C2410_CPUFREQ && CPU_FREQ_S3C24XX_PLL
-	default y
-	help
-	  Select the PLL table for the S3C2410
-
diff --git a/arch/arm/mach-s3c2410/Makefile b/arch/arm/mach-s3c2410/Makefile
deleted file mode 100644
index 2a160a5..0000000
--- a/arch/arm/mach-s3c2410/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-# arch/arm/mach-s3c2410/Makefile
-#
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-obj-y				:=
-obj-m				:=
-obj-n				:=
-obj-				:=
-
-obj-$(CONFIG_S3C2410_PLLTABLE)	+= pll.o
-
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 04921b9..5cc740c 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -134,6 +134,13 @@ config S3C2410_CPUFREQ
 	help
 	  CPU Frequency scaling support for S3C2410
 
+config S3C2410_PLL
+	bool
+	depends on S3C2410_CPUFREQ && CPU_FREQ_S3C24XX_PLL
+	default y
+	help
+	  Select the PLL table for the S3C2410
+
 config S3C24XX_SIMTEC_NOR
 	bool
 	help
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 3c9fd51..ecace54 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -19,6 +19,7 @@ obj-y				+= common.o
 obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
 obj-$(CONFIG_S3C2410_CPUFREQ)	+= cpufreq-s3c2410.o
 obj-$(CONFIG_S3C2410_DMA)	+= dma-s3c2410.o
+obj-$(CONFIG_S3C2410_PLL)	+= pll-s3c2410.o
 obj-$(CONFIG_S3C2410_PM)	+= pm-s3c2410.o sleep-s3c2410.o
 
 obj-$(CONFIG_CPU_S3C2412)	+= s3c2412.o irq-s3c2412.o clock-s3c2412.o
diff --git a/arch/arm/mach-s3c2410/pll.c b/arch/arm/mach-s3c24xx/pll-s3c2410.c
similarity index 99%
rename from arch/arm/mach-s3c2410/pll.c
rename to arch/arm/mach-s3c24xx/pll-s3c2410.c
index e0b3b34..dcf3420 100644
--- a/arch/arm/mach-s3c2410/pll.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2410.c
@@ -1,5 +1,4 @@
-/* arch/arm/mach-s3c2410/pll.c
- *
+/*
  * Copyright (c) 2006-2007 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
@@ -82,7 +81,6 @@ static int __init s3c2410_pll_init(void)
 	return subsys_interface_register(&s3c2410_plls_interface);
 
 }
-
 arch_initcall(s3c2410_pll_init);
 
 static struct subsys_interface s3c2410a_plls_interface = {
@@ -95,5 +93,4 @@ static int __init s3c2410a_pll_init(void)
 {
 	return subsys_interface_register(&s3c2410a_plls_interface);
 }
-
 arch_initcall(s3c2410a_pll_init);
-- 
1.7.10.4
