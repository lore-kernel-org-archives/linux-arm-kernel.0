From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 24 Feb 2015 11:17:05 +0100
Subject: [PATCH v2 1/7] serial: imx: Fix clearing of receiver overrun flag
In-Reply-To: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424773031-19692-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The writeable bits in the USR2 register are all "write 1 to
clear" so only write the bits that actually should be cleared.

Fixes: f1f836e4209e ("serial: imx: Add Rx Fifo overrun error message")
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0eb29b1c47ac..23061918b0e4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -818,7 +818,7 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	if (sts2 & USR2_ORE) {
 		dev_err(sport->port.dev, "Rx FIFO overrun\n");
 		sport->port.icount.overrun++;
-		writel(sts2 | USR2_ORE, sport->port.membase + USR2);
+		writel(USR2_ORE, sport->port.membase + USR2);
 	}
 
 	return IRQ_HANDLED;
@@ -1181,10 +1181,12 @@ static int imx_startup(struct uart_port *port)
 		imx_uart_dma_init(sport);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
+
 	/*
 	 * Finally, clear and enable interrupts
 	 */
 	writel(USR1_RTSD, sport->port.membase + USR1);
+	writel(USR2_ORE, sport->port.membase + USR2);
 
 	if (sport->dma_is_inited && !sport->dma_is_enabled)
 		imx_enable_dma(sport);
@@ -1199,10 +1201,6 @@ static int imx_startup(struct uart_port *port)
 
 	writel(temp, sport->port.membase + UCR1);
 
-	/* Clear any pending ORE flag before enabling interrupt */
-	temp = readl(sport->port.membase + USR2);
-	writel(temp | USR2_ORE, sport->port.membase + USR2);
-
 	temp = readl(sport->port.membase + UCR4);
 	temp |= UCR4_OREN;
 	writel(temp, sport->port.membase + UCR4);
-- 
2.1.4
