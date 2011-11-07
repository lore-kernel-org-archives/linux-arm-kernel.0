From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon,  7 Nov 2011 22:31:43 +0100
Subject: [PATCH 1/3 V2] ARM: pxa: Add DT support to pxa2xx-uart
In-Reply-To: <1320701506-26812-1-git-send-email-marek.vasut@gmail.com>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
 <1320701506-26812-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1320701506-26812-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding for PXA2xx UARTs. Tested on Vpac270 board.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <robherring2@gmail.com>
---
 drivers/tty/serial/pxa.c |   46 +++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 43 insertions(+), 3 deletions(-)

V2: Use of_alias_get_id() instead of static int portnum
    Drop checking of CPU type, instead let user handle HWUART on his own (by not
    registering it in the DT file on new CPUs -- this depends on user's sanity).

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 5c8e3bb..80bee8e 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -43,6 +43,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 struct uart_pxa_port {
 	struct uart_port        port;
@@ -781,11 +783,48 @@ static const struct dev_pm_ops serial_pxa_pm_ops = {
 };
 #endif
 
+#ifdef CONFIG_OF
+static struct of_device_id serial_pxa_dt_ids[] = {
+	{ .compatible = "marvell,pxa2xx-uart" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
+
+static int serial_pxa_probe_dt(struct platform_device *pdev, int *portid)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	ret = of_alias_get_id(np, "serial");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to get alias id, errno %d\n", ret);
+		return -ENODEV;
+	}
+
+	*portid = ret;
+
+	return 0;
+}
+#else
+static inline int serial_pxa_probe_dt(struct platform_device *pdev, int *portid)
+{
+	return 0;
+}
+#endif
+
 static int serial_pxa_probe(struct platform_device *dev)
 {
 	struct uart_pxa_port *sport;
 	struct resource *mmres, *irqres;
 	int ret;
+	int portid = dev->id;
+
+	ret = serial_pxa_probe_dt(dev, &portid);
+	if (ret == -EINVAL)
+		return 0;
 
 	mmres = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	irqres = platform_get_resource(dev, IORESOURCE_IRQ, 0);
@@ -808,12 +847,12 @@ static int serial_pxa_probe(struct platform_device *dev)
 	sport->port.irq = irqres->start;
 	sport->port.fifosize = 64;
 	sport->port.ops = &serial_pxa_pops;
-	sport->port.line = dev->id;
+	sport->port.line = portid;
 	sport->port.dev = &dev->dev;
 	sport->port.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 	sport->port.uartclk = clk_get_rate(sport->clk);
 
-	switch (dev->id) {
+	switch (portid) {
 	case 0: sport->name = "FFUART"; break;
 	case 1: sport->name = "BTUART"; break;
 	case 2: sport->name = "STUART"; break;
@@ -829,7 +868,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 		goto err_clk;
 	}
 
-	serial_pxa_ports[dev->id] = sport;
+	serial_pxa_ports[portid] = sport;
 
 	uart_add_one_port(&serial_pxa_reg, &sport->port);
 	platform_set_drvdata(dev, sport);
@@ -866,6 +905,7 @@ static struct platform_driver serial_pxa_driver = {
 #ifdef CONFIG_PM
 		.pm	= &serial_pxa_pm_ops,
 #endif
+		.of_match_table = of_match_ptr(serial_pxa_dt_ids),
 	},
 };
 
-- 
1.7.7.1
