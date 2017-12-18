From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 18 Dec 2017 16:17:48 +0100
Subject: [PATCH V2 5/9] ARM: stm32: add initial support for STM32MP157
In-Reply-To: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1513610272-7824-6-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds initial support of STM32MP157 microprocessor (MPU)
based on Arm Cortex-A7. New Cortex-A infrastructure (gic, timer,...)
are selected if ARCH_MULTI_V7 is defined.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/arm/stm32/stm32mp157-overview.rst | 19 +++++++++++++++++++
 arch/arm/mach-stm32/Kconfig                     |  8 ++++++++
 arch/arm/mach-stm32/Makefile                    |  1 +
 arch/arm/mach-stm32/board-mpu-dt.c              | 16 ++++++++++++++++
 4 files changed, 44 insertions(+)
 create mode 100644 Documentation/arm/stm32/stm32mp157-overview.rst
 create mode 100644 arch/arm/mach-stm32/board-mpu-dt.c

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
index e0f744b..146e22f 100644
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
@@ -31,4 +34,9 @@ config MACH_STM32H743
 	depends on ARM_SINGLE_ARMV7M
 	default y
 
+config MACH_STM32MP157
+	bool "STMicroelectronics STM32MP157"
+	depends on ARCH_MULTI_V7
+	default y
+
 endif
diff --git a/arch/arm/mach-stm32/Makefile b/arch/arm/mach-stm32/Makefile
index 5940af1..2cc3542 100644
--- a/arch/arm/mach-stm32/Makefile
+++ b/arch/arm/mach-stm32/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_ARM_SINGLE_ARMV7M) += board-mcu-dt.o
+obj-$(CONFIG_ARCH_MULTI_V7) += board-mpu-dt.o
diff --git a/arch/arm/mach-stm32/board-mpu-dt.c b/arch/arm/mach-stm32/board-mpu-dt.c
new file mode 100644
index 0000000..9e18405
--- /dev/null
+++ b/arch/arm/mach-stm32/board-mpu-dt.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
+ * Author: Ludovic Barre <ludovic.barre@st.com> for STMicroelectronics.
+ */
+#include <asm/mach/arch.h>
+#include <linux/of_platform.h>
+
+static const char *const stm32mp_compat[] __initconst = {
+	"st,stm32mp157",
+	NULL
+};
+
+DT_MACHINE_START(STM32MPDT, "STM32 MP (Device Tree Support)")
+	.dt_compat = stm32mp_compat,
+MACHINE_END
-- 
2.7.4
