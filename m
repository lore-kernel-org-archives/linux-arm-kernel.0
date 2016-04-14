From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 14 Apr 2016 14:13:22 +0200
Subject: [PATCH 4/5] serial: sirf: Introduce helper variable struct
 device_node *np
In-Reply-To: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1460636003-3011-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sirfsoc_uart.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index c6657de789977c90..1d1c0b9857ff6900 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1264,6 +1264,7 @@ MODULE_DEVICE_TABLE(of, sirfsoc_uart_ids);
 
 static int sirfsoc_uart_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct sirfsoc_uart_port *sirfport;
 	struct uart_port *port;
 	struct resource *res;
@@ -1276,13 +1277,13 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 	};
 	const struct of_device_id *match;
 
-	match = of_match_node(sirfsoc_uart_ids, pdev->dev.of_node);
+	match = of_match_node(sirfsoc_uart_ids, np);
 	sirfport = devm_kzalloc(&pdev->dev, sizeof(*sirfport), GFP_KERNEL);
 	if (!sirfport) {
 		ret = -ENOMEM;
 		goto err;
 	}
-	sirfport->port.line = of_alias_get_id(pdev->dev.of_node, "serial");
+	sirfport->port.line = of_alias_get_id(np, "serial");
 	sirf_ports[sirfport->port.line] = sirfport;
 	sirfport->port.iotype = UPIO_MEM;
 	sirfport->port.flags = UPF_BOOT_AUTOCONF;
@@ -1291,25 +1292,24 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 	port->private_data = sirfport;
 	sirfport->uart_reg = (struct sirfsoc_uart_register *)match->data;
 
-	sirfport->hw_flow_ctrl = of_property_read_bool(pdev->dev.of_node,
-		"sirf,uart-has-rtscts");
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart") ||
-		of_device_is_compatible(pdev->dev.of_node, "sirf,atlas7-uart"))
+	sirfport->hw_flow_ctrl =
+		of_property_read_bool(np, "sirf,uart-has-rtscts");
+	if (of_device_is_compatible(np, "sirf,prima2-uart") ||
+		of_device_is_compatible(np, "sirf,atlas7-uart"))
 		sirfport->uart_reg->uart_type = SIRF_REAL_UART;
-	if (of_device_is_compatible(pdev->dev.of_node,
-		"sirf,prima2-usp-uart") || of_device_is_compatible(
-		pdev->dev.of_node, "sirf,atlas7-usp-uart")) {
+	if (of_device_is_compatible(np, "sirf,prima2-usp-uart") ||
+	    of_device_is_compatible(np, "sirf,atlas7-usp-uart")) {
 		sirfport->uart_reg->uart_type =	SIRF_USP_UART;
 		if (!sirfport->hw_flow_ctrl)
 			goto usp_no_flow_control;
-		if (of_find_property(pdev->dev.of_node, "cts-gpios", NULL))
-			sirfport->cts_gpio = of_get_named_gpio(
-					pdev->dev.of_node, "cts-gpios", 0);
+		if (of_find_property(np, "cts-gpios", NULL))
+			sirfport->cts_gpio =
+				of_get_named_gpio(np, "cts-gpios", 0);
 		else
 			sirfport->cts_gpio = -1;
-		if (of_find_property(pdev->dev.of_node, "rts-gpios", NULL))
-			sirfport->rts_gpio = of_get_named_gpio(
-					pdev->dev.of_node, "rts-gpios", 0);
+		if (of_find_property(np, "rts-gpios", NULL))
+			sirfport->rts_gpio =
+				of_get_named_gpio(np, "rts-gpios", 0);
 		else
 			sirfport->rts_gpio = -1;
 
@@ -1336,13 +1336,11 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 		gpio_direction_output(sirfport->rts_gpio, 1);
 	}
 usp_no_flow_control:
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,atlas7-uart") ||
-	    of_device_is_compatible(pdev->dev.of_node, "sirf,atlas7-usp-uart"))
+	if (of_device_is_compatible(np, "sirf,atlas7-uart") ||
+	    of_device_is_compatible(np, "sirf,atlas7-usp-uart"))
 		sirfport->is_atlas7 = true;
 
-	if (of_property_read_u32(pdev->dev.of_node,
-			"fifosize",
-			&port->fifosize)) {
+	if (of_property_read_u32(np, "fifosize", &port->fifosize)) {
 		dev_err(&pdev->dev,
 			"Unable to find fifosize in uart node.\n");
 		ret = -EFAULT;
-- 
1.9.1
