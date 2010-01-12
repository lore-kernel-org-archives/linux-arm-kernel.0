From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Jan 2010 17:49:36 +0900
Subject: [PATCH v4 8/8] ARM: S5P6440: Add serial port support
Message-ID: <1263286176-21502-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds UART serial port support for S5P6440 CPU. Most of the
serial support of Samsung's 6400 CPU is reused for 6440 CPU.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s3c/include/plat/devs.h |    1 +
 arch/arm/plat-s5p/dev-uart.c          |  165 +++++++++++++++++++++++++++++++++
 drivers/serial/Kconfig                |    8 +-
 3 files changed, 170 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/plat-s5p/dev-uart.c

diff --git a/arch/arm/plat-s3c/include/plat/devs.h b/arch/arm/plat-s3c/include/plat/devs.h
index c1c20b0..8a4153b 100644
--- a/arch/arm/plat-s3c/include/plat/devs.h
+++ b/arch/arm/plat-s3c/include/plat/devs.h
@@ -18,6 +18,7 @@ struct s3c24xx_uart_resources {
 
 extern struct s3c24xx_uart_resources s3c2410_uart_resources[];
 extern struct s3c24xx_uart_resources s3c64xx_uart_resources[];
+extern struct s3c24xx_uart_resources s5p_uart_resources[];
 
 extern struct platform_device *s3c24xx_uart_devs[];
 extern struct platform_device *s3c24xx_uart_src[];
diff --git a/arch/arm/plat-s5p/dev-uart.c b/arch/arm/plat-s5p/dev-uart.c
new file mode 100644
index 0000000..af726f4
--- /dev/null
+++ b/arch/arm/plat-s5p/dev-uart.c
@@ -0,0 +1,165 @@
+/* linux/arch/arm/plat-s5p/dev-uart.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Base S5P UART resource and device definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/irq.h>
+#include <mach/hardware.h>
+#include <mach/map.h>
+
+#include <plat/devs.h>
+
+ /* Serial port registrations */
+
+static struct resource s5p_uart0_resource[] = {
+	[0] = {
+		.start	= S5P_PA_UART0,
+		.end	= S5P_PA_UART0 + S5P_SZ_UART,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_S5P_UART_RX0,
+		.end	= IRQ_S5P_UART_RX0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_S5P_UART_TX0,
+		.end	= IRQ_S5P_UART_TX0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= IRQ_S5P_UART_ERR0,
+		.end	= IRQ_S5P_UART_ERR0,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct resource s5p_uart1_resource[] = {
+	[0] = {
+		.start	= S5P_PA_UART1,
+		.end	= S5P_PA_UART1 + S5P_SZ_UART,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_S5P_UART_RX1,
+		.end	= IRQ_S5P_UART_RX1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_S5P_UART_TX1,
+		.end	= IRQ_S5P_UART_TX1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= IRQ_S5P_UART_ERR1,
+		.end	= IRQ_S5P_UART_ERR1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource s5p_uart2_resource[] = {
+	[0] = {
+		.start	= S5P_PA_UART2,
+		.end	= S5P_PA_UART2 + S5P_SZ_UART,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_S5P_UART_RX2,
+		.end	= IRQ_S5P_UART_RX2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_S5P_UART_TX2,
+		.end	= IRQ_S5P_UART_TX2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= IRQ_S5P_UART_ERR2,
+		.end	= IRQ_S5P_UART_ERR2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource s5p_uart3_resource[] = {
+	[0] = {
+		.start	= S5P_PA_UART3,
+		.end	= S5P_PA_UART3 + S5P_SZ_UART,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_S5P_UART_RX3,
+		.end	= IRQ_S5P_UART_RX3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_S5P_UART_TX3,
+		.end	= IRQ_S5P_UART_TX3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= IRQ_S5P_UART_ERR3,
+		.end	= IRQ_S5P_UART_ERR3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct s3c24xx_uart_resources s5p_uart_resources[] __initdata = {
+	[0] = {
+		.resources	= s5p_uart0_resource,
+		.nr_resources	= ARRAY_SIZE(s5p_uart0_resource),
+	},
+	[1] = {
+		.resources	= s5p_uart1_resource,
+		.nr_resources	= ARRAY_SIZE(s5p_uart1_resource),
+	},
+	[2] = {
+		.resources	= s5p_uart2_resource,
+		.nr_resources	= ARRAY_SIZE(s5p_uart2_resource),
+	},
+	[3] = {
+		.resources	= s5p_uart3_resource,
+		.nr_resources	= ARRAY_SIZE(s5p_uart3_resource),
+	},
+};
+
+/* uart devices */
+
+static struct platform_device s5p_uart_device0 = {
+	.id		= 0,
+};
+
+static struct platform_device s5p_uart_device1 = {
+	.id		= 1,
+};
+
+static struct platform_device s5p_uart_device2 = {
+	.id		= 2,
+};
+
+static struct platform_device s5p_uart_device3 = {
+	.id		= 3,
+};
+
+struct platform_device *s3c24xx_uart_src[4] = {
+	&s5p_uart_device0,
+	&s5p_uart_device1,
+	&s5p_uart_device2,
+	&s5p_uart_device3,
+};
+
+struct platform_device *s3c24xx_uart_devs[4] = {
+};
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 9ff47db..d7d687f 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -459,7 +459,7 @@ config SERIAL_SAMSUNG_UARTS
 	int
 	depends on ARM && PLAT_S3C
 	default 2 if ARCH_S3C2400
-	default 4 if ARCH_S5PC1XX || ARCH_S3C64XX || CPU_S3C2443
+	default 4 if ARCH_S5P6440 || ARCH_S5PC1XX || ARCH_S3C64XX || CPU_S3C2443
 	default 3
 	help
 	  Select the number of available UART ports for the Samsung S3C
@@ -526,11 +526,11 @@ config SERIAL_S3C24A0
 	  Serial port support for the Samsung S3C24A0 SoC
 
 config SERIAL_S3C6400
-	tristate "Samsung S3C6400/S3C6410 Serial port support"
-	depends on SERIAL_SAMSUNG && (CPU_S3C6400 || CPU_S3C6410)
+	tristate "Samsung S3C6400/S3C6410/S5P6440 Serial port support"
+	depends on SERIAL_SAMSUNG && (CPU_S3C6400 || CPU_S3C6410 || CPU_S5P6440)
 	default y
 	help
-	  Serial port support for the Samsung S3C6400 and S3C6410
+	  Serial port support for the Samsung S3C6400, S3C6410 and S5P6440
 	  SoCs
 
 config SERIAL_S5PC100
-- 
1.6.2.5
