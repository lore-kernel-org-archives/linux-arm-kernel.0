From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 22 Jan 2010 09:17:38 +0900
Subject: [PATCH 8/8] ARM: S5P6442: Add serial port support
Message-ID: <1264119458-14698-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Atul Dahiya <atul.dahiya@samsung.com>

This patch adds UART serial port support for S5P6442 CPU.

Signed-off-by: Aditya Paratap Sharma <aditya.ps@samsung.com>
Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s3c/include/plat/regs-serial.h |    8 ++
 arch/arm/plat-s5p/dev-uart.c                 |    2 +
 drivers/serial/Kconfig                       |    7 +
 drivers/serial/Makefile                      |    1 +
 drivers/serial/s5p6442.c                     |  172 ++++++++++++++++++++++++++
 5 files changed, 190 insertions(+), 0 deletions(-)
 create mode 100644 drivers/serial/s5p6442.c

diff --git a/arch/arm/plat-s3c/include/plat/regs-serial.h b/arch/arm/plat-s3c/include/plat/regs-serial.h
index 85d8904..b67d8e9 100644
--- a/arch/arm/plat-s3c/include/plat/regs-serial.h
+++ b/arch/arm/plat-s3c/include/plat/regs-serial.h
@@ -171,6 +171,14 @@
 #define S3C2440_UFSTAT_TXMASK	  (63<<8)
 #define S3C2440_UFSTAT_RXMASK	  (63)
 
+/* UFSTAT S5P6442 */
+#define S5P6442_UFSTAT_RXMASK	(255<<0)
+#define S5P6442_UFSTAT_RXSHIFT	(0)
+#define S5P6442_UFSTAT_RXFULL	(1<<8)
+#define S5P6442_UFSTAT_TXFULL	(1<<24)
+#define S5P6442_UFSTAT_TXMASK	(255<<16)
+#define S5P6442_UFSTAT_TXSHIFT	(16)
+
 #define S3C2410_UTRSTAT_TXE	  (1<<2)
 #define S3C2410_UTRSTAT_TXFE	  (1<<1)
 #define S3C2410_UTRSTAT_RXDR	  (1<<0)
