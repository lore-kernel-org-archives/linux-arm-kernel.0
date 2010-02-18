From: maz@misterjones.org (Marc Zyngier)
Date: Thu, 18 Feb 2010 20:33:02 +0000
Subject: [PATCH 5/5] pxa/zeus: Add support for mcp2515 CAN bus
Message-ID: <20100218203302.23593f6f@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/mach-pxa/include/mach/zeus.h |    2 +
 arch/arm/mach-pxa/zeus.c              |   55 +++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/zeus.h b/arch/arm/mach-pxa/include/mach/zeus.h
index 89e4fb5..6e11997 100644
--- a/arch/arm/mach-pxa/include/mach/zeus.h
+++ b/arch/arm/mach-pxa/include/mach/zeus.h
@@ -58,6 +58,8 @@
 #define ZEUS_EXT1_GPIO(x)	(ZEUS_EXT1_GPIO_BASE + (x))
 #define ZEUS_USER_GPIO(x)	(ZEUS_USER_GPIO_BASE + (x))
 
+#define	ZEUS_CAN_SHDN_GPIO	ZEUS_EXT1_GPIO(2)
+
 /*
  * CPLD registers:
  * Only 4 registers, but spreaded over a 32MB address space.
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index ec22bbf..773d6d0 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -26,6 +26,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
 #include <linux/apm-emulation.h>
+#include <linux/can/platform/mcp251x.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -387,11 +388,47 @@ static struct pxa2xx_spi_master pxa2xx_spi_ssp3_master_info = {
 	.enable_dma     = 1,
 };
 
-static struct platform_device pxa2xx_spi_ssp3_device = {
-	.name = "pxa2xx-spi",
-	.id = 3,
-	.dev = {
-		.platform_data = &pxa2xx_spi_ssp3_master_info,
+/* CAN bus on SPI */
+static int zeus_mcp2515_setup(struct spi_device *sdev)
+{
+	int err;
+
+	err = gpio_request(ZEUS_CAN_SHDN_GPIO, "CAN shutdown");
+	if (err)
+		return err;
+
+	err = gpio_direction_output(ZEUS_CAN_SHDN_GPIO, 1);
+	if (err) {
+		gpio_free(ZEUS_CAN_SHDN_GPIO);
+		return err;
+	}
+
+	return 0;
+}
+
+static int zeus_mcp2515_transceiver_enable(int enable)
+{
+	gpio_set_value(ZEUS_CAN_SHDN_GPIO, !enable);
+	return 0;
+}
+
+static struct mcp251x_platform_data zeus_mcp2515_pdata = {
+	.oscillator_frequency	= 16*1000*1000,
+	.model			= CAN_MCP251X_MCP2515,
+	.board_specific_setup	= zeus_mcp2515_setup,
+	.transceiver_enable	= zeus_mcp2515_transceiver_enable,
+	.power_enable		= zeus_mcp2515_transceiver_enable,
+};
+
+static struct spi_board_info zeus_spi_board_info[] = {
+	[0] = {
+		.modalias	= "mcp251x",
+		.platform_data	= &zeus_mcp2515_pdata,
+		.irq		= gpio_to_irq(ZEUS_CAN_GPIO),
+		.max_speed_hz	= 1*1000*1000,
+		.bus_num	= 3,
+		.mode		= SPI_MODE_0,
+		.chip_select	= 0,
 	},
 };
 
@@ -476,7 +513,6 @@ static struct platform_device *zeus_devices[] __initdata = {
 	&zeus_dm9k0_device,
 	&zeus_dm9k1_device,
 	&zeus_sram_device,
-	&pxa2xx_spi_ssp3_device,
 	&zeus_leds_device,
 	&zeus_pcmcia_device,
 	&zeus_max6369_device,
@@ -747,6 +783,11 @@ static mfp_cfg_t zeus_pin_config[] __initdata = {
 	GPIO104_CIF_DD_2,
 	GPIO105_CIF_DD_1,
 
+	GPIO81_SSP3_TXD,
+	GPIO82_SSP3_RXD,
+	GPIO83_SSP3_SFRM,
+	GPIO84_SSP3_SCLK,
+
 	GPIO48_nPOE,
 	GPIO49_nPWE,
 	GPIO50_nPIOR,
@@ -801,6 +842,8 @@ static void __init zeus_init(void)
 	pxa_set_ac97_info(&zeus_ac97_info);
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(zeus_i2c_devices));
+	pxa2xx_set_spi_info(3, &pxa2xx_spi_ssp3_master_info);
+	spi_register_board_info(zeus_spi_board_info, ARRAY_SIZE(zeus_spi_board_info));
 }
 
 static struct map_desc zeus_io_desc[] __initdata = {
-- 
1.7.0



-- 
I'm the slime oozin' out from your TV set...
