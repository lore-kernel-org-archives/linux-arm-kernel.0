From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 18 Feb 2015 21:41:02 +0100
Subject: [PATCH 1/7] serial: imx: drop members from driver data that are only
 used during probe
Message-ID: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no benefit in keeping this information in RAM when it's not
used any more, so better use function local variables instead.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4c5e9092e2d7..d6da02210919 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -205,7 +205,6 @@ struct imx_port {
 	struct uart_port	port;
 	struct timer_list	timer;
 	unsigned int		old_status;
-	int			txirq, rxirq, rtsirq;
 	unsigned int		have_rtscts:1;
 	unsigned int		dte_mode:1;
 	unsigned int		use_irda:1;
@@ -1851,6 +1850,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret = 0;
 	struct resource *res;
+	int txirq, rxirq, rtsirq;
 
 	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
 	if (!sport)
@@ -1867,15 +1867,16 @@ static int serial_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	rxirq = platform_get_irq(pdev, 0);
+	txirq = platform_get_irq(pdev, 1);
+	rtsirq = platform_get_irq(pdev, 2);
+
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
 	sport->port.membase = base;
 	sport->port.type = PORT_IMX,
 	sport->port.iotype = UPIO_MEM;
-	sport->port.irq = platform_get_irq(pdev, 0);
-	sport->rxirq = platform_get_irq(pdev, 0);
-	sport->txirq = platform_get_irq(pdev, 1);
-	sport->rtsirq = platform_get_irq(pdev, 2);
+	sport->port.irq = rxirq;
 	sport->port.fifosize = 32;
 	sport->port.ops = &imx_pops;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
@@ -1903,27 +1904,27 @@ static int serial_imx_probe(struct platform_device *pdev)
 	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later
 	 * chips only have one interrupt.
 	 */
-	if (sport->txirq > 0) {
-		ret = devm_request_irq(&pdev->dev, sport->rxirq, imx_rxint, 0,
+	if (txirq > 0) {
+		ret = devm_request_irq(&pdev->dev, rxirq, imx_rxint, 0,
 				       dev_name(&pdev->dev), sport);
 		if (ret)
 			return ret;
 
-		ret = devm_request_irq(&pdev->dev, sport->txirq, imx_txint, 0,
+		ret = devm_request_irq(&pdev->dev, txirq, imx_txint, 0,
 				       dev_name(&pdev->dev), sport);
 		if (ret)
 			return ret;
 
 		/* do not use RTS IRQ on IrDA */
 		if (!USE_IRDA(sport)) {
-			ret = devm_request_irq(&pdev->dev, sport->rtsirq,
+			ret = devm_request_irq(&pdev->dev, rtsirq,
 					       imx_rtsint, 0,
 					       dev_name(&pdev->dev), sport);
 			if (ret)
 				return ret;
 		}
 	} else {
-		ret = devm_request_irq(&pdev->dev, sport->port.irq, imx_int, 0,
+		ret = devm_request_irq(&pdev->dev, rxirq, imx_int, 0,
 				       dev_name(&pdev->dev), sport);
 		if (ret)
 			return ret;
-- 
2.1.4
