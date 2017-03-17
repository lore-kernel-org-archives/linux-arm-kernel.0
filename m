From: gerg@linux-m68k.org (Greg Ungerer)
Date: Fri, 17 Mar 2017 15:03:02 +1000
Subject: [PATCH 1/2] spi: imx: set correct chip_select in platform setup
In-Reply-To: <1489726983-17706-1-git-send-email-gerg@linux-m68k.org>
References: <1489726983-17706-1-git-send-email-gerg@linux-m68k.org>
Message-ID: <1489726983-17706-2-git-send-email-gerg@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platform based configuration setup of spi-imx SPI devices does
not set the "chip_select" to the actual hardware chip select used.
This works because the cs_gpio mapping that is associated with this
platform setup maps the chip_select offset used to the appropriate
hardware chip select. The spi-imx driver uses the chip_select as an
index into the cs_gpio array and ultimately gets the correct hardware
chip select for its hardware setup.

The motivation is to be able to eventually modify the spi-imx code to
use the "chip_select" directly for harwdare setup instead of indirectly
via the cs_gpio mapping array.

This change only affects platforms using the hardware chip select
addressing method for their SPI devices (sometimes called native chip
select). The majority of devices using the spi-imx driver use the GPIO
addressing method.

The change to use the correct "chip_select" is strait forward. But the
cs_gpio mapping arrary also needs to be modifed to match that change. In
simple terms the cs_gpio mapping should always have the hardware chip
select number at its same index offset.

There is no functional change with these patches. The three affected
platforms should work exactly as before. However I don't have any of
these platforms (or access to them) and so I can't test them. So this
patch is compile tested only.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/arm/mach-imx/mach-mx31_3ds.c    | 7 +++++--
 arch/arm/mach-imx/mach-mx31moboard.c | 4 ++--
 arch/arm/mach-imx/mach-pcm037_eet.c  | 4 ++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 558e5f8..68c3f07 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -375,6 +375,8 @@ static void mx31_3ds_sdhc1_setpower(struct device *dev, unsigned int vdd)
 
 /* SPI */
 static int spi0_internal_chipselect[] = {
+	MXC_SPI_CS(0),
+	MXC_SPI_CS(1),
 	MXC_SPI_CS(2),
 };
 
@@ -385,6 +387,7 @@ static void mx31_3ds_sdhc1_setpower(struct device *dev, unsigned int vdd)
 
 static int spi1_internal_chipselect[] = {
 	MXC_SPI_CS(0),
+	MXC_SPI_CS(1),
 	MXC_SPI_CS(2),
 };
 
@@ -398,7 +401,7 @@ static void mx31_3ds_sdhc1_setpower(struct device *dev, unsigned int vdd)
 		.modalias	= "mc13783",
 		.max_speed_hz	= 1000000,
 		.bus_num	= 1,
-		.chip_select	= 1, /* SS2 */
+		.chip_select	= 2, /* SS2 */
 		.platform_data	= &mc13783_pdata,
 		/* irq number is run-time assigned */
 		.mode = SPI_CS_HIGH,
@@ -406,7 +409,7 @@ static void mx31_3ds_sdhc1_setpower(struct device *dev, unsigned int vdd)
 		.modalias	= "l4f00242t03",
 		.max_speed_hz	= 5000000,
 		.bus_num	= 0,
-		.chip_select	= 0, /* SS2 */
+		.chip_select	= 2, /* SS2 */
 		.platform_data	= &mx31_3ds_l4f00242t03_pdata,
 	},
 };
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index cc86768..bde9a9a 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -296,14 +296,14 @@ static void __init moboard_uart0_init(void)
 		/* irq number is run-time assigned */
 		.max_speed_hz = 300000,
 		.bus_num = 1,
-		.chip_select = 0,
+		.chip_select = 1,
 		.platform_data = &moboard_pmic,
 		.mode = SPI_CS_HIGH,
 	},
 };
 
 static int moboard_spi2_cs[] = {
-	MXC_SPI_CS(1),
+	MXC_SPI_CS(0), MXC_SPI_CS(1),
 };
 
 static const struct spi_imx_master moboard_spi2_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-pcm037_eet.c b/arch/arm/mach-imx/mach-pcm037_eet.c
index 8fd8255..95bd977 100644
--- a/arch/arm/mach-imx/mach-pcm037_eet.c
+++ b/arch/arm/mach-imx/mach-pcm037_eet.c
@@ -50,13 +50,13 @@
 		.modalias	= "dac124s085",
 		.max_speed_hz	= 400000,
 		.bus_num	= 0,
-		.chip_select	= 0,		/* Index in pcm037_spi1_cs[] */
+		.chip_select	= 1,		/* Index in pcm037_spi1_cs[] */
 		.mode		= SPI_CPHA,
 	},
 };
 
 /* Platform Data for MXC CSPI */
-static int pcm037_spi1_cs[] = {MXC_SPI_CS(1), IOMUX_TO_GPIO(MX31_PIN_KEY_COL7)};
+static int pcm037_spi1_cs[] = { MXC_SPI_CS(0), MXC_SPI_CS(1), };
 
 static const struct spi_imx_master pcm037_spi1_pdata __initconst = {
 	.chipselect = pcm037_spi1_cs,
-- 
1.9.1
