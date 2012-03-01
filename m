From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu,  1 Mar 2012 14:10:22 +0800
Subject: [PATCH 2/8] serial: pxa: add OF support
In-Reply-To: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330582228-12424-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse uart device id from alias in DTS file.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/tty/serial/pxa.c |   57 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 5c8e3bb..380f15f 100644
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
@@ -781,6 +782,39 @@ static const struct dev_pm_ops serial_pxa_pm_ops = {
 };
 #endif
 
+static struct of_device_id serial_pxa_dt_ids[] = {
+	{ .compatible = "mrvl,pxa-uart", },
+	{ .compatible = "mrvl,mmp-uart", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
+
+#ifdef CONFIG_OF
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
+#else
+static int serial_pxa_probe_dt(struct platform_device *pdev,
+			       struct uart_pxa_port *sport)
+{
+	return 1;
+}
+#endif
+
 static int serial_pxa_probe(struct platform_device *dev)
 {
 	struct uart_pxa_port *sport;
@@ -792,7 +826,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 	if (!mmres || !irqres)
 		return -ENODEV;
 
-	sport = kzalloc(sizeof(struct uart_pxa_port), GFP_KERNEL);
+	sport = kzalloc(sizeof(struct uart_pxa_port) + 8, GFP_KERNEL);
 	if (!sport)
 		return -ENOMEM;
 
@@ -808,20 +842,18 @@ static int serial_pxa_probe(struct platform_device *dev)
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
+	sport->name = (char *)((unsigned int)sport + 8);
+	/* name can't exceed 8 bytes */
+	sprintf(sport->name, "UART%d", sport->port.line + 1);
 
 	sport->port.membase = ioremap(mmres->start, resource_size(mmres));
 	if (!sport->port.membase) {
@@ -829,7 +861,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 		goto err_clk;
 	}
 
-	serial_pxa_ports[dev->id] = sport;
+	serial_pxa_ports[sport->port.line] = sport;
 
 	uart_add_one_port(&serial_pxa_reg, &sport->port);
 	platform_set_drvdata(dev, sport);
@@ -866,6 +898,7 @@ static struct platform_driver serial_pxa_driver = {
 #ifdef CONFIG_PM
 		.pm	= &serial_pxa_pm_ops,
 #endif
+		.of_match_table = serial_pxa_dt_ids,
 	},
 };
 
-- 
1.7.0.4
