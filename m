From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 15 Jul 2010 10:31:34 +0900
Subject: [PATCH v2] ARM: S5P: Add PMU device
Message-ID: <1279157494-22329-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an initcall for the s5p platforms so that they register
their PMU IRQs with the PMU framework in the Kernel.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5p6440/include/mach/irqs.h |    2 +-
 arch/arm/mach-s5p6442/include/mach/irqs.h |    2 +-
 arch/arm/mach-s5pc100/include/mach/irqs.h |    2 +-
 arch/arm/mach-s5pv210/include/mach/irqs.h |    2 +-
 arch/arm/plat-s5p/Makefile                |    1 +
 arch/arm/plat-s5p/dev-pmu.c               |   36 +++++++++++++++++++++++++++++
 6 files changed, 41 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/plat-s5p/dev-pmu.c

diff --git a/arch/arm/mach-s5p6440/include/mach/irqs.h b/arch/arm/mach-s5p6440/include/mach/irqs.h
index 911854d..16a7612 100644
--- a/arch/arm/mach-s5p6440/include/mach/irqs.h
+++ b/arch/arm/mach-s5p6440/include/mach/irqs.h
@@ -51,7 +51,7 @@
 #define IRQ_DISPCON3		S5P_IRQ_VIC1(19)
 #define IRQ_FIMGVG		S5P_IRQ_VIC1(20)
 #define IRQ_EINT_GROUPS		S5P_IRQ_VIC1(21)
-#define IRQ_PMUIRQ		S5P_IRQ_VIC1(23)
+#define IRQ_PMU			S5P_IRQ_VIC1(23)
 #define IRQ_HSMMC0		S5P_IRQ_VIC1(24)
 #define IRQ_HSMMC1		S5P_IRQ_VIC1(25)
 #define IRQ_HSMMC2		IRQ_SPI1	/* shared with SPI1 */
diff --git a/arch/arm/mach-s5p6442/include/mach/irqs.h b/arch/arm/mach-s5p6442/include/mach/irqs.h
index 02c2374..3fbc6c3 100644
--- a/arch/arm/mach-s5p6442/include/mach/irqs.h
+++ b/arch/arm/mach-s5p6442/include/mach/irqs.h
@@ -32,7 +32,7 @@
 #define IRQ_GPIOINT		S5P_IRQ_VIC0(30)
 
 /* VIC1 */
-#define IRQ_nPMUIRQ 		S5P_IRQ_VIC1(0)
+#define IRQ_PMU			S5P_IRQ_VIC1(0)
 #define IRQ_ONENAND 		S5P_IRQ_VIC1(7)
 #define IRQ_UART0 		S5P_IRQ_VIC1(10)
 #define IRQ_UART1 		S5P_IRQ_VIC1(11)
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
index 28aa551..59e90bf 100644
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
@@ -29,7 +29,7 @@
 #define IRQ_GPIOINT		S5P_IRQ_VIC0(30)
 
 /* VIC1: ARM, power, memory, connectivity */
-#define IRQ_CORTEX0		S5P_IRQ_VIC1(0)
+#define IRQ_PMU			S5P_IRQ_VIC1(0)
 #define IRQ_CORTEX1		S5P_IRQ_VIC1(1)
 #define IRQ_CORTEX2		S5P_IRQ_VIC1(2)
 #define IRQ_CORTEX3		S5P_IRQ_VIC1(3)
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 9689537..b55f9e0 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -36,7 +36,7 @@
 
 /* VIC1: ARM, Power, Memory, Connectivity, Storage */
 
-#define IRQ_CORTEX0		S5P_IRQ_VIC1(0)
+#define IRQ_PMU			S5P_IRQ_VIC1(0)
 #define IRQ_CORTEX1		S5P_IRQ_VIC1(1)
 #define IRQ_CORTEX2		S5P_IRQ_VIC1(2)
 #define IRQ_CORTEX3		S5P_IRQ_VIC1(3)
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
index 0000000..a08576d
--- /dev/null
+++ b/arch/arm/plat-s5p/dev-pmu.c
@@ -0,0 +1,36 @@
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
+
+static struct resource s5p_pmu_resource = {
+	.start	= IRQ_PMU,
+	.end	= IRQ_PMU,
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
