From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon,  6 Nov 2017 12:46:10 -0700
Subject: [PATCH v3 1/1] tty: serial: imx: remove imx_disable_rx_int
Message-ID: <20171106194610.9983-1-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since imx_disable_rx_int is only called by imx_startup,
let's integrate it into that function.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
v2: new patch
v3: rebased on tty-next
---
 drivers/tty/serial/imx.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1b04ef5925ef..9923b57fa60d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -712,25 +712,6 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void imx_disable_rx_int(struct imx_port *sport)
-{
-	unsigned long temp;
-
-	/* disable the receiver ready and aging timer interrupts */
-	temp = readl(sport->port.membase + UCR1);
-	temp &= ~(UCR1_RRDYEN);
-	writel(temp, sport->port.membase + UCR1);
-
-	temp = readl(sport->port.membase + UCR2);
-	temp &= ~(UCR2_ATEN);
-	writel(temp, sport->port.membase + UCR2);
-
-	/* disable the rx errors interrupts */
-	temp = readl(sport->port.membase + UCR4);
-	temp &= ~UCR4_OREN;
-	writel(temp, sport->port.membase + UCR4);
-}
-
 static void clear_rx_errors(struct imx_port *sport);
 
 /*
@@ -1261,18 +1242,21 @@ static int imx_startup(struct uart_port *port)
 	if (sport->dma_is_inited && !sport->dma_is_enabled)
 		imx_enable_dma(sport);
 
-	temp = readl(sport->port.membase + UCR1);
-	temp |= UCR1_RRDYEN | UCR1_UARTEN;
+	temp = readl(sport->port.membase + UCR1) & ~UCR1_RRDYEN;
+	if (!sport->dma_is_enabled)
+		temp |= UCR1_RRDYEN;
+	temp |= UCR1_UARTEN;
 	if (sport->have_rtscts)
 			temp |= UCR1_RTSDEN;
 
 	writel(temp, sport->port.membase + UCR1);
 
-	temp = readl(sport->port.membase + UCR4);
-	temp |= UCR4_OREN;
+	temp = readl(sport->port.membase + UCR4) & ~UCR4_OREN;
+	if (!sport->dma_is_enabled)
+		temp |= UCR4_OREN;
 	writel(temp, sport->port.membase + UCR4);
 
-	temp = readl(sport->port.membase + UCR2);
+	temp = readl(sport->port.membase + UCR2) & ~UCR2_ATEN;
 	temp |= (UCR2_RXEN | UCR2_TXEN);
 	if (!sport->have_rtscts)
 		temp |= UCR2_IRTS;
@@ -1306,10 +1290,8 @@ static int imx_startup(struct uart_port *port)
 	 * In our iMX53 the average delay for the first reception dropped from
 	 * approximately 35000 microseconds to 1000 microseconds.
 	 */
-	if (sport->dma_is_enabled) {
-		imx_disable_rx_int(sport);
+	if (sport->dma_is_enabled)
 		start_rx_dma(sport);
-	}
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-- 
2.11.0
