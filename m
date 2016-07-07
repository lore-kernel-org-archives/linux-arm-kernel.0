From: broonie@kernel.org (Mark Brown)
Date: Thu, 07 Jul 2016 12:01:54 +0200
Subject: Applied "spi: s3c64xx: do not disable the clock while configuring the
 spi" to the spi tree
In-Reply-To: <1467876237-12183-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <E1bL682-0000ul-2D@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: s3c64xx: do not disable the clock while configuring the spi

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From d9aaf1dc984a448ae5630e53a611a8b3489d1f8d Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Thu, 7 Jul 2016 16:23:57 +0900
Subject: [PATCH] spi: s3c64xx: do not disable the clock while configuring the
 spi

When the clock is coming from the cmu it is not required to be
disabled and then re-enabled in order to change the rate.

Besides, some exynos chipsets (e.g. exynos5433) do not deliver
any to the SFR if one from the pclk ("spi" in this case) or sclk
("busclk") is disabled.

Remove the clock disabling/enabling to avoid falling into this
situation.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9f0119f64f93..df88fa161d8a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -596,9 +596,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	u32 val;
 
 	/* Disable Clock */
-	if (sdd->port_conf->clk_from_cmu) {
-		clk_disable_unprepare(sdd->src_clk);
-	} else {
+	if (!sdd->port_conf->clk_from_cmu) {
 		val = readl(regs + S3C64XX_SPI_CLK_CFG);
 		val &= ~S3C64XX_SPI_ENCLK_ENABLE;
 		writel(val, regs + S3C64XX_SPI_CLK_CFG);
@@ -641,11 +639,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
 	if (sdd->port_conf->clk_from_cmu) {
-		/* Configure Clock */
-		/* There is half-multiplier before the SPI */
 		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
-		/* Enable Clock */
-		clk_prepare_enable(sdd->src_clk);
 	} else {
 		/* Configure Clock */
 		val = readl(regs + S3C64XX_SPI_CLK_CFG);
-- 
2.8.1
