From: broonie@kernel.org (Mark Brown)
Date: Mon,  5 Nov 2018 12:06:58 +0000 (GMT)
Subject: Applied "spi: rockchip: make spi_enable_chip take bool" to the spi
 tree
In-Reply-To: <20181031105711.19575-2-esmil@mailme.dk>
Message-ID: <20181105120659.0191B1124D98@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: make spi_enable_chip take bool

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

>From 30688e4e670d21126aa596df4523940e2f8d24de Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:56:58 +0100
Subject: [PATCH] spi: rockchip: make spi_enable_chip take bool

The spi_enable_chip function takes a boolean
argument. Change the type to reflect that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
