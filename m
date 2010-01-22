From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 22 Jan 2010 09:22:34 +0900
Subject: [PATCH v3 9/9] ARM: S5PV210: Add serial port support
Message-ID: <1264119754-15857-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds UART serial port support for S5PV210.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s3c/include/plat/regs-serial.h |   30 +++++
 drivers/serial/Kconfig                       |    9 ++-
 drivers/serial/Makefile                      |    1 +
 drivers/serial/s5pv210.c                     |  154 ++++++++++++++++++++++++++
 4 files changed, 193 insertions(+), 1 deletions(-)
 create mode 100644 drivers/serial/s5pv210.c

diff --git a/arch/arm/plat-s3c/include/plat/regs-serial.h b/arch/arm/plat-s3c/include/plat/regs-serial.h
index 85d8904..60d6604 100644
--- a/arch/arm/plat-s3c/include/plat/regs-serial.h
+++ b/arch/arm/plat-s3c/include/plat/regs-serial.h
@@ -194,6 +194,36 @@
 #define S3C64XX_UINTSP		0x34
 #define S3C64XX_UINTM		0x38
 
+/* Following are specific to S5PV210 and S5P6442 */
+#define S5PV210_UCON_CLKMASK	(1<<10)
+#define S5PV210_UCON_PCLK	(0<<10)
+#define S5PV210_UCON_UCLK	(1<<10)
+
+#define S5PV210_UFCON_TXTRIG0	(0<<8)
+#define S5PV210_UFCON_TXTRIG4	(1<<8)
+#define S5PV210_UFCON_TXTRIG8	(2<<8)
+#define S5PV210_UFCON_TXTRIG16	(3<<8)
+#define S5PV210_UFCON_TXTRIG32	(4<<8)
+#define S5PV210_UFCON_TXTRIG64	(5<<8)
+#define S5PV210_UFCON_TXTRIG128 (6<<8)
+#define S5PV210_UFCON_TXTRIG256 (7<<8)
+
+#define S5PV210_UFCON_RXTRIG1	(0<<4)
+#define S5PV210_UFCON_RXTRIG4	(1<<4)
+#define S5PV210_UFCON_RXTRIG8	(2<<4)
+#define S5PV210_UFCON_RXTRIG16	(3<<4)
+#define S5PV210_UFCON_RXTRIG32	(4<<4)
+#define S5PV210_UFCON_RXTRIG64	(5<<4)
+#define S5PV210_UFCON_RXTRIG128	(6<<4)
+#define S5PV210_UFCON_RXTRIG256	(7<<4)
+
+#define S5PV210_UFSTAT_TXFULL	(1<<24)
+#define S5PV210_UFSTAT_RXFULL	(1<<8)
+#define S5PV210_UFSTAT_TXMASK	(255<<16)
+#define S5PV210_UFSTAT_TXSHIFT	(16)
+#define S5PV210_UFSTAT_RXMASK	(255<<0)
+#define S5PV210_UFSTAT_RXSHIFT	(0)
+
 #ifndef __ASSEMBLY__
 
 /* struct s3c24xx_uart_clksrc
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index d7d687f..ebdd2b9 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -459,7 +459,7 @@ config SERIAL_SAMSUNG_UARTS
 	int
 	depends on ARM && PLAT_S3C
 	default 2 if ARCH_S3C2400
-	default 4 if ARCH_S5P6440 || ARCH_S5PC1XX || ARCH_S3C64XX || CPU_S3C2443
+	default 4 if ARCH_S5P6440 || ARCH_S5PC1XX || ARCH_S5PV210 || ARCH_S3C64XX || CPU_S3C2443
 	default 3
 	help
 	  Select the number of available UART ports for the Samsung S3C
@@ -540,6 +540,13 @@ config SERIAL_S5PC100
 	help
 	  Serial port support for the Samsung S5PC100 SoCs
 
+config SERIAL_S5PV210
+	tristate "Samsung S5PV210 Serial port support"
+	depends on SERIAL_SAMSUNG && CPU_S5PV210
+	default y
+	help
+	  Serial port support for Samsung's S5P Family of SoC's
+
 config SERIAL_MAX3100
 	tristate "MAX3100 support"
 	depends on SPI
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 5548fe7..6aa4723 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_SERIAL_S3C2440) += s3c2440.o
 obj-$(CONFIG_SERIAL_S3C24A0) += s3c24a0.o
 obj-$(CONFIG_SERIAL_S3C6400) += s3c6400.o
 obj-$(CONFIG_SERIAL_S5PC100) += s3c6400.o
+obj-$(CONFIG_SERIAL_S5PV210) += s5pv210.o
 obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
 obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
 obj-$(CONFIG_SERIAL_MUX) += mux.o
diff --git a/drivers/serial/s5pv210.c b/drivers/serial/s5pv210.c
new file mode 100644
index 0000000..8dc0383
--- /dev/null
+++ b/drivers/serial/s5pv210.c
@@ -0,0 +1,154 @@
+/* linux/drivers/serial/s5pv210.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Based on drivers/serial/s3c6400.c
+ *
+ * Driver for Samsung S5PV210 SoC UARTs.
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
+
+#include <asm/irq.h>
+#include <mach/hardware.h>
+#include <plat/regs-serial.h>
+#include "samsung.h"
+
+static int s5pv210_serial_setsource(struct uart_port *port,
+					struct s3c24xx_uart_clksrc *clk)
+{
+	unsigned long ucon = rd_regl(port, S3C2410_UCON);
+
+	if (strcmp(clk->name, "pclk") == 0)
+		ucon &= ~S5PV210_UCON_CLKMASK;
+	else if (strcmp(clk->name, "uclk1") == 0)
+		ucon |= S5PV210_UCON_CLKMASK;
+	else {
+		printk(KERN_ERR "unknown clock source %s\n", clk->name);
+		return -EINVAL;
+	}
+
+	wr_regl(port, S3C2410_UCON, ucon);
+	return 0;
+}
+
+
+static int s5pv210_serial_getsource(struct uart_port *port,
+					struct s3c24xx_uart_clksrc *clk)
+{
+	u32 ucon = rd_regl(port, S3C2410_UCON);
+
+	clk->divisor = 1;
+
+	switch (ucon & S5PV210_UCON_CLKMASK) {
+	case S5PV210_UCON_PCLK:
+		clk->name = "pclk";
+		break;
+	case S5PV210_UCON_UCLK:
+		clk->name = "uclk1";
+		break;
+	}
+
+	return 0;
+}
+
+static int s5pv210_serial_resetport(struct uart_port *port,
+					struct s3c2410_uartcfg *cfg)
+{
+	unsigned long ucon = rd_regl(port, S3C2410_UCON);
+
+	ucon &= S5PV210_UCON_CLKMASK;
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
+#define S5PV210_UART_DEFAULT_INFO(fifo_size)			\
+		.name		= "Samsung S5PV210 UART0",	\
+		.type		= PORT_S3C6400,			\
+		.fifosize	= fifo_size,			\
+		.has_divslot	= 1,				\
+		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
+		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
+		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,	\
+		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,	\
+		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,	\
+		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,	\
+		.get_clksrc	= s5pv210_serial_getsource,	\
+		.set_clksrc	= s5pv210_serial_setsource,	\
+		.reset_port	= s5pv210_serial_resetport
+
+static struct s3c24xx_uart_info s5p_port_fifo256 = {
+	S5PV210_UART_DEFAULT_INFO(256),
+};
+
+static struct s3c24xx_uart_info s5p_port_fifo64 = {
+	S5PV210_UART_DEFAULT_INFO(64),
+};
+
+static struct s3c24xx_uart_info s5p_port_fifo16 = {
+	S5PV210_UART_DEFAULT_INFO(16),
+};
+
+static struct s3c24xx_uart_info *s5p_uart_inf[] = {
+	[0] = &s5p_port_fifo256,
+	[1] = &s5p_port_fifo64,
+	[2] = &s5p_port_fifo16,
+	[3] = &s5p_port_fifo16,
+};
+
+/* device management */
+static int s5p_serial_probe(struct platform_device *pdev)
+{
+	return s3c24xx_serial_probe(pdev, s5p_uart_inf[pdev->id]);
+}
+
+static struct platform_driver s5p_serial_drv = {
+	.probe		= s5p_serial_probe,
+	.remove		= __devexit_p(s3c24xx_serial_remove),
+	.driver		= {
+		.name	= "s5pv210-uart",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init s5pv210_serial_console_init(void)
+{
+	return s3c24xx_serial_initconsole(&s5p_serial_drv, s5p_uart_inf);
+}
+
+console_initcall(s5pv210_serial_console_init);
+
+static int __init s5p_serial_init(void)
+{
+	return s3c24xx_serial_init(&s5p_serial_drv, *s5p_uart_inf);
+}
+
+static void __exit s5p_serial_exit(void)
+{
+	platform_driver_unregister(&s5p_serial_drv);
+}
+
+module_init(s5p_serial_init);
+module_exit(s5p_serial_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:s5pv210-uart");
+MODULE_DESCRIPTION("Samsung S5PV210 UART Driver support");
+MODULE_AUTHOR("Thomas Abraham <thomas.ab@samsung.com>");
-- 
1.6.2.5
