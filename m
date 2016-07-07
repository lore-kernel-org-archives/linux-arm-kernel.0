From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 07 Jul 2016 16:23:57 +0900
Subject: [PATCH] spi: s3c64xx: do not disable the clock while configuring the
 spi
Message-ID: <1467876237-12183-1-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the clock is coming from the cmu it is not required to be
disabled and then re-enabled in order to change the rate.

Besides, some exynos chipsets (e.g. exynos5433) do not deliver
any to the SFR if one from the pclk ("spi" in this case) or sclk
("busclk") is disabled.

Remove the clock disabling/enabling to avoid falling into this
situation.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---

Hi,

This patch has been tested by me and Sylwester on Trats2
(exynos4412) and tm2(e) (exynos5433) boards, for big data
(which use dma transfer) and small data.

It also fixes in exynos5433 a synchronus abort caused by the fact
that the pclk (spi) doesn't get delivered if the sclk is disabled
(busclk)

Thanks,
Andi

 drivers/spi/spi-s3c64xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 048c900..c719e73 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -577,9 +577,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	u32 val;
 
 	/* Disable Clock */
-	if (sdd->port_conf->clk_from_cmu) {
-		clk_disable_unprepare(sdd->src_clk);
-	} else {
+	if (!sdd->port_conf->clk_from_cmu) {
 		val = readl(regs + S3C64XX_SPI_CLK_CFG);
 		val &= ~S3C64XX_SPI_ENCLK_ENABLE;
 		writel(val, regs + S3C64XX_SPI_CLK_CFG);
@@ -622,11 +620,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
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
