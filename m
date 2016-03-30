From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 17:39:49 +0200
Subject: [PATCH v2 2/7] mtd: nand: sunxi: make OOB retrieval optional
In-Reply-To: <1459352394-22810-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459352394-22810-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459352394-22810-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi_nfc_hw_ecc_read_chunk() always retrieves the ECC and protected free
bytes, no matter if the user really asked for it or not. This can take a
non negligible amount of time, especially on NAND chips exposing large OOB
areas (> 1KB). Make it optional.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index f6ea0fb..3e7b919 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -867,7 +867,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 				       u8 *oob, int oob_off,
 				       int *cur_off,
 				       unsigned int *max_bitflips,
-				       bool bbm, int page)
+				       bool bbm, bool oob_required, int page)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
@@ -899,7 +899,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 
 	*cur_off = oob_off + ecc->bytes + 4;
 
-	ret = sunxi_nfc_hw_ecc_correct(mtd, data, oob, 0,
+	ret = sunxi_nfc_hw_ecc_correct(mtd, data, oob_required ? oob : NULL, 0,
 				       readl(nfc->regs + NFC_REG_ECC_ST),
 				       &erased);
 	if (erased)
@@ -929,12 +929,14 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	} else {
 		memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
-		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
-		sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + 4,
-					      true, page);
+		if (oob_required) {
+			nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
+			sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + 4,
+						      true, page);
 
-		sunxi_nfc_hw_ecc_get_prot_oob_bytes(mtd, oob, 0,
-						    bbm, page);
+			sunxi_nfc_hw_ecc_get_prot_oob_bytes(mtd, oob, 0,
+							    bbm, page);
+		}
 	}
 
 	sunxi_nfc_hw_ecc_update_stats(mtd, max_bitflips, ret);
@@ -1048,7 +1050,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, oob,
 						  oob_off + mtd->writesize,
 						  &cur_off, &max_bitflips,
-						  !i, page);
+						  !i, oob_required, page);
 		if (ret < 0)
 			return ret;
 		else if (ret)
@@ -1086,8 +1088,8 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct mtd_info *mtd,
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off,
 						  oob,
 						  oob_off + mtd->writesize,
-						  &cur_off, &max_bitflips,
-						  !i, page);
+						  &cur_off, &max_bitflips, !i,
+						  false, page);
 		if (ret < 0)
 			return ret;
 	}
@@ -1149,7 +1151,9 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, oob,
 						  oob_off, &cur_off,
-						  &max_bitflips, !i, page);
+						  &max_bitflips, !i,
+						  oob_required,
+						  page);
 		if (ret < 0)
 			return ret;
 		else if (ret)
-- 
2.5.0
