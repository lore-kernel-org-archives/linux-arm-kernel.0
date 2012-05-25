From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 25 May 2012 16:22:42 +0200
Subject: [PATCH 2/2] mtd mxc_nand: move ecc strengh setup before nand_scan_tail
In-Reply-To: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
References: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1337955762-19157-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since this commit:

  commit 6a918bade9dab40aaef80559bd1169c69e8d69cb
  Author: Mike Dunn <mikedunn@newsguy.com>
  Date:   Sun Mar 11 14:21:11 2012 -0700

     mtd: flash drivers set ecc strength

The mxc_nand driver fails with:

Driver must set ecc.strength when using hardware ECC

This is because nand_scan_tail checks for correct ecc strength
settings, so we must set them up before nand_scan_tail.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: stable at vger.kernel.org
---
 drivers/mtd/nand/mxc_nand.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 4d27ddc..aaf042b 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1485,12 +1485,6 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	else if (mtd->writesize == 4096)
 		this->ecc.layout = host->devtype_data->ecclayout_4k;
 
-	/* second phase scan */
-	if (nand_scan_tail(mtd)) {
-		err = -ENXIO;
-		goto escan;
-	}
-
 	if (this->ecc.mode == NAND_ECC_HW) {
 		if (nfc_is_v1())
 			this->ecc.strength = 1;
@@ -1498,6 +1492,12 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 			this->ecc.strength = (host->eccsize == 4) ? 4 : 8;
 	}
 
+	/* second phase scan */
+	if (nand_scan_tail(mtd)) {
+		err = -ENXIO;
+		goto escan;
+	}
+
 	/* Register the partitions */
 	mtd_device_parse_register(mtd, part_probes,
 			&(struct mtd_part_parser_data){
-- 
1.7.10
