From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 10 Apr 2014 13:54:55 +0530
Subject: [PATCH 5/6] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <1397118296-6846-1-git-send-email-sachin.kamat@linaro.org>
References: <1397118296-6846-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1397118296-6846-6-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This makes it possible to enable the exynos platform as part of a
multiplatform kernel, in addition to keeping the single-platform
Exynos support.
sparsemem is currently not supported in multiplatform.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/Kconfig                  |   27 +++------------------------
 arch/arm/configs/exynos_defconfig |    2 +-
 arch/arm/mach-exynos/Kconfig      |   27 +++++++++++++++++++++++++++
 arch/arm/mach-exynos/Makefile     |    2 ++
 arch/arm/plat-samsung/Makefile    |    3 +++
 5 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4422601059e8..9d459e9c396b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -828,34 +828,13 @@ config ARCH_S5PV210
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
-config ARCH_EXYNOS
+config ARCH_EXYNOS_SINGLE
 	bool "Samsung EXYNOS"
-	select ARCH_HAS_BANDGAP
-	select ARCH_HAS_CPUFREQ
-	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_EXYNOS
 	select ARCH_SPARSEMEM_ENABLE
-	select ARM_AMBA
-	select ARM_GIC
-	select CLKSRC_OF
-	select COMMON_CLK
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
-	select HAVE_ARM_SCU if SMP
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select HAVE_S3C_RTC if RTC_CLASS
-	select HAVE_SMP
 	select NEED_MACH_MEMORY_H
-	select PINCTRL
-	select PINCTRL_EXYNOS
-	select PM_GENERIC_DOMAINS if PM_RUNTIME
-	select S5P_DEV_MFC
-	select SAMSUNG_DMADEV
-	select SPARSE_IRQ
-	select USE_OF
 	help
-	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
+	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
 
 config ARCH_DAVINCI
 	bool "TI DaVinci"
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 4ce7b70ea901..103a676256cd 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -7,7 +7,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
-CONFIG_ARCH_EXYNOS=y
+CONFIG_ARCH_EXYNOS_SINGLE=y
 CONFIG_S3C_LOWLEVEL_UART_PORT=3
 CONFIG_S3C24XX_PWM=y
 CONFIG_ARCH_EXYNOS5=y
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 5c34dc26cec6..bc55af76a05f 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -7,6 +7,33 @@
 
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
+	select COMMON_CLK
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
+	select USE_OF
+	help
+	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
+
 if ARCH_EXYNOS
 
 menu "SAMSUNG EXYNOS SoCs Support"
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index f6dcc256db56..24a8efe3d4bd 100644
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
