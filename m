From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 25 May 2012 16:22:41 +0200
Subject: [PATCH 1/2] mtd mxc_nand: use 32bit copy functions
Message-ID: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following commit changes the function used to copy from/to
the hardware buffer to memcpy_[from|to]io. This does not work
since the hardware cannot handle the byte accesses used by these
functions. Instead of reverting this patch introduce 32bit
correspondents of these functions.

commit 5775ba36ea9c760c2d7e697dac04f2f7fc95aa62
Author: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Date:   Tue Apr 24 10:05:22 2012 +0200

    mtd: mxc_nand: fix several sparse warnings about incorrect address space

    Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
    Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index fd14966..4d27ddc 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -273,6 +273,26 @@ static struct nand_ecclayout nandv2_hw_eccoob_4k = {
 
 static const char *part_probes[] = { "RedBoot", "cmdlinepart", "ofpart", NULL };
 
+static void memcpy32_fromio(void *trg, const volatile void __iomem  *src, size_t size)
+{
+	int i;
+	u32 *t = trg;
+	const volatile u32 *s = src;
+
+	for (i = 0; i < (size >> 2); i++)
+		*t++ = __raw_readl(s++);
+}
+
+static void memcpy32_toio(volatile void __iomem *trg, const void *src, int size)
+{
+	int i;
+	volatile u32 *t = trg;
+	const u32 *s = src;
+
+	for (i = 0; i < (size >> 2); i++)
+		__raw_writel(*s++, t++);
+}
+
 static int check_int_v3(struct mxc_nand_host *host)
 {
 	uint32_t tmp;
@@ -519,7 +539,7 @@ static void send_read_id_v3(struct mxc_nand_host *host)
 
 	wait_op_done(host, true);
 
-	memcpy_fromio(host->data_buf, host->main_area0, 16);
+	memcpy32_fromio(host->data_buf, host->main_area0, 16);
 }
 
 /* Request the NANDFC to perform a read of the NAND device ID. */
@@ -535,7 +555,7 @@ static void send_read_id_v1_v2(struct mxc_nand_host *host)
 	/* Wait for operation to complete */
 	wait_op_done(host, true);
 
-	memcpy_fromio(host->data_buf, host->main_area0, 16);
+	memcpy32_fromio(host->data_buf, host->main_area0, 16);
 
 	if (this->options & NAND_BUSWIDTH_16) {
 		/* compress the ID info */
@@ -797,16 +817,16 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
 
 	if (bfrom) {
 		for (i = 0; i < n - 1; i++)
-			memcpy_fromio(d + i * j, s + i * t, j);
+			memcpy32_fromio(d + i * j, s + i * t, j);
 
 		/* the last section */
-		memcpy_fromio(d + i * j, s + i * t, mtd->oobsize - i * j);
+		memcpy32_fromio(d + i * j, s + i * t, mtd->oobsize - i * j);
 	} else {
 		for (i = 0; i < n - 1; i++)
-			memcpy_toio(&s[i * t], &d[i * j], j);
+			memcpy32_toio(&s[i * t], &d[i * j], j);
 
 		/* the last section */
-		memcpy_toio(&s[i * t], &d[i * j], mtd->oobsize - i * j);
+		memcpy32_toio(&s[i * t], &d[i * j], mtd->oobsize - i * j);
 	}
 }
 
@@ -1070,7 +1090,7 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 
 		host->devtype_data->send_page(mtd, NFC_OUTPUT);
 
-		memcpy_fromio(host->data_buf, host->main_area0, mtd->writesize);
+		memcpy32_fromio(host->data_buf, host->main_area0, mtd->writesize);
 		copy_spare(mtd, true);
 		break;
 
@@ -1086,7 +1106,7 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 		break;
 
 	case NAND_CMD_PAGEPROG:
-		memcpy_toio(host->main_area0, host->data_buf, mtd->writesize);
+		memcpy32_toio(host->main_area0, host->data_buf, mtd->writesize);
 		copy_spare(mtd, false);
 		host->devtype_data->send_page(mtd, NFC_INPUT);
 		host->devtype_data->send_cmd(host, command, true);
-- 
1.7.10
