From: swarren@nvidia.com (Stephen Warren)
Date: Fri,  6 Jan 2012 13:43:22 -0700
Subject: [PATCH V2 4/4] ARM: tegra: Pass uncompress.h UART selection to
 DEBUG_LL
In-Reply-To: <1325882602-7573-1-git-send-email-swarren@nvidia.com>
References: <1325882602-7573-1-git-send-email-swarren@nvidia.com>
Message-ID: <1325882602-7573-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uncompress.h now saves the selected UART's physical address in Tegra's
IRAM, along with a cookie to indicate validity.

The first time it's run, macro addruart in debug-macro.S looks for this
cookie, and if it's present, uses the UART address stored there. If not,
the static value TEGRA_DEBUG_UART_BASE is used, as was previous behaviour.
The static behaviour will thus be used when not booting using a zImage.

This work was inspired by work by Doug Anderson <dianders@chromium.org>;
see http://lkml.org/lkml/2011/9/26/284. However, this patch relies on
the data passing describe above, rather than duplicating the UART
selection logic in debug-macro.S; the latest selection logic is more
complex due to the need to check reset/clock bits too.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Created <mach/irammap.h> to document IRAM usage.
---
 arch/arm/mach-tegra/common.c                   |   17 +++++
 arch/arm/mach-tegra/include/mach/debug-macro.S |   88 +++++++++++++++++++++---
 arch/arm/mach-tegra/include/mach/irammap.h     |   35 +++++++++
 arch/arm/mach-tegra/include/mach/uncompress.h  |   15 ++++-
 4 files changed, 143 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/irammap.h

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 2db20da..9f1bd0c 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -32,6 +32,23 @@
 #include "clock.h"
 #include "fuse.h"
 
