From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 19 Jan 2015 16:33:06 +0800
Subject: [PATCH 1/2] mtd: atmel_nand: introduce a new compatible string for
 sama5d4 chip
Message-ID: <1421656387-12538-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since in SAMA5D4 chip, the PMECC can correct bit flips in erased page.
So we add a DT property to indicate this hardware character.

If the PMECC support correct bitflip erased page (all data are 0xff).
Then we can use the PMECC correct the page and skip the erased page
check.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 .../devicetree/bindings/mtd/atmel-nand.txt         |  2 +-
 drivers/mtd/nand/atmel_nand.c                      | 25 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index 1fe6dde..7d4c8eb 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -1,7 +1,7 @@
 Atmel NAND flash
 
 Required properties:
-- compatible : "atmel,at91rm9200-nand".
+- compatible : should be "atmel,at91rm9200-nand" or "atmel,sama5d4-nand".
 - reg : should specify localbus address and size used for the chip,
 	and hardware ECC controller if available.
 	If the hardware ECC is PMECC, it should contain address and size for
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 044c9d1..8d5b008 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -63,6 +63,10 @@ module_param(on_flash_bbt, int, 0);
 #include "atmel_nand_ecc.h"	/* Hardware ECC registers */
 #include "atmel_nand_nfc.h"	/* Nand Flash Controller definition */
 
+struct atmel_nand_caps {
+	bool pmecc_correct_erase_page;
+};
+
 /* oob layout for large page size
  * bad block info is on bytes 0 and 1
  * the bytes have to be consecutives to avoid
@@ -124,6 +128,7 @@ struct atmel_nand_host {
 
 	struct atmel_nfc	*nfc;
 
+	struct atmel_nand_caps	*caps;
 	bool			has_pmecc;
 	u8			pmecc_corr_cap;
 	u16			pmecc_sector_size;
@@ -849,6 +854,10 @@ static int pmecc_correction(struct mtd_info *mtd, u32 pmecc_stat, uint8_t *buf,
 	uint8_t *buf_pos;
 	int max_bitflips = 0;
 
+	/* If can correct bitfilps from erased page, do the normal check */
+	if (host->caps->pmecc_correct_erase_page)
+		goto normal_check;
+
 	for (i = 0; i < nand_chip->ecc.total; i++)
 		if (ecc[i] != 0xff)
 			goto normal_check;
@@ -1474,6 +1483,8 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
 		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
 }
 
+static const struct of_device_id atmel_nand_dt_ids[];
+
 static int atmel_of_init_port(struct atmel_nand_host *host,
 			      struct device_node *np)
 {
@@ -1483,6 +1494,9 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 	struct atmel_nand_data *board = &host->board;
 	enum of_gpio_flags flags = 0;
 
+	host->caps = (struct atmel_nand_caps *)
+		of_match_device(atmel_nand_dt_ids, host->dev)->data;
+
 	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) == 0) {
 		if (val >= 32) {
 			dev_err(host->dev, "invalid addr-offset %u\n", val);
@@ -2287,8 +2301,17 @@ static int atmel_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct atmel_nand_caps at91rm9200_caps = {
+	.pmecc_correct_erase_page = false,
+};
+
+static struct atmel_nand_caps sama5d4_caps = {
+	.pmecc_correct_erase_page = true,
+};
+
 static const struct of_device_id atmel_nand_dt_ids[] = {
-	{ .compatible = "atmel,at91rm9200-nand" },
+	{ .compatible = "atmel,at91rm9200-nand", .data = &at91rm9200_caps },
+	{ .compatible = "atmel,sama5d4-nand", .data = &sama5d4_caps },
 	{ /* sentinel */ }
 };
 
-- 
1.9.1
