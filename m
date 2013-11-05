From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:31 -0300
Subject: [PATCH v3 24/28] mtd: nand: pxa3xx: Add ECC BCH correctable errors
 detection
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-25-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit extends the ECC correctable error detection to include
ECC BCH errors. The number of BCH correctable errors can be any up to 16,
and the actual value is exposed in the NDSR register.

Therefore, we change some symbol names to refer to correctable or
uncorrectable (instead of single-bit or double-bit as it was in the
Hamming case) and while at it, cleanup the detection code slightly.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 43 +++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 45c7b7c..7945544 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -97,6 +97,9 @@
 #define NDCR_INT_MASK           (0xFFF)
 
 #define NDSR_MASK		(0xfff)
+#define NDSR_ERR_CNT_OFF	(16)
+#define NDSR_ERR_CNT_MASK       (0x1f)
+#define NDSR_ERR_CNT(sr)	((sr >> NDSR_ERR_CNT_OFF) & NDSR_ERR_CNT_MASK)
 #define NDSR_RDY                (0x1 << 12)
 #define NDSR_FLASH_RDY          (0x1 << 11)
 #define NDSR_CS0_PAGED		(0x1 << 10)
@@ -105,8 +108,8 @@
 #define NDSR_CS1_CMDD		(0x1 << 7)
 #define NDSR_CS0_BBD		(0x1 << 6)
 #define NDSR_CS1_BBD		(0x1 << 5)
-#define NDSR_DBERR		(0x1 << 4)
-#define NDSR_SBERR		(0x1 << 3)
+#define NDSR_UNCORERR		(0x1 << 4)
+#define NDSR_CORERR		(0x1 << 3)
 #define NDSR_WRDREQ		(0x1 << 2)
 #define NDSR_RDDREQ		(0x1 << 1)
 #define NDSR_WRCMDREQ		(0x1)
@@ -147,9 +150,9 @@ enum {
 	ERR_NONE	= 0,
 	ERR_DMABUSERR	= -1,
 	ERR_SENDCMD	= -2,
-	ERR_DBERR	= -3,
+	ERR_UNCORERR	= -3,
 	ERR_BBERR	= -4,
-	ERR_SBERR	= -5,
+	ERR_CORERR	= -5,
 };
 
 enum {
@@ -240,6 +243,7 @@ struct pxa3xx_nand_info {
 	unsigned int		oob_size;
 	unsigned int		spare_size;
 	unsigned int		ecc_size;
+	unsigned int		ecc_err_cnt;
 	int 			retcode;
 
 	/* cached register value */
@@ -590,10 +594,16 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 
 	status = nand_readl(info, NDSR);
 
-	if (status & NDSR_DBERR)
-		info->retcode = ERR_DBERR;
-	if (status & NDSR_SBERR)
-		info->retcode = ERR_SBERR;
+	if (status & NDSR_UNCORERR)
+		info->retcode = ERR_UNCORERR;
+	if (status & NDSR_CORERR) {
+		info->retcode = ERR_CORERR;
+		if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370 &&
+		    info->ecc_bch)
+			info->ecc_err_cnt = NDSR_ERR_CNT(status);
+		else
+			info->ecc_err_cnt = 1;
+	}
 	if (status & (NDSR_RDDREQ | NDSR_WRDREQ)) {
 		/* whether use dma to transfer data */
 		if (info->use_dma) {
@@ -692,6 +702,7 @@ static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
 	info->use_ecc		= 0;
 	info->use_spare		= 1;
 	info->retcode		= ERR_NONE;
+	info->ecc_err_cnt	= 0;
 	info->ndcb3		= 0;
 
 	switch (command) {
@@ -1077,20 +1088,14 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 	chip->read_buf(mtd, buf, mtd->writesize);
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
-	if (info->retcode == ERR_SBERR) {
-		switch (info->use_ecc) {
-		case 1:
-			mtd->ecc_stats.corrected++;
-			break;
-		case 0:
-		default:
-			break;
-		}
-	} else if (info->retcode == ERR_DBERR) {
+	if (info->retcode == ERR_CORERR && info->use_ecc) {
+		mtd->ecc_stats.corrected += info->ecc_err_cnt;
+
+	} else if (info->retcode == ERR_UNCORERR) {
 		/*
 		 * for blank page (all 0xff), HW will calculate its ECC as
 		 * 0, which is different from the ECC information within
-		 * OOB, ignore such double bit errors
+		 * OOB, ignore such ucorrectable errors
 		 */
 		if (is_buf_blank(buf, mtd->writesize))
 			info->retcode = ERR_NONE;
-- 
1.8.1.5
