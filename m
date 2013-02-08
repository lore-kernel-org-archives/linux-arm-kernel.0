From: dbrignoli@audioscience.com (Delio Brignoli)
Date: Fri,  8 Feb 2013 10:44:24 +0100
Subject: [PATCH 1/1] ARM: OMAP: ASI1230: Create board support and enable build
 for ASI1230
In-Reply-To: <1360316664-17210-1-git-send-email-dbrignoli@audioscience.com>
References: <1360316664-17210-1-git-send-email-dbrignoli@audioscience.com>
Message-ID: <1360316664-17210-2-git-send-email-dbrignoli@audioscience.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds minimal support and build configuration for ASI1230

Signed-off-by: Delio Brignoli <dbrignoli@audioscience.com>
---
 arch/arm/mach-omap2/Kconfig                   |    5 +++
 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/board-asi1230.c           |   44 +++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/uncompress.h |    1 +
 4 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-asi1230.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 41b581f..68cc25b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -359,6 +359,11 @@ config MACH_TI8148EVM
 	depends on SOC_TI81XX
 	default y
 
+config MACH_ASI1230
+	bool "AudioScience ASI1230"
+	depends on SOC_TI81XX
+	default y
+
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	default y
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 947cafe..7f164f4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -261,6 +261,7 @@ obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
 obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
 obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8168evm.o
+obj-$(CONFIG_MACH_ASI1230)		+= board-asi1230.o
 
 # Platform specific device init code
 
diff --git a/arch/arm/mach-omap2/board-asi1230.c b/arch/arm/mach-omap2/board-asi1230.c
new file mode 100644
index 0000000..3de1cd8
--- /dev/null
+++ b/arch/arm/mach-omap2/board-asi1230.c
@@ -0,0 +1,44 @@
+/*
+ * board-asi1230.c (ASI1230)
+ *
+ * Copyright (C) 2013 AudioScience, Inc. - http://www.audioscience.com/
+ * Author: Delio Brignoli <dbrignoli@audioscience.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/usb/musb.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include "common.h"
+
+static void __init asi1230_init(void)
+{
+	omap_serial_init();
+}
+
+MACHINE_START(ASI1230, "asi1230")
+	/* Maintainer: AudioScience Inc */
+	.atag_offset	= 0x100,
+	.map_io		= ti81xx_map_io,
+	.init_early	= ti81xx_init_early,
+	.init_irq	= ti81xx_init_irq,
+	.timer		= &omap3_timer,
+	.init_machine	= asi1230_init,
+	.init_late	= ti81xx_init_late,
+	.restart	= omap44xx_restart,
+MACHINE_END
diff --git a/arch/arm/mach-omap2/include/mach/uncompress.h b/arch/arm/mach-omap2/include/mach/uncompress.h
index 8e3546d..9c5aad6 100644
--- a/arch/arm/mach-omap2/include/mach/uncompress.h
+++ b/arch/arm/mach-omap2/include/mach/uncompress.h
@@ -164,6 +164,7 @@ static inline void arch_decomp_setup(void)
 
 		/* TI8148 base boards using UART1 */
 		DEBUG_LL_TI81XX(1, ti8148evm);
+		DEBUG_LL_TI81XX(1, asi1230);
 
 		/* AM33XX base boards using UART1 */
 		DEBUG_LL_AM33XX(1, am335xevm);
-- 
1.7.0.4
