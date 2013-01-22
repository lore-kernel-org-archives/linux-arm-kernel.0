From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Jan 2013 17:12:09 -0800
Subject: [PATCH 4/6] ARM: S3C24XX: Move mach-s3c2412/ cpufreq driver into
 mach-s3c24xx/
In-Reply-To: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
References: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1358817131-27169-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves mach-s3c2412/cpufreq driver into mach-s3c24xx/
and removes arch/arm/mach-s3c2412/ directory in kernel.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig                                          |    1 -
 arch/arm/Makefile                                         |    2 +-
 arch/arm/mach-s3c2412/Kconfig                             |   13 -------------
 arch/arm/mach-s3c2412/Makefile                            |   12 ------------
 arch/arm/mach-s3c24xx/Kconfig                             |    8 ++++++++
 arch/arm/mach-s3c24xx/Makefile                            |    1 +
 .../cpu-freq.c => mach-s3c24xx/cpufreq-s3c2412.c}         |    6 ++----
 7 files changed, 12 insertions(+), 31 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2412/Kconfig
 delete mode 100644 arch/arm/mach-s3c2412/Makefile
 rename arch/arm/{mach-s3c2412/cpu-freq.c => mach-s3c24xx/cpufreq-s3c2412.c} (99%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f95ba14..5d566bf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1095,7 +1095,6 @@ source "arch/arm/plat-spear/Kconfig"
 
 source "arch/arm/mach-s3c24xx/Kconfig"
 if ARCH_S3C24XX
-source "arch/arm/mach-s3c2412/Kconfig"
 source "arch/arm/mach-s3c2440/Kconfig"
 endif
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30c443c..29e8fae 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -173,7 +173,7 @@ machine-$(CONFIG_ARCH_PRIMA2)		+= prima2
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
 machine-$(CONFIG_ARCH_RPC)		+= rpc
-machine-$(CONFIG_ARCH_S3C24XX)		+= s3c24xx s3c2412 s3c2440
+machine-$(CONFIG_ARCH_S3C24XX)		+= s3c24xx s3c2440
 machine-$(CONFIG_ARCH_S3C64XX)		+= s3c64xx
 machine-$(CONFIG_ARCH_S5P64X0)		+= s5p64x0
 machine-$(CONFIG_ARCH_S5PC100)		+= s5pc100
diff --git a/arch/arm/mach-s3c2412/Kconfig b/arch/arm/mach-s3c2412/Kconfig
deleted file mode 100644
index 495f692..0000000
--- a/arch/arm/mach-s3c2412/Kconfig
+++ /dev/null
@@ -1,13 +0,0 @@
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-# Note, the S3C2412 IOtiming support is in plat-s3c24xx
-
-config S3C2412_CPUFREQ
-	bool
-	depends on CPU_FREQ_S3C24XX && CPU_S3C2412
-	default y
-	select S3C2412_IOTIMING
-	help
-	  CPU Frequency scaling support for S3C2412 and S3C2413 SoC CPUs.
diff --git a/arch/arm/mach-s3c2412/Makefile b/arch/arm/mach-s3c2412/Makefile
deleted file mode 100644
index 41a6c27..0000000
--- a/arch/arm/mach-s3c2412/Makefile
+++ /dev/null
@@ -1,12 +0,0 @@
-# arch/arm/mach-s3c2412/Makefile
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
-obj-$(CONFIG_S3C2412_CPUFREQ)	+= cpu-freq.o
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 5cc740c..f1d3951 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -280,6 +280,14 @@ config CPU_S3C2412_ONLY
 		   !CPU_S3C2443 && CPU_S3C2412
 	default y
 
+config S3C2412_CPUFREQ
+	bool
+	depends on CPU_FREQ_S3C24XX && CPU_S3C2412
+	default y
+	select S3C2412_IOTIMING
+	help
+	  CPU Frequency scaling support for S3C2412 and S3C2413 SoC CPUs.
+
 config S3C2412_DMA
 	bool
 	help
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index ecace54..0f042d1 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_S3C2410_PLL)	+= pll-s3c2410.o
 obj-$(CONFIG_S3C2410_PM)	+= pm-s3c2410.o sleep-s3c2410.o
 
 obj-$(CONFIG_CPU_S3C2412)	+= s3c2412.o irq-s3c2412.o clock-s3c2412.o
+obj-$(CONFIG_S3C2412_CPUFREQ)	+= cpufreq-s3c2412.o
 obj-$(CONFIG_S3C2412_DMA)	+= dma-s3c2412.o
 obj-$(CONFIG_S3C2412_PM)	+= pm-s3c2412.o
 obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep-s3c2412.o
diff --git a/arch/arm/mach-s3c2412/cpu-freq.c b/arch/arm/mach-s3c24xx/cpufreq-s3c2412.c
similarity index 99%
rename from arch/arm/mach-s3c2412/cpu-freq.c
rename to arch/arm/mach-s3c24xx/cpufreq-s3c2412.c
index 125be7d..c8f05f3 100644
--- a/arch/arm/mach-s3c2412/cpu-freq.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-s3c2412.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-s3c2412/cpu-freq.c
- *
+/*
  * Copyright 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
@@ -111,7 +110,7 @@ static int s3c2412_cpufreq_calcdivs(struct s3c_cpufreq_config *cfg)
 
 	return 0;
 
- invalid:
+invalid:
 	return -EINVAL;
 }
 
@@ -255,5 +254,4 @@ static int s3c2412_cpufreq_init(void)
 {
 	return subsys_interface_register(&s3c2412_cpufreq_interface);
 }
-
 arch_initcall(s3c2412_cpufreq_init);
-- 
1.7.10.4
