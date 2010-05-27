From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Thu, 27 May 2010 10:27:30 +0200
Subject: [PATCH 4/6] U6715 platform serial driver It's a generic driver for
	all U6 platform (V2)
In-Reply-To: <1274948852-9179-1-git-send-email-philippe.langlais@stericsson.com>
References: <1274948852-9179-1-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <1274948852-9179-5-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>
---
 arch/arm/plat-u6xxx/Makefile              |    2 +-
 arch/arm/plat-u6xxx/include/mach/serial.h |   23 ++++++
 arch/arm/plat-u6xxx/serial.c              |  115 +++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-u6xxx/include/mach/serial.h
 create mode 100644 arch/arm/plat-u6xxx/serial.c

diff --git a/arch/arm/plat-u6xxx/Makefile b/arch/arm/plat-u6xxx/Makefile
index 3d6898e..f12068c 100644
--- a/arch/arm/plat-u6xxx/Makefile
+++ b/arch/arm/plat-u6xxx/Makefile
@@ -3,6 +3,6 @@
 #
 
 # Common support
-obj-y := io.o irq.o clock.o gpio.o
+obj-y := io.o irq.o clock.o gpio.o serial.o
 
 obj-$(CONFIG_U6_MTU_TIMER) += timer.o
diff --git a/arch/arm/plat-u6xxx/include/mach/serial.h b/arch/arm/plat-u6xxx/include/mach/serial.h
new file mode 100644
index 0000000..a136e7f
--- /dev/null
+++ b/arch/arm/plat-u6xxx/include/mach/serial.h
@@ -0,0 +1,23 @@
+/*
+ * linux/arch/arm/plat-u6xxx/include/mach/serial.h
+ *
+ * Copyright (C) ST-Ericsson SA 2010
+ * Author: Ludovic Barre <ludovic.barre@stericsson.com> for ST-Ericsson.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+
+#ifndef __SERIAL_H
+#define __SERIAL_H
+
+#include <linux/clk.h>
+
+struct u6_uart {
+	struct clk *uartClk;
+	struct clk *pClk_13M;
+	struct clk *pClk_26M;
+	struct clk *pClk_pclk;
+	char   uart_name[7];
+};
+
+#endif   /* __SERIAL_H */
diff --git a/arch/arm/plat-u6xxx/serial.c b/arch/arm/plat-u6xxx/serial.c
new file mode 100644
index 0000000..a0e91dd
--- /dev/null
+++ b/arch/arm/plat-u6xxx/serial.c
@@ -0,0 +1,115 @@
+/*
+ * linux/arch/arm/plat-u6xxx/serial.c
+ *
+ * Copyright (C) ST-Ericsson SA 2010
+ * Author: Ludovic Barre <ludovic.barre@stericsson.com> for ST-Ericsson.
+ * License terms:  GNU General Public License (GPL), version 2
+ * U6 cpu type detection
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/serial_8250.h>
+#include <linux/slab.h>
+
+#include <mach/hardware.h>
+#include <mach/serial.h>
+
+#define BASE_BAUD	(7372800)
+
+/*
+ * Internal UARTs need to be initialized for the 8250 autoconfig to work
+ * properly. Note that the TX watermark initialization may not be needed
+ * once the 8250.c watermark handling code is merged.
+ */
+static struct plat_serial8250_port serial_platform_data[] = {
+	{
+		.membase	= (void __iomem *)IO_ADDRESS(UART1_BASE),
+		.mapbase	= UART1_BASE,
+		.irq		= IRQ_UART1,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= BASE_BAUD,
+	},
+	{
+		.membase	= (void __iomem *)IO_ADDRESS(UART2_BASE),
+		.mapbase	= UART2_BASE,
+		.irq		= IRQ_UART2,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= BASE_BAUD,
+	},
+	/* void declaration needed by serial core */
+	{
+		.flags		= 0
+	},
+};
+
+static struct platform_device serial_device = {
+	.name = "serial8250",
+	.id = 0,
+	.dev = {.platform_data = serial_platform_data,},
+};
+
+static int __init u6_serial_init(void)
+{
+	int i;
+	struct clk *pClk_13M;
+	struct clk *pClk_26M;
+	struct clk *pClk_pclk;
+	struct u6_uart *uart_u6;
+
+	pClk_13M = clk_get(NULL, "clk13m_ck");
+	pClk_26M = clk_get(NULL, "clk26m_ck");
+	pClk_pclk = clk_get(NULL, "pclk2_ck");
+
+	if (IS_ERR(pClk_13M) || IS_ERR(pClk_26M) || IS_ERR(pClk_pclk)) {
+		printk(KERN_WARNING "%s: parents clk failed\n", __func__);
+		goto out;
+	}
+
+	/* supress void element from loop */
+	for (i = 0; i < (ARRAY_SIZE(serial_platform_data) - 1); i++) {
+		struct clk *clk_tmp = NULL;
+
+		/* Allocation of u6 struct on uart X */
+		uart_u6 = kzalloc(sizeof(*uart_u6), GFP_KERNEL);
+		if (!uart_u6)
+			continue;
+
+		if (serial_platform_data[i].irq == IRQ_UART1) {
+			clk_tmp = clk_get(NULL, "UART1");
+			strcpy(uart_u6->uart_name, "UART1");
+		} else if (serial_platform_data[i].irq == IRQ_UART2) {
+			clk_tmp = clk_get(NULL, "UART2");
+			strcpy(uart_u6->uart_name, "UART2");
+		}
+
+		/* initialize pclk2 rate management withdrawn FIXME */
+
+		if (!IS_ERR(clk_tmp) && clk_tmp != NULL) {
+			uart_u6->uartClk = clk_tmp;
+			uart_u6->pClk_13M = pClk_13M;
+			uart_u6->pClk_26M = pClk_26M;
+			uart_u6->pClk_pclk = pClk_pclk;
+			serial_platform_data[i].private_data = uart_u6;
+		} else {
+			printk(KERN_WARNING
+			       "%s - get uart clock failed error:%ld\n",
+			       __func__, PTR_ERR(clk_tmp));
+			kfree(uart_u6);
+			continue;
+		}
+	}
+
+out:
+	/* free clks */
+	clk_put(pClk_13M);
+	clk_put(pClk_26M);
+	clk_put(pClk_pclk);
+
+	return platform_device_register(&serial_device);
+}
+arch_initcall(u6_serial_init);
-- 
1.7.1
