From: ludovic.Barre@st.com (Ludovic Barre)
Date: Tue, 2 Jan 2018 16:01:46 +0100
Subject: [PATCH v3 2/7] ARM: stm32: prepare stm32 family to welcome armv7
 architecture
In-Reply-To: <1514905311-12925-1-git-send-email-ludovic.Barre@st.com>
References: <1514905311-12925-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1514905311-12925-3-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch prepares the STM32 machine for the integration of Cortex-A
based microprocessor (MPU), on top of the existing Cortex-M
microcontroller family (MCU). Since both MCUs and MPUs are sharing
common hardware blocks we can keep using ARCH_STM32 flag for most of
them. If a hardware block is specific to one family we can use either
ARM_SINGLE_ARMV7M or ARCH_MULTI_V7 flag.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/arm/stm32/overview.rst | 15 +++++++++------
 arch/arm/mach-stm32/Kconfig          | 27 +++++++++++++++------------
 arch/arm/mach-stm32/board-dt.c       |  4 +---
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/Documentation/arm/stm32/overview.rst b/Documentation/arm/stm32/overview.rst
index 6be6059..85cfc84 100644
--- a/Documentation/arm/stm32/overview.rst
+++ b/Documentation/arm/stm32/overview.rst
@@ -5,16 +5,17 @@ STM32 ARM Linux Overview
 Introduction
 ------------
 
-The STMicroelectronics family of Cortex-M based MCUs are supported by the
-'STM32' platform of ARM Linux. Currently only the STM32F429 (Cortex-M4)
-and STM32F746 (Cortex-M7) are supported.
+The STMicroelectronics STM32 family of Cortex-A microprocessors (MPUs) and
+Cortex-M microcontrollers (MCUs) are supported by the 'STM32' platform of
+ARM Linux.
 
 Configuration
 -------------
 
-A generic configuration is provided for STM32 family, and can be used as the
-default by
+For MCUs, use the provided default configuration:
         make stm32_defconfig
+For MPUs, use multi_v7 configuration:
+        make multi_v7_defconfig
 
 Layout
 ------
@@ -28,4 +29,6 @@ Device Trees.
 
 :Authors:
 
-Maxime Coquelin <mcoquelin.stm32@gmail.com>
+- Maxime Coquelin <mcoquelin.stm32@gmail.com>
+- Ludovic Barre <ludovic.barre@st.com>
+- Gerald Baeza <gerald.baeza@st.com>
diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 0d1889b..fb4b8b8 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -1,8 +1,7 @@
-config ARCH_STM32
-	bool "STMicrolectronics STM32"
-	depends on ARM_SINGLE_ARMV7M
+menuconfig ARCH_STM32
+	bool "STMicroelectronics STM32 family" if ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
+	select ARMV7M_SYSTICK if ARM_SINGLE_ARMV7M
 	select ARCH_HAS_RESET_CONTROLLER
-	select ARMV7M_SYSTICK
 	select CLKSRC_STM32
 	select PINCTRL
 	select RESET_CONTROLLER
@@ -10,22 +9,26 @@ config ARCH_STM32
 	help
 	  Support for STMicroelectronics STM32 processors.
 
+if ARCH_STM32
+
+if ARM_SINGLE_ARMV7M
+
 config MACH_STM32F429
-	bool "STMicrolectronics STM32F429"
-	depends on ARCH_STM32
+	bool "STMicroelectronics STM32F429"
 	default y
 
 config MACH_STM32F469
-	bool "STMicrolectronics STM32F469"
-	depends on ARCH_STM32
+	bool "STMicroelectronics STM32F469"
 	default y
 
 config MACH_STM32F746
-	bool "STMicrolectronics STM32F746"
-	depends on ARCH_STM32
+	bool "STMicroelectronics STM32F746"
 	default y
 
 config MACH_STM32H743
-	bool "STMicrolectronics STM32H743"
-	depends on ARCH_STM32
+	bool "STMicroelectronics STM32H743"
 	default y
+
+endif # ARMv7-M
+
+endif
diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
index e918686..4a258eb 100644
--- a/arch/arm/mach-stm32/board-dt.c
+++ b/arch/arm/mach-stm32/board-dt.c
@@ -1,11 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
- * License terms:  GNU General Public License (GPL), version 2
  */
 
 #include <linux/kernel.h>
-#include <asm/v7m.h>
 #include <asm/mach/arch.h>
 
 static const char *const stm32_compat[] __initconst = {
@@ -18,5 +17,4 @@ static const char *const stm32_compat[] __initconst = {
 
 DT_MACHINE_START(STM32DT, "STM32 (Device Tree Support)")
 	.dt_compat = stm32_compat,
-	.restart = armv7m_restart,
 MACHINE_END
-- 
2.7.4
