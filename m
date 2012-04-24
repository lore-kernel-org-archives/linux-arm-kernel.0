From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 24 Apr 2012 10:12:17 +0200
Subject: [PATCH] mtd: mxc_nand: fix several sparse warnings about incorrect
 address space
In-Reply-To: <20120424081052.GG20039@pengutronix.de>
References: <20120424081052.GG20039@pengutronix.de>
Message-ID: <1335255137-13714-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 1041bb1..ec5ba8b 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -181,8 +181,8 @@ struct mxc_nand_host {
 	struct nand_chip	nand;
 	struct device		*dev;
 
-	void			*spare0;
-	void			*main_area0;
+	void __iomem		*spare0;
+	void __iomem		*main_area0;
 
 	void __iomem		*base;
 	void __iomem		*regs;
@@ -519,7 +519,7 @@ static void send_read_id_v3(struct mxc_nand_host *host)
 
 	wait_op_done(host, true);
 
-	memcpy(host->data_buf, host->main_area0, 16);
+	memcpy_fromio(host->data_buf, host->main_area0, 16);
 }
 
 /* Request the NANDFC to perform a read of the NAND device ID. */
@@ -535,7 +535,7 @@ static void send_read_id_v1_v2(struct mxc_nand_host *host)
 	/* Wait for operation to complete */
 	wait_op_done(host, true);
 
-	memcpy(host->data_buf, host->main_area0, 16);
+	memcpy_fromio(host->data_buf, host->main_area0, 16);
 
 	if (this->options & NAND_BUSWIDTH_16) {
 		/* compress the ID info */
@@ -790,23 +790,23 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
 	u16 i, j;
 	u16 n = mtd->writesize >> 9;
 	u8 *d = host->data_buf + mtd->writesize;
-	u8 *s = host->spare0;
+	u8 __iomem *s = host->spare0;
 	u16 t = host->devtype_data->spare_len;
 
 	j = (mtd->oobsize / n >> 1) << 1;
 
 	if (bfrom) {
 		for (i = 0; i < n - 1; i++)
-			memcpy(d + i * j, s + i * t, j);
+			memcpy_fromio(d + i * j, s + i * t, j);
 
 		/* the last section */
-		memcpy(d + i * j, s + i * t, mtd->oobsize - i * j);
+		memcpy_fromio(d + i * j, s + i * t, mtd->oobsize - i * j);
 	} else {
 		for (i = 0; i < n - 1; i++)
-			memcpy(&s[i * t], &d[i * j], j);
+			memcpy_toio(&s[i * t], &d[i * j], j);
 
 		/* the last section */
-		memcpy(&s[i * t], &d[i * j], mtd->oobsize - i * j);
+		memcpy_toio(&s[i * t], &d[i * j], mtd->oobsize - i * j);
 	}
 }
 
@@ -1070,7 +1070,7 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 
 		host->devtype_data->send_page(mtd, NFC_OUTPUT);
 
-		memcpy(host->data_buf, host->main_area0, mtd->writesize);
+		memcpy_fromio(host->data_buf, host->main_area0, mtd->writesize);
 		copy_spare(mtd, true);
 		break;
 
@@ -1086,7 +1086,7 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 		break;
 
 	case NAND_CMD_PAGEPROG:
-		memcpy(host->main_area0, host->data_buf, mtd->writesize);
+		memcpy_toio(host->main_area0, host->data_buf, mtd->writesize);
 		copy_spare(mtd, false);
 		host->devtype_data->send_page(mtd, NFC_INPUT);
 		host->devtype_data->send_cmd(host, command, true);
-- 
1.7.10
