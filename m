From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  4 Jul 2016 17:34:12 +0200
Subject: [PATCH] serial: imx: add rx and tx led trigger
Message-ID: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for two led triggers per UART instance that blink on
transmission and reception of data respectively.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 621e488cbb12..2b6ba3b8bdd5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -39,6 +39,7 @@
 #include <linux/of_device.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
+#include <linux/leds.h>
 
 #include <asm/irq.h>
 #include <linux/platform_data/serial-imx.h>
@@ -227,6 +228,8 @@ struct imx_port {
 	wait_queue_head_t	dma_wait;
 	unsigned int            saved_reg[10];
 	bool			context_saved;
+	struct led_trigger	led_trigger_rx;
+	struct led_trigger	led_trigger_tx;
 };
 
 struct imx_port_ucrs {
@@ -293,6 +296,10 @@ static inline int is_imx6q_uart(struct imx_port *sport)
 {
 	return sport->devdata->devtype == IMX6Q_UART;
 }
+
+static unsigned long led_delay = 50;
+module_param(led_delay, ulong, 0644);
+
 /*
  * Save and restore functions for UCR1, UCR2 and UCR3 registers
  */
@@ -426,6 +433,9 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
 		return;
 	}
 
+	led_trigger_blink_oneshot(&sport->led_trigger_tx,
+				  &led_delay, &led_delay, 1);
+
 	if (sport->dma_is_enabled) {
 		/*
 		 * We've just sent a X-char Ensure the TX DMA is enabled
@@ -635,6 +645,9 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long flags, temp;
 
+	led_trigger_blink_oneshot(&sport->led_trigger_rx,
+				  &led_delay, &led_delay, 1);
+
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	while (readl(sport->port.membase + USR2) & USR2_RDR) {
@@ -708,6 +721,9 @@ static void imx_dma_rxint(struct imx_port *sport)
 	unsigned long temp;
 	unsigned long flags;
 
+	led_trigger_blink_oneshot(&sport->led_trigger_rx,
+				  &led_delay, &led_delay, 1);
+
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	temp = readl(sport->port.membase + USR2);
@@ -2002,6 +2018,42 @@ static void serial_imx_probe_pdata(struct imx_port *sport,
 		sport->have_rtscts = 1;
 }
 
+static void imx_register_led_trigger(struct device *dev, struct imx_port *sport)
+{
+#ifdef CONFIG_LEDS_TRIGGERS
+	int ret;
+	char *name;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "ttymxc%d-rx|ttymxc%d-tx",
+			      sport->port.line, sport->port.line);
+	if (!name) {
+		dev_warn(dev, "failed to allocate led trigger name\n");
+		return;
+	}
+
+	sport->led_trigger_rx.name = name;
+
+	name = strchr(name, '|');
+	*name = '\0';
+
+	sport->led_trigger_tx.name = name + 1;
+
+	ret = led_trigger_register(&sport->led_trigger_rx);
+	if (ret) {
+		dev_warn(dev, "failed to register rx led trigger\n");
+		goto err_register_rx;
+	}
+
+	ret = led_trigger_register(&sport->led_trigger_tx);
+	if (ret) {
+		dev_warn(dev, "failed to register tx led trigger\n");
+		led_trigger_unregister(&sport->led_trigger_rx);
+err_register_rx:
+		devm_kfree(dev, name);
+	}
+#endif
+}
+
 static int serial_imx_probe(struct platform_device *pdev)
 {
 	struct imx_port *sport;
@@ -2065,6 +2117,8 @@ static int serial_imx_probe(struct platform_device *pdev)
 
 	sport->port.uartclk = clk_get_rate(sport->clk_per);
 
+	imx_register_led_trigger(&pdev->dev, sport);
+
 	/* For register access, we only need to enable the ipg clock. */
 	ret = clk_prepare_enable(sport->clk_ipg);
 	if (ret)
@@ -2110,6 +2164,9 @@ static int serial_imx_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
+#ifdef CONFIG_LEDS_TRIGGERS
+	led_trigger_unregister(&sport->led_trigger_rx);
+#endif
 	return uart_remove_one_port(&imx_reg, &sport->port);
 }
 
-- 
2.8.1
