From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Jan 2013 17:12:11 -0800
Subject: [PATCH 6/6] ARM: S3C24XX: Move mach-s3c2440/ pll into mach-s3c24xx/
In-Reply-To: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
References: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1358817131-27169-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves mach-s3c2440/pll into mach-s3c24xx/
and removes arch/arm/mach-s3c2440/ directory in kernel.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig                                   |    3 --
 arch/arm/Makefile                                  |    2 +-
 arch/arm/mach-s3c2440/Kconfig                      |   29 --------------------
 arch/arm/mach-s3c2440/Makefile                     |   13 ---------
 arch/arm/mach-s3c24xx/Kconfig                      |   26 ++++++++++++++++++
 arch/arm/mach-s3c24xx/Makefile                     |    2 ++
 .../pll-s3c2440-12000000.c}                        |    5 +---
 .../pll-s3c2440-16934400.c}                        |    5 +---
 8 files changed, 31 insertions(+), 54 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2440/Kconfig
 delete mode 100644 arch/arm/mach-s3c2440/Makefile
 rename arch/arm/{mach-s3c2440/s3c2440-pll-12000000.c => mach-s3c24xx/pll-s3c2440-12000000.c} (98%)
 rename arch/arm/{mach-s3c2440/s3c2440-pll-16934400.c => mach-s3c24xx/pll-s3c2440-16934400.c} (99%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5d566bf..f22c510 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1094,9 +1094,6 @@ source "arch/arm/mach-socfpga/Kconfig"
 source "arch/arm/plat-spear/Kconfig"
 
 source "arch/arm/mach-s3c24xx/Kconfig"
-if ARCH_S3C24XX
-source "arch/arm/mach-s3c2440/Kconfig"
-endif
 
 if ARCH_S3C64XX
 source "arch/arm/mach-s3c64xx/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 29e8fae..0935dac 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -173,7 +173,7 @@ machine-$(CONFIG_ARCH_PRIMA2)		+= prima2
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
 machine-$(CONFIG_ARCH_RPC)		+= rpc
-machine-$(CONFIG_ARCH_S3C24XX)		+= s3c24xx s3c2440
+machine-$(CONFIG_ARCH_S3C24XX)		+= s3c24xx
 machine-$(CONFIG_ARCH_S3C64XX)		+= s3c64xx
 machine-$(CONFIG_ARCH_S5P64X0)		+= s5p64x0
 machine-$(CONFIG_ARCH_S5PC100)		+= s5pc100
diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
deleted file mode 100644
index ad06fa2..0000000
--- a/arch/arm/mach-s3c2440/Kconfig
+++ /dev/null
@@ -1,29 +0,0 @@
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-config S3C2440_XTAL_12000000
-	bool
-	help
-	  Indicate that the build needs to support 12MHz system
-	  crystal.
-
-config S3C2440_XTAL_16934400
-	bool
-	help
-	  Indicate that the build needs to support 16.9344MHz system
-	  crystal.
-
-config S3C2440_PLL_12000000
-	bool
-	depends on S3C2440_CPUFREQ && S3C2440_XTAL_12000000
-	default y if CPU_FREQ_S3C24XX_PLL
-	help
-	  PLL tables for S3C2440 or S3C2442 CPUs with 12MHz crystals.
-
-config S3C2440_PLL_16934400
-	bool
-	depends on S3C2440_CPUFREQ && S3C2440_XTAL_16934400
-	default y if CPU_FREQ_S3C24XX_PLL
-	help
-	  PLL tables for S3C2440 or S3C2442 CPUs with 16.934MHz crystals.
diff --git a/arch/arm/mach-s3c2440/Makefile b/arch/arm/mach-s3c2440/Makefile
deleted file mode 100644
index d76e4b9..0000000
--- a/arch/arm/mach-s3c2440/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-# arch/arm/mach-s3c2440/Makefile
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
-obj-$(CONFIG_S3C2440_PLL_12000000) += s3c2440-pll-12000000.o
-obj-$(CONFIG_S3C2440_PLL_16934400) += s3c2440-pll-16934400.o
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index edf6549..67df58b 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -400,6 +400,32 @@ config S3C2440_DMA
 	help
 	  Support for S3C2440 specific DMA code5A
 
+config S3C2440_XTAL_12000000
+	bool
+	help
+	  Indicate that the build needs to support 12MHz system
+	  crystal.
+
+config S3C2440_XTAL_16934400
+	bool
+	help
+	  Indicate that the build needs to support 16.9344MHz system
+	  crystal.
+
+config S3C2440_PLL_12000000
+	bool
+	depends on S3C2440_CPUFREQ && S3C2440_XTAL_12000000
+	default y if CPU_FREQ_S3C24XX_PLL
+	help
+	  PLL tables for S3C2440 or S3C2442 CPUs with 12MHz crystals.
+
+config S3C2440_PLL_16934400
+	bool
+	depends on S3C2440_CPUFREQ && S3C2440_XTAL_16934400
+	default y if CPU_FREQ_S3C24XX_PLL
+	help
+	  PLL tables for S3C2440 or S3C2442 CPUs with 16.934MHz crystals.
+
 comment "S3C2440 Boards"
 
 #
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 6d4b9ad..08b87cd 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -36,6 +36,8 @@ obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
 obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o irq-s3c244x.o clock-s3c244x.o
 obj-$(CONFIG_S3C2440_CPUFREQ)	+= cpufreq-s3c2440.o
 obj-$(CONFIG_S3C2440_DMA)	+= dma-s3c2440.o
+obj-$(CONFIG_S3C2440_PLL_12000000) += pll-s3c2440-12000000.o
+obj-$(CONFIG_S3C2440_PLL_16934400) += pll-s3c2440-16934400.o
 
 obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o irq-s3c2443.o clock-s3c2443.o
 
diff --git a/arch/arm/mach-s3c2440/s3c2440-pll-12000000.c b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
similarity index 98%
rename from arch/arm/mach-s3c2440/s3c2440-pll-12000000.c
rename to arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
index 551fb43..6737817 100644
--- a/arch/arm/mach-s3c2440/s3c2440-pll-12000000.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
@@ -1,5 +1,4 @@
-/* arch/arm/mach-s3c2440/s3c2440-pll-12000000.c
- *
+/*
  * Copyright (c) 2006-2007 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
@@ -83,7 +82,6 @@ static int __init s3c2440_pll_12mhz(void)
 	return subsys_interface_register(&s3c2440_plls12_interface);
 
 }
-
 arch_initcall(s3c2440_pll_12mhz);
 
 static struct subsys_interface s3c2442_plls12_interface = {
@@ -97,5 +95,4 @@ static int __init s3c2442_pll_12mhz(void)
 	return subsys_interface_register(&s3c2442_plls12_interface);
 
 }
-
 arch_initcall(s3c2442_pll_12mhz);
diff --git a/arch/arm/mach-s3c2440/s3c2440-pll-16934400.c b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
similarity index 99%
rename from arch/arm/mach-s3c2440/s3c2440-pll-16934400.c
rename to arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
index 3f15bcf..debfa10 100644
--- a/arch/arm/mach-s3c2440/s3c2440-pll-16934400.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
@@ -1,5 +1,4 @@
-/* arch/arm/mach-s3c2440/s3c2440-pll-16934400.c
- *
+/*
  * Copyright (c) 2006-2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
@@ -111,7 +110,6 @@ static int __init s3c2440_pll_16934400(void)
 {
 	return subsys_interface_register(&s3c2440_plls169344_interface);
 }
-
 arch_initcall(s3c2440_pll_16934400);
 
 static struct subsys_interface s3c2442_plls169344_interface = {
@@ -124,5 +122,4 @@ static int __init s3c2442_pll_16934400(void)
 {
 	return subsys_interface_register(&s3c2442_plls169344_interface);
 }
-
 arch_initcall(s3c2442_pll_16934400);
-- 
1.7.10.4
