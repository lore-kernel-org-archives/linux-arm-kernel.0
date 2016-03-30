From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:14:24 +0200
Subject: [PATCH v5 09/50] mtd: nand: qcom: use mtd_ooblayout_xxx() helpers
 where appropriate
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mtd_ooblayout_xxx() helper functions have been added to avoid direct
accesses to ecclayout fields, and thus ease for future reworks.
Use these helpers in all places where the oobfree[] and eccpos[] arrays
where directly accessed.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Archit Taneja <architt@codeaurora.org>
---
 drivers/mtd/nand/qcom_nandc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
index f550a57..012c202 100644
--- a/drivers/mtd/nand/qcom_nandc.c
+++ b/drivers/mtd/nand/qcom_nandc.c
@@ -1437,7 +1437,6 @@ static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	u8 *oob = chip->oob_poi;
-	int free_boff;
 	int data_size, oob_size;
 	int ret, status = 0;
 
@@ -1451,12 +1450,11 @@ static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 
 	/* calculate the data and oob size for the last codeword/step */
 	data_size = ecc->size - ((ecc->steps - 1) << 2);
-	oob_size = ecc->steps << 2;
-
-	free_boff = ecc->layout->oobfree[0].offset;
+	oob_size = mtd->oobavail;
 
 	/* override new oob content to last codeword */
-	memcpy(nandc->data_buffer + data_size, oob + free_boff, oob_size);
+	mtd_ooblayout_get_databytes(mtd, nandc->data_buffer + data_size, oob,
+				    0, mtd->oobavail);
 
 	set_address(host, host->cw_size * (ecc->steps - 1), page);
 	update_rw_regs(host, 1, false);
-- 
2.5.0
