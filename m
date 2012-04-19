From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Apr 2012 19:20:31 -0700
Subject: [PATCH 2/7] ARM: SAMSUNG: move interrupt part for common s5p into
 plat-samsung
In-Reply-To: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
References: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1334802036-16768-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/Kconfig                          |   11 -----------
 arch/arm/plat-s5p/Makefile                         |    3 ---
 arch/arm/plat-samsung/Kconfig                      |   16 ++++++++++++++++
 arch/arm/plat-samsung/Makefile                     |    3 +++
 .../irq-eint.c => plat-samsung/s5p-irq-eint.c}     |    3 +--
 .../s5p-irq-gpioint.c}                             |    3 +--
 .../arm/{plat-s5p/irq.c => plat-samsung/s5p-irq.c} |    3 +--
 7 files changed, 22 insertions(+), 20 deletions(-)
 rename arch/arm/{plat-s5p/irq-eint.c => plat-samsung/s5p-irq-eint.c} (99%)
 rename arch/arm/{plat-s5p/irq-gpioint.c => plat-samsung/s5p-irq-gpioint.c} (99%)
 rename arch/arm/{plat-s5p/irq.c => plat-samsung/s5p-irq.c} (96%)

diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 2c1193c..efff0a3 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -23,17 +23,6 @@ config PLAT_S5P
 	help
 	  Base platform code for Samsung's S5P series SoC.
 
-config S5P_EXT_INT
-	bool
-	help
-	  Use the external interrupts (other than GPIO interrupts.)
-	  Note: Do not choose this for S5P6440 and S5P6450.
-
-config S5P_GPIO_INT
-	bool
-	help
-	  Common code for the GPIO interrupts (other than external interrupts.)
-
 config S5P_HRT
 	bool
 	select SAMSUNG_DEV_PWM
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 8315210..8701c3c 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -12,9 +12,6 @@ obj-				:=
 
 # Core files
 
-obj-y				+= irq.o
-obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
-obj-$(CONFIG_S5P_GPIO_INT)	+= irq-gpioint.o
 obj-$(CONFIG_S5P_PM)		+= pm.o irq-pm.o
 obj-$(CONFIG_S5P_SLEEP)		+= sleep.o
 obj-$(CONFIG_S5P_HRT) 		+= s5p-time.o
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 4283765..9ae8036 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -70,6 +70,22 @@ config SAMSUNG_IRQ_VIC_TIMER
        help
          Internal configuration to build the VIC timer interrupt code.
 
+config S5P_IRQ
+	def_bool (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
+	help
+	  Support common interrup part for ARCH_S5P and ARCH_EXYNOS SoCs
+
+config S5P_EXT_INT
+	bool
+	help
+	  Use the external interrupts (other than GPIO interrupts.)
+	  Note: Do not choose this for S5P6440 and S5P6450.
+
+config S5P_GPIO_INT
+	bool
+	help
+	  Common code for the GPIO interrupts (other than external interrupts.)
+
 # options for gpio configuration support
 
 config SAMSUNG_GPIOLIB_4BIT
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 997ce10..5b65009 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -20,6 +20,9 @@ obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
 obj-$(CONFIG_S5P_CLOCK)		+= s5p-clock.o
 
 obj-$(CONFIG_SAMSUNG_IRQ_VIC_TIMER) += irq-vic-timer.o
+obj-$(CONFIG_S5P_IRQ)		+= s5p-irq.o
+obj-$(CONFIG_S5P_EXT_INT)	+= s5p-irq-eint.o
+obj-$(CONFIG_S5P_GPIO_INT)	+= s5p-irq-gpioint.o
 
 # ADC
 
diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-samsung/s5p-irq-eint.c
similarity index 99%
rename from arch/arm/plat-s5p/irq-eint.c
rename to arch/arm/plat-samsung/s5p-irq-eint.c
index 139c050..33bd3f3 100644
--- a/arch/arm/plat-s5p/irq-eint.c
+++ b/arch/arm/plat-samsung/s5p-irq-eint.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s5p/irq-eint.c
- *
+/*
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-samsung/s5p-irq-gpioint.c
similarity index 99%
rename from arch/arm/plat-s5p/irq-gpioint.c
rename to arch/arm/plat-samsung/s5p-irq-gpioint.c
index 82c7311..f9431fe 100644
--- a/arch/arm/plat-s5p/irq-gpioint.c
+++ b/arch/arm/plat-samsung/s5p-irq-gpioint.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s5p/irq-gpioint.c
- *
+/*
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  * Author: Kyungmin Park <kyungmin.park@samsung.com>
  * Author: Joonyoung Shim <jy0922.shim@samsung.com>
diff --git a/arch/arm/plat-s5p/irq.c b/arch/arm/plat-samsung/s5p-irq.c
similarity index 96%
rename from arch/arm/plat-s5p/irq.c
rename to arch/arm/plat-samsung/s5p-irq.c
index afdaa10..dfb47d6 100644
--- a/arch/arm/plat-s5p/irq.c
+++ b/arch/arm/plat-samsung/s5p-irq.c
@@ -1,5 +1,4 @@
-/* arch/arm/plat-s5p/irq.c
- *
+/*
  * Copyright (c) 2009 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
-- 
1.7.2.3
