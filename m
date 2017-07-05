From: romain.perier@collabora.com (Romain Perier)
Date: Wed,  5 Jul 2017 15:07:02 +0200
Subject: [PATCH v2 2/6] serial: imx: Simplify DMA disablement
In-Reply-To: <20170705130706.10388-1-romain.perier@collabora.com>
References: <20170705130706.10388-1-romain.perier@collabora.com>
Message-ID: <20170705130706.10388-3-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nandor Han <nandor.han@ge.com>

This commits simplify the function imx_disable_dma() by moving
the code for disabling RX and TX DMAs to dedicated functions.
This is a preparation for the next commit.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/tty/serial/imx.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 01df430..5291b86 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -360,6 +360,24 @@ static void imx_port_rts_auto(struct imx_port *sport, unsigned long *ucr2)
 	*ucr2 |= UCR2_CTSC;
 }
 
+static void imx_stop_tx_dma(struct imx_port *sport)
+{
+	unsigned long temp;
+
+	temp = readl(sport->port.membase + UCR1);
+	temp &= ~UCR1_TDMAEN;
+	writel(temp, sport->port.membase + UCR1);
+}
+
+static void imx_stop_rx_dma(struct imx_port *sport)
+{
+	unsigned long temp;
+
+	temp = readl(sport->port.membase + UCR1);
+	temp &= ~(UCR1_RDMAEN | UCR1_ATDMAEN);
+	writel(temp, sport->port.membase + UCR1);
+}
+
 /*
  * interrupts disabled on entry
  */
@@ -1228,12 +1246,8 @@ static void imx_enable_dma(struct imx_port *sport)
 
 static void imx_disable_dma(struct imx_port *sport)
 {
-	unsigned long temp;
-
-	/* clear UCR1 */
-	temp = readl(sport->port.membase + UCR1);
-	temp &= ~(UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN);
-	writel(temp, sport->port.membase + UCR1);
+	imx_stop_rx_dma(sport);
+	imx_stop_tx_dma(sport);
 
 	/* clear UCR2 */
 	temp = readl(sport->port.membase + UCR2);
-- 
1.8.3.1
