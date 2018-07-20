From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 20 Jul 2018 17:15:14 +0200
Subject: [PATCH v4 22/35] mtd: rawnand: tango: convert driver to nand_scan()
In-Reply-To: <20180720151527.16038-1-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
Message-ID: <20180720151527.16038-23-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/tango_nand.c | 40 +++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index dd7a26efdf4f..a448d0797cd5 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -517,6 +517,28 @@ static int tango_set_timings(struct mtd_info *mtd, int csline,
 	return 0;
 }
 
+static int tango_attach_chip(struct nand_chip *chip)
+{
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	ecc->mode = NAND_ECC_HW;
+	ecc->algo = NAND_ECC_BCH;
+	ecc->bytes = DIV_ROUND_UP(ecc->strength * FIELD_ORDER, BITS_PER_BYTE);
+
+	ecc->read_page_raw = tango_read_page_raw;
+	ecc->write_page_raw = tango_write_page_raw;
+	ecc->read_page = tango_read_page;
+	ecc->write_page = tango_write_page;
+	ecc->read_oob = tango_read_oob;
+	ecc->write_oob = tango_write_oob;
+
+	return 0;
+}
+
+static const struct nand_controller_ops tango_controller_ops = {
+	.attach_chip = tango_attach_chip,
+};
+
 static int chip_init(struct device *dev, struct device_node *np)
 {
 	u32 cs;
@@ -560,28 +582,14 @@ static int chip_init(struct device *dev, struct device_node *np)
 			NAND_NO_SUBPAGE_WRITE |
 			NAND_WAIT_TCCS;
 	chip->controller = &nfc->hw;
+	chip->controller->ops = &tango_controller_ops;
 	tchip->base = nfc->pbus_base + (cs * 256);
 
 	nand_set_flash_node(chip, np);
 	mtd_set_ooblayout(mtd, &tango_nand_ooblayout_ops);
 	mtd->dev.parent = dev;
 
-	err = nand_scan_ident(mtd, 1, NULL);
-	if (err)
-		return err;
-
-	ecc->mode = NAND_ECC_HW;
-	ecc->algo = NAND_ECC_BCH;
-	ecc->bytes = DIV_ROUND_UP(ecc->strength * FIELD_ORDER, BITS_PER_BYTE);
-
-	ecc->read_page_raw = tango_read_page_raw;
-	ecc->write_page_raw = tango_write_page_raw;
-	ecc->read_page = tango_read_page;
-	ecc->write_page = tango_write_page;
-	ecc->read_oob = tango_read_oob;
-	ecc->write_oob = tango_write_oob;
-
-	err = nand_scan_tail(mtd);
+	err = nand_scan(mtd, 1);
 	if (err)
 		return err;
 
-- 
2.14.1
