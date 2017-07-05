From: romain.perier@collabora.com (Romain Perier)
Date: Wed,  5 Jul 2017 15:07:03 +0200
Subject: [PATCH v2 3/6] serial: imx: remove CTSC and CTS handling
In-Reply-To: <20170705130706.10388-1-romain.perier@collabora.com>
References: <20170705130706.10388-1-romain.perier@collabora.com>
Message-ID: <20170705130706.10388-4-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nandor Han <nandor.han@ge.com>

CTSC and CTS are not related to DMA and might add
disruption in some cases.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/tty/serial/imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 5291b86..dd3ebb4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1249,11 +1249,6 @@ static void imx_disable_dma(struct imx_port *sport)
 	imx_stop_rx_dma(sport);
 	imx_stop_tx_dma(sport);
 
-	/* clear UCR2 */
-	temp = readl(sport->port.membase + UCR2);
-	temp &= ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
-	writel(temp, sport->port.membase + UCR2);
-
 	imx_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 
 	sport->dma_is_enabled = 0;
-- 
1.8.3.1