+/*
+ * Storage for debug-macro.S's state.
+ *
+ * This must be in .data not .bss so that it gets initialized each time the
+ * kernel is loaded. The data is declared here rather than debug-macro.S so
+ * that multiple inclusions of debug-macro.S point at the same data.
+ */
+#define TEGRA_DEBUG_UART_OFFSET (TEGRA_DEBUG_UART_BASE & 0xFFFF)
+u32 tegra_uart_config[3] = {
+	/* Debug UART initialization required */
+	1,
+	/* Debug UART physical address */
+	(u32)(IO_APB_PHYS + TEGRA_DEBUG_UART_OFFSET),
+	/* Debug UART virtual address */
+	(u32)(IO_APB_VIRT + TEGRA_DEBUG_UART_OFFSET),
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id tegra_dt_irq_match[] __initconst = {
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init },
diff --git a/arch/arm/mach-tegra/include/mach/debug-macro.S b/arch/arm/mach-tegra/include/mach/debug-macro.S
index 619abc6..90069ab 100644
--- a/arch/arm/mach-tegra/include/mach/debug-macro.S
+++ b/arch/arm/mach-tegra/include/mach/debug-macro.S
@@ -1,11 +1,17 @@
 /*
  * arch/arm/mach-tegra/include/mach/debug-macro.S
  *
- * Copyright (C) 2010 Google, Inc.
+ * Copyright (C) 2010,2011 Google, Inc.
+ * Copyright (C) 2011-2012 NVIDIA CORPORATION. All Rights Reserved.
  *
  * Author:
  *	Colin Cross <ccross@google.com>
  *	Erik Gilling <konkers@google.com>
+ *	Doug Anderson <dianders@chromium.org>
+ *	Stephen Warren <swarren@nvidia.com>
+ *
+ * Portions based on mach-omap2's debug-macro.S
+ * Copyright (C) 1994-1999 Russell King
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -18,18 +24,78 @@
  *
  */
 
+#include <linux/serial_reg.h>
+
 #include <mach/io.h>
 #include <mach/iomap.h>
+#include <mach/irammap.h>
+
+		.macro  addruart, rp, rv, tmp
+		adr	\rp, 99f		@ actual addr of 99f
+		ldr	\rv, [\rp]		@ linked addr is stored there
+		sub	\rv, \rv, \rp		@ offset between the two
+		ldr	\rp, [\rp, #4]		@ linked tegra_uart_config
+		sub	\tmp, \rp, \rv		@ actual tegra_uart_config
+		ldr	\rp, [\tmp]		@ Load tegra_uart_config
+		cmp	\rp, #1			@ needs intitialization?
+		bne	100f			@ no; go load the addresses
+		mov	\rv, #0			@ yes; record init is done
+		str	\rv, [\tmp]
+		mov	\rp, #TEGRA_IRAM_BASE	@ See if cookie is in IRAM
+		ldr	\rv, [\rp, #TEGRA_IRAM_DEBUG_UART_OFFSET]
+		movw	\rp, #TEGRA_IRAM_DEBUG_UART_COOKIE & 0xffff
+		movt	\rp, #TEGRA_IRAM_DEBUG_UART_COOKIE >> 16
+		cmp	\rv, \rp		@ Cookie present?
+		bne	100f			@ No, use default UART
+		mov	\rp, #TEGRA_IRAM_BASE	@ Load UART address from IRAM
+		ldr	\rv, [\rp, #TEGRA_IRAM_DEBUG_UART_OFFSET + 4]
+		str	\rv, [\tmp, #4]		@ Store in tegra_uart_phys
+		sub	\rv, \rv, #IO_APB_PHYS	@ Calculate virt address
+		add	\rv, \rv, #IO_APB_VIRT
+		str	\rv, [\tmp, #8]		@ Store in tegra_uart_virt
+		b	100f
+
+		.align
+99:		.word	.
+		.word	tegra_uart_config
+		.ltorg
+
+100:		ldr	\rp, [\tmp, #4]		@ Load tegra_uart_phys
+		ldr	\rv, [\tmp, #8]		@ Load tegra_uart_virt
+		.endm
+
+#define UART_SHIFT 2
+
+/*
+ * Code below is swiped from <asm/hardware/debug-8250.S>, but add an extra
+ * check to make sure that we aren't in the CONFIG_TEGRA_DEBUG_UART_NONE case.
+ * We use the fact that all 5 valid UART addresses all have something in the
+ * 2nd-to-lowest byte.
+ */
 
-	.macro  addruart, rp, rv, tmp
-        ldr     \rp, =IO_APB_PHYS       @ physical
-        ldr     \rv, =IO_APB_VIRT        @ virtual
-	orr	\rp, \rp, #(TEGRA_DEBUG_UART_BASE & 0xFF)
-	orr	\rp, \rp, #(TEGRA_DEBUG_UART_BASE & 0xFF00)
-	orr	\rv, \rv, #(TEGRA_DEBUG_UART_BASE & 0xFF)
-	orr	\rv, \rv, #(TEGRA_DEBUG_UART_BASE & 0xFF00)
-	.endm
+		.macro	senduart, rd, rx
+		tst	\rx, #0x0000ff00
+		strneb	\rd, [\rx, #UART_TX << UART_SHIFT]
+1001:
+		.endm
 
-#define UART_SHIFT	2
-#include <asm/hardware/debug-8250.S>
+		.macro	busyuart, rd, rx
+		tst	\rx, #0x0000ff00
+		beq	1002f
+1001:		ldrb	\rd, [\rx, #UART_LSR << UART_SHIFT]
+		and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
+		teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
+		bne	1001b
+1002:
+		.endm
 
+		.macro	waituart, rd, rx
+#ifdef FLOW_CONTROL
+		tst	\rx, #0x0000ff00
+		beq	1002f
+1001:		ldrb	\rd, [\rx, #UART_MSR << UART_SHIFT]
+		tst	\rd, #UART_MSR_CTS
+		beq	1001b
+1002:
+#endif
+		.endm
diff --git a/arch/arm/mach-tegra/include/mach/irammap.h b/arch/arm/mach-tegra/include/mach/irammap.h
new file mode 100644
index 0000000..0cbe632
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/irammap.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __MACH_TEGRA_IRAMMAP_H
+#define __MACH_TEGRA_IRAMMAP_H
+
+#include <asm/sizes.h>
+
+/* The first 1K of IRAM is permanently reserved for the CPU reset handler */
+#define TEGRA_IRAM_RESET_HANDLER_OFFSET	0
+#define TEGRA_IRAM_RESET_HANDLER_SIZE	SZ_1K
+
+/*
+ * These locations are written to by uncompress.h, and read by debug-macro.S.
+ * The first word holds the cookie value if the data is valid. The second
+ * word holds the UART physical address.
+ */
+#define TEGRA_IRAM_DEBUG_UART_OFFSET	SZ_1K
+#define TEGRA_IRAM_DEBUG_UART_SIZE	8
+#define TEGRA_IRAM_DEBUG_UART_COOKIE	0x55415254
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index 6c087b6..b066ba0 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2010 Google, Inc.
  * Copyright (C) 2011 Google, Inc.
- * Copyright (C) 2011 NVIDIA CORPORATION. All Rights Reserved.
+ * Copyright (C) 2011-2012 NVIDIA CORPORATION. All Rights Reserved.
  *
  * Author:
  *	Colin Cross <ccross@google.com>
@@ -30,6 +30,7 @@
 #include <linux/serial_reg.h>
 
 #include <mach/iomap.h>
+#include <mach/irammap.h>
 
 #define DEBUG_UART_SHIFT 2
 
@@ -49,6 +50,17 @@ static inline void flush(void)
 {
 }
 
+static inline void save_uart_address(void)
+{
+	u32 *buf = (u32 *)(TEGRA_IRAM_BASE + TEGRA_IRAM_DEBUG_UART_OFFSET);
+
+	if (uart) {
+		buf[0] = TEGRA_IRAM_DEBUG_UART_COOKIE;
+		buf[1] = (u32)uart;
+	} else
+		buf[0] = 0;
+}
+
 /*
  * Setup before decompression.  This is where we do UART selection for
  * earlyprintk and init the uart_base register.
@@ -125,6 +137,7 @@ static inline void arch_decomp_setup(void)
 	}
 	if (i == ARRAY_SIZE(uarts))
 		uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
+	save_uart_address();
 	if (uart == NULL)
 		return;
 
-- 
1.7.0.4
