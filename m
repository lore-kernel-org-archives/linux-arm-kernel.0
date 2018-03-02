From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:48 +0100
Subject: [PATCH 40/52] mtd: rawnand: tango: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-41-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/tango_nand.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index 69e5eb136edc..a45ad30bc095 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -517,6 +517,24 @@ static int tango_set_timings(struct mtd_info *mtd, int csline,
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
 static int chip_init(struct device *dev, struct device_node *np)
 {
 	u32 cs;
@@ -566,22 +584,8 @@ static int chip_init(struct device *dev, struct device_node *np)
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
+	chip->ecc.attach_chip = tango_attach_chip;
+	err = nand_scan(mtd, 1);
 	if (err)
 		return err;
 
-- 
2.14.1
