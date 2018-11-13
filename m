From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 13 Nov 2018 15:01:12 +0100
Subject: [PATCH v2 04/25] ARM: davinci: dm644x-evm: use cell nvmem lookup for
 mac address
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Message-ID: <20181113140133.17385-5-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups and cell definitions for machine code.
Add relevant data structures for the mac-address stored in at24 EEPROM.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index e4a8f9225d16..e1428115067f 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -22,6 +22,7 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/nvmem-provider.h>
 #include <linux/phy.h>
 #include <linux/clk.h>
 #include <linux/videodev2.h>
@@ -510,6 +511,27 @@ static struct pcf857x_platform_data pcf_data_u35 = {
  *  - ... newer boards may have more
  */
 
+static struct nvmem_cell_info dm644evm_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x7f00,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table dm644evm_nvmem_cell_table = {
+	.nvmem_name	= "1-00500",
+	.cells		= dm644evm_nvmem_cells,
+	.ncells		= ARRAY_SIZE(dm644evm_nvmem_cells),
+};
+
+static struct nvmem_cell_lookup dm644evm_nvmem_cell_lookup = {
+	.nvmem_name	= "1-00500",
+	.cell_name	= "macaddr",
+	.dev_id		= "davinci_emac.1",
+	.con_id		= "mac-address",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len	= (256*1024) / 8,
 	.page_size	= 64,
@@ -842,6 +864,8 @@ static __init void davinci_evm_init(void)
 	platform_add_devices(davinci_evm_devices,
 			     ARRAY_SIZE(davinci_evm_devices));
 #ifdef CONFIG_I2C
+	nvmem_add_cell_table(&dm644evm_nvmem_cell_table);
+	nvmem_add_cell_lookups(&dm644evm_nvmem_cell_lookup, 1);
 	evm_init_i2c();
 	davinci_setup_mmc(0, &dm6446evm_mmc_config);
 #endif
-- 
2.19.1
