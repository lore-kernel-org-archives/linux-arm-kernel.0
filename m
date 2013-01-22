From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Jan 2013 17:12:06 -0800
Subject: [PATCH 1/6] ARM: S3C24XX: Move mach-s3c2410/ cpufreq into
 mach-s3c24xx/
In-Reply-To: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
References: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1358817131-27169-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basically, the cpufreq driver for s3c2410 should be implemented into
drivers/cpufreq, but we don't need to keep the mach-s3c2410 directory.
So this patch moves current cpufreq driver into mach-s3c24xx/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/Kconfig                                   |    7 -------
 arch/arm/mach-s3c2410/Makefile                                  |    1 -
 arch/arm/mach-s3c24xx/Kconfig                                   |    7 +++++++
 arch/arm/mach-s3c24xx/Makefile                                  |    1 +
 .../{mach-s3c2410/cpu-freq.c => mach-s3c24xx/cpufreq-s3c2410.c} |    7 ++-----
 5 files changed, 10 insertions(+), 13 deletions(-)
 rename arch/arm/{mach-s3c2410/cpu-freq.c => mach-s3c24xx/cpufreq-s3c2410.c} (98%)

diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
index 68d89cb..910b8d2 100644
--- a/arch/arm/mach-s3c2410/Kconfig
+++ b/arch/arm/mach-s3c2410/Kconfig
@@ -4,13 +4,6 @@
 
 # cpu frequency scaling support
 
-config S3C2410_CPUFREQ
-	bool
-	depends on CPU_FREQ_S3C24XX && CPU_S3C2410
-	select S3C2410_CPUFREQ_UTILS
-	help
-	  CPU Frequency scaling support for S3C2410
-
 config S3C2410_PLLTABLE
 	bool
 	depends on S3C2410_CPUFREQ && CPU_FREQ_S3C24XX_PLL
diff --git a/arch/arm/mach-s3c2410/Makefile b/arch/arm/mach-s3c2410/Makefile
index 6b9a316..2a160a5 100644
--- a/arch/arm/mach-s3c2410/Makefile
+++ b/arch/arm/mach-s3c2410/Makefile
@@ -9,6 +9,5 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-obj-$(CONFIG_S3C2410_CPUFREQ)	+= cpu-freq.o
 obj-$(CONFIG_S3C2410_PLLTABLE)	+= pll.o
 
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 25df14a..04921b9 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -127,6 +127,13 @@ config S3C2410_PM
 
 if CPU_S3C2410
 
+config S3C2410_CPUFREQ
+	bool
+	depends on CPU_FREQ_S3C24XX && CPU_S3C2410
+	select S3C2410_CPUFREQ_UTILS
+	help
+	  CPU Frequency scaling support for S3C2410
+
 config S3C24XX_SIMTEC_NOR
 	bool
 	help
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 0ab6ab1..3c9fd51 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -17,6 +17,7 @@ obj-				:=
 obj-y				+= common.o
 
 obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
+obj-$(CONFIG_S3C2410_CPUFREQ)	+= cpufreq-s3c2410.o
 obj-$(CONFIG_S3C2410_DMA)	+= dma-s3c2410.o
 obj-$(CONFIG_S3C2410_PM)	+= pm-s3c2410.o sleep-s3c2410.o
 
diff --git a/arch/arm/mach-s3c2410/cpu-freq.c b/arch/arm/mach-s3c24xx/cpufreq-s3c2410.c
similarity index 98%
rename from arch/arm/mach-s3c2410/cpu-freq.c
rename to arch/arm/mach-s3c24xx/cpufreq-s3c2410.c
index 5404535..cfa0dd8 100644
--- a/arch/arm/mach-s3c2410/cpu-freq.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-s3c2410.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-s3c2410/cpu-freq.c
- *
+/*
  * Copyright (c) 2006-2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
@@ -81,7 +80,7 @@ static int s3c2410_cpufreq_calcdivs(struct s3c_cpufreq_config *cfg)
 	cfg->divs.p_divisor = pdiv;
 	cfg->divs.h_divisor = hdiv;
 
-	return 0      ;
+	return 0;
 }
 
 static struct s3c_cpufreq_info s3c2410_cpufreq_info = {
@@ -131,7 +130,6 @@ static int __init s3c2410_cpufreq_init(void)
 {
 	return subsys_interface_register(&s3c2410_cpufreq_interface);
 }
-
 arch_initcall(s3c2410_cpufreq_init);
 
 static int s3c2410a_cpufreq_add(struct device *dev,
@@ -159,5 +157,4 @@ static int __init s3c2410a_cpufreq_init(void)
 {
 	return subsys_interface_register(&s3c2410a_cpufreq_interface);
 }
-
 arch_initcall(s3c2410a_cpufreq_init);
-- 
1.7.10.4
