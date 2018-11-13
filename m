From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 13 Nov 2018 15:01:11 +0100
Subject: [PATCH v2 03/25] ARM: davinci: dm365-evm: use cell nvmem lookup for
 mac address
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Message-ID: <20181113140133.17385-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups and cell definitions for machine code.
Add relevant data structures for the mac-address stored in at24 EEPROM.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 8143756ff38b..8703fc18dd3b 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/slab.h>
 #include <linux/mtd/rawnand.h>
+#include <linux/nvmem-provider.h>
 #include <linux/input.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
@@ -203,6 +204,27 @@ static struct platform_device davinci_aemif_device = {
 	.num_resources		= ARRAY_SIZE(davinci_aemif_resources),
 };
 
+static struct nvmem_cell_info davinci_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x7f00,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table davinci_nvmem_cell_table = {
+	.nvmem_name	= "1-00500",
+	.cells		= davinci_nvmem_cells,
+	.ncells		= ARRAY_SIZE(davinci_nvmem_cells),
+};
+
+static struct nvmem_cell_lookup davinci_nvmem_cell_lookup = {
+	.nvmem_name	= "1-00500",
+	.cell_name	= "macaddr",
+	.dev_id		= "davinci_emac.1",
+	.con_id		= "mac-address",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len       = (256*1024) / 8,
 	.page_size      = 64,
@@ -781,6 +803,9 @@ static __init void dm365_evm_init(void)
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
 
+	nvmem_add_cell_table(&davinci_nvmem_cell_table);
+	nvmem_add_cell_lookups(&davinci_nvmem_cell_lookup, 1);
+
 	evm_init_i2c();
 	davinci_serial_init(dm365_serial_device);
 
-- 
2.19.1
