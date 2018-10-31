From: esmil@mailme.dk (Emil Renner Berthing)
Date: Wed, 31 Oct 2018 11:57:05 +0100
Subject: [PATCH v1 08/14] spi: rockchip: remove master pointer from dev data
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
Message-ID: <20181031105711.19575-9-esmil@mailme.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emil Renner Berthing <kernel@esmil.dk>

In almost all cases we already have a pointer to the
spi master structure where we have the driver data.

The only exceptions are the dma callbacks which are
easily fixed by passing them the master and using
spi_master_get_devdata to retrieve the driver data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index f3fe6d4cf6f6..45a1479c1a29 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -159,7 +159,6 @@
 
 struct rockchip_spi {
 	struct device *dev;
-	struct spi_master *master;
 
 	struct clk *spiclk;
 	struct clk *apb_pclk;
@@ -350,19 +349,21 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 
 static void rockchip_spi_dma_rxcb(void *data)
 {
-	struct rockchip_spi *rs = data;
+	struct spi_master *master = data;
+	struct rockchip_spi *rs = spi_master_get_devdata(master);
 	int state = atomic_fetch_andnot(RXDMA, &rs->state);
 
 	if (state & TXDMA)
 		return;
 
 	spi_enable_chip(rs, false);
-	spi_finalize_current_transfer(rs->master);
+	spi_finalize_current_transfer(master);
 }
 
 static void rockchip_spi_dma_txcb(void *data)
 {
-	struct rockchip_spi *rs = data;
+	struct spi_master *master = data;
+	struct rockchip_spi *rs = spi_master_get_devdata(master);
 	int state = atomic_fetch_andnot(TXDMA, &rs->state);
 
 	if (state & RXDMA)
@@ -372,7 +373,7 @@ static void rockchip_spi_dma_txcb(void *data)
 	wait_for_idle(rs);
 
 	spi_enable_chip(rs, false);
-	spi_finalize_current_transfer(rs->master);
+	spi_finalize_current_transfer(master);
 }
 
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
@@ -401,7 +402,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 			return -EINVAL;
 
 		rxdesc->callback = rockchip_spi_dma_rxcb;
-		rxdesc->callback_param = rs;
+		rxdesc->callback_param = master;
 	}
 
 	txdesc = NULL;
@@ -426,7 +427,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 		}
 
 		txdesc->callback = rockchip_spi_dma_txcb;
-		txdesc->callback_param = rs;
+		txdesc->callback_param = master;
 	}
 
 	/* rx must be started before tx due to spi instinct */
@@ -633,7 +634,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	spi_enable_chip(rs, false);
 
-	rs->master = master;
 	rs->dev = &pdev->dev;
 	rs->max_freq = clk_get_rate(rs->spiclk);
 
@@ -746,9 +746,8 @@ static int rockchip_spi_suspend(struct device *dev)
 {
 	int ret;
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	ret = spi_master_suspend(rs->master);
+	ret = spi_master_suspend(master);
 	if (ret < 0)
 		return ret;
 
@@ -773,7 +772,7 @@ static int rockchip_spi_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = spi_master_resume(rs->master);
+	ret = spi_master_resume(master);
 	if (ret < 0) {
 		clk_disable_unprepare(rs->spiclk);
 		clk_disable_unprepare(rs->apb_pclk);
-- 
2.19.1
