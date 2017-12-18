From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 18 Dec 2017 16:17:46 +0100
Subject: [PATCH V2 3/9] ARM: stm32: prepare stm32 family to welcome armv7
 architecture
In-Reply-To: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1513610272-7824-4-git-send-email-ludovic.Barre@st.com>
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
 Documentation/arm/stm32/overview.rst               | 21 +++++++++--------
 arch/arm/mach-stm32/Kconfig                        | 27 ++++++++++++----------
 arch/arm/mach-stm32/Makefile                       |  2 +-
 arch/arm/mach-stm32/{board-dt.c => board-mcu-dt.c} |  0
 4 files changed, 28 insertions(+), 22 deletions(-)
 rename arch/arm/mach-stm32/{board-dt.c => board-mcu-dt.c} (100%)

diff --git a/Documentation/arm/stm32/overview.rst b/Documentation/arm/stm32/overview.rst
index 6be6059..3da6a8e 100644
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
@@ -22,10 +23,12 @@ Layout
 All the files for multiple machine families are located in the platform code
 contained in arch/arm/mach-stm32
 
-There is a generic board board-dt.c in the mach folder which support
-Flattened Device Tree, which means, it works with any compatible board with
-Device Trees.
+There are generic boards board-mcu-dt.c and board-mpu-dt.c files in the mach
+folder which support Flattened Device Tree, which means, they work with any
+compatible board with Device Trees.
 
 :Authors:
 
-Maxime Coquelin <mcoquelin.stm32@gmail.com>
+- Maxime Coquelin <mcoquelin.stm32@gmail.com>
+- Ludovic Barre <ludovic.barre@st.com>
+- Gerald Baeza <gerald.baeza@st.com>
diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 0d1889b..e0f744b 100644
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
 config MACH_STM32F429
-	bool "STMicrolectronics STM32F429"
-	depends on ARCH_STM32
+	bool "STMicroelectronics STM32F429"
+	depends on ARM_SINGLE_ARMV7M
 	default y
 
 config MACH_STM32F469
-	bool "STMicrolectronics STM32F469"
-	depends on ARCH_STM32
+	bool "STMicroelectronics STM32F469"
+	depends on ARM_SINGLE_ARMV7M
 	default y
 
 config MACH_STM32F746
-	bool "STMicrolectronics STM32F746"
-	depends on ARCH_STM32
+	bool "STMicroelectronics STM32F746"
+	depends on ARM_SINGLE_ARMV7M
 	default y
 
 config MACH_STM32H743
-	bool "STMicrolectronics STM32H743"
-	depends on ARCH_STM32
+	bool "STMicroelectronics STM32H743"
+	depends on ARM_SINGLE_ARMV7M
 	default y
+
+endif
diff --git a/arch/arm/mach-stm32/Makefile b/arch/arm/mach-stm32/Makefile
index bd0b7b5..5940af1 100644
--- a/arch/arm/mach-stm32/Makefile
+++ b/arch/arm/mach-stm32/Makefile
@@ -1 +1 @@
-obj-y += board-dt.o
+obj-$(CONFIG_ARM_SINGLE_ARMV7M) += board-mcu-dt.o
diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-mcu-dt.c
similarity index 100%
rename from arch/arm/mach-stm32/board-dt.c
rename to arch/arm/mach-stm32/board-mcu-dt.c
-- 
2.7.4
