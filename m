From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 10 Aug 2018 10:05:18 +0200
Subject: [PATCH v2 21/29] ARM: davinci: da830-evm: use device properties for
 at24 eeprom
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Message-ID: <20180810080526.27207-22-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Drop the byte_len/size property, as the model name
already implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 9a055ebba081..fcfd1565bfdc 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -18,7 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/pcf857x.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/nvmem-provider.h>
@@ -419,12 +419,9 @@ static struct nvmem_cell_lookup da830_evm_mac_address_cell = {
 	.nvmem_name = "1-00500",
 };
 
-static struct at24_platform_data da830_evm_i2c_eeprom_info = {
-	.byte_len	= SZ_256K / 8,
-	.page_size	= 64,
-	.flags		= AT24_FLAG_ADDR16,
-	.setup		= davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry da830_evm_i2c_eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
+	{ }
 };
 
 static int __init da830_evm_ui_expander_setup(struct i2c_client *client,
@@ -458,7 +455,7 @@ static struct pcf857x_platform_data __initdata da830_evm_ui_expander_info = {
 static struct i2c_board_info __initdata da830_evm_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &da830_evm_i2c_eeprom_info,
+		.properties = da830_evm_i2c_eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-- 
2.18.0
