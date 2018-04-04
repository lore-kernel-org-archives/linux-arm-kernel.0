From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  4 Apr 2018 15:16:26 +0200
Subject: [PATCH 3/4] ARM: imx: pca100: use device properties for at24 eeprom
In-Reply-To: <20180404131627.9135-1-brgl@bgdev.pl>
References: <20180404131627.9135-1-brgl@bgdev.pl>
Message-ID: <20180404131627.9135-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Specify the exact model instead of the "at24"
wildcard and drop the byte_len/size property, as the model name already
implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/mach-imx/mach-pca100.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index ed675863655b..5714e2f1b106 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -20,7 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/dma-mapping.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
@@ -168,16 +168,15 @@ static const struct imxi2c_platform_data pca100_i2c1_data __initconst = {
 	.bitrate = 100000,
 };
 
-static struct at24_platform_data board_eeprom = {
-	.byte_len = 4096,
-	.page_size = 32,
-	.flags = AT24_FLAG_ADDR16,
+static const struct property_entry board_eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 32),
+	{ }
 };
 
 static struct i2c_board_info pca100_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("at24", 0x52), /* E0=0, E1=1, E2=0 */
-		.platform_data = &board_eeprom,
+		I2C_BOARD_INFO("24c32", 0x52), /* E0=0, E1=1, E2=0 */
+		.properties = board_eeprom_properties,
 	}, {
 		I2C_BOARD_INFO("pcf8563", 0x51),
 	}, {
-- 
2.16.3
