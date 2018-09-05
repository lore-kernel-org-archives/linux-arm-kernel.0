From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  5 Sep 2018 11:57:37 +0200
Subject: [PATCH 12/13] Documentation: nvmem: document cell tables and lookup
 entries
In-Reply-To: <20180905095738.26406-1-brgl@bgdev.pl>
References: <20180905095738.26406-1-brgl@bgdev.pl>
Message-ID: <20180905095738.26406-13-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Document the new nvmem kernel APIs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/nvmem/nvmem.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
index 8d8d8f58f96f..2cb01cdf87c8 100644
--- a/Documentation/nvmem/nvmem.txt
+++ b/Documentation/nvmem/nvmem.txt
@@ -58,6 +58,36 @@ static int qfprom_probe(struct platform_device *pdev)
 It is mandatory that the NVMEM provider has a regmap associated with its
 struct device. Failure to do would return error code from nvmem_register().
 
+Users of board files can define and register nvmem cells using the
+nvmem_cell_table struct:
+
+static struct nvmem_cell_info foo_nvmem_cells[] = {
+	{
+		.name		= "mac-address",
+		.offset		= 0x7f00,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table foo_nvmem_cell_table = {
+	.nvmem_name		= "i2c-eeprom",
+	.cells			= foo_nvmem_cells,
+	.ncells			= ARRAY_SIZE(foo_nvmem_cells),
+};
+
+nvmem_add_cell_table(&foo_nvmem_cell_table);
+
+Additionally it is possible to create nvmem cell lookup entries and register
+them with the nvmem framework from machine code as shown in the example below:
+
+static struct nvmem_cell_lookup foo_nvmem_lookup = {
+	.nvmem_name		= "i2c-eeprom",
+	.dev_id			= "foo_mac.0",
+	.cell_id		= "mac-address",
+};
+
+nvmem_add_cell_lookups(&foo_nvmem_lookup, 1);
+
 NVMEM Consumers
 +++++++++++++++
 
-- 
2.18.0
