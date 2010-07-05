From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Mon, 05 Jul 2010 10:46:51 +0900
Subject: [PATCH] ARM: S5P: Add PMU device
Message-ID: <1278294411-5104-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an initcall for the s5p platforms so that they register
their PMU IRQs with the PMU framework in the Kernel.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 arch/arm/mach-s5p6442/include/mach/irqs.h |    2 +-
 arch/arm/mach-s5pc100/include/mach/irqs.h |    1 +
 arch/arm/mach-s5pv210/include/mach/irqs.h |    1 +
 arch/arm/plat-s5p/Makefile                |    1 +
 arch/arm/plat-s5p/dev-pmu.c               |   37 +++++++++++++++++++++++++++++
 5 files changed, 41 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-s5p/dev-pmu.c

diff --git a/arch/arm/mach-s5p6442/include/mach/irqs.h b/arch/arm/mach-s5p6442/include/mach/irqs.h
index 02c2374..22173cc 100644
--- a/arch/arm/mach-s5p6442/include/mach/irqs.h
+++ b/arch/arm/mach-s5p6442/include/mach/irqs.h
@@ -32,7 +32,7 @@
 #define IRQ_GPIOINT		S5P_IRQ_VIC0(30)
 
 /* VIC1 */
-#define IRQ_nPMUIRQ 		S5P_IRQ_VIC1(0)
+#define IRQ_PMUIRQ		S5P_IRQ_VIC1(0)
 #define IRQ_ONENAND 		S5P_IRQ_VIC1(7)
 #define IRQ_UART0 		S5P_IRQ_VIC1(10)
 #define IRQ_UART1 		S5P_IRQ_VIC1(11)
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
index 28aa551..9cc1b0d 100644
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
@@ -110,5 +110,6 @@
 #define IRQ_LCD_FIFO		IRQ_LCD0
 #define IRQ_LCD_VSYNC		IRQ_LCD1
 #define IRQ_LCD_SYSTEM		IRQ_LCD2
+#define IRQ_PMUIRQ		IRQ_CORTEX0
 
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 9689537..3972f8d 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -128,5 +128,6 @@
 #define IRQ_LCD_FIFO		IRQ_LCD0
 #define IRQ_LCD_VSYNC		IRQ_LCD1
 #define IRQ_LCD_SYSTEM		IRQ_LCD2
+#define IRQ_PMUIRQ		IRQ_CORTEX0
 
 #endif /* ASM_ARCH_IRQS_H */
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 39c242b..7e34194 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -12,6 +12,7 @@ obj-				:=
 
 # Core files
 
+obj-y				+= dev-pmu.o
 obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= clock.o
diff --git a/arch/arm/plat-s5p/dev-pmu.c b/arch/arm/plat-s5p/dev-pmu.c
new file mode 100644
index 0000000..de3b118
--- /dev/null
+++ b/arch/arm/plat-s5p/dev-pmu.c
@@ -0,0 +1,37 @@
+/*
+ * linux/arch/arm/plat-s5p/dev-pmu.c
+ *
+ * Copyright (C) 2010 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <asm/pmu.h>
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+static struct resource s5p_pmu_resource = {
+	.start	= IRQ_PMUIRQ,
+	.end	= IRQ_PMUIRQ,
+	.flags	= IORESOURCE_IRQ,
+};
+
+struct platform_device s5p_device_pmu = {
+	.name		= "arm-pmu",
+	.id		= ARM_PMU_DEVICE_CPU,
+	.num_resources	= 1,
+	.resource	= &s5p_pmu_resource,
+};
+
+static int __init s5p_pmu_init(void)
+{
+	platform_device_register(&s5p_device_pmu);
+	return 0;
+}
+arch_initcall(s5p_pmu_init);
-- 
1.7.0.4
