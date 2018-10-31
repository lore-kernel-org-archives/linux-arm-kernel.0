From: esmil@mailme.dk (Emil Renner Berthing)
Date: Wed, 31 Oct 2018 11:57:06 +0100
Subject: [PATCH v1 09/14] spi: rockchip: simplify use_dma logic
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
Message-ID: <20181031105711.19575-10-esmil@mailme.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emil Renner Berthing <kernel@esmil.dk>

We only need to know if we're using dma when setting
up the transfer, so just use a local variable for
that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 45a1479c1a29..ba60cbcd45c2 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -184,8 +184,6 @@ struct rockchip_spi {
 	void *rx_end;
 
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
-
-	bool use_dma;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
@@ -450,7 +448,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 }
 
 static void rockchip_spi_config(struct rockchip_spi *rs,
-		struct spi_device *spi, struct spi_transfer *xfer)
+		struct spi_device *spi, struct spi_transfer *xfer,
+		bool use_dma)
 {
 	u32 div = 0;
 	u32 dmacr = 0;
@@ -471,7 +470,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	else
 		cr0 |= CR0_XFM_TO << CR0_XFM_OFFSET;
 
-	if (rs->use_dma) {
+	if (use_dma) {
 		if (xfer->tx_buf)
 			dmacr |= TF_DMA_EN;
 		if (xfer->rx_buf)
@@ -537,6 +536,7 @@ static int rockchip_spi_transfer_one(
 		struct spi_transfer *xfer)
 {
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
+	bool use_dma;
 
 	WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
 		(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY));
@@ -559,15 +559,11 @@ static int rockchip_spi_transfer_one(
 	rs->rx = xfer->rx_buf;
 	rs->rx_end = rs->rx + xfer->len;
 
-	/* we need prepare dma before spi was enabled */
-	if (master->can_dma && master->can_dma(master, spi, xfer))
-		rs->use_dma = true;
-	else
-		rs->use_dma = false;
+	use_dma = master->can_dma ? master->can_dma(master, spi, xfer) : false;
 
-	rockchip_spi_config(rs, spi, xfer);
+	rockchip_spi_config(rs, spi, xfer, use_dma);
 
-	if (rs->use_dma)
+	if (use_dma)
 		return rockchip_spi_prepare_dma(rs, master, xfer);
 
 	return rockchip_spi_pio_transfer(rs);
-- 
2.19.1
