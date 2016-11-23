From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 23 Nov 2016 11:01:05 +0100
Subject: [PATCH 3/4] serial: cpm_uart: Add LED trigger support
In-Reply-To: <20161123100106.15969-1-s.hauer@pengutronix.de>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
Message-ID: <20161123100106.15969-4-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index d3e3d42..5d5633d 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -255,6 +255,8 @@ static void cpm_uart_int_rx(struct uart_port *port)
 
 	pr_debug("CPM uart[%d]:RX INT\n", port->line);
 
+	uart_led_trigger_rx(port);
+
 	/* Just loop through the closed BDs and copy the characters into
 	 * the buffer.
 	 */
@@ -721,6 +723,8 @@ static int cpm_uart_tx_pump(struct uart_port *port)
 	/* Pick next descriptor and fill from buffer */
 	bdp = pinfo->tx_cur;
 
+	uart_led_trigger_tx(port);
+
 	while (!(in_be16(&bdp->cbd_sc) & BD_SC_READY) &&
 	       xmit->tail != xmit->head) {
 		count = 0;
@@ -1426,13 +1430,27 @@ static int cpm_uart_probe(struct platform_device *ofdev)
 	if (ret)
 		return ret;
 
-	return uart_add_one_port(&cpm_reg, &pinfo->port);
+	ret = uart_add_one_port(&cpm_reg, &pinfo->port);
+	if (ret)
+		return ret;
+
+	uart_add_led_triggers(&cpm_reg, &pinfo->port);
+
+	return 0;
 }
 
 static int cpm_uart_remove(struct platform_device *ofdev)
 {
 	struct uart_cpm_port *pinfo = platform_get_drvdata(ofdev);
-	return uart_remove_one_port(&cpm_reg, &pinfo->port);
+	int ret;
+
+	ret = uart_remove_one_port(&cpm_reg, &pinfo->port);
+	if (ret)
+		return ret;
+
+	uart_remove_led_triggers(&pinfo->port);
+
+	return 0;
 }
 
 static const struct of_device_id cpm_uart_match[] = {
-- 
2.10.2
