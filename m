From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 18 Feb 2015 21:41:06 +0100
Subject: [PATCH 5/7] serial: imx: Fix handling of receiver overrun
In-Reply-To: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424292068-28197-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ORE bit only signals overflow of the receiver fifo, so the
respective interrupt should be enabled in the startup callback instead
of the start_tx callback.

Moreover the writeable bits in the USR2 register are all "write 1 to
clear", so only write the bits that actually should be cleared.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

a colleague asked me to split this patch into two. i.e. move ORE handling to
.startup + fixing acknowledge. But line 526

	writel(temp | USR2_ORE, sport->port.membase + USR2);

suffers from both problems, and so would need to be touched twice. So I kept
both changes in a single patch.

Best regards
Uwe

 drivers/tty/serial/imx.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 587f7b3075e4..985a1178911c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -520,14 +520,6 @@ static void imx_start_tx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
-	/* Clear any pending ORE flag before enabling interrupt */
-	temp = readl(sport->port.membase + USR2);
-	writel(temp | USR2_ORE, sport->port.membase + USR2);
-
-	temp = readl(sport->port.membase + UCR4);
-	temp |= UCR4_OREN;
-	writel(temp, sport->port.membase + UCR4);
-
 	if (!sport->dma_is_enabled) {
 		temp = readl(sport->port.membase + UCR1);
 		writel(temp | UCR1_TXMPTYEN, sport->port.membase + UCR1);
@@ -691,7 +683,7 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	if (sts2 & USR2_ORE) {
 		dev_err(sport->port.dev, "Rx FIFO overrun\n");
 		sport->port.icount.overrun++;
-		writel(sts2 | USR2_ORE, sport->port.membase + USR2);
+		writel(USR2_ORE, sport->port.membase + USR2);
 	}
 
 	return IRQ_HANDLED;
@@ -1026,16 +1018,21 @@ static int imx_startup(struct uart_port *port)
 		udelay(1);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
+
 	/*
 	 * Finally, clear and enable interrupts
 	 */
 	writel(USR1_RTSD, sport->port.membase + USR1);
+	writel(USR2_ORE, sport->port.membase + USR2);
 
 	temp = readl(sport->port.membase + UCR1);
 	temp |= UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN;
-
 	writel(temp, sport->port.membase + UCR1);
 
+	temp = read(sport->port.membase + UCR4);
+	temp |= UCR4_OREN;
+	writel(temp, sport->port.membase + UCR4);
+
 	temp = readl(sport->port.membase + UCR2);
 	temp |= (UCR2_RXEN | UCR2_TXEN);
 	if (!sport->have_rtscts)
-- 
2.1.4
