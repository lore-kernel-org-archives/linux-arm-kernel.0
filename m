From: esmil@mailme.dk (Emil Renner Berthing)
Date: Wed, 31 Oct 2018 11:56:59 +0100
Subject: [PATCH v1 02/14] spi: rockchip: use designated init for dma config
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
Message-ID: <20181031105711.19575-3-esmil@mailme.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emil Renner Berthing <kernel@esmil.dk>

Use C99 designated initializers for dma slave config
structures. This also makes sure uninitialized fields
are zeroed so we don't need an explicit memset.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 7e54e1a69cc8..87d1b9837d94 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -442,12 +442,8 @@ static void rockchip_spi_dma_txcb(void *data)
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 {
 	unsigned long flags;
-	struct dma_slave_config rxconf, txconf;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
-	memset(&rxconf, 0, sizeof(rxconf));
-	memset(&txconf, 0, sizeof(txconf));
-
 	spin_lock_irqsave(&rs->lock, flags);
 	rs->state &= ~RXBUSY;
 	rs->state &= ~TXBUSY;
@@ -455,10 +451,13 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	rxdesc = NULL;
 	if (rs->rx) {
-		rxconf.direction = DMA_DEV_TO_MEM;
-		rxconf.src_addr = rs->dma_rx.addr;
-		rxconf.src_addr_width = rs->n_bytes;
-		rxconf.src_maxburst = 1;
+		struct dma_slave_config rxconf = {
+			.direction = DMA_DEV_TO_MEM,
+			.src_addr = rs->dma_rx.addr,
+			.src_addr_width = rs->n_bytes,
+			.src_maxburst = 1,
+		};
+
 		dmaengine_slave_config(rs->dma_rx.ch, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
@@ -474,10 +473,13 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	txdesc = NULL;
 	if (rs->tx) {
-		txconf.direction = DMA_MEM_TO_DEV;
-		txconf.dst_addr = rs->dma_tx.addr;
-		txconf.dst_addr_width = rs->n_bytes;
-		txconf.dst_maxburst = rs->fifo_len / 2;
+		struct dma_slave_config txconf = {
+			.direction = DMA_MEM_TO_DEV,
+			.dst_addr = rs->dma_tx.addr,
+			.dst_addr_width = rs->n_bytes,
+			.dst_maxburst = rs->fifo_len / 2,
+		};
+
 		dmaengine_slave_config(rs->dma_tx.ch, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
-- 
2.19.1
