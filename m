From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:58:05 +0000
Subject: [PATCH] ARM: S3C24XX: Move S3C2440/S3C2442 support from plat-s3c24xx
	to mach-s3c2440
In-Reply-To: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
References: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264492686-16901-7-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the old common S3C2440 and S3C2442 SoC support from plat-s3c24xx
into mach-s3c2440 now this directory is serving both SoCs.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2440/Kconfig                      |   42 ++++++++++++++++++++
 arch/arm/mach-s3c2440/Makefile                     |    8 ++++
 .../{plat-s3c24xx => mach-s3c2440}/s3c244x-clock.c |    0
 .../{plat-s3c24xx => mach-s3c2440}/s3c244x-irq.c   |    0
 arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c244x.c  |    2 +-
 arch/arm/plat-s3c24xx/Kconfig                      |   41 -------------------
 arch/arm/plat-s3c24xx/Makefile                     |    7 ---
 arch/arm/plat-s3c24xx/cpu.c                        |    2 +-
 arch/arm/plat-s3c24xx/{ => include/plat}/s3c244x.h |    2 +-
 9 files changed, 53 insertions(+), 51 deletions(-)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c244x-clock.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c244x-irq.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c244x.c (99%)
 rename arch/arm/plat-s3c24xx/{ => include/plat}/s3c244x.h (92%)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index f496385..7f46526 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -27,6 +27,48 @@ config CPU_S3C2442
 	help
 	  Support for S3C2442 Samsung Mobile CPU based systems.
 
+config CPU_S3C244X
+	bool
+	depends on ARCH_S3C2410 && (CPU_S3C2440 || CPU_S3C2442)
+	help
+	  Support for S3C2440 and S3C2442 Samsung Mobile CPU based systems.
+
+
+
+config S3C2440_CPUFREQ
+	bool "S3C2440/S3C2442 CPU Frequency scaling support"
+	depends on CPU_FREQ_S3C24XX && (CPU_S3C2440 || CPU_S3C2442)
+	select S3C2410_CPUFREQ_UTILS
+	default y
+	help
+	  CPU Frequency scaling support for S3C2440 and S3C2442 SoC CPUs.
+
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
 config S3C2440_DMA
 	bool
 	depends on ARCH_S3C2410 && CPU_S3C24405B
diff --git a/arch/arm/mach-s3c2440/Makefile b/arch/arm/mach-s3c2440/Makefile
index e8412b3..c85ba32 100644
--- a/arch/arm/mach-s3c2440/Makefile
+++ b/arch/arm/mach-s3c2440/Makefile
@@ -16,6 +16,14 @@ obj-$(CONFIG_CPU_S3C2440)	+= irq.o
 obj-$(CONFIG_CPU_S3C2440)	+= clock.o
 obj-$(CONFIG_S3C2440_DMA)	+= dma.o
 
+obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o
+obj-$(CONFIG_CPU_S3C244X)	+= s3c244x-irq.o
+obj-$(CONFIG_CPU_S3C244X)	+= s3c244x-clock.o
+obj-$(CONFIG_S3C2440_CPUFREQ)	+= s3c2440-cpufreq.o
+
+obj-$(CONFIG_S3C2440_PLL_12000000) += s3c2440-pll-12000000.o
+obj-$(CONFIG_S3C2440_PLL_16934400) += s3c2440-pll-16934400.o
+
 # Machine support
 
 obj-$(CONFIG_MACH_ANUBIS)	+= mach-anubis.o
