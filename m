From: gregory.clement@free-electrons.com (Gregory Clement)
Date: Tue, 26 Jun 2012 10:28:26 +0200
Subject: [PATCH v4 2/9] arm: mach-mvebu: add header
In-Reply-To: <1340699313-29331-1-git-send-email-gregory.clement@free-electrons.com>
References: <1340699313-29331-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1340699313-29331-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/mach-mvebu/include/mach/debug-macro.S |   24 +++++++++++++
 arch/arm/mach-mvebu/include/mach/timex.h       |   13 +++++++
 arch/arm/mach-mvebu/include/mach/uncompress.h  |   43 ++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 arch/arm/mach-mvebu/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-mvebu/include/mach/timex.h
 create mode 100644 arch/arm/mach-mvebu/include/mach/uncompress.h

diff --git a/arch/arm/mach-mvebu/include/mach/debug-macro.S b/arch/arm/mach-mvebu/include/mach/debug-macro.S
new file mode 100644
index 0000000..2282576
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
+#include <mach/armada-370-xp.h>
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =ARMADA_370_XP_REGS_PHYS_BASE
+	ldr	\rv, =ARMADA_370_XP_REGS_VIRT_BASE
+	orr	\rp, \rp, #0x00012000
+	orr	\rv, \rv, #0x00012000
+	.endm
+
+#define UART_SHIFT	2
+#include <asm/hardware/debug-8250.S>
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
index 0000000..d6a100c
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/uncompress.h
@@ -0,0 +1,43 @@
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
+#include <mach/armada-370-xp.h>
+
+#define UART_THR ((volatile unsigned char *)(ARMADA_370_XP_REGS_PHYS_BASE\
+								+ 0x12000))
+#define UART_LSR ((volatile unsigned char *)(ARMADA_370_XP_REGS_PHYS_BASE\
+								+ 0x12014))
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
