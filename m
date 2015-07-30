From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 30 Jul 2015 15:50:25 +0200
Subject: [RFC PATCH 6/6] mtd: nand: sunxi: support per-partition ECC config
In-Reply-To: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1438264225-23796-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner SoCs have to support per-partition ECC in order to properly
expose the first stage bootloader partition which requires specific ECC
config that might not match the NAND chip requirements.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 61 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 96dda70..6ced4c9 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -210,6 +210,10 @@ struct sunxi_nand_hw_ecc {
 	struct nand_ecclayout layout;
 };
 
+struct sunxi_nand_part {
+	struct nand_ecc_ctrl ecc;
+};
+
 /*
  * NAND chip structure: stores NAND chip device related information
  *
@@ -535,7 +539,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 				      int oob_required, int page)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	struct nand_ecc_ctrl *ecc = nand_ecc(chip);
 	struct nand_ecclayout *layout = ecc->layout;
 	struct sunxi_nand_hw_ecc *data = ecc->priv;
 	unsigned int max_bitflips = 0;
@@ -621,7 +625,7 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 				       const uint8_t *buf, int oob_required)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	struct nand_ecc_ctrl *ecc = nand_ecc(chip);
 	struct nand_ecclayout *layout = ecc->layout;
 	struct sunxi_nand_hw_ecc *data = ecc->priv;
 	int offset;
@@ -697,7 +701,7 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 					       int page)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	struct nand_ecc_ctrl *ecc = nand_ecc(chip);
 	struct sunxi_nand_hw_ecc *data = ecc->priv;
 	unsigned int max_bitflips = 0;
 	uint8_t *oob = chip->oob_poi;
@@ -765,7 +769,7 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 						int oob_required)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	struct nand_ecc_ctrl *ecc = nand_ecc(chip);
 	struct sunxi_nand_hw_ecc *data = ecc->priv;
 	uint8_t *oob = chip->oob_poi;
 	int offset = 0;
@@ -1214,6 +1218,54 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
 	return 0;
 }
 
+static int sunxi_nand_part_add(struct mtd_part *part)
+{
+	struct nand_part *npart = mtd_part_get_priv(part);
+	struct device_node *np = part->mtd.dev.of_node;
+	struct sunxi_nand_part *spart;
+	int ret;
+
+	if (!np)
+		return 0;
+
+	spart = kzalloc(sizeof(*spart), GFP_KERNEL);
+	if (!spart)
+		return -ENOMEM;
+
+	/*
+	 * Only initialize partition specific ECC config if the nand-ecc-mode
+	 * property is provided.
+	 */
+	if (of_get_nand_ecc_mode(np) >= 0) {
+		ret = sunxi_nand_ecc_init(&part->mtd, &spart->ecc, np);
+		if (ret) {
+			kfree(spart);
+			return ret;
+		}
+
+		npart->ecc = &spart->ecc;
+	}
+
+	nand_part_set_priv(npart, spart);
+
+	return 0;
+}
+
+static void sunxi_nand_part_remove(struct mtd_part *part)
+{
+	struct nand_part *npart = mtd_part_get_priv(part);
+	struct sunxi_nand_part *spart = nand_part_get_priv(npart);
+
+	npart->ecc = NULL;
+	sunxi_nand_ecc_cleanup(&spart->ecc);
+	kfree(spart);
+}
+
+static const struct nand_part_ops sunxi_nand_part_ops = {
+	.add = sunxi_nand_part_add,
+	.remove = sunxi_nand_part_remove,
+};
+
 static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 				struct device_node *np)
 {
@@ -1317,6 +1369,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	nand->read_buf = sunxi_nfc_read_buf;
 	nand->write_buf = sunxi_nfc_write_buf;
 	nand->read_byte = sunxi_nfc_read_byte;
+	nand->part_ops = &sunxi_nand_part_ops;
 
 	if (of_get_nand_on_flash_bbt(np))
 		nand->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
-- 
1.9.1
