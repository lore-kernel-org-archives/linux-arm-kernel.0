From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 25 Mar 2010 14:10:47 +0530
Subject: [PATCH V2 Resend 04/12] ST SPEAr: Added basic header files for SPEAr
	platform
In-Reply-To: <1269506455-15173-4-git-send-email-viresh.kumar@st.com>
References: <1269506455-15173-1-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-2-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-3-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-4-git-send-email-viresh.kumar@st.com>
Message-ID: <1269506455-15173-5-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/plat-spear/include/plat/debug-macro.S |   38 +++++++++++++++++++++
 arch/arm/plat-spear/include/plat/gpio.h        |   24 +++++++++++++
 arch/arm/plat-spear/include/plat/io.h          |   22 ++++++++++++
 arch/arm/plat-spear/include/plat/memory.h      |   20 +++++++++++
 arch/arm/plat-spear/include/plat/system.h      |   41 ++++++++++++++++++++++
 arch/arm/plat-spear/include/plat/timex.h       |   19 ++++++++++
 arch/arm/plat-spear/include/plat/uncompress.h  |   43 ++++++++++++++++++++++++
 arch/arm/plat-spear/include/plat/vmalloc.h     |   19 ++++++++++
 8 files changed, 226 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/debug-macro.S
 create mode 100644 arch/arm/plat-spear/include/plat/gpio.h
 create mode 100644 arch/arm/plat-spear/include/plat/io.h
 create mode 100644 arch/arm/plat-spear/include/plat/memory.h
 create mode 100644 arch/arm/plat-spear/include/plat/system.h
 create mode 100644 arch/arm/plat-spear/include/plat/timex.h
 create mode 100644 arch/arm/plat-spear/include/plat/uncompress.h
 create mode 100644 arch/arm/plat-spear/include/plat/vmalloc.h

