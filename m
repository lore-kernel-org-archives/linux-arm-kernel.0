From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Sep 2012 16:46:52 -0600
Subject: [RFC PATCH 3/3] ARM: tegra: move debug macros to include/debug
In-Reply-To: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
References: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1348613212-21897-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Move Tegra's debug-macro.S and uncompress.h over to the common debug
macro directory.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
TODO: We need to find a better solution for access to <mach/iomap.h>.
Perhaps the headers should just be moved into some generally accessible
location, such as arch/arm/include or include/linux/...
---
 arch/arm/Kconfig.debug                             |    9 +++++++++
 .../debug/tegra-uncompress.h}                      |    6 ++----
 .../mach/debug-macro.S => include/debug/tegra.S}   |    6 ++----
 3 files changed, 13 insertions(+), 8 deletions(-)
 rename arch/arm/{mach-tegra/include/mach/uncompress.h => include/debug/tegra-uncompress.h} (98%)
 rename arch/arm/{mach-tegra/include/mach/debug-macro.S => include/debug/tegra.S} (96%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index af34a43..78e11ed 100644
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
@@ -418,12 +425,14 @@ config DEBUG_LL_INCLUDE
 	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
 	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
 		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
+	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "mach/debug-macro.S"
 
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/icedcc-uncompress.h" if DEBUG_ICEDCC
 	default "debug/mvebu-uncompress.h" if DEBUG_MVEBU_UART
+	default "debug/tegra-uncompress.h" if DEBUG_TEGRA_UART
 	default "debug/none-uncompress.h" if ARCH_MULTIPLATFORM || \
 		DEBUG_HIGHBANK_UART || \
 		DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART || \
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/include/debug/tegra-uncompress.h
similarity index 98%
rename from arch/arm/mach-tegra/include/mach/uncompress.h
rename to arch/arm/include/debug/tegra-uncompress.h
index 937c4c5..da0f7e5 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/include/debug/tegra-uncompress.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-tegra/include/mach/uncompress.h
- *
  * Copyright (C) 2010 Google, Inc.
  * Copyright (C) 2011 Google, Inc.
  * Copyright (C) 2011-2012 NVIDIA CORPORATION. All Rights Reserved.
@@ -28,8 +26,8 @@
 #include <linux/types.h>
 #include <linux/serial_reg.h>
 
-#include <mach/iomap.h>
-#include <mach/irammap.h>
+#include "../../mach-tegra/include/mach/iomap.h"
+#include "../../mach-tegra/include/mach/irammap.h"
 
 #define BIT(x) (1 << (x))
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
diff --git a/arch/arm/mach-tegra/include/mach/debug-macro.S b/arch/arm/include/debug/tegra.S
similarity index 96%
rename from arch/arm/mach-tegra/include/mach/debug-macro.S
rename to arch/arm/include/debug/tegra.S
index 8ce0661..879511b 100644
--- a/arch/arm/mach-tegra/include/mach/debug-macro.S
+++ b/arch/arm/include/debug/tegra.S
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-tegra/include/mach/debug-macro.S
- *
  * Copyright (C) 2010,2011 Google, Inc.
  * Copyright (C) 2011-2012 NVIDIA CORPORATION. All Rights Reserved.
  *
@@ -26,8 +24,8 @@
 
 #include <linux/serial_reg.h>
 
-#include <mach/iomap.h>
-#include <mach/irammap.h>
+#include "../../mach-tegra/include/mach/iomap.h"
+#include "../../mach-tegra/include/mach/irammap.h"
 
 		.macro  addruart, rp, rv, tmp
 		adr	\rp, 99f		@ actual addr of 99f
-- 
1.7.0.4
