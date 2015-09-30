From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Sep 2015 23:45:26 +0200
Subject: [PATCH v2 4/7] mtd: nand: sunxi: factorize extra OOB bytes handling
In-Reply-To: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1443649529-9852-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add helper functions to factorize the code dealing extra OOB bytes in the
normal and syndrome ECC implementations.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 90 +++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 176d0f0..45b74fc 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -621,6 +621,26 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	return 0;
 }
 
+static void sunxi_nfc_hw_ecc_read_extra_oob(struct mtd_info *mtd,
+					    u8 *oob, int *cur_off)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	int offset = ((ecc->bytes + 4) * ecc->steps);
+	int len = mtd->oobsize - offset;
+
+	if (len <= 0)
+		return;
+
+	if (*cur_off != offset)
+		nand->cmdfunc(mtd, NAND_CMD_RNDOUT,
+			      offset + mtd->writesize, -1);
+
+	sunxi_nfc_read_buf(mtd, oob + offset, len);
+
+	*cur_off = mtd->oobsize + mtd->writesize;
+}
+
 static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 					const u8 *data, int data_off,
 					const u8 *oob, int oob_off,
@@ -659,6 +679,26 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	return 0;
 }
 
+static void sunxi_nfc_hw_ecc_write_extra_oob(struct mtd_info *mtd,
+					     u8 *oob, int *cur_off)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	int offset = ((ecc->bytes + 4) * ecc->steps);
+	int len = mtd->oobsize - offset;
+
+	if (len <= 0)
+		return;
+
+	if (*cur_off != offset)
+		nand->cmdfunc(mtd, NAND_CMD_RNDIN,
+			      offset + mtd->writesize, -1);
+
+	sunxi_nfc_write_buf(mtd, oob + offset, len);
+
+	*cur_off = mtd->oobsize + mtd->writesize;
+}
+
 static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 				      struct nand_chip *chip, uint8_t *buf,
 				      int oob_required, int page)
@@ -666,8 +706,6 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	int ret, i, cur_off = 0;
-	int offset;
-	int cnt;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
@@ -684,16 +722,8 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 			return ret;
 	}
 
-	if (oob_required) {
-		cnt = ecc->layout->oobfree[ecc->steps].length;
-		if (cnt > 0) {
-			offset = mtd->writesize +
-				 ecc->layout->oobfree[ecc->steps].offset;
-			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
-			offset -= mtd->writesize;
-			chip->read_buf(mtd, chip->oob_poi + offset, cnt);
-		}
-	}
+	if (oob_required)
+		sunxi_nfc_hw_ecc_read_extra_oob(mtd, chip->oob_poi, &cur_off);
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
@@ -706,8 +736,6 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 {
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
-	int offset;
-	int cnt;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
@@ -724,16 +752,8 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 			return ret;
 	}
 
-	if (oob_required) {
-		cnt = ecc->layout->oobfree[i].length;
-		if (cnt > 0) {
-			offset = mtd->writesize +
-				 ecc->layout->oobfree[i].offset;
-			chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset, -1);
-			offset -= mtd->writesize;
-			chip->write_buf(mtd, chip->oob_poi + offset, cnt);
-		}
-	}
+	if (oob_required)
+		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi, &cur_off);
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
@@ -748,7 +768,6 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	int ret, i, cur_off = 0;
-	int cnt;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
@@ -765,14 +784,8 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 			return ret;
 	}
 
-	if (oob_required) {
-		cnt = mtd->writesize + mtd->oobsize - cur_off;
-		if (cnt > 0) {
-			u8 *oob = chip->oob_poi + mtd->oobsize - cnt;
-
-			chip->read_buf(mtd, oob, cnt);
-		}
-	}
+	if (oob_required)
+		sunxi_nfc_hw_ecc_read_extra_oob(mtd, chip->oob_poi, &cur_off);
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
@@ -786,7 +799,6 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 {
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
-	int cnt;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
@@ -802,14 +814,8 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 			return ret;
 	}
 
-	if (oob_required) {
-		cnt = mtd->writesize + mtd->oobsize - cur_off;
-		if (cnt > 0) {
-			u8 *oob = chip->oob_poi + mtd->oobsize - cnt;
-
-			chip->write_buf(mtd, oob, cnt);
-		}
-	}
+	if (oob_required)
+		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi, &cur_off);
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
-- 
2.1.4