diff --git a/arch/arm/plat-s5p/dev-uart.c b/arch/arm/plat-s5p/dev-uart.c
index 23c7531..a89331e 100644
--- a/arch/arm/plat-s5p/dev-uart.c
+++ b/arch/arm/plat-s5p/dev-uart.c
@@ -95,6 +95,7 @@ static struct resource s5p_uart2_resource[] = {
 };
 
 static struct resource s5p_uart3_resource[] = {
+#if CONFIG_SERIAL_SAMSUNG_UARTS > 3
 	[0] = {
 		.start	= S5P_PA_UART3,
 		.end	= S5P_PA_UART3 + S5P_SZ_UART,
@@ -115,6 +116,7 @@ static struct resource s5p_uart3_resource[] = {
 		.end	= IRQ_S5P_UART_ERR3,
 		.flags	= IORESOURCE_IRQ,
 	},
+#endif
 };
 
 struct s3c24xx_uart_resources s5p_uart_resources[] __initdata = {
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index d7d687f..b7950c1 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -533,6 +533,13 @@ config SERIAL_S3C6400
 	  Serial port support for the Samsung S3C6400, S3C6410 and S5P6440
 	  SoCs
 
+config SERIAL_S5P6442
+	tristate "Samsung S5P6442 Serial port support"
+	depends on SERIAL_SAMSUNG && CPU_S5P6442
+	default y
+	help
+	  Serial port support for the Samsung S5P6442 SoCs
+
 config SERIAL_S5PC100
 	tristate "Samsung S5PC100 Serial port support"
 	depends on SERIAL_SAMSUNG && CPU_S5PC100
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 5548fe7..2a8d745 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_SERIAL_S3C2440) += s3c2440.o
 obj-$(CONFIG_SERIAL_S3C24A0) += s3c24a0.o
 obj-$(CONFIG_SERIAL_S3C6400) += s3c6400.o
 obj-$(CONFIG_SERIAL_S5PC100) += s3c6400.o
+obj-$(CONFIG_SERIAL_S5P6442) += s5p6442.o
 obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
 obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
 obj-$(CONFIG_SERIAL_MUX) += mux.o
diff --git a/drivers/serial/s5p6442.c b/drivers/serial/s5p6442.c
new file mode 100644
index 0000000..b66f194
--- /dev/null
+++ b/drivers/serial/s5p6442.c
@@ -0,0 +1,172 @@
+/* linux/drivers/serial/s5p6442.c
+ *
+ * Based on drivers/serial/s3c6400.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Driver for Samsung S5P6442 SoC onboard UARTs.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <asm/irq.h>
+#include <mach/hardware.h>
+#include <plat/regs-serial.h>
+#include "samsung.h"
+
+static int uart_portno;
+
+static int s5p6442_serial_setsource(struct uart_port *port,
+				    struct s3c24xx_uart_clksrc *clk)
+{
+	unsigned long ucon = rd_regl(port, S3C2410_UCON);
+
+	if (strcmp(clk->name, "uclk0") == 0) {
+		ucon &= ~S3C6400_UCON_CLKMASK;
+		ucon |= S3C6400_UCON_UCLK0;
+	} else if (strcmp(clk->name, "uclk1") == 0)
+		ucon |= S3C6400_UCON_UCLK1;
+	else if (strcmp(clk->name, "pclk") == 0) {
+		/* See notes about transitioning from UCLK to PCLK */
+		ucon &= ~S3C6400_UCON_UCLK0;
+	} else {
+		printk(KERN_ERR "unknown clock source %s\n", clk->name);
+		return -EINVAL;
+	}
+
+	wr_regl(port, S3C2410_UCON, ucon);
+	return 0;
+}
+
+static int s5p6442_serial_getsource(struct uart_port *port,
+				    struct s3c24xx_uart_clksrc *clk)
+{
+	u32 ucon = rd_regl(port, S3C2410_UCON);
+
+	clk->divisor = 1;
+
+	switch (ucon & S3C6400_UCON_CLKMASK) {
+	case S3C6400_UCON_UCLK1:
+		clk->name = "uclk1";
+		break;
+
+	case S3C6400_UCON_PCLK:
+	case S3C6400_UCON_PCLK2:
+		clk->name = "pclk";
+		break;
+	}
+	return 0;
+}
+
+static int s5p6442_serial_resetport(struct uart_port *port,
+				    struct s3c2410_uartcfg *cfg)
+{
+	unsigned long ucon = rd_regl(port, S3C2410_UCON);
+
+	dbg("s5p6442_serial_resetport: port=%p (%08lx), cfg=%p\n",
+					port, port->mapbase, cfg);
+
+	ucon &= S3C6400_UCON_CLKMASK;
+
+	wr_regl(port, S3C2410_UCON,  ucon | cfg->ucon);
+	wr_regl(port, S3C2410_ULCON, cfg->ulcon);
+
+	/* reset both fifos */
+	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
+	wr_regl(port, S3C2410_UFCON, cfg->ufcon);
+
+	return 0;
+}
+
+static struct s3c24xx_uart_info s5p6442_uart_inf[] = {
+	[0] = {
+		.name		= "Samsung S5P6442 UART0",
+		.type		= PORT_S3C6400,
+		.fifosize	= 256,
+		.rx_fifomask	= S5P6442_UFSTAT_RXMASK,
+		.rx_fifoshift	= S5P6442_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S5P6442_UFSTAT_RXFULL,
+		.tx_fifofull	= S5P6442_UFSTAT_TXFULL,
+		.tx_fifomask	= S5P6442_UFSTAT_TXMASK,
+		.tx_fifoshift	= S5P6442_UFSTAT_TXSHIFT,
+		.get_clksrc	= s5p6442_serial_getsource,
+		.set_clksrc	= s5p6442_serial_setsource,
+		.reset_port	= s5p6442_serial_resetport,
+	},
+	[1] = {
+		.name		= "Samsung S5P6442 UART1",
+		.type		= PORT_S3C6400,
+		.fifosize	= 64,
+		.rx_fifomask	= S5P6442_UFSTAT_RXMASK,
+		.rx_fifoshift	= S5P6442_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S5P6442_UFSTAT_RXFULL,
+		.tx_fifofull	= S5P6442_UFSTAT_TXFULL,
+		.tx_fifomask	= S5P6442_UFSTAT_TXMASK,
+		.tx_fifoshift	= S5P6442_UFSTAT_TXSHIFT,
+		.get_clksrc	= s5p6442_serial_getsource,
+		.set_clksrc	= s5p6442_serial_setsource,
+		.reset_port	= s5p6442_serial_resetport,
+	},
+	[2] = {
+		.name		= "Samsung S5P6442 UART2",
+		.type		= PORT_S3C6400,
+		.fifosize	= 16,
+		.rx_fifomask	= S5P6442_UFSTAT_RXMASK,
+		.rx_fifoshift	= S5P6442_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S5P6442_UFSTAT_RXFULL,
+		.tx_fifofull	= S5P6442_UFSTAT_TXFULL,
+		.tx_fifomask	= S5P6442_UFSTAT_TXMASK,
+		.tx_fifoshift	= S5P6442_UFSTAT_TXSHIFT,
+		.get_clksrc	= s5p6442_serial_getsource,
+		.set_clksrc	= s5p6442_serial_setsource,
+		.reset_port	= s5p6442_serial_resetport,
+	},
+};
+
+/* device management */
+static int s5p6442_serial_probe(struct platform_device *dev)
+{
+	int ret;
+	ret = s3c24xx_serial_probe(dev, &s5p6442_uart_inf[uart_portno]);
+	uart_portno++;
+	return ret;
+}
+
+static struct platform_driver s5p6442_serial_drv = {
+	.probe		= s5p6442_serial_probe,
+	.remove		= s3c24xx_serial_remove,
+	.driver		= {
+		.name	= "s5p6442-uart",
+		.owner	= THIS_MODULE,
+	},
+};
+
+s3c24xx_console_init(&s5p6442_serial_drv, s5p6442_uart_inf);
+
+static int __init s5p6442_serial_init(void)
+{
+	return s3c24xx_serial_init(&s5p6442_serial_drv, s5p6442_uart_inf);
+}
+
+static void __exit s5p6442_serial_exit(void)
+{
+	platform_driver_unregister(&s5p6442_serial_drv);
+}
+
+module_init(s5p6442_serial_init);
+module_exit(s5p6442_serial_exit);
+
+MODULE_DESCRIPTION("Samsung S5P6442 Serial driver, based on S3C6400 driver");
+MODULE_AUTHOR("Aditya Pratap <aditya.ps@samsung.com");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:s5p6442-uart");
-- 
1.6.2.5
