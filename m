From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue,  6 Mar 2012 10:42:10 +0800
Subject: [PATCH v3 1/7] serial: pxa: add OF support
In-Reply-To: <201203051255.37311.arnd@arndb.de>
References: <201203051255.37311.arnd@arndb.de>
Message-ID: <1331001730-13429-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse uart device id from alias in DTS file.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/tty/serial/pxa.c |   52 +++++++++++++++++++++++++++++++++++----------
 1 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 5c8e3bb..23d32f6 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -36,6 +36,7 @@
 #include <linux/circ_buf.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -44,6 +45,8 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
+#define PXA_NAME_LEN		8
+
 struct uart_pxa_port {
 	struct uart_port        port;
 	unsigned char           ier;
@@ -51,7 +54,7 @@ struct uart_pxa_port {
 	unsigned char           mcr;
 	unsigned int            lsr_break_flag;
 	struct clk		*clk;
-	char			*name;
+	char			name[PXA_NAME_LEN];
 };
 
 static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
@@ -781,6 +784,33 @@ static const struct dev_pm_ops serial_pxa_pm_ops = {
 };
 #endif
 
+#ifdef CONFIG_OF
+static struct of_device_id serial_pxa_dt_ids[] = {
+	{ .compatible = "mrvl,pxa-uart", },
+	{ .compatible = "mrvl,mmp-uart", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
+#endif
+
+static int serial_pxa_probe_dt(struct platform_device *pdev,
+			       struct uart_pxa_port *sport)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	if (!np)
+		return 1;
+
+	ret = of_alias_get_id(np, "serial");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
+		return ret;
+	}
+	sport->port.line = ret;
+	return 0;
+}
+
 static int serial_pxa_probe(struct platform_device *dev)
 {
 	struct uart_pxa_port *sport;
@@ -808,20 +838,16 @@ static int serial_pxa_probe(struct platform_device *dev)
 	sport->port.irq = irqres->start;
 	sport->port.fifosize = 64;
 	sport->port.ops = &serial_pxa_pops;
-	sport->port.line = dev->id;
 	sport->port.dev = &dev->dev;
 	sport->port.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 	sport->port.uartclk = clk_get_rate(sport->clk);
 
-	switch (dev->id) {
-	case 0: sport->name = "FFUART"; break;
-	case 1: sport->name = "BTUART"; break;
-	case 2: sport->name = "STUART"; break;
-	case 3: sport->name = "HWUART"; break;
-	default:
-		sport->name = "???";
-		break;
-	}
+	ret = serial_pxa_probe_dt(dev, sport);
+	if (ret > 0)
+		sport->port.line = dev->id;
+	else if (ret < 0)
+		goto err_clk;
+	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
 
 	sport->port.membase = ioremap(mmres->start, resource_size(mmres));
 	if (!sport->port.membase) {
@@ -829,7 +855,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 		goto err_clk;
 	}
 
-	serial_pxa_ports[dev->id] = sport;
+	serial_pxa_ports[sport->port.line] = sport;
 
 	uart_add_one_port(&serial_pxa_reg, &sport->port);
 	platform_set_drvdata(dev, sport);
@@ -850,6 +876,7 @@ static int serial_pxa_remove(struct platform_device *dev)
 	platform_set_drvdata(dev, NULL);
 
 	uart_remove_one_port(&serial_pxa_reg, &sport->port);
+	kfree(sport->name);
 	clk_put(sport->clk);
 	kfree(sport);
 
@@ -866,6 +893,7 @@ static struct platform_driver serial_pxa_driver = {
 #ifdef CONFIG_PM
 		.pm	= &serial_pxa_pm_ops,
 #endif
+		.of_match_table = serial_pxa_dt_ids,
 	},
 };
 
-- 
1.7.0.4
