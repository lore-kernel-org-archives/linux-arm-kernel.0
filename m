From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 10 Aug 2018 10:05:04 +0200
Subject: [PATCH v2 07/29] ARM: davinci: dm365-evm: use nvmem lookup for mac
 address
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Message-ID: <20180810080526.27207-8-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 435f7ec7d9af..cf3f2e611228 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -22,6 +22,7 @@
 #include <linux/leds.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/nvmem-provider.h>
 #include <linux/slab.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/input.h>
@@ -169,6 +170,15 @@ static struct platform_device davinci_nand_device = {
 	},
 };
 
+static struct nvmem_cell_lookup dm365evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x7f00,
+		.bytes = ETH_ALEN,
+	},
+	.nvmem_name = "1-00500",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len       = (256*1024) / 8,
 	.page_size      = 64,
@@ -769,6 +779,8 @@ static __init void dm365_evm_init(void)
 
 	dm365_init_spi0(BIT(0), dm365_evm_spi_info,
 			ARRAY_SIZE(dm365_evm_spi_info));
+
+	nvmem_add_lookup_table(&dm365evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
-- 
2.18.0