diff --git a/arch/arm/plat-spear/include/plat/debug-macro.S b/arch/arm/plat-spear/include/plat/debug-macro.S
new file mode 100644
index 0000000..1670734
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/debug-macro.S
@@ -0,0 +1,38 @@
+/*
+ * arch/arm/plat-spear/include/plat/debug-macro.S
+ *
+ * Debugging macro include header for spear platform
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/amba/serial.h>
+#include <mach/spear.h>
+
+		.macro	addruart, rx
+		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1					@ MMU enabled?
+		moveq	\rx, =SPEAR_DBG_UART_BASE		@ Physical base
+		movne	\rx, =VA_SPEAR_DBG_UART_BASE		@ Virtual base
+		.endm
+
+		.macro	senduart, rd, rx
+		strb	\rd, [\rx, #UART01x_DR]			@ ASC_TX_BUFFER
+		.endm
+
+		.macro	waituart, rd, rx
+1001:		ldr	\rd, [\rx, #UART01x_FR]			@ FLAG REGISTER
+		tst	\rd, #UART01x_FR_TXFF			@ TX_FULL
+		bne	1001b
+		.endm
+
+		.macro	busyuart, rd, rx
+1002:		ldr	\rd, [\rx, #UART01x_FR]			@ FLAG REGISTER
+		tst	\rd, #UART011_FR_TXFE			@ TX_EMPTY
+		beq	1002b
+		.endm
diff --git a/arch/arm/plat-spear/include/plat/gpio.h b/arch/arm/plat-spear/include/plat/gpio.h
new file mode 100644
index 0000000..b857c91
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/gpio.h
@@ -0,0 +1,24 @@
+/*
+ * arch/arm/plat-spear/include/plat/gpio.h
+ *
+ * GPIO macros for SPEAr platform
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_GPIO_H
+#define __PLAT_GPIO_H
+
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
+
+#endif /* __PLAT_GPIO_H */
diff --git a/arch/arm/plat-spear/include/plat/io.h b/arch/arm/plat-spear/include/plat/io.h
new file mode 100644
index 0000000..4d4ba82
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/io.h
@@ -0,0 +1,22 @@
+/*
+ * arch/arm/plat-spear/include/plat/io.h
+ *
+ * IO definitions for SPEAr platform
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_IO_H
+#define __PLAT_IO_H
+
+#define IO_SPACE_LIMIT		0xFFFFFFFF
+
+#define __io(a)			__typesafe_io(a)
+#define __mem_pci(a)		(a)
+
+#endif /* __PLAT_IO_H */
diff --git a/arch/arm/plat-spear/include/plat/memory.h b/arch/arm/plat-spear/include/plat/memory.h
new file mode 100644
index 0000000..27a4aba
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/memory.h
@@ -0,0 +1,20 @@
+/*
+ * arch/arm/plat-spear/include/plat/memory.h
+ *
+ * Memory map for SPEAr platform
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_MEMORY_H
+#define __PLAT_MEMORY_H
+
+/* Physical DRAM offset */
+#define PHYS_OFFSET		UL(0x00000000)
+
+#endif /* __PLAT_MEMORY_H */
diff --git a/arch/arm/plat-spear/include/plat/system.h b/arch/arm/plat-spear/include/plat/system.h
new file mode 100644
index 0000000..55a4e40
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/system.h
@@ -0,0 +1,41 @@
+/*
+ * arch/arm/plat-spear/include/plat/system.h
+ *
+ * SPEAr platform specific architecture functions
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_SYSTEM_H
+#define __PLAT_SYSTEM_H
+
+#include <asm/hardware/sp810.h>
+#include <linux/io.h>
+#include <mach/spear.h>
+
+static inline void arch_idle(void)
+{
+	/*
+	 * This should do all the clock switching
+	 * and wait for interrupt tricks
+	 */
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	if (mode == 's') {
+		/* software reset, Jump into ROM at address 0 */
+		cpu_reset(0);
+	} else {
+		/* hardware reset, Use on-chip reset capability */
+		sysctl_soft_reset((void __iomem *)VA_SPEAR_SYS_CTRL_BASE);
+	}
+}
+
+#endif /* __PLAT_SYSTEM_H */
diff --git a/arch/arm/plat-spear/include/plat/timex.h b/arch/arm/plat-spear/include/plat/timex.h
new file mode 100644
index 0000000..914d09d
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/timex.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/plat-spear/include/plat/timex.h
+ *
+ * SPEAr platform specific timex definitions
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_TIMEX_H
+#define __PLAT_TIMEX_H
+
+#define CLOCK_TICK_RATE			48000000
+
+#endif /* __PLAT_TIMEX_H */
diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
new file mode 100644
index 0000000..99ba678
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -0,0 +1,43 @@
+/*
+ * arch/arm/plat-spear/include/plat/uncompress.h
+ *
+ * Serial port stubs for kernel decompress status messages
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/amba/serial.h>
+#include <mach/spear.h>
+
+#ifndef __PLAT_UNCOMPRESS_H
+#define __PLAT_UNCOMPRESS_H
+/*
+ * This does not append a newline
+ */
+static inline void putc(int c)
+{
+	void __iomem *base = (void __iomem *)SPEAR_DBG_UART_BASE;
+
+	while (readl(base + UART01x_FR) & UART01x_FR_TXFF)
+		barrier();
+
+	writel(c, base + UART01x_DR);
+}
+
+static inline void flush(void)
+{
+}
+
+/*
+ * nothing to do
+ */
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
+
+#endif /* __PLAT_UNCOMPRESS_H */
diff --git a/arch/arm/plat-spear/include/plat/vmalloc.h b/arch/arm/plat-spear/include/plat/vmalloc.h
new file mode 100644
index 0000000..09e9372
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/vmalloc.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/plat-spear/include/plat/vmalloc.h
+ *
+ * Defining Vmalloc area for SPEAr platform
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_VMALLOC_H
+#define __PLAT_VMALLOC_H
+
+#define VMALLOC_END		0xF0000000
+
+#endif /* __PLAT_VMALLOC_H */
-- 
1.6.0.2
