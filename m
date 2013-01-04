From: avinashphilip@ti.com (Philip Avinash)
Date: Fri, 4 Jan 2013 13:26:49 +0530
Subject: [PATCH v4 1/3] mtd: nand: omap2: Update nerrors using ecc.strength
In-Reply-To: <1357286211-5012-1-git-send-email-avinashphilip@ti.com>
References: <1357286211-5012-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1357286211-5012-2-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove check of ecc bytes with 13, number of errors can directly update
from nand ecc strength. This will increase re-usability of the code.
Also add macro definitions BCH8_ERROR_MAX & BCH4_ERROR_MAX for better
readability and cleaner code.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
Changes since v3:
	- Update commit message.

 drivers/mtd/nand/omap2.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 1d333497c..7d907b7 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -117,6 +117,9 @@
 
 #define OMAP24XX_DMA_GPMC		4
 
+#define BCH8_MAX_ERROR		8	/* upto 8 bit correctable */
+#define BCH4_MAX_ERROR		4	/* upto 4 bit correctable */
+
 /* oob info generated runtime depending on ecc algorithm and layout selected */
 static struct nand_ecclayout omap_oobinfo;
 /* Define some generic bad / good block scan pattern which are used
@@ -1041,7 +1044,7 @@ static void omap3_enable_hwecc_bch(struct mtd_info *mtd, int mode)
 	struct nand_chip *chip = mtd->priv;
 	u32 val;
 
-	nerrors = (info->nand.ecc.bytes == 13) ? 8 : 4;
+	nerrors = info->nand.ecc.strength;
 	dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
 	nsectors = 1;
 	/*
@@ -1218,13 +1221,14 @@ static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 						   mtd);
 #ifdef CONFIG_MTD_NAND_OMAP_BCH8
-	const int hw_errors = 8;
+	const int hw_errors = BCH8_MAX_ERROR;
 #else
-	const int hw_errors = 4;
+	const int hw_errors = BCH4_MAX_ERROR;
 #endif
 	info->bch = NULL;
 
-	max_errors = (ecc_opt == OMAP_ECC_BCH8_CODE_HW) ? 8 : 4;
+	max_errors = (ecc_opt == OMAP_ECC_BCH8_CODE_HW) ?
+		BCH8_MAX_ERROR : BCH4_MAX_ERROR;
 	if (max_errors != hw_errors) {
 		pr_err("cannot configure %d-bit BCH ecc, only %d-bit supported",
 		       max_errors, hw_errors);
-- 
1.7.9.5
