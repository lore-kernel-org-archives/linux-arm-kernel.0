From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Mar 2016 14:24:25 +0100
Subject: [PATCH v2 6/6] serial: imx: implement DSR irq handling for DTE mode
In-Reply-To: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable reporting of DSR events (which is named DTR in the registers
because Freescale uses the names as seem from a DCE).

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c07e652f8f58..621e488cbb12 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -114,6 +114,7 @@
 #define UCR3_RXDSEN	(1<<6)	/* Receive status interrupt enable */
 #define UCR3_AIRINTEN	(1<<5)	/* Async IR wake interrupt enable */
 #define UCR3_AWAKEN	(1<<4)	/* Async wake interrupt enable */
+#define UCR3_DTRDEN	(1<<3)	/* Data Terminal Ready Delta Enable. */
 #define IMX21_UCR3_RXDMUXSEL	(1<<2)	/* RXD Muxed Input Select */
 #define UCR3_INVT	(1<<1)	/* Inverted Infrared transmission */
 #define UCR3_BPEN	(1<<0)	/* Preset registers enable */
@@ -142,7 +143,7 @@
 #define USR1_FRAMERR	(1<<10) /* Frame error interrupt flag */
 #define USR1_RRDY	(1<<9)	 /* Receiver ready interrupt/dma flag */
 #define USR1_AGTIM	(1<<8)	 /* Ageing timer interrupt flag */
-#define USR1_TIMEOUT	(1<<7)	 /* Receive timeout interrupt status */
+#define USR1_DTRD	(1<<7)	 /* DTR Delta */
 #define USR1_RXDS	 (1<<6)	 /* Receiver idle interrupt flag */
 #define USR1_AIRINT	 (1<<5)	 /* Async IR wake interrupt flag */
 #define USR1_AWAKE	 (1<<4)	 /* Aysnc wake interrupt flag */
@@ -804,6 +805,19 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 	}
 
+	if (sts & USR1_DTRD) {
+		unsigned long flags;
+
+		if (sts & USR1_DTRD)
+			writel(USR1_DTRD, sport->port.membase + USR1);
+
+		spin_lock_irqsave(&sport->port.lock, flags);
+		imx_mctrl_check(sport);
+		spin_unlock_irqrestore(&sport->port.lock, flags);
+
+		ret = IRQ_HANDLED;
+	}
+
 	if (sts & USR1_RTSD) {
 		imx_rtsint(irq, dev_id);
 		ret = IRQ_HANDLED;
@@ -1202,7 +1216,7 @@ static int imx_startup(struct uart_port *port)
 	/*
 	 * Finally, clear and enable interrupts
 	 */
-	writel(USR1_RTSD, sport->port.membase + USR1);
+	writel(USR1_RTSD | USR1_DTRD, sport->port.membase + USR1);
 	writel(USR2_ORE, sport->port.membase + USR2);
 
 	if (sport->dma_is_inited && !sport->dma_is_enabled)
@@ -1242,7 +1256,7 @@ static int imx_startup(struct uart_port *port)
 		 * now, too.
 		 */
 		temp |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP |
-			UCR3_RI | UCR3_DCD;
+			UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
 
 		if (sport->dte_mode)
 			temp &= ~(UCR3_RI | UCR3_DCD);
-- 
2.7.0
