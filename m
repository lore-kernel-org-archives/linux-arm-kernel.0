From: zoss@devai.org (Zoltan Devai)
Date: Wed, 19 Oct 2011 18:01:54 +0200
Subject: [PATCH v2 1/5] ARM: SPMP8000: Add machine base files
In-Reply-To: <1319040118-29773-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1319040118-29773-1-git-send-email-zoss@devai.org>
Message-ID: <1319040118-29773-2-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Files needed for the basic machine support of SPMP8000

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-spmp8000/Makefile                   |    4 +
 arch/arm/mach-spmp8000/Makefile.boot              |    1 +
 arch/arm/mach-spmp8000/core.c                     |   79 +++++++++++++++++++++
 arch/arm/mach-spmp8000/core.h                     |   27 +++++++
 arch/arm/mach-spmp8000/include/mach/debug-macro.S |   19 +++++
 arch/arm/mach-spmp8000/include/mach/entry-macro.S |   14 ++++
 arch/arm/mach-spmp8000/include/mach/gpio.h        |    1 +
 arch/arm/mach-spmp8000/include/mach/hardware.h    |   25 +++++++
 arch/arm/mach-spmp8000/include/mach/io.h          |   17 +++++
 arch/arm/mach-spmp8000/include/mach/irqs.h        |   21 ++++++
 arch/arm/mach-spmp8000/include/mach/memory.h      |    1 +
 arch/arm/mach-spmp8000/include/mach/system.h      |   43 +++++++++++
 arch/arm/mach-spmp8000/include/mach/timex.h       |   17 +++++
 arch/arm/mach-spmp8000/include/mach/uncompress.h  |   37 ++++++++++
 arch/arm/mach-spmp8000/include/mach/vmalloc.h     |   16 ++++
 arch/arm/mach-spmp8000/lluart.c                   |   24 ++++++
 16 files changed, 346 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spmp8000/Makefile
 create mode 100644 arch/arm/mach-spmp8000/Makefile.boot
 create mode 100644 arch/arm/mach-spmp8000/core.c
 create mode 100644 arch/arm/mach-spmp8000/core.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-spmp8000/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-spmp8000/include/mach/gpio.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/hardware.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/io.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/irqs.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/memory.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/system.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/timex.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-spmp8000/lluart.c

