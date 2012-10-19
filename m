From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 19 Oct 2012 16:41:47 -0600
Subject: [PATCH V3 5/5] ARM: tegra: move debug-macro.S to include/debug
In-Reply-To: <1350686507-3022-1-git-send-email-swarren@wwwdotorg.org>
References: <1350686507-3022-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1350686507-3022-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Move Tegra's debug-macro.S over to the common debug macro directory.

Move Tegra's debug UART selection menu into ARM's Kconfig.debug, so that
all related options are selected in the same place.

Tegra's uncompress.h is left in mach-tegra/include/mach; it will be
removed whenever Tegra is converted to multi-platform.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v3: No change; just rebased on updated earlier patches.
v2: Remove redundant default selection in Kconfig.debug, fix indentation
    there.
---
 arch/arm/Kconfig.debug                             |   38 ++++++++++++++++++++
 .../mach/debug-macro.S => include/debug/tegra.S}   |    2 -
 arch/arm/mach-tegra/Kconfig                        |   29 ---------------
 3 files changed, 38 insertions(+), 31 deletions(-)
 rename arch/arm/{mach-tegra/include/mach/debug-macro.S => include/debug/tegra.S} (99%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b0f3857..96b9425 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -345,6 +345,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on SOCFPGA based platforms.
 
+	config DEBUG_TEGRA_UART
+		depends on ARCH_TEGRA
+		bool "Use Tegra UART for low-level debug"
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Tegra based platforms.
+
 	config DEBUG_VEXPRESS_UART0_DETECT
 		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
 		depends on ARCH_VEXPRESS && CPU_CP15_MMU
@@ -409,6 +416,36 @@ choice
 
 endchoice
 
+choice
+	prompt "Low-level debug console UART"
+	depends on DEBUG_LL && DEBUG_TEGRA_UART
+
+	config TEGRA_DEBUG_UART_AUTO_ODMDATA
+	bool "Via ODMDATA"
+	help
+	  Automatically determines which UART to use for low-level debug based
+	  on the ODMDATA value. This value is part of the BCT, and is written
+	  to the boot memory device using nvflash, or other flashing tool.
+	  When bits 19:18 are 3, then bits 17:15 indicate which UART to use;
+	  0/1/2/3/4 are UART A/B/C/D/E.
+
+	config TEGRA_DEBUG_UARTA
+		bool "UART A"
+
+	config TEGRA_DEBUG_UARTB
+		bool "UART B"
+
+	config TEGRA_DEBUG_UARTC
+		bool "UART C"
+
+	config TEGRA_DEBUG_UARTD
+		bool "UART D"
+
+	config TEGRA_DEBUG_UARTE
+		bool "UART E"
+
+endchoice
+
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/icedcc.S" if DEBUG_ICEDCC
@@ -418,6 +455,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
 	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
 		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
+	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "mach/debug-macro.S"
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-tegra/include/mach/debug-macro.S b/arch/arm/include/debug/tegra.S
similarity index 99%
rename from arch/arm/mach-tegra/include/mach/debug-macro.S
rename to arch/arm/include/debug/tegra.S
index f67fd6d..883d7c2 100644
--- a/arch/arm/mach-tegra/include/mach/debug-macro.S
+++ b/arch/arm/include/debug/tegra.S
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-tegra/include/mach/debug-macro.S
- *
  * Copyright (C) 2010,2011 Google, Inc.
  * Copyright (C) 2011-2012 NVIDIA CORPORATION. All Rights Reserved.
  *
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 97fcd16..e426d1b 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -57,35 +57,6 @@ config TEGRA_AHB
 	  which controls AHB bus master arbitration and some
 	  perfomance parameters(priority, prefech size).
 
-choice
-        prompt "Low-level debug console UART"
-
-config TEGRA_DEBUG_UART_AUTO_ODMDATA
-	bool "Via ODMDATA"
-	help
-	  Automatically determines which UART to use for low-level debug based
-	  on the ODMDATA value. This value is part of the BCT, and is written
-	  to the boot memory device using nvflash, or other flashing tool.
-	  When bits 19:18 are 3, then bits 17:15 indicate which UART to use;
-	  0/1/2/3/4 are UART A/B/C/D/E.
-
-config TEGRA_DEBUG_UARTA
-        bool "UART-A"
-
-config TEGRA_DEBUG_UARTB
-        bool "UART-B"
-
-config TEGRA_DEBUG_UARTC
-        bool "UART-C"
-
-config TEGRA_DEBUG_UARTD
-        bool "UART-D"
-
-config TEGRA_DEBUG_UARTE
-        bool "UART-E"
-
-endchoice
-
 config TEGRA_EMC_SCALING_ENABLE
 	bool "Enable scaling the memory frequency"
 
-- 
1.7.0.4
