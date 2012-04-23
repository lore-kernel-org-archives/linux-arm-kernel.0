From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Apr 2012 11:23:36 +0200
Subject: [PATCH 04/10] mtd: mxc_nand: split some functions to get rid of more
 nfc_is_vX()
In-Reply-To: <20120423092240.GA18013@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
Message-ID: <1335173022-22371-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |  109 +++++++++++++++++++++++++++++++------------
 1 file changed, 80 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 1672e4b..c9cdec2 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -151,6 +151,7 @@ struct mxc_nand_devtype_data {
 	uint16_t (*get_dev_status)(struct mxc_nand_host *);
 	int (*check_int)(struct mxc_nand_host *);
 	void (*irq_control)(struct mxc_nand_host *, int);
+	u32 (*get_ecc_status)(struct mxc_nand_host *);
 };
 
 struct mxc_nand_host {
@@ -325,6 +326,21 @@ static void irq_control(struct mxc_nand_host *host, int activate)
 	}
 }
 
+static u32 get_ecc_status_v1(struct mxc_nand_host *host)
+{
+	return readw(NFC_V1_V2_ECC_STATUS_RESULT);
+}
+
+static u32 get_ecc_status_v2(struct mxc_nand_host *host)
+{
+	return readl(NFC_V1_V2_ECC_STATUS_RESULT);
+}
+
+static u32 get_ecc_status_v3(struct mxc_nand_host *host)
+{
+	return readl(NFC_V3_ECC_STATUS_RESULT);
+}
+
 static irqreturn_t mxc_nfc_irq(int irq, void *dev_id)
 {
 	struct mxc_nand_host *host = dev_id;
@@ -445,13 +461,27 @@ static void send_page_v3(struct mtd_info *mtd, unsigned int ops)
 	wait_op_done(host, false);
 }
 
