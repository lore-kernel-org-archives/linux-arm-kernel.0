From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Mar 2016 14:24:21 +0100
Subject: [PATCH v2 2/6] serial: imx: let irq handler return IRQ_NONE if no
 event was handled
In-Reply-To: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1458825865-7434-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gives the irq core a chance to disable the serial interrupt in case
an event isn't cleared in the handler.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index bfc4555c63d1..5ced61e1de6a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -734,6 +734,7 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	unsigned int sts;
 	unsigned int sts2;
+	irqreturn_t ret = IRQ_NONE;
 
 	sts = readl(sport->port.membase + USR1);
 	sts2 = readl(sport->port.membase + USR2);
@@ -743,26 +744,34 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 			imx_dma_rxint(sport);
 		else
 			imx_rxint(irq, dev_id);
+		ret = IRQ_HANDLED;
 	}
 
 	if ((sts & USR1_TRDY &&
 	     readl(sport->port.membase + UCR1) & UCR1_TXMPTYEN) ||
 	    (sts2 & USR2_TXDC &&
-	     readl(sport->port.membase + UCR4) & UCR4_TCEN))
+	     readl(sport->port.membase + UCR4) & UCR4_TCEN)) {
 		imx_txint(irq, dev_id);
+		ret = IRQ_HANDLED;
+	}
 
-	if (sts & USR1_RTSD)
+	if (sts & USR1_RTSD) {
 		imx_rtsint(irq, dev_id);
+		ret = IRQ_HANDLED;
+	}
 
-	if (sts & USR1_AWAKE)
+	if (sts & USR1_AWAKE) {
 		writel(USR1_AWAKE, sport->port.membase + USR1);
+		ret = IRQ_HANDLED;
+	}
 
 	if (sts2 & USR2_ORE) {
 		sport->port.icount.overrun++;
 		writel(USR2_ORE, sport->port.membase + USR2);
+		ret = IRQ_HANDLED;
 	}
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 /*
-- 
2.7.0
