From: esmil@mailme.dk (Emil Renner Berthing)
Date: Wed, 31 Oct 2018 11:56:58 +0100
Subject: [PATCH v1 01/14] spi: rockchip: make spi_enable_chip take bool
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
Message-ID: <20181031105711.19575-2-esmil@mailme.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emil Renner Berthing <kernel@esmil.dk>

The spi_enable_chip function takes a boolean
argument. Change the type to reflect that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 51ef632bca52..7e54e1a69cc8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -208,9 +208,9 @@ struct rockchip_spi {
 	struct rockchip_spi_dma_data dma_tx;
 };
 
-static inline void spi_enable_chip(struct rockchip_spi *rs, int enable)
+static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
 {
-	writel_relaxed((enable ? 1 : 0), rs->regs + ROCKCHIP_SPI_SSIENR);
+	writel_relaxed((enable ? 1U : 0U), rs->regs + ROCKCHIP_SPI_SSIENR);
 }
 
 static inline void spi_set_clk(struct rockchip_spi *rs, u16 div)
@@ -339,7 +339,7 @@ static int rockchip_spi_unprepare_message(struct spi_master *master,
 {
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	spi_enable_chip(rs, 0);
+	spi_enable_chip(rs, false);
 
 	return 0;
 }
@@ -379,7 +379,7 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 {
 	int remain = 0;
 
-	spi_enable_chip(rs, 1);
+	spi_enable_chip(rs, true);
 
 	do {
 		if (rs->tx) {
@@ -399,7 +399,7 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 	if (rs->tx)
 		wait_for_idle(rs);
 
-	spi_enable_chip(rs, 0);
+	spi_enable_chip(rs, false);
 
 	return 0;
 }
@@ -413,7 +413,7 @@ static void rockchip_spi_dma_rxcb(void *data)
 
 	rs->state &= ~RXBUSY;
 	if (!(rs->state & TXBUSY)) {
-		spi_enable_chip(rs, 0);
+		spi_enable_chip(rs, false);
 		spi_finalize_current_transfer(rs->master);
 	}
 
@@ -432,7 +432,7 @@ static void rockchip_spi_dma_txcb(void *data)
 
 	rs->state &= ~TXBUSY;
 	if (!(rs->state & RXBUSY)) {
-		spi_enable_chip(rs, 0);
+		spi_enable_chip(rs, false);
 		spi_finalize_current_transfer(rs->master);
 	}
 
@@ -503,7 +503,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_rx.ch);
 	}
 
-	spi_enable_chip(rs, 1);
+	spi_enable_chip(rs, true);
 
 	if (txdesc) {
 		spin_lock_irqsave(&rs->lock, flags);
@@ -705,7 +705,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_disable_apbclk;
 	}
 
-	spi_enable_chip(rs, 0);
+	spi_enable_chip(rs, false);
 
 	rs->type = SSI_MOTO_SPI;
 	rs->master = master;
-- 
2.19.1
