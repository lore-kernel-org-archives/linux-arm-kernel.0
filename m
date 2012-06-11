From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 Jun 2012 18:52:58 +0200
Subject: [PATCH v2 1/8] arm: mach-mvebu: add header
In-Reply-To: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1339433585-28087-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/mach-mvebu/include/mach/debug-macro.S |   24 ++++++++++++++
 arch/arm/mach-mvebu/include/mach/mvebu.h       |   22 +++++++++++++
 arch/arm/mach-mvebu/include/mach/timex.h       |   13 ++++++++
 arch/arm/mach-mvebu/include/mach/uncompress.h  |   41 ++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 arch/arm/mach-mvebu/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-mvebu/include/mach/mvebu.h
 create mode 100644 arch/arm/mach-mvebu/include/mach/timex.h
 create mode 100644 arch/arm/mach-mvebu/include/mach/uncompress.h

diff --git a/arch/arm/mach-mvebu/include/mach/debug-macro.S b/arch/arm/mach-mvebu/include/mach/debug-macro.S
new file mode 100644
index 0000000..6da4fa1
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/debug-macro.S
@@ -0,0 +1,24 @@
+/*
+ * Early serial output macro for Marvell  SoC
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory Clement <gregory.clement@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <mach/mvebu.h>
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =MVEBU_REGS_PHYS_BASE
+	ldr	\rv, =MVEBU_REGS_VIRT_BASE
+	orr	\rp, \rp, #0x00012000
+	orr	\rv, \rv, #0x00012000
+	.endm
+
+#define UART_SHIFT	2
+#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-mvebu/include/mach/mvebu.h b/arch/arm/mach-mvebu/include/mach/mvebu.h
new file mode 100644
index 0000000..3496471
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/mvebu.h
@@ -0,0 +1,22 @@
+/*
+ * Generic definitions for Marvell SoCs
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_MVEBU_H
+#define __MACH_MVEBU_H
+
+#define MVEBU_REGS_PHYS_BASE		0xd0000000
+#define MVEBU_REGS_VIRT_BASE		0xfeb00000
+#define MVEBU_REGS_SIZE		SZ_1M
+
+#endif /* __MACH_MVEBU_H */
diff --git a/arch/arm/mach-mvebu/include/mach/timex.h b/arch/arm/mach-mvebu/include/mach/timex.h
new file mode 100644
index 0000000..ab324a3
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/timex.h
@@ -0,0 +1,13 @@
+/*
+ * Marvell Armada SoC time definitions
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define CLOCK_TICK_RATE		(100 * HZ)
diff --git a/arch/arm/mach-mvebu/include/mach/uncompress.h b/arch/arm/mach-mvebu/include/mach/uncompress.h
new file mode 100644
index 0000000..3642997
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/uncompress.h
@@ -0,0 +1,41 @@
+/*
+ * Marvell Armada SoC kernel uncompression UART routines
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <mach/mvebu.h>
+
+#define UART_THR ((volatile unsigned char *)(MVEBU_REGS_PHYS_BASE + 0x12000))
+#define UART_LSR ((volatile unsigned char *)(MVEBU_REGS_PHYS_BASE + 0x12014))
+
+#define LSR_THRE	0x20
+
+static void putc(const char c)
+{
+	int i;
+
+	for (i = 0; i < 0x1000; i++) {
+		/* Transmit fifo not full? */
+		if (*UART_LSR & LSR_THRE)
+			break;
+	}
+
+	*UART_THR = c;
+}
+
+static void flush(void)
+{
+}
+
+/*
+ * nothing to do
+ */
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
-- 
1.7.9.5
