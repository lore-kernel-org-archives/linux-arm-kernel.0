From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 17 Nov 2010 10:23:19 -0800 (PST)
Subject: [PATCH] mx51_babbage: Add AT24C512 EEPROM support
Message-ID: <475095.26590.qm@web51005.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX51 Babbage has an AT24C512 connected to I2C1 on its expansion
board.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 66b07d8..ffb403e 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -22,6 +22,7 @@
 #include <linux/input.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
+#include <linux/i2c/at24.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -342,6 +343,19 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
 };
 
+static struct at24_platform_data at24c512 = {
+	.byte_len = SZ_512K/8,
+	.page_size = 128,
+	.flags = AT24_FLAG_ADDR16,
+};
+
+static struct i2c_board_info mx51_babbage_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("at24-eeprom", 0x50),
+		.platform_data = &at24c512,
+	},
+};
+
 /*
  * Board specific initialization.
  */
@@ -364,6 +378,8 @@ static void __init mxc_board_init(void)
 	mxc_iomux_v3_setup_pad(&power_key);
 	imx51_add_gpio_keys(&imx_button_data);
 
+	i2c_register_board_info(0, mx51_babbage_i2c_devices,
+		ARRAY_SIZE(mx51_babbage_i2c_devices));
 	imx51_add_imx_i2c(0, &babbage_i2c_data);
 	imx51_add_imx_i2c(1, &babbage_i2c_data);
 	mxc_register_device(&mxc_hsi2c_device, &babbage_hsi2c_data);
-- 
1.6.0.4



      
