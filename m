From: b32955@freescale.com (Huang Shijie)
Date: Mon, 3 Jun 2013 15:42:11 +0800
Subject: [PATCH] serial: imx: enable the clocks only when the uart is used
Message-ID: <1370245331-12501-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code opens the clocks when the uart driver is probed.
This will wastes some power if several uarts are enabled, but not really
used.

So close these clocks for uart, and enable the clocks only when
the uart is used.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 72bc1db..5705fc8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -699,6 +699,9 @@ static int imx_startup(struct uart_port *port)
 	int retval;
 	unsigned long flags, temp;
 
+	clk_prepare_enable(sport->clk_per);
+	clk_prepare_enable(sport->clk_ipg);
+
 	imx_setup_ufcr(sport, 0);
 
 	/* disable the DREN bit (Data Ready interrupt enable) before
@@ -884,6 +887,9 @@ static void imx_shutdown(struct uart_port *port)
 
 	writel(temp, sport->port.membase + UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
 }
 
 static void
@@ -1557,6 +1563,9 @@ static int serial_imx_probe(struct platform_device *pdev)
 		goto deinit;
 	platform_set_drvdata(pdev, sport);
 
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
+
 	return 0;
 deinit:
 	if (pdata && pdata->exit)
@@ -1578,9 +1587,6 @@ static int serial_imx_remove(struct platform_device *pdev)
 
 	uart_remove_one_port(&imx_reg, &sport->port);
 
-	clk_disable_unprepare(sport->clk_per);
-	clk_disable_unprepare(sport->clk_ipg);
-
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 
-- 
1.7.1