diff --git a/arch/arm/plat-s3c24xx/s3c244x-clock.c b/arch/arm/mach-s3c2440/s3c244x-clock.c
similarity index 100%
rename from arch/arm/plat-s3c24xx/s3c244x-clock.c
rename to arch/arm/mach-s3c2440/s3c244x-clock.c
diff --git a/arch/arm/plat-s3c24xx/s3c244x-irq.c b/arch/arm/mach-s3c2440/s3c244x-irq.c
similarity index 100%
rename from arch/arm/plat-s3c24xx/s3c244x-irq.c
rename to arch/arm/mach-s3c2440/s3c244x-irq.c
diff --git a/arch/arm/plat-s3c24xx/s3c244x.c b/arch/arm/mach-s3c2440/s3c244x.c
similarity index 99%
rename from arch/arm/plat-s3c24xx/s3c244x.c
rename to arch/arm/mach-s3c2440/s3c244x.c
index 12623a4..46e13db 100644
--- a/arch/arm/plat-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c2440/s3c244x.c
@@ -39,7 +39,7 @@
 
 #include <plat/s3c2410.h>
 #include <plat/s3c2440.h>
-#include "s3c244x.h"
+#include <plat/s3c244x.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index a806f35..0cc5760 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -27,46 +27,6 @@ config S3C24XX_DCLK
 	help
 	  Clock code for supporting DCLK/CLKOUT on S3C24XX architectures
 
-config CPU_S3C244X
-	bool
-	depends on ARCH_S3C2410 && (CPU_S3C2440 || CPU_S3C2442)
-	help
-	  Support for S3C2440 and S3C2442 Samsung Mobile CPU based systems.
-
-config S3C2440_CPUFREQ
-	bool "S3C2440/S3C2442 CPU Frequency scaling support"
-	depends on CPU_FREQ_S3C24XX && (CPU_S3C2440 || CPU_S3C2442)
-	select S3C2410_CPUFREQ_UTILS
-	default y
-	help
-	  CPU Frequency scaling support for S3C2440 and S3C2442 SoC CPUs.
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
-
 config S3C24XX_PWM
 	bool "PWM device support"
 	select HAVE_PWM
@@ -74,7 +34,6 @@ config S3C24XX_PWM
 	  Support for exporting the PWM timer blocks via the pwm device
 	  system.
 
-
 # gpio configurations
 
 config S3C24XX_GPIO_EXTRA
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index e010026..c2237c4 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -25,13 +25,6 @@ obj-$(CONFIG_CPU_FREQ_S3C24XX_DEBUGFS) += cpu-freq-debugfs.o
 
 # Architecture dependant builds
 
-obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o
-obj-$(CONFIG_CPU_S3C244X)	+= s3c244x-irq.o
-obj-$(CONFIG_CPU_S3C244X)	+= s3c244x-clock.o
-obj-$(CONFIG_S3C2440_CPUFREQ)	+= s3c2440-cpufreq.o
-obj-$(CONFIG_S3C2440_PLL_12000000) += s3c2440-pll-12000000.o
-obj-$(CONFIG_S3C2440_PLL_16934400) += s3c2440-pll-16934400.o
-
 obj-$(CONFIG_PM_SIMTEC)		+= pm-simtec.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM)		+= irq-pm.o
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 4af9dd9..6ecf87a 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -49,7 +49,7 @@
 #include <plat/s3c2400.h>
 #include <plat/s3c2410.h>
 #include <plat/s3c2412.h>
-#include "s3c244x.h"
+#include <plat/s3c244x.h>
 #include <plat/s3c2440.h>
 #include <plat/s3c2442.h>
 #include <plat/s3c2443.h>
diff --git a/arch/arm/plat-s3c24xx/s3c244x.h b/arch/arm/plat-s3c24xx/include/plat/s3c244x.h
similarity index 92%
rename from arch/arm/plat-s3c24xx/s3c244x.h
rename to arch/arm/plat-s3c24xx/include/plat/s3c244x.h
index 6aab5ea..8da0904 100644
--- a/arch/arm/plat-s3c24xx/s3c244x.h
+++ b/arch/arm/plat-s3c24xx/include/plat/s3c244x.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/s3c244x.h
+/* linux/arch/arm/plat-s3c24xx/include/plat/s3c244x.h
  *
  * Copyright (c) 2004-2005 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
-- 
1.6.0.4
