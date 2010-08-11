From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Aug 2010 14:03:51 +0200
Subject: [PATCH 2/9] ARM: S5PV210: add initial device-table
In-Reply-To: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
References: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1281528238-7298-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the initial device-table for S5PV210 SoCs. Contains only
definitions for UART devices.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Makefile           |    1 +
 arch/arm/mach-s5pv210/cpu.c              |    1 +
 arch/arm/mach-s5pv210/dev-table.c        |   71 ++++++++++++++++++++++++++++++
 arch/arm/plat-s5p/include/plat/s5pv210.h |    1 +
 4 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/dev-table.c

diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 05048c5..6f7c13b 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -14,6 +14,7 @@ obj-				:=
 
 obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o dma.o gpiolib.o
 obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
+obj-$(CONFIG_CPU_S5PV210)	+= dev-table.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index c7e0b8a..785f011 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -87,6 +87,7 @@ static void s5pv210_sw_reset(void)
 void __init s5pv210_map_io(void)
 {
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
+	s5pv210_register_devtable();
 
 	/* initialise device information early */
 	s5pv210_default_sdhci0();
diff --git a/arch/arm/mach-s5pv210/dev-table.c b/arch/arm/mach-s5pv210/dev-table.c
new file mode 100644
index 0000000..396c4a7
--- /dev/null
+++ b/arch/arm/mach-s5pv210/dev-table.c
@@ -0,0 +1,71 @@
+/* linux/arch/arm/mach-s5pv210/dev-table.c
+ *
+ * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
+ *
+ * S5PV210 series device creation code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+
+#include <plat/devs.h>
+#include <plat/dev-core.h>
+#include <plat/cpu.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+#include <mach/dma.h>
+
+#include <plat/sdhci.h>
+#include <plat/iic.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/onenand.h>
+
+/* note, table is not ordered */
+
+struct s3c_pdev_table s5pv210_dev_table[] __initdata = {
+	{
+		.type	= SAMSUNG_DEVICE_UART,
+		.name	= "s5pv210-uart",
+		.index	= 0,
+		.res	= {
+			S5P_PA_UART0,
+			IRQ_S5P_UART_RX0, IRQ_S5P_UART_TX0, IRQ_S5P_UART_ERR0,
+		},
+	}, {
+		.type	= SAMSUNG_DEVICE_UART,
+		.name	= "s5pv210-uart",
+		.index	= 1,
+		.res	= {
+			S5P_PA_UART1,
+			IRQ_S5P_UART_RX1, IRQ_S5P_UART_TX1, IRQ_S5P_UART_ERR1,
+		},
+	}, {
+		.type	= SAMSUNG_DEVICE_UART,
+		.name	= "s5pv210-uart",
+		.index	= 2,
+		.res	= {
+			S5P_PA_UART2,
+			IRQ_S5P_UART_RX2, IRQ_S5P_UART_TX2, IRQ_S5P_UART_ERR2,
+		},
+	}, {
+		.type	= SAMSUNG_DEVICE_UART,
+		.name	= "s5pv210-uart",
+		.index	= 3,
+		.res	= {
+			S5P_PA_UART3,
+			IRQ_S5P_UART_RX3, IRQ_S5P_UART_TX3, IRQ_S5P_UART_ERR3,
+		},
+	},
+};
+
+void __init s5pv210_register_devtable(void)
+{
+	s3c_device_register_table(s5pv210_dev_table,
+				  ARRAY_SIZE(s5pv210_dev_table));
+}
diff --git a/arch/arm/plat-s5p/include/plat/s5pv210.h b/arch/arm/plat-s5p/include/plat/s5pv210.h
index 6c93a0c..49dac0b 100644
--- a/arch/arm/plat-s5p/include/plat/s5pv210.h
+++ b/arch/arm/plat-s5p/include/plat/s5pv210.h
@@ -15,6 +15,7 @@
 extern void s5pv210_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s5pv210_register_clocks(void);
 extern void s5pv210_setup_clocks(void);
+extern void s5pv210_register_devtable(void);
 
 #ifdef CONFIG_CPU_S5PV210
 
-- 
1.7.1.569.g6f426