-static void send_page_v1_v2(struct mtd_info *mtd, unsigned int ops)
+static void send_page_v2(struct mtd_info *mtd, unsigned int ops)
+{
+	struct nand_chip *nand_chip = mtd->priv;
+	struct mxc_nand_host *host = nand_chip->priv;
+
+	/* NANDFC buffer 0 is used for page read/write */
+	writew(host->active_cs << 4, NFC_V1_V2_BUF_ADDR);
+
+	writew(ops, NFC_V1_V2_CONFIG2);
+
+	/* Wait for operation to complete */
+	wait_op_done(host, true);
+}
+
+static void send_page_v1(struct mtd_info *mtd, unsigned int ops)
 {
 	struct nand_chip *nand_chip = mtd->priv;
 	struct mxc_nand_host *host = nand_chip->priv;
 	int bufs, i;
 
-	if (nfc_is_v1() && mtd->writesize > 512)
+	if (mtd->writesize > 512)
 		bufs = 4;
 	else
 		bufs = 1;
@@ -567,7 +597,7 @@ static int mxc_nand_correct_data_v1(struct mtd_info *mtd, u_char *dat,
 	 * additional correction.  2-Bit errors cannot be corrected by
 	 * HW ECC, so we need to return failure
 	 */
-	uint16_t ecc_status = readw(NFC_V1_V2_ECC_STATUS_RESULT);
+	uint16_t ecc_status = get_ecc_status_v1(host);
 
 	if (((ecc_status & 0x3) == 2) || ((ecc_status >> 2) == 2)) {
 		pr_debug("MXC_NAND: HWECC uncorrectable 2-bit ECC error\n");
@@ -592,10 +622,7 @@ static int mxc_nand_correct_data_v2_v3(struct mtd_info *mtd, u_char *dat,
 
 	no_subpages = mtd->writesize >> 9;
 
-	if (nfc_is_v21())
-		ecc_stat = readl(NFC_V1_V2_ECC_STATUS_RESULT);
-	else
-		ecc_stat = readl(NFC_V3_ECC_STATUS_RESULT);
+	ecc_stat = host->devtype_data->get_ecc_status(host);
 
 	do {
 		err = ecc_stat & ecc_bit_mask;
@@ -822,7 +849,7 @@ static int get_eccsize(struct mtd_info *mtd)
 		return 8;
 }
 
-static void preset_v1_v2(struct mtd_info *mtd)
+static void preset_v1(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd->priv;
 	struct mxc_nand_host *host = nand_chip->priv;
@@ -831,13 +858,40 @@ static void preset_v1_v2(struct mtd_info *mtd)
 	if (nand_chip->ecc.mode == NAND_ECC_HW)
 		config1 |= NFC_V1_V2_CONFIG1_ECC_EN;
 
-	if (nfc_is_v21())
-		config1 |= NFC_V2_CONFIG1_FP_INT;
+	if (!host->irqpending_quirk)
+		config1 |= NFC_V1_V2_CONFIG1_INT_MSK;
+
+	host->eccsize = 1;
+
+	writew(config1, NFC_V1_V2_CONFIG1);
+	/* preset operation */
+
+	/* Unlock the internal RAM Buffer */
+	writew(0x2, NFC_V1_V2_CONFIG);
+
+	/* Blocks to be unlocked */
+	writew(0x0, NFC_V1_UNLOCKSTART_BLKADDR);
+	writew(0xffff, NFC_V1_UNLOCKEND_BLKADDR);
+
+	/* Unlock Block Command for given address range */
+	writew(0x4, NFC_V1_V2_WRPROT);
+}
+
+static void preset_v2(struct mtd_info *mtd)
+{
+	struct nand_chip *nand_chip = mtd->priv;
+	struct mxc_nand_host *host = nand_chip->priv;
+	uint16_t config1 = 0;
+
+	if (nand_chip->ecc.mode == NAND_ECC_HW)
+		config1 |= NFC_V1_V2_CONFIG1_ECC_EN;
+
+	config1 |= NFC_V2_CONFIG1_FP_INT;
 
 	if (!host->irqpending_quirk)
 		config1 |= NFC_V1_V2_CONFIG1_INT_MSK;
 
-	if (nfc_is_v21() && mtd->writesize) {
+	if (mtd->writesize) {
 		uint16_t pages_per_block = mtd->erasesize / mtd->writesize;
 
 		host->eccsize = get_eccsize(mtd);
@@ -856,20 +910,14 @@ static void preset_v1_v2(struct mtd_info *mtd)
 	writew(0x2, NFC_V1_V2_CONFIG);
 
 	/* Blocks to be unlocked */
-	if (nfc_is_v21()) {
-		writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR0);
-		writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR1);
-		writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR2);
-		writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR3);
-		writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR0);
-		writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR1);
-		writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR2);
-		writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR3);
-	} else if (nfc_is_v1()) {
-		writew(0x0, NFC_V1_UNLOCKSTART_BLKADDR);
-		writew(0xffff, NFC_V1_UNLOCKEND_BLKADDR);
-	} else
-		BUG();
+	writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR0);
+	writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR1);
+	writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR2);
+	writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR3);
+	writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR0);
+	writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR1);
+	writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR2);
+	writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR3);
 
 	/* Unlock Block Command for given address range */
 	writew(0x4, NFC_V1_V2_WRPROT);
@@ -1057,26 +1105,28 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 
 /* v1: 21, 27, 31 */
 static const struct mxc_nand_devtype_data imx21_nand_devtype_data = {
-	.preset = preset_v1_v2,
+	.preset = preset_v1,
 	.send_cmd = send_cmd_v1_v2,
 	.send_addr = send_addr_v1_v2,
-	.send_page = send_page_v1_v2,
+	.send_page = send_page_v1,
 	.send_read_id = send_read_id_v1_v2,
 	.get_dev_status = get_dev_status_v1_v2,
 	.check_int = check_int_v1_v2,
 	.irq_control = irq_control_v1_v2,
+	.get_ecc_status = get_ecc_status_v1,
 };
 
 /* v21: 25, 35 */
 static const struct mxc_nand_devtype_data imx25_nand_devtype_data = {
-	.preset = preset_v1_v2,
+	.preset = preset_v2,
 	.send_cmd = send_cmd_v1_v2,
 	.send_addr = send_addr_v1_v2,
-	.send_page = send_page_v1_v2,
+	.send_page = send_page_v2,
 	.send_read_id = send_read_id_v1_v2,
 	.get_dev_status = get_dev_status_v1_v2,
 	.check_int = check_int_v1_v2,
 	.irq_control = irq_control_v1_v2,
+	.get_ecc_status = get_ecc_status_v2,
 };
 
 /* v3: 51, 53 */
@@ -1089,6 +1139,7 @@ static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
 	.get_dev_status = get_dev_status_v3,
 	.check_int = check_int_v3,
 	.irq_control = irq_control_v3,
+	.get_ecc_status = get_ecc_status_v3,
 };
 
 static int __init mxcnd_probe(struct platform_device *pdev)
-- 
1.7.10
