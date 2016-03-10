From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 10 Mar 2016 11:26:07 +0100
Subject: [PATCH 2/4] serial: imx: implement handshaking irq handling for DTE
 mode
In-Reply-To: <1457605569-7828-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1457605569-7828-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1457605569-7828-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although this looks like a feature patch this is really a bug fix. In
DTE mode (i.e. with the devicetree property fsl,dte-mode) the interrupts
for RI and DCD are enabled because that's the reset default of these
bits (which have a different semantic in DCE mode) and the driver didn't
touch these bits before. The irq handler didn't handle these
subinterrupts and even fails to return IRQ_NONE in this case which
results in the machine being stuck when the RI or DCD pin changes level.
Still worse, when the respective pins are pinmuxed for a different
function, they include (at least on i.MX25) the SION bit, which means
the value at the pin is routed to the UART even then triggering the irq.

As of 4.5-rc7 there is only a single supported machine that operates an
UART in DTE mode and this UART doesn't have the respective pins, so no
in-tree-user should be affected.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
I already sent a patch to linux-arm-kernel ML that drops the SION bits.

 drivers/tty/serial/imx.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index ffa81e629a79..5586260059aa 100644
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
@@ -154,6 +155,7 @@
 #define USR2_RIIN	 (1<<9)	 /* Ring Indicator Input */
 #define USR2_IRINT	 (1<<8)	 /* Serial infrared interrupt flag */
 #define USR2_WAKE	 (1<<7)	 /* Wake */
+#define USR2_DCDDELT	 (1<<6)	 /* Data Carrier Detect Delta */
 #define USR2_DCDIN	 (1<<5)	 /* Data Carrier Detect Input */
 #define USR2_RTSF	 (1<<4)	 /* RTS edge interrupt flag */
 #define USR2_TXDC	 (1<<3)	 /* Transmitter complete */
@@ -800,6 +802,20 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	     readl(sport->port.membase + UCR4) & UCR4_TCEN))
 		imx_txint(irq, dev_id);
 
+	if ((sts & USR1_DTRD) || (sts2 & (USR2_DCDDELT | USR2_RIDELT))) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&sport->port.lock, flags);
+		imx_mctrl_check(sport);
+		spin_unlock_irqrestore(&sport->port.lock, flags);
+		if (sts & USR1_DTRD)
+			writel(USR1_DTRD, sport->port.membase + USR1);
+
+		if (sts2 & (USR2_DCDDELT | USR2_RIDELT))
+			writel(sts2 & (USR2_DCDDELT | USR2_RIDELT),
+			       sport->port.membase + USR2);
+	}
+
 	if (sts & USR1_RTSD)
 		imx_rtsint(irq, dev_id);
 
@@ -1193,8 +1209,9 @@ static int imx_startup(struct uart_port *port)
 	/*
 	 * Finally, clear and enable interrupts
 	 */
-	writel(USR1_RTSD, sport->port.membase + USR1);
-	writel(USR2_ORE, sport->port.membase + USR2);
+	writel(USR1_RTSD | USR1_DTRD, sport->port.membase + USR1);
+	writel(USR2_ORE | USR2_DCDDELT | USR2_RIDELT,
+	       sport->port.membase + USR2);
 
 	if (sport->dma_is_inited && !sport->dma_is_enabled)
 		imx_enable_dma(sport);
@@ -1212,11 +1229,23 @@ static int imx_startup(struct uart_port *port)
 	temp |= (UCR2_RXEN | UCR2_TXEN);
 	if (!sport->have_rtscts)
 		temp |= UCR2_IRTS;
+	/* disable edge sensitive RTS-irq, we're using RTSD instead */
+	if (!is_imx1_uart(sport))
+		temp &= ~UCR2_RTSEN;
 	writel(temp, sport->port.membase + UCR2);
 
 	if (!is_imx1_uart(sport)) {
 		temp = readl(sport->port.membase + UCR3);
-		temp |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP;
+
+		/*
+		 * The effect of RI and DCD differs depending on the UFCR_DCEDTE
+		 * bit. In DCE mode they control the outputs, in DTE mode they
+		 * enable the respective irqs. For both modes it's correct to
+		 * set them (which matches the reset default).
+		 */
+		temp |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP |
+			UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
+
 		writel(temp, sport->port.membase + UCR3);
 	}
 
-- 
2.7.0
