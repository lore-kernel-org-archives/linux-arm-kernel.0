From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  2 Mar 2014 11:44:32 +0400
Subject: [PATCH 1/4] mfd: mc13xxx: Honor designed SPI mode
Message-ID: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using hard coded SPI mode, use mode described in
devicetree or defined for the board.
Additionally, patch updates all users of this PMIC to use
correct SPI mode.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/mach-mx31lilly.c | 1 +
 arch/arm/mach-imx/mach-mx31lite.c  | 1 +
 drivers/mfd/mc13xxx-spi.c          | 2 --
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 832b1e2..16c688e 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -231,6 +231,7 @@ static struct spi_board_info mc13783_dev __initdata = {
 	.bus_num	= 1,
 	.chip_select	= 0,
 	.platform_data	= &mc13783_pdata,
+	.mode		= SPI_MODE_0 | SPI_CS_HIGH,
 	/* irq number is run-time assigned */
 };
 
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index bea0729..bf3e61e 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -121,6 +121,7 @@ static struct spi_board_info mc13783_spi_dev __initdata = {
 	.bus_num	= 1,
 	.chip_select    = 0,
 	.platform_data  = &mc13783_pdata,
+	.mode		= SPI_MODE_0 | SPI_CS_HIGH,
 	/* irq number is run-time assigned */
 };
 
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index 38ab678..f88087f 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -136,8 +136,6 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
 
 	dev_set_drvdata(&spi->dev, mc13xxx);
 
-	spi->mode = SPI_MODE_0 | SPI_CS_HIGH;
-
 	mc13xxx->irq = spi->irq;
 
 	mc13xxx->regmap = devm_regmap_init(&spi->dev, &regmap_mc13xxx_bus,
-- 
1.8.3.2
