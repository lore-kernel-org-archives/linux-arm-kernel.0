From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:23 +0200
Subject: [PATCH 10/40] serial i.MX: do not depend on grouped clocks
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-11-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the current i.MX clock support groups together unrelated clocks
to a single clock which is then used by the driver. This can't
be accomplished with the generic clock framework so we instead
request the individual clocks in the driver. For i.MX there are
generally three different clocks:

ipg: bus clock (needed to access registers)
ahb: dma relevant clock, sometimes referred to as hclk in the datasheet
per: bit clock, pixel clock

This patch changes the driver to request the individual clocks.
Currently all clk_get will get the same clock until the SoCs
are converted to the generic clock framework

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c |   38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e7fecee..267ec6d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -204,7 +204,8 @@ struct imx_port {
 	unsigned int		irda_inv_rx:1;
 	unsigned int		irda_inv_tx:1;
 	unsigned short		trcv_delay; /* transceiver delay */
-	struct clk		*clk;
+	struct clk		*clk_ipg;
+	struct clk		*clk_per;
 	struct imx_uart_data	*devdata;
 };
 
@@ -672,7 +673,7 @@ static int imx_setup_ufcr(struct imx_port *sport, unsigned int mode)
 	 * RFDIV is set such way to satisfy requested uartclk value
 	 */
 	val = TXTL << 10 | RXTL;
-	ufcr_rfdiv = (clk_get_rate(sport->clk) + sport->port.uartclk / 2)
+	ufcr_rfdiv = (clk_get_rate(sport->clk_per) + sport->port.uartclk / 2)
 			/ sport->port.uartclk;
 
 	if(!ufcr_rfdiv)
@@ -1285,7 +1286,7 @@ imx_console_get_options(struct imx_port *sport, int *baud,
 		else
 			ucfr_rfdiv = 6 - ucfr_rfdiv;
 
-		uartclk = clk_get_rate(sport->clk);
+		uartclk = clk_get_rate(sport->clk_per);
 		uartclk /= ucfr_rfdiv;
 
 		{	/*
@@ -1503,14 +1504,22 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->timer.function = imx_timeout;
 	sport->timer.data     = (unsigned long)sport;
 
-	sport->clk = clk_get(&pdev->dev, "uart");
-	if (IS_ERR(sport->clk)) {
-		ret = PTR_ERR(sport->clk);
+	sport->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(sport->clk_ipg)) {
+		ret = PTR_ERR(sport->clk_ipg);
 		goto unmap;
 	}
-	clk_prepare_enable(sport->clk);
 
-	sport->port.uartclk = clk_get_rate(sport->clk);
+	sport->clk_per = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(sport->clk_per)) {
+		ret = PTR_ERR(sport->clk_per);
+		goto unmap;
+	}
+
+	clk_prepare_enable(sport->clk_per);
+	clk_prepare_enable(sport->clk_ipg);
+
+	sport->port.uartclk = clk_get_rate(sport->clk_per);
 
 	imx_ports[sport->port.line] = sport;
 
@@ -1531,8 +1540,8 @@ deinit:
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 clkput:
-	clk_disable_unprepare(sport->clk);
-	clk_put(sport->clk);
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
 unmap:
 	iounmap(sport->port.membase);
 free:
@@ -1550,11 +1559,10 @@ static int serial_imx_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	if (sport) {
-		uart_remove_one_port(&imx_reg, &sport->port);
-		clk_disable_unprepare(sport->clk);
-		clk_put(sport->clk);
-	}
+	uart_remove_one_port(&imx_reg, &sport->port);
+
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
 
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
-- 
1.7.9.5
