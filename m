From: ludovic.Barre@st.com (Ludovic Barre)
Date: Tue, 2 Jan 2018 16:01:48 +0100
Subject: [PATCH v3 4/7] ARM: stm32: add initial support for STM32MP157
In-Reply-To: <1514905311-12925-1-git-send-email-ludovic.Barre@st.com>
References: <1514905311-12925-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1514905311-12925-5-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds initial support of STM32MP157 microprocessor (MPU)
based on Arm Cortex-A7. New Cortex-A infrastructure (gic, timer,...)
are selected if ARCH_MULTI_V7 is defined.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/arm/stm32/stm32mp157-overview.rst | 19 +++++++++++++++++++
 arch/arm/mach-stm32/Kconfig                     | 11 +++++++++++
 arch/arm/mach-stm32/board-dt.c                  |  1 +
 3 files changed, 31 insertions(+)
 create mode 100644 Documentation/arm/stm32/stm32mp157-overview.rst

diff --git a/Documentation/arm/stm32/stm32mp157-overview.rst b/Documentation/arm/stm32/stm32mp157-overview.rst
new file mode 100644
index 0000000..62e176d
--- /dev/null
+++ b/Documentation/arm/stm32/stm32mp157-overview.rst
@@ -0,0 +1,19 @@
+STM32MP157 Overview
+===================
+
+Introduction
+------------
+
+The STM32MP157 is a Cortex-A MPU aimed at various applications.
+It features:
+
+- Dual core Cortex-A7 application core
+- 2D/3D image composition with GPU
+- Standard memories interface support
+- Standard connectivity, widely inherited from the STM32 MCU family
+- Comprehensive security support
+
+:Authors:
+
+- Ludovic Barre <ludovic.barre@st.com>
+- Gerald Baeza <gerald.baeza@st.com>
diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index fb4b8b8..6b65df1 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -1,6 +1,9 @@
 menuconfig ARCH_STM32
 	bool "STMicroelectronics STM32 family" if ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
 	select ARMV7M_SYSTICK if ARM_SINGLE_ARMV7M
+	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
+	select ARM_GIC if ARCH_MULTI_V7
+	select ARM_PSCI if ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_STM32
 	select PINCTRL
@@ -31,4 +34,12 @@ config MACH_STM32H743
 
 endif # ARMv7-M
 
+if ARCH_MULTI_V7
+
+config MACH_STM32MP157
+	bool "STMicroelectronics STM32MP157"
+	default y
+
+endif # ARMv7-A
+
 endif
diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
index 4a258eb..d4e58ea 100644
--- a/arch/arm/mach-stm32/board-dt.c
+++ b/arch/arm/mach-stm32/board-dt.c
@@ -12,6 +12,7 @@ static const char *const stm32_compat[] __initconst = {
 	"st,stm32f469",
 	"st,stm32f746",
 	"st,stm32h743",
+	"st,stm32mp157",
 	NULL
 };
 
-- 
2.7.4