diff --git a/arch/arm/mach-spmp8000/Makefile b/arch/arm/mach-spmp8000/Makefile
new file mode 100644
index 0000000..15e0238
--- /dev/null
+++ b/arch/arm/mach-spmp8000/Makefile
@@ -0,0 +1,4 @@
+obj-y 			:= core.o
+obj-y			+= clkdev.o
+obj-y			+= clock.o
+obj-$(CONFIG_DEBUG_LL)	+= lluart.o
diff --git a/arch/arm/mach-spmp8000/Makefile.boot b/arch/arm/mach-spmp8000/Makefile.boot
new file mode 100644
index 0000000..dae9661
--- /dev/null
+++ b/arch/arm/mach-spmp8000/Makefile.boot
@@ -0,0 +1 @@
+zreladdr-y	:= 0x00008000
diff --git a/arch/arm/mach-spmp8000/core.c b/arch/arm/mach-spmp8000/core.c
new file mode 100644
index 0000000..15a2111
--- /dev/null
+++ b/arch/arm/mach-spmp8000/core.c
@@ -0,0 +1,79 @@
+/*
+ * SPMP8000 machines core functions
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <asm/mach/map.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/hardware/vic.h>
+#include "core.h"
+
+void __iomem *spmp8000_wdt_base;
+EXPORT_SYMBOL(spmp8000_wdt_base);
+
+static void spmp8000_wdt_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "sunplus,spmp8000-wdt");
+	if (!np) {
+		pr_err("spmp8000: unable to find watchdog node in dtb\n");
+		return;
+	}
+
+	spmp8000_wdt_base = of_iomap(np, 0);
+	if (!spmp8000_wdt_base)
+		pr_err("spmp8000: unable to map watchdog registers\n");
+}
+
+static const struct of_device_id spmp8000_vic_matches[] = {
+		{ .compatible = "arm,pl192", .data = vic_of_init },
+		{ /* Sentinel */ },
+};
+
+void __init spmp8000_init_irq(void)
+{
+	of_irq_init(spmp8000_vic_matches);
+}
+
+static const char *letcool_dt_match[] __initconst = {
+	"gameware,letcool",
+	NULL,
+};
+
+static void __init letcool_dt_init(void)
+{
+	spmp8000_init_clkdev();
+
+	/* Create platform devices */
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	/* Setup WDT reg base to be used by the WDT driver and arch_reset */
+	spmp8000_wdt_init();
+}
+
+struct sys_timer spmp8000_sys_timer = {
+	.init		= spmp8000_sys_timer_init,
+};
+
+DT_MACHINE_START(SPMP8000, "SPMP8000")
+	.map_io		= spmp8000_map_lluart,
+	.init_irq	= spmp8000_init_irq,
+	.handle_irq	= vic_handle_irq,
+	.nr_irqs	= SPMP8000_TOTAL_IRQS,
+	.init_machine	= letcool_dt_init,
+	.timer		= &spmp8000_sys_timer,
+	.dt_compat	= letcool_dt_match,
+MACHINE_END
diff --git a/arch/arm/mach-spmp8000/core.h b/arch/arm/mach-spmp8000/core.h
new file mode 100644
index 0000000..1e84a49
--- /dev/null
+++ b/arch/arm/mach-spmp8000/core.h
@@ -0,0 +1,27 @@
+/*
+ * SPMP8000 generic includes
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_CORE_H__
+#define __MACH_SPMP8000_CORE_H__
+
+/* drivers/clksrc/spmp8000_tmrb.c */
+extern void spmp8000_sys_timer_init(void);
+
+/* clkdev.c */
+extern void spmp8000_init_clkdev(void);
+
+/* lluart.c */
+#ifdef CONFIG_DEBUG_LL
+extern void spmp8000_map_lluart(void);
+#else
+#define spmp8000_map_lluart	NULL
+#endif
+
+#endif /* __MACH_SPMP8000_CORE_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/debug-macro.S b/arch/arm/mach-spmp8000/include/mach/debug-macro.S
new file mode 100644
index 0000000..698c37e
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/debug-macro.S
@@ -0,0 +1,19 @@
+/*
+ * SPMP8000 debug-macro.S
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+	.macro  addruart, rp, rv
+	mov     \rp, #0x92000000
+	add	\rp, #0x00B00000
+	add	\rp, #0x00004000
+	orr	\rv, \rp, #0xF0000000
+	.endm
+
+#define UART_SHIFT 2
+#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-spmp8000/include/mach/entry-macro.S b/arch/arm/mach-spmp8000/include/mach/entry-macro.S
new file mode 100644
index 0000000..3d26088
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/entry-macro.S
@@ -0,0 +1,14 @@
+/*
+ * SPMP8000 entry-macro.S
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+	.macro  disable_fiq
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
diff --git a/arch/arm/mach-spmp8000/include/mach/gpio.h b/arch/arm/mach-spmp8000/include/mach/gpio.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/gpio.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/mach-spmp8000/include/mach/hardware.h b/arch/arm/mach-spmp8000/include/mach/hardware.h
new file mode 100644
index 0000000..bf65e47
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/hardware.h
@@ -0,0 +1,25 @@
+/*
+ * SPMP8000 hardware.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_HARDWARE_H__
+#define __MACH_SPMP8000_HARDWARE_H__
+
+/* Used by WDT driver and arch_reset */
+extern void *spmp8000_wdt_base;
+
+/* Physical to virtual translation of static mappings */
+#define SPMP8000_P2V(x)		((x) | 0xF0000000)
+#define IO_ADDRESS(x)		((void __iomem *)SPMP8000_P2V(x))
+
+/* Needed by lluart.c and uncompress.h */
+#define SPMP8000_UARTC0_BASE	0x92B04000
+#define SPMP8000_UARTC0_SIZE	SZ_4K
+
+#endif /* __MACH_SPMP8000_HARDWARE_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/io.h b/arch/arm/mach-spmp8000/include/mach/io.h
new file mode 100644
index 0000000..464b78c
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/io.h
@@ -0,0 +1,17 @@
+/*
+ * SPMP8000 io.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_IO_H__
+#define __MACH_SPMP8000_IO_H__
+
+#define __mem_pci(a)	(a)
+#define __io(a)		NULL /* Only for 8250 UART driver */
+
+#endif /* __MACH_SPMP8000_IO_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/irqs.h b/arch/arm/mach-spmp8000/include/mach/irqs.h
new file mode 100644
index 0000000..7becde7
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/irqs.h
@@ -0,0 +1,21 @@
+/*
+ * SPMP8000 irqs.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_IRQS_H__
+#define __MACH_SPMP8000_IRQS_H__
+
+#define SPMP8000_HW_IRQS		64
+#define SPMP8000_GPIO_IRQS_START	SPMP8000_HW_IRQS
+#define SPMP8000_GPIO_IRQS		(16 + 32)
+#define SPMP8000_TOTAL_IRQS		(SPMP8000_HW_IRQS + SPMP8000_GPIO_IRQS)
+
+#define NR_IRQS				0
+
+#endif /* __MACH_SPMP8000_IRQS_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/memory.h b/arch/arm/mach-spmp8000/include/mach/memory.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/memory.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/mach-spmp8000/include/mach/system.h b/arch/arm/mach-spmp8000/include/mach/system.h
new file mode 100644
index 0000000..3c2ab5e
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/system.h
@@ -0,0 +1,43 @@
+/*
+ * SPMP8000 system.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_SYSTEM_H__
+#define __MACH_SPMP8000_SYSTEM_H__
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <mach/hardware.h>
+
+#define SPMP8000_WDT_CTR	0x00
+#define SPMP8000_WDT_CTR_TE	BIT(0)
+#define SPMP8000_WDT_CTR_RE	BIT(3)
+#define SPMP8000_WDT_VLR	0x0C
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	if (!spmp8000_wdt_base) {
+		pr_err("spmp8000: arch_reset: Watchdog not initialized\n");
+		return;
+	}
+
+	/* Make sure WDT is enabled */
+	writel(SPMP8000_WDT_CTR_RE | SPMP8000_WDT_CTR_TE,
+			spmp8000_wdt_base + SPMP8000_WDT_CTR);
+
+	/* Force reset by writing invalid value to reload register */
+	writel(0, spmp8000_wdt_base + SPMP8000_WDT_VLR);
+}
+
+#endif /* __MACH_SPMP8000_SYSTEM_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/timex.h b/arch/arm/mach-spmp8000/include/mach/timex.h
new file mode 100644
index 0000000..795deff
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/timex.h
@@ -0,0 +1,17 @@
+/*
+ * SPMP8000 timex.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_TIMEX_H__
+#define __MACH_SPMP8000_TIMEX_H__
+
+/* TODO this should go away */
+#define CLOCK_TICK_RATE		(50 * HZ)
+
+#endif /* __MACH_SPMP8000_TIMEX_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/uncompress.h b/arch/arm/mach-spmp8000/include/mach/uncompress.h
new file mode 100644
index 0000000..105778b
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/uncompress.h
@@ -0,0 +1,37 @@
+/*
+ * SPMP8000 uncompress.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * Based on the mach-kirkwood implementation
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/serial_reg.h>
+#include <mach/hardware.h>
+
+#define SERIAL_BASE	((volatile unsigned char *)SPMP8000_UARTC0_BASE)
+
+static void putc(const char c)
+{
+	volatile unsigned char *base = SERIAL_BASE;
+	int i;
+
+	for (i = 0; i < 0x1000; i++) {
+		if (base[UART_LSR << 2] & UART_LSR_THRE)
+			break;
+		barrier();
+	}
+
+	base[UART_TX << 2] = c;
+}
+
+static void flush(void)
+{
+}
+
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
diff --git a/arch/arm/mach-spmp8000/include/mach/vmalloc.h b/arch/arm/mach-spmp8000/include/mach/vmalloc.h
new file mode 100644
index 0000000..ff40d1c
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/vmalloc.h
@@ -0,0 +1,16 @@
+/*
+ * SPMP8000 vmalloc.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_VMALLOC_H__
+#define __MACH_SPMP8000_VMALLOC_H__
+
+#define VMALLOC_END	0xF0000000UL
+
+#endif /* __MACH_SPMP8000_VMALLOC_H__ */
diff --git a/arch/arm/mach-spmp8000/lluart.c b/arch/arm/mach-spmp8000/lluart.c
new file mode 100644
index 0000000..4b90514
--- /dev/null
+++ b/arch/arm/mach-spmp8000/lluart.c
@@ -0,0 +1,24 @@
+/*
+ * Static memory mapping for DEBUG_LL
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <asm/page.h>
+#include <asm/mach/map.h>
+#include <mach/hardware.h>
+
+void __init spmp8000_map_lluart(void)
+{
+	struct map_desc spmp8000_lluart_map = {
+		.virtual        = SPMP8000_P2V(SPMP8000_UARTC0_BASE),
+		.pfn            = __phys_to_pfn(SPMP8000_UARTC0_BASE),
+		.length         = SPMP8000_UARTC0_SIZE,
+		.type           = MT_DEVICE,
+	};
+
+	iotable_init(&spmp8000_lluart_map, 1);
+}
-- 
1.7.4.1
