From: broonie@kernel.org (Mark Brown)
Date: Mon,  5 Nov 2018 12:06:30 +0000 (GMT)
Subject: Applied "spi: rockchip: remove master pointer from dev data" to the
 spi tree
In-Reply-To: <20181031105711.19575-9-esmil@mailme.dk>
Message-ID: <20181105120630.2BE051124D98@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: remove master pointer from dev data

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d790c342e689ea77a5cf72d5b993299911ee5276 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:05 +0100
Subject: [PATCH] spi: rockchip: remove master pointer from dev data

In almost all cases we already have a pointer to the
spi master structure where we have the driver data.

The only exceptions are the dma callbacks which are
easily fixed by passing them the master and using
spi_master_get_devdata to retrieve the driver data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
