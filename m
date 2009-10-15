From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 15 Oct 2009 11:43:00 +0200
Subject: [PATCH 6/6] mx31moboard: SPI and MC13783 votage regulator support
In-Reply-To: <1255599780-12948-6-git-send-email-valentin.longchamp@epfl.ch>
References: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-2-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-3-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-4-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-5-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-6-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1255599780-12948-7-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mx31moboard.c |  118 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 118 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mx31moboard.c
index 605c0fa..3a0be12 100644
--- a/arch/arm/mach-mx3/mx31moboard.c
+++ b/arch/arm/mach-mx3/mx31moboard.c
@@ -26,6 +26,9 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/partitions.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/machine.h>
+#include <linux/mfd/mc13783.h>
+#include <linux/spi/spi.h>
 #include <linux/types.h>
 
 #include <asm/mach-types.h>
@@ -41,6 +44,7 @@
 #include <mach/i2c.h>
 #include <mach/mmc.h>
 #include <mach/mx3_camera.h>
+#include <mach/spi.h>
 
 #include "devices.h"
 
@@ -80,6 +84,16 @@ static unsigned int moboard_pins[] = {
 	/* SEL */
 	MX31_PIN_DTR_DCE1__GPIO2_8, MX31_PIN_DSR_DCE1__GPIO2_9,
 	MX31_PIN_RI_DCE1__GPIO2_10, MX31_PIN_DCD_DCE1__GPIO2_11,
+	/* SPI1 */
+	MX31_PIN_CSPI2_MOSI__MOSI, MX31_PIN_CSPI2_MISO__MISO,
+	MX31_PIN_CSPI2_SCLK__SCLK, MX31_PIN_CSPI2_SPI_RDY__SPI_RDY,
+	MX31_PIN_CSPI2_SS0__SS0, MX31_PIN_CSPI2_SS2__SS2,
+	/* Atlas IRQ */
+	MX31_PIN_GPIO1_3__GPIO1_3,
+	/* SPI2 */
+	MX31_PIN_CSPI3_MOSI__MOSI, MX31_PIN_CSPI3_MISO__MISO,
+	MX31_PIN_CSPI3_SCLK__SCLK, MX31_PIN_CSPI3_SPI_RDY__SPI_RDY,
+	MX31_PIN_CSPI2_SS1__CSPI3_SS1,
 };
 
 static struct physmap_flash_data mx31moboard_flash_data = {
@@ -125,6 +139,102 @@ static struct imxi2c_platform_data moboard_i2c1_pdata = {
 	.bitrate = 100000,
 };
 
+static int moboard_spi1_cs[] = {
+	MXC_SPI_CS(0),
+	MXC_SPI_CS(2),
+};
+
+static struct spi_imx_master moboard_spi1_master = {
+	.chipselect	= moboard_spi1_cs,
+	.num_chipselect	= ARRAY_SIZE(moboard_spi1_cs),
+};
+
+static struct regulator_consumer_supply sdhc_consumers[] = {
+	{
+		.dev	= &mxcsdhc_device0.dev,
+		.supply	= "sdhc0_vcc",
+	},
+	{
+		.dev	= &mxcsdhc_device1.dev,
+		.supply	= "sdhc1_vcc",
+	},
+};
+
+static struct regulator_init_data sdhc_vreg_data = {
+	.constraints = {
+		.min_uV = 2700000,
+		.max_uV = 3000000,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+			REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS,
+		.valid_modes_mask = REGULATOR_MODE_NORMAL |
+			REGULATOR_MODE_FAST,
+		.always_on = 0,
+		.boot_on = 1,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(sdhc_consumers),
+	.consumer_supplies = sdhc_consumers,
+};
+
+static struct regulator_consumer_supply cam_consumers[] = {
+	{
+		.dev	= &mx3_camera.dev,
+		.supply	= "cam_vcc",
+	},
+};
+
+static struct regulator_init_data cam_vreg_data = {
+	.constraints = {
+		.min_uV = 2700000,
+		.max_uV = 3000000,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+			REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS,
+		.valid_modes_mask = REGULATOR_MODE_NORMAL |
+			REGULATOR_MODE_FAST,
+		.always_on = 0,
+		.boot_on = 1,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(cam_consumers),
+	.consumer_supplies = cam_consumers,
+};
+
+static struct mc13783_regulator_init_data moboard_regulators[] = {
+	{
+		.id = MC13783_REGU_VMMC1,
+		.init_data = &sdhc_vreg_data,
+	},
+	{
+		.id = MC13783_REGU_VCAM,
+		.init_data = &cam_vreg_data,
+	},
+};
+
+static struct mc13783_platform_data moboard_pmic = {
+	.regulators = moboard_regulators,
+	.num_regulators = ARRAY_SIZE(moboard_regulators),
+	.flags = MC13783_USE_REGULATOR | MC13783_USE_RTC,
+};
+
+static struct spi_board_info moboard_spi_board_info[] __initdata = {
+	{
+		.modalias = "mc13783",
+		.irq = IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+		.max_speed_hz = 300000,
+		.bus_num = 1,
+		.chip_select = 0,
+		.platform_data = &moboard_pmic,
+		.mode = SPI_CS_HIGH,
+	}
+};
+
+static int moboard_spi2_cs[] = {
+	MXC_SPI_CS(1),
+};
+
+static struct spi_imx_master moboard_spi2_master = {
+	.chipselect	= moboard_spi2_cs,
+	.num_chipselect	= ARRAY_SIZE(moboard_spi2_cs),
+};
+
 #define SDHC1_CD IOMUX_TO_GPIO(MX31_PIN_ATA_CS0)
 #define SDHC1_WP IOMUX_TO_GPIO(MX31_PIN_ATA_CS1)
 
@@ -342,6 +452,14 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_i2c_device0, &moboard_i2c0_pdata);
 	mxc_register_device(&mxc_i2c_device1, &moboard_i2c1_pdata);
 
+	mxc_register_device(&mxc_spi_device1, &moboard_spi1_master);
+	mxc_register_device(&mxc_spi_device2, &moboard_spi2_master);
+
+	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3), "pmic-irq");
+	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
+	spi_register_board_info(moboard_spi_board_info,
+		ARRAY_SIZE(moboard_spi_board_info));
+
 	mxc_register_device(&mxcsdhc_device0, &sdhc1_pdata);
 
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
-- 
1.6.0.4
