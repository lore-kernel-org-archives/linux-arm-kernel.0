From: john.ogness@linutronix.de (John Ogness)
Date: Fri, 18 Jun 2010 19:01:03 +0200
Subject: [PATCH 3/5] mtd: mxc_nand fixups
Message-ID: <808w6cb7hs.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes how failures with the hardware ECC error correction
for the NFCv21 are detected.

The patch is against linux-next 20100618.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   39 +++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

Index: linux-next-20100618/drivers/mtd/nand/mxc_nand.c
===================================================================
--- linux-next-20100618.orig/drivers/mtd/nand/mxc_nand.c
+++ linux-next-20100618/drivers/mtd/nand/mxc_nand.c
@@ -359,18 +359,37 @@ static int mxc_nand_correct_data(struct 
 	struct nand_chip *nand_chip = mtd->priv;
 	struct mxc_nand_host *host = nand_chip->priv;
 
-	/*
-	 * 1-Bit errors are automatically corrected in HW.  No need for
-	 * additional correction.  2-Bit errors cannot be corrected by
-	 * HW ECC, so we need to return failure
-	 */
 	uint16_t ecc_status = readw(host->regs + NFC_ECC_STATUS_RESULT);
 
-	if (((ecc_status & 0x3) == 2) || ((ecc_status >> 2) == 2)) {
-		DEBUG(MTD_DEBUG_LEVEL0,
-		      "MXC_NAND: HWECC uncorrectable 2-bit ECC error\n");
-		return -1;
-	}
+	if (nfc_is_v21()) {
+		/*
+		 * Up to 8 9-bit symbol errors can be corrected by the HW.
+		 * A status value of 0xf means that an uncorrectable error
+		 * occurred, so we need to return failure.
+		 */
+		if ((ecc_status & 0xf) == 0xf ||
+		    ((ecc_status >> 4) & 0xf) == 0xf ||
+		    ((ecc_status >> 8) & 0xf) == 0xf ||
+		    ((ecc_status >> 12) & 0xf) == 0xf) {
+			DEBUG(MTD_DEBUG_LEVEL0,
+			      "MXC_NAND: "
+			      "HWECC uncorrectable ECC error\n");
+			return -1;
+		}
+	} else if (nfc_is_v1()) {
+		/*
+		 * 1-Bit errors are automatically corrected in HW. No need for
+		 * additional correction. 2-Bit errors cannot be corrected by
+		 * HW ECC, so we need to return failure.
+		 */
+		if (((ecc_status & 0x3) == 2) || ((ecc_status >> 2) == 2)) {
+			DEBUG(MTD_DEBUG_LEVEL0,
+			      "MXC_NAND: "
+			      "HWECC uncorrectable 2-bit ECC error\n");
+			return -1;
+		}
+	} else
+		BUG();
 
 	return 0;
 }
