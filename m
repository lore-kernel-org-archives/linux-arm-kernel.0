From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jun 2010 23:27:17 +0900
Subject: [PATCH 8/8] ARM: S5PV310: Add serial port support
In-Reply-To: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
References: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1277476037-8806-9-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds UART serial port support for S5PV310 CPU.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/serial/Kconfig   |    8 +++
 drivers/serial/Makefile  |    1 +
 drivers/serial/s5pv310.c |  124 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 0 deletions(-)
 create mode 100644 drivers/serial/s5pv310.c

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 8b23165..b5ff41f 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -550,6 +550,14 @@ config SERIAL_S5PV210
 	help
 	  Serial port support for Samsung's S5P Family of SoC's
 
+config SERIAL_S5PV310
+	tristate "Samsung S5PV310 Serial port support"
+	depends on SERIAL_SAMSUNG && CPU_S5PV310
+	select SERIAL_SAMSUNG_UARTS_4
+	default y
+	help
+	  Serial port support for Samsung's S5P Family of SoC's
+
 config SERIAL_MAX3100
 	tristate "MAX3100 support"
 	depends on SPI
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 208a855..bd32d3f 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_SERIAL_S3C2440) += s3c2440.o
 obj-$(CONFIG_SERIAL_S3C24A0) += s3c24a0.o
 obj-$(CONFIG_SERIAL_S3C6400) += s3c6400.o
 obj-$(CONFIG_SERIAL_S5PV210) += s5pv210.o
+obj-$(CONFIG_SERIAL_S5PV310) += s5pv310.o
 obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
 obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
 obj-$(CONFIG_SERIAL_MUX) += mux.o
diff --git a/drivers/serial/s5pv310.c b/drivers/serial/s5pv310.c
new file mode 100644
index 0000000..1d466cf
--- /dev/null
+++ b/drivers/serial/s5pv310.c
@@ -0,0 +1,124 @@
+/* linux/drivers/serial/s5pv310.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Based on drivers/serial/s5pv210.c
+ *
+ * Driver for Samsung S5PV310 SoC UARTs.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/serial_core.h>
+
+#include <plat/regs-serial.h>
+#include "samsung.h"
+
+static int s5pv310_serial_setsource(struct uart_port *port,
+				    struct s3c24xx_uart_clksrc *clk)
+{
+	/* for s5pv310, serial clock source is only uclk1 */
+	return 0;
+};
+
+static int s5pv310_serial_getsource(struct uart_port *port,
+				    struct s3c24xx_uart_clksrc *clk)
+{
+	/* for s5pv310, serial clock source is only uclk1 */
+	clk->divisor = 1;
+	clk->name = "uclk1";
+	return 0;
+};
+
+static int s5pv310_serial_resetport(struct uart_port *port,
+				    struct s3c2410_uartcfg *cfg)
+{
+	wr_regl(port, S3C2410_UCON,  cfg->ucon);
+	wr_regl(port, S3C2410_ULCON, cfg->ulcon);
+
+	/* reset both fifos */
+	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
+	wr_regl(port, S3C2410_UFCON, cfg->ufcon);
+
+	return 0;
+}
+
+#define S5PV310_UART_DEFAULT_INFO(fifo_size)			\
+		.name		= "Samsung S5PV310 UART",	\
+		.type		= PORT_S3C6400,			\
+		.fifosize	= fifo_size,			\
+		.has_fracval	= 1,				\
+		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
+		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
+		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,	\
+		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,	\
+		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,	\
+		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,	\
+		.get_clksrc	= s5pv310_serial_getsource,	\
+		.set_clksrc	= s5pv310_serial_setsource,	\
+		.reset_port	= s5pv310_serial_resetport
+
+static struct s3c24xx_uart_info s5p_port_fifo256 = {
+	S5PV310_UART_DEFAULT_INFO(256),
+};
+
+static struct s3c24xx_uart_info s5p_port_fifo64 = {
+	S5PV310_UART_DEFAULT_INFO(64),
+};
+
+static struct s3c24xx_uart_info s5p_port_fifo16 = {
+	S5PV310_UART_DEFAULT_INFO(16),
+};
+
+struct s3c24xx_uart_info *s5p_uart_inf[] = {
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
+static struct platform_driver s5p_serial_driver = {
+	.probe		= s5p_serial_probe,
+	.remove		= __devexit_p(s3c24xx_serial_remove),
+	.driver		= {
+		.name	= "s5pv310-uart",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init s5pv310_serial_console_init(void)
+{
+	return s3c24xx_serial_initconsole(&s5p_serial_driver, s5p_uart_inf);
+}
+
+console_initcall(s5pv310_serial_console_init);
+
+static int __init s5p_serial_init(void)
+{
+	return s3c24xx_serial_init(&s5p_serial_driver, *s5p_uart_inf);
+}
+
+static void __exit s5p_serial_exit(void)
+{
+	platform_driver_unregister(&s5p_serial_driver);
+}
+
+module_init(s5p_serial_init);
+module_exit(s5p_serial_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:s5pv310-uart");
+MODULE_DESCRIPTION("Samsung S5PV310 UART Driver support");
+MODULE_AUTHOR("Changhwan Youn <chaos.youn@samsung.com>");
-- 
1.6.2.5
