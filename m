From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 08:33:17 +0200
Subject: [PATCH v2 5/8] serial/imx.c: fix suspend/resume
In-Reply-To: <1274942000-3580-4-git-send-email-eric@eukrea.com>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>
	<1274942000-3580-2-git-send-email-eric@eukrea.com>
	<1274942000-3580-3-git-send-email-eric@eukrea.com>
	<1274942000-3580-4-git-send-email-eric@eukrea.com>
Message-ID: <1274942000-3580-5-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* when uart is used as a kernel's console, its baudrate is wrong
after resume :
when resuming, serial_core call set_termios which fails to
get the right baudrate.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/serial/imx.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
index eacb588..936f810 100644
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -1020,6 +1020,17 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return ret;
 }
 
+static void
+imx_suspend(struct uart_port *port, unsigned int state, unsigned int oldstate)
+{
+	struct imx_port *sport = (struct imx_port *)port;
+
+	if (!state)
+		clk_enable(sport->clk);
+	else
+		clk_disable(sport->clk);
+}
+
 static struct uart_ops imx_pops = {
 	.tx_empty	= imx_tx_empty,
 	.set_mctrl	= imx_set_mctrl,
@@ -1037,6 +1048,7 @@ static struct uart_ops imx_pops = {
 	.request_port	= imx_request_port,
 	.config_port	= imx_config_port,
 	.verify_port	= imx_verify_port,
+	.pm		= imx_suspend,
 };
 
 static struct imx_port *imx_ports[UART_NR];
@@ -1207,6 +1219,7 @@ static struct uart_driver imx_reg = {
 	.cons           = IMX_CONSOLE,
 };
 
+#ifdef CONFIG_PM
 static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct imx_port *sport = platform_get_drvdata(dev);
@@ -1226,6 +1239,7 @@ static int serial_imx_resume(struct platform_device *dev)
 
 	return 0;
 }
+#endif
 
 static int serial_imx_probe(struct platform_device *pdev)
 {
@@ -1343,8 +1357,10 @@ static struct platform_driver serial_imx_driver = {
 	.probe		= serial_imx_probe,
 	.remove		= serial_imx_remove,
 
+#ifdef CONFIG_PM
 	.suspend	= serial_imx_suspend,
 	.resume		= serial_imx_resume,
+#endif
 	.driver		= {
 		.name	= "imx-uart",
 		.owner	= THIS_MODULE,
-- 
1.6.3.3
