From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 16:23:11 +0100
Subject: [PATCH 1/3] ARM: shmobile: r8a7790: Add early debugging support
In-Reply-To: <1383060193-1505-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383060193-1505-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add serial port debug macros for the SCIF0 serial port on R8A7790.
Support for other serial ports can easily be added if needed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/Kconfig.debug           |  8 ++++++++
 arch/arm/include/debug/r8a7790.S | 43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 arch/arm/include/debug/r8a7790.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9762c84..f1b765a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -493,6 +493,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on PXA UART1.
 
+	config DEBUG_R8A7790
+		bool "Kernel low-level debugging messages via SCIF0 on R8A7790 SoCs"
+		depends on ARCH_R8A7790
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Renesas R8A7790 based platforms.
+
 	config DEBUG_REALVIEW_STD_PORT
 		bool "RealView Default UART"
 		depends on ARCH_REALVIEW
@@ -901,6 +908,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_MSM8660_UART || \
 				 DEBUG_MSM8960_UART
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
+	default "debug/r8a7790.S" if DEBUG_R8A7790
 	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
 	default "debug/sti.S" if DEBUG_STI_UART
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
diff --git a/arch/arm/include/debug/r8a7790.S b/arch/arm/include/debug/r8a7790.S
new file mode 100644
index 0000000..4f1feb8
--- /dev/null
+++ b/arch/arm/include/debug/r8a7790.S
@@ -0,0 +1,43 @@
+/*
+ * Renesas R8A7790 debugging macro include header
+ *
+ * Copyright (C) 2012-2013 Renesas Electronics Corporation
+ * Copyright (C) 1994-1999 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define FTDR	0x0c
+#define FSR	0x10
+
+#define TDFE	(1 << 5)
+#define TEND	(1 << 6)
+
+#define SCIF_PHYS	0xe6e60000
+#define SCIF_VIRT	0xffe60000
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =SCIF_PHYS
+	ldr	\rv, =SCIF_VIRT
+	.endm
+
+	.macro	waituart, rd, rx
+1001:	ldrh	\rd, [\rx, #FSR]
+	tst	\rd, #TDFE
+	beq	1001b
+	.endm
+
+	.macro	senduart, rd, rx
+	strb	\rd, [\rx, #FTDR]
+	ldrh	\rd, [\rx, #FSR]
+	bic	\rd, \rd, #TEND
+	strh	\rd, [\rx, #FSR]
+	.endm
+
+	.macro	busyuart, rd, rx
+1001:	ldrh	\rd, [\rx, #FSR]
+	tst	\rd, #TEND
+	beq	1001b
+	.endm
-- 
1.8.1.5
