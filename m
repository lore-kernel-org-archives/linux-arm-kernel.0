From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 21 May 2010 13:12:43 +0200
Subject: [PATCH 5/5] serial/imx.c: fix suspend/resume
In-Reply-To: <1274440363-435-4-git-send-email-eric@eukrea.com>
References: <1274440363-435-1-git-send-email-eric@eukrea.com>
	<1274440363-435-2-git-send-email-eric@eukrea.com>
	<1274440363-435-3-git-send-email-eric@eukrea.com>
	<1274440363-435-4-git-send-email-eric@eukrea.com>
Message-ID: <1274440363-435-5-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* there is a stange behaviour in suspend & resume functions :
if console is enabled on serial the baudrate is not properly restored
at resume. The "fix" is tho use platform_get_drvdata directly on
dev in suspend/resume instead of using to_platform_device.
Someone more used to this driver than me may find a better fix !

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/serial/imx.c |   33 ++++++++++++++++++++++++++-------
 1 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
index eacb588..606566e 100644
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
@@ -1207,9 +1219,11 @@ static struct uart_driver imx_reg = {
 	.cons           = IMX_CONSOLE,
 };
 
-static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
+#ifdef CONFIG_PM
+static int serial_imx_suspend(struct device *dev)
 {
-	struct imx_port *sport = platform_get_drvdata(dev);
+/* FIXME	struct platform_device *pdev = to_platform_device(dev); */
+	struct imx_port *sport = platform_get_drvdata((struct platform_device *)dev);
 
 	if (sport)
 		uart_suspend_port(&imx_reg, &sport->port);
@@ -1217,9 +1231,10 @@ static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 	return 0;
 }
 
-static int serial_imx_resume(struct platform_device *dev)
+static int serial_imx_resume(struct device *dev)
 {
-	struct imx_port *sport = platform_get_drvdata(dev);
+/* FIXME	struct platform_device *pdev = to_platform_device(dev); */
+	struct imx_port *sport = platform_get_drvdata((struct platform_device *)dev);
 
 	if (sport)
 		uart_resume_port(&imx_reg, &sport->port);
@@ -1227,6 +1242,10 @@ static int serial_imx_resume(struct platform_device *dev)
 	return 0;
 }
 
+static const SIMPLE_DEV_PM_OPS(serial_imx_pm_ops,
+				serial_imx_suspend, serial_imx_resume);
+#endif
+
 static int serial_imx_probe(struct platform_device *pdev)
 {
 	struct imx_port *sport;
@@ -1342,12 +1361,12 @@ static int serial_imx_remove(struct platform_device *pdev)
 static struct platform_driver serial_imx_driver = {
 	.probe		= serial_imx_probe,
 	.remove		= serial_imx_remove,
-
-	.suspend	= serial_imx_suspend,
-	.resume		= serial_imx_resume,
 	.driver		= {
 		.name	= "imx-uart",
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &serial_imx_pm_ops,
+#endif
 	},
 };
 
-- 
1.6.3.3
