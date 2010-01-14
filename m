From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:28 +0100
Subject: [PATCH 10/21] drivers: serial: add support for Samsung S5PC110 SoC
	uart
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-11-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC110 SoCs have UART that differs a bit from the one known
from the previous Samsung SoCs. This patch adds support for this new
driver.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/plat-s3c/include/plat/regs-serial.h |   31 ++++++
 drivers/serial/Kconfig                       |    7 ++
 drivers/serial/Makefile                      |    1 +
 drivers/serial/s5pc110.c                     |  143 ++++++++++++++++++++++++++
 4 files changed, 182 insertions(+), 0 deletions(-)
 create mode 100644 drivers/serial/s5pc110.c

diff --git a/arch/arm/plat-s3c/include/plat/regs-serial.h b/arch/arm/plat-s3c/include/plat/regs-serial.h
index 85d8904..f38b852 100644
--- a/arch/arm/plat-s3c/include/plat/regs-serial.h
+++ b/arch/arm/plat-s3c/include/plat/regs-serial.h
@@ -194,6 +194,37 @@
 #define S3C64XX_UINTSP		0x34
 #define S3C64XX_UINTM		0x38
 
+/* S5PC110 UCON */
+#define S5PC110_UCON_CLKMASK	(1<<10)
+#define S5PC110_UCON_PCLK	(0<<10)
+#define S5PC110_UCON_SCLK_UART	(1<<10)
+
+/* S5PC110 FIFO trigger levels */
+#define S5PC110_UFCON_RXTRIG1	(0<<4)
+#define S5PC110_UFCON_RXTRIG4	(1<<4)
+#define S5PC110_UFCON_RXTRIG8	(2<<4)
+#define S5PC110_UFCON_RXTRIG16	(3<<4)
+#define S5PC110_UFCON_RXTRIG32	(4<<4)
+#define S5PC110_UFCON_RXTRIG64	(5<<4)
+#define S5PC110_UFCON_RXTRIG128	(6<<4)
+#define S5PC110_UFCON_RXTRIG256	(7<<4)
+
+#define S5PC110_UFCON_TXTRIG1	(0<<8)
+#define S5PC110_UFCON_TXTRIG4	(1<<8)
+#define S5PC110_UFCON_TXTRIG8	(2<<8)
+#define S5PC110_UFCON_TXTRIG16	(3<<8)
+#define S5PC110_UFCON_TXTRIG32	(4<<8)
+#define S5PC110_UFCON_TXTRIG64	(5<<8)
+#define S5PC110_UFCON_TXTRIG128	(6<<8)
+#define S5PC110_UFCON_TXTRIG256	(7<<8)
+
+#define S5PC110_UFSTAT_TXFULL	(1<<24)
+#define S5PC110_UFSTAT_RXFULL	(1<<8)
+#define S5PC110_UFSTAT_TXSHIFT	(16)
+#define S5PC110_UFSTAT_RXSHIFT	(0)
+#define S5PC110_UFSTAT_TXMASK	(255<<16)
+#define S5PC110_UFSTAT_RXMASK	(255)
+
 #ifndef __ASSEMBLY__
 
 /* struct s3c24xx_uart_clksrc
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index b8158a5..228f25f 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -533,6 +533,13 @@ config SERIAL_S3C6400
 	  Serial port support for the Samsung S3C6400, S3C6410 and
 	  S5PC100 SoCs
 
+config SERIAL_S5PC110
+	tristate "Samsung S5PC110 Serial port support"
+	depends on SERIAL_SAMSUNG && CPU_S5PC110
+	default y
+	help
+	  Serial port support for the Samsung S5PC110 SoCs
+
 config SERIAL_MAX3100
 	tristate "MAX3100 support"
 	depends on SPI
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index ce8c17f..02328c5 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_SERIAL_S3C2412) += s3c2412.o
 obj-$(CONFIG_SERIAL_S3C2440) += s3c2440.o
 obj-$(CONFIG_SERIAL_S3C24A0) += s3c24a0.o
 obj-$(CONFIG_SERIAL_S3C6400) += s3c6400.o
+obj-$(CONFIG_SERIAL_S5PC110) += s5pc110.o
 obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
 obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
 obj-$(CONFIG_SERIAL_MUX) += mux.o
diff --git a/drivers/serial/s5pc110.c b/drivers/serial/s5pc110.c
new file mode 100644
index 0000000..1e1e229
--- /dev/null
+++ b/drivers/serial/s5pc110.c
@@ -0,0 +1,143 @@
+/*
+ * linux/drivers/serial/s5pc110.c
+ *
+ * Driver for Samsung S5PC110 SoC onboard UARTs.
+ *
+ *  Copyright 2009 Samsung Electronics
+ *  Kyungin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
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
+
+#include <plat/regs-serial.h>
+
+#include "samsung.h"
+
+static int s5pc110_serial_setsource(struct uart_port *port,
+				    struct s3c24xx_uart_clksrc *clk)
+{
+	unsigned long ucon = rd_regl(port, S3C2410_UCON);
+
+	if (strcmp(clk->name, "uclk0") == 0)
+		ucon |= S5PC110_UCON_SCLK_UART;
+	else if (strcmp(clk->name, "pclk") == 0)
+		/* See notes about transitioning from UCLK to PCLK */
+		ucon &= ~S5PC110_UCON_SCLK_UART;
+	else {
+		printk(KERN_ERR "unknown clock source %s\n", clk->name);
+		return -EINVAL;
+	}
+
+	wr_regl(port, S3C2410_UCON, ucon);
+	return 0;
+}
+
+static int s5pc110_serial_getsource(struct uart_port *port,
+				    struct s3c24xx_uart_clksrc *clk)
+{
+	u32 ucon = rd_regl(port, S3C2410_UCON);
+
+	clk->divisor = 1;
+
+	switch (ucon & S5PC110_UCON_CLKMASK) {
+	case S5PC110_UCON_SCLK_UART:
+		clk->name = "uclk0";
+		break;
+
+	case S5PC110_UCON_PCLK:
+		clk->name = "pclk";
+		break;
+	}
+
+	return 0;
+}
+
+static int s5pc110_serial_resetport(struct uart_port *port,
+				    struct s3c2410_uartcfg *cfg)
+{
+	unsigned long ucon = rd_regl(port, S3C2410_UCON);
+
+	dbg("s5pc110_serial_resetport: port=%p (%08lx), cfg=%p\n",
+	    port, port->mapbase, cfg);
+
+	/* ensure we don't change the clock settings... */
+
+	ucon &= S5PC110_UCON_CLKMASK;
+
+	wr_regl(port, S3C2410_UCON,  ucon | cfg->ucon);
+	wr_regl(port, S3C2410_ULCON, cfg->ulcon);
+
+	/* reset both fifos */
+
+	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
+	wr_regl(port, S3C2410_UFCON, cfg->ufcon);
+
+	return 0;
+}
+
+static struct s3c24xx_uart_info s5pc110_uart_inf = {
+	.name		= "Samsung S5PC110 UART",
+	.type		= PORT_S3C6400,
+	.fifosize	= 16,
+	.has_divslot	= 1,
+	.rx_fifomask	= S5PC110_UFSTAT_RXMASK,
+	.rx_fifoshift	= S5PC110_UFSTAT_RXSHIFT,
+	.rx_fifofull	= S5PC110_UFSTAT_RXFULL,
+	.tx_fifofull	= S5PC110_UFSTAT_TXFULL,
+	.tx_fifomask	= S5PC110_UFSTAT_TXMASK,
+	.tx_fifoshift	= S5PC110_UFSTAT_TXSHIFT,
+	.get_clksrc	= s5pc110_serial_getsource,
+	.set_clksrc	= s5pc110_serial_setsource,
+	.reset_port	= s5pc110_serial_resetport,
+};
+
+/* device management */
+
+static int s5pc110_serial_probe(struct platform_device *dev)
+{
+	dbg("s5pc110_serial_probe: dev=%p\n", dev);
+
+	return s3c24xx_serial_probe(dev, &s5pc110_uart_inf);
+}
+
+static struct platform_driver s5pc110_serial_driver = {
+	.probe		= s5pc110_serial_probe,
+	.remove		= __devexit_p(s3c24xx_serial_remove),
+	.driver		= {
+		.name	= "s5pc110-uart",
+		.owner	= THIS_MODULE,
+	},
+};
+
+s3c24xx_console_init(&s5pc110_serial_driver, &s5pc110_uart_inf);
+
+static int __init s5pc110_serial_init(void)
+{
+	return s3c24xx_serial_init(&s5pc110_serial_driver, &s5pc110_uart_inf);
+}
+
+static void __exit s5pc110_serial_exit(void)
+{
+	platform_driver_unregister(&s5pc110_serial_driver);
+}
+
+module_init(s5pc110_serial_init);
+module_exit(s5pc110_serial_exit);
+
+MODULE_DESCRIPTION("Samsung S5PC110 SoC Serial port driver");
+MODULE_AUTHOR("Kyungmin Park <kyungmin.park@samsung.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:s5pc110-uart");
-- 
1.6.4
