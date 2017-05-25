From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 25 May 2017 16:30:43 +1200
Subject: [RFC PATCH 5/5] ARM: ep93xx: remove chipselect from ep93xx_spi_info
In-Reply-To: <20170525043043.1930-1-chris.packham@alliedtelesis.co.nz>
References: <20170525043043.1930-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170525043043.1930-6-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the driver has been updated to use gpiod there is no need to
have platform data to define the SPI chipselects. We still need to
define the number of chipselects used.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/mach-ep93xx/edb93xx.c           | 7 +------
 arch/arm/mach-ep93xx/simone.c            | 7 +------
 arch/arm/mach-ep93xx/vision_ep9307.c     | 9 +--------
 include/linux/platform_data/spi-ep93xx.h | 4 +---
 4 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 9042adfe03de..b8d354fc27f5 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -127,13 +127,8 @@ static struct gpiod_lookup_table edb93xx_gpios_table = {
 	},
 };
 
-static int edb93xx_spi_chipselects[] __initdata = {
-	EP93XX_GPIO_LINE_EGPIO6,
-};
-
 static struct ep93xx_spi_info edb93xx_spi_info __initdata = {
-	.chipselect	= edb93xx_spi_chipselects,
-	.num_chipselect	= ARRAY_SIZE(edb93xx_spi_chipselects),
+	.num_chipselect	= 1,
 };
 
 static void __init edb93xx_register_spi(void)
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index f297a7a89ed9..cb6bc2e1670a 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -129,13 +129,8 @@ static struct gpiod_lookup_table simone_gpios_table = {
 	},
 };
 
-static int simone_spi_chipselects[] __initdata = {
-	EP93XX_GPIO_LINE_EGPIO1,
-};
-
 static struct ep93xx_spi_info simone_spi_info __initdata = {
-	.chipselect	= simone_spi_chipselects,
-	.num_chipselect	= ARRAY_SIZE(simone_spi_chipselects),
+	.num_chipselect	= 1,
 	.use_dma = 1,
 };
 
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index 3d9c66bbf2af..494c55080472 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -256,15 +256,8 @@ static struct gpiod_lookup_table vision_gpios_table = {
 	},
 };
 
-static int vision_spi_chipselects[] __initdata = {
-	EP93XX_GPIO_LINE_EGPIO6,
-	EP93XX_GPIO_LINE_EGPIO7,
-	EP93XX_GPIO_LINE_G(2),
-};
-
 static struct ep93xx_spi_info vision_spi_master __initdata = {
-	.chipselect	= vision_spi_chipselects,
-	.num_chipselect	= ARRAY_SIZE(vision_spi_chipselects),
+	.num_chipselect	= 3,
 	.use_dma	= 1,
 };
 
diff --git a/include/linux/platform_data/spi-ep93xx.h b/include/linux/platform_data/spi-ep93xx.h
index 171a271c2cbd..efcf33eff851 100644
--- a/include/linux/platform_data/spi-ep93xx.h
+++ b/include/linux/platform_data/spi-ep93xx.h
@@ -5,12 +5,10 @@ struct spi_device;
 
 /**
  * struct ep93xx_spi_info - EP93xx specific SPI descriptor
- * @chipselect: array of gpio numbers to use as chip selects
- * @num_chipselect: ARRAY_SIZE(chipselect)
+ * @num_chipselect: number chip selects supported
  * @use_dma: use DMA for the transfers
  */
 struct ep93xx_spi_info {
-	int	*chipselect;
 	int	num_chipselect;
 	bool	use_dma;
 };
-- 
2.13.0
