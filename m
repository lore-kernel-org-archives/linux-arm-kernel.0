From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 8 Dec 2010 00:31:55 +0800
Subject: [PATCH v2 05/15] ARM: mxs: Add low-level debug UART support
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1291739523-25077-4-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - DEBUG_LL support, which is incompatible with single MXS image
   because of different DUART base address on MX23 and MX28
 - uncompress message support

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes for v2:
 - Remove incorrect comments

 arch/arm/mach-mxs/include/mach/debug-macro.S |   51 +++++++++++++++++
 arch/arm/mach-mxs/include/mach/uncompress.h  |   78 ++++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-mxs/include/mach/uncompress.h

diff --git a/arch/arm/mach-mxs/include/mach/debug-macro.S b/arch/arm/mach-mxs/include/mach/debug-macro.S
new file mode 100644
index 0000000..efb3173
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/debug-macro.S
@@ -0,0 +1,51 @@
+/* arch/arm/mach-mxs/include/mach/debug-macro.S
+ *
+ * Debugging macro include header
+ *
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <mach/hardware.h>
+
+#ifdef CONFIG_SOC_IMX23
+#ifdef UART_PADDR
+#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
+#endif
+#define UART_PADDR	MX23_DUART_BASE_ADDR
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+#ifdef UART_PADDR
+#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
+#endif
+#define UART_PADDR	MX28_DUART_BASE_ADDR
+#endif
+
+#define UART_VADDR	MXS_IO_ADDRESS(UART_PADDR)
+
+		.macro	addruart, rp, rv
+		ldr	\rp, =UART_PADDR	@ physical
+		ldr	\rv, =UART_VADDR	@ virtual
+		.endm
+
+		.macro	senduart, rd, rx
+		str	\rd, [\rx, #0x0]	@ DR
+		.endm
+
+		.macro	waituart, rd, rx
+1001:		ldr	\rd, [\rx, #0x18]	@ FR
+		tst	\rd, #1 << 5		@ FR_TXFF
+		bne	1001b
+		.endm
+
+		.macro	busyuart, rd, rx
+1002:		ldr	\rd, [\rx, #0x18]	@ FR
+		tst	\rd, #1 << 3		@ FR_BUSY
+		beq	1002b
+		.endm
diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
new file mode 100644
index 0000000..efdacc7
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/uncompress.h
@@ -0,0 +1,78 @@
+/*
+ *  arch/arm/mach-mxs/include/mach/uncompress.h
+ *
+ *  Copyright (C) 1999 ARM Limited
+ *  Copyright (C) Shane Nay (shane@minirl.com)
+ *  Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __MACH_MXS_UNCOMPRESS_H__
+#define __MACH_MXS_UNCOMPRESS_H__
+
+#define __MXS_BOOT_UNCOMPRESS
+
+#include <asm/mach-types.h>
+
+static unsigned long uart_base;
+
+#define UART(x) (*(volatile unsigned long *)(uart_base + (x)))
+
+#define DR		0x00
+#define FR		0x18
+#define FR_BUSY		(1 << 3)
+#define FR_TXFE		(1 << 7)
+#define CR		0x30
+#define CR_UARTEN	1
+
+/*
+ * The following code assumes the serial port has already been
+ * initialized by the bootloader.
+ */
+
+static void putc(int ch)
+{
+	if (!uart_base)
+		return;
+	if (!(UART(CR) & CR_UARTEN))
+		return;
+
+	while (!(UART(FR) & FR_TXFE))
+		barrier();
+
+	UART(DR) = ch;
+}
+
+static inline void flush(void)
+{
+}
+
+#define MX23_DUART_BASE_ADDR	0x80070000
+#define MX28_DUART_BASE_ADDR	0x80074000
+
+static __inline__ void __arch_decomp_setup(unsigned long arch_id)
+{
+	switch (arch_id) {
+	case MACH_TYPE_MX23EVK:
+		uart_base = MX23_DUART_BASE_ADDR;
+		break;
+	case MACH_TYPE_MX28EVK:
+		uart_base = MX28_DUART_BASE_ADDR;
+		break;
+	default:
+		break;
+	}
+}
+
+#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
+#define arch_decomp_wdog()
+
+#endif /* __MACH_MXS_UNCOMPRESS_H__ */
-- 
1.7.1
