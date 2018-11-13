From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 13 Nov 2018 15:01:13 +0100
Subject: [PATCH v2 05/25] ARM: davinci: dm646x-evm: use cell nvmem lookup for
 mac address
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Message-ID: <20181113140133.17385-6-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups and cell definitions for machine code.
Add relevant data structures for the mac-address stored in at24 EEPROM.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 3e5ee09ee717..8d5be6dd2019 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -32,6 +32,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/nvmem-provider.h>
 #include <linux/clk.h>
 #include <linux/export.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -342,6 +343,27 @@ static struct pcf857x_platform_data pcf_data = {
  *  - ... newer boards may have more
  */
 
+static struct nvmem_cell_info dm646x_evm_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x7f00,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table dm646x_evm_nvmem_cell_table = {
+	.nvmem_name	= "1-00500",
+	.cells		= dm646x_evm_nvmem_cells,
+	.ncells		= ARRAY_SIZE(dm646x_evm_nvmem_cells),
+};
+
+static struct nvmem_cell_lookup dm646x_evm_nvmem_cell_lookup = {
+	.nvmem_name	= "1-00500",
+	.cell_name	= "macaddr",
+	.dev_id		= "davinci_emac.1",
+	.con_id		= "mac-address",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len       = (256*1024) / 8,
 	.page_size      = 64,
@@ -815,6 +837,8 @@ static __init void evm_init(void)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
 
 #ifdef CONFIG_I2C
+	nvmem_add_cell_table(&dm646x_evm_nvmem_cell_table);
+	nvmem_add_cell_lookups(&dm646x_evm_nvmem_cell_lookup, 1);
 	evm_init_i2c();
 #endif
 
-- 
2.19.1
