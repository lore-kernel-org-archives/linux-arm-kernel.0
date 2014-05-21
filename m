From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 21 May 2014 12:22:48 +0530
Subject: [PATCH 2/3] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <1400655169-21683-1-git-send-email-sachin.kamat@linaro.org>
References: <1400655169-21683-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1400655169-21683-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This makes it possible to enable the exynos platform as part of a
multiplatform kernel, in addition to keeping the single-platform
Exynos support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/Kconfig               |   30 ------------------------------
 arch/arm/mach-exynos/Kconfig   |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-exynos/Makefile  |    2 ++
 arch/arm/plat-samsung/Makefile |    3 +++
 4 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 666b59b58ab0..26f2bae4d948 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -829,36 +829,6 @@ config ARCH_S5PV210
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
-config ARCH_EXYNOS
-	bool "Samsung EXYNOS"
-	select ARCH_HAS_BANDGAP
-	select ARCH_HAS_CPUFREQ
-	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_SPARSEMEM_ENABLE
-	select ARM_AMBA
-	select ARM_GIC
-	select CLKSRC_OF
-	select COMMON_CLK_SAMSUNG
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
-	select HAVE_ARM_SCU if SMP
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select HAVE_S3C_RTC if RTC_CLASS
-	select HAVE_SMP
-	select NEED_MACH_MEMORY_H
-	select PINCTRL
-	select PINCTRL_EXYNOS
-	select PM_GENERIC_DOMAINS if PM_RUNTIME
-	select S5P_DEV_MFC
-	select SAMSUNG_DMADEV
-	select SPARSE_IRQ
-	select SRAM
-	select USE_OF
-	help
-	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
-
 config ARCH_DAVINCI
 	bool "TI DaVinci"
 	select ARCH_HAS_HOLES_MEMORYMODEL
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 138070e42aa9..46634175cf54 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -7,6 +7,34 @@
 
 # Configuration options for the EXYNOS4
 
+config ARCH_EXYNOS
+	bool "Samsung EXYNOS" if ARCH_MULTI_V7
+	select ARCH_HAS_BANDGAP
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select ARM_GIC
+	select CLKSRC_OF
+	select COMMON_CLK_SAMSUNG
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_SCU if SMP
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select HAVE_S3C_RTC if RTC_CLASS
+	select HAVE_SMP
+	select PINCTRL
+	select PINCTRL_EXYNOS
+	select PM_GENERIC_DOMAINS if PM_RUNTIME
+	select S5P_DEV_MFC
+	select SAMSUNG_DMADEV
+	select SPARSE_IRQ
+	select SRAM
+	select USE_OF
+	help
+	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
+
 if ARCH_EXYNOS
 
 menu "SAMSUNG EXYNOS SoCs Support"
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 2e0666d31e75..97af694291f1 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -5,6 +5,8 @@
 #
 # Licensed under GPLv2
 
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
+
 obj-y				:=
 obj-m				:=
 obj-n				:=
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 25c826ed3b65..5e5beaa9ae15 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -4,6 +4,9 @@
 #
 # Licensed under GPLv2
 
+ccflags-$(CONFIG_ARCH_MULTI_V7) += -I$(srctree)/$(src)/include
+ccflags-$(CONFIG_ARCH_EXYNOS)	+= -I$(srctree)/arch/arm/mach-exynos/include
+
 obj-y				:=
 obj-m				:=
 obj-n				:= dummy.o
-- 
1.7.9.5
