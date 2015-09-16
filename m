From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 16 Sep 2015 09:46:36 +0200
Subject: [PATCH 1/2] mtd: nand: sunxi: rework macros
In-Reply-To: <1442389597-30698-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1442389597-30698-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1442389597-30698-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suffix mask macros with _MSK and add new helper macros to avoid manually
shifting values.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 123 ++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 59 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index ef1fe61..dc44435 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -57,11 +57,8 @@
 #define NFC_REG_ECC_CTL		0x0034
 #define NFC_REG_ECC_ST		0x0038
 #define NFC_REG_DEBUG		0x003C
-#define NFC_REG_ECC_CNT0	0x0040
-#define NFC_REG_ECC_CNT1	0x0044
-#define NFC_REG_ECC_CNT2	0x0048
-#define NFC_REG_ECC_CNT3	0x004c
-#define NFC_REG_USER_DATA_BASE	0x0050
+#define NFC_REG_ECC_ERR_CNT(x)	((0x0040 + (x)) & ~0x3)
+#define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
 #define NFC_REG_SPARE_AREA	0x00A0
 #define NFC_RAM0_BASE		0x0400
 #define NFC_RAM1_BASE		0x0800
@@ -69,12 +66,16 @@
 /* define bit use in NFC_CTL */
 #define NFC_EN			BIT(0)
 #define NFC_RESET		BIT(1)
-#define NFC_BUS_WIDYH		BIT(2)
-#define NFC_RB_SEL		BIT(3)
-#define NFC_CE_SEL		GENMASK(26, 24)
+#define NFC_BUS_WIDTH_MSK	BIT(2)
+#define NFC_BUS_WIDTH_8		(0 << 2)
+#define NFC_BUS_WIDTH_16	(1 << 2)
+#define NFC_RB_SEL_MSK		BIT(3)
+#define NFC_RB_SEL(x)		((x) << 3)
+#define NFC_CE_SEL_MSK		GENMASK(26, 24)
+#define NFC_CE_SEL(x)		((x) << 24)
 #define NFC_CE_CTL		BIT(6)
-#define NFC_CE_CTL1		BIT(7)
-#define NFC_PAGE_SIZE		GENMASK(11, 8)
+#define NFC_PAGE_SHIFT_MSK	GENMASK(11, 8)
+#define NFC_PAGE_SHIFT(x)	(((x) < 10 ? 0 : (x) - 10) << 8)
 #define NFC_SAM			BIT(12)
 #define NFC_RAM_METHOD		BIT(14)
 #define NFC_DEBUG_CTL		BIT(31)
@@ -86,10 +87,7 @@
 #define NFC_CMD_FIFO_STATUS	BIT(3)
 #define NFC_STA			BIT(4)
 #define NFC_NATCH_INT_FLAG	BIT(5)
-#define NFC_RB_STATE0		BIT(8)
-#define NFC_RB_STATE1		BIT(9)
-#define NFC_RB_STATE2		BIT(10)
-#define NFC_RB_STATE3		BIT(11)
+#define NFC_RB_STATE(x)		BIT(x + 8)
 
 /* define bit use in NFC_INT */
 #define NFC_B2R_INT_ENABLE	BIT(0)
@@ -109,9 +107,11 @@
 	(((tCAD) & 0x7) << 8))
 
 /* define bit use in NFC_CMD */
-#define NFC_CMD_LOW_BYTE	GENMASK(7, 0)
-#define NFC_CMD_HIGH_BYTE	GENMASK(15, 8)
-#define NFC_ADR_NUM		GENMASK(18, 16)
+#define NFC_CMD_LOW_BYTE_MSK	GENMASK(7, 0)
+#define NFC_CMD_HIGH_BYTE_MSK	GENMASK(15, 8)
+#define NFC_CMD(x)		(x)
+#define NFC_ADR_NUM_MSK		GENMASK(18, 16)
+#define NFC_ADR_NUM(x)		(((x) - 1) << 16)
 #define NFC_SEND_ADR		BIT(19)
 #define NFC_ACCESS_DIR		BIT(20)
 #define NFC_DATA_TRANS		BIT(21)
@@ -123,29 +123,38 @@
 #define NFC_ROW_AUTO_INC	BIT(27)
 #define NFC_SEND_CMD3		BIT(28)
 #define NFC_SEND_CMD4		BIT(29)
-#define NFC_CMD_TYPE		GENMASK(31, 30)
+#define NFC_CMD_TYPE_MSK	GENMASK(31, 30)
+#define NFC_NORMAL_OP		(0 << 30)
+#define NFC_ECC_OP		(1 << 30)
+#define NFC_PAGE_OP		(2 << 30)
 
 /* define bit use in NFC_RCMD_SET */
-#define NFC_READ_CMD		GENMASK(7, 0)
-#define NFC_RANDOM_READ_CMD0	GENMASK(15, 8)
-#define NFC_RANDOM_READ_CMD1	GENMASK(23, 16)
+#define NFC_READ_CMD_MSK	GENMASK(7, 0)
+#define NFC_RND_READ_CMD0_MSK	GENMASK(15, 8)
+#define NFC_RND_READ_CMD1_MSK	GENMASK(23, 16)
 
 /* define bit use in NFC_WCMD_SET */
-#define NFC_PROGRAM_CMD		GENMASK(7, 0)
-#define NFC_RANDOM_WRITE_CMD	GENMASK(15, 8)
-#define NFC_READ_CMD0		GENMASK(23, 16)
-#define NFC_READ_CMD1		GENMASK(31, 24)
+#define NFC_PROGRAM_CMD_MSK	GENMASK(7, 0)
+#define NFC_RND_WRITE_CMD_MSK	GENMASK(15, 8)
+#define NFC_READ_CMD0_MSK	GENMASK(23, 16)
+#define NFC_READ_CMD1_MSK	GENMASK(31, 24)
 
 /* define bit use in NFC_ECC_CTL */
 #define NFC_ECC_EN		BIT(0)
 #define NFC_ECC_PIPELINE	BIT(3)
 #define NFC_ECC_EXCEPTION	BIT(4)
-#define NFC_ECC_BLOCK_SIZE	BIT(5)
+#define NFC_ECC_BLOCK_SIZE_MSK	BIT(5)
 #define NFC_RANDOM_EN		BIT(9)
 #define NFC_RANDOM_DIRECTION	BIT(10)
-#define NFC_ECC_MODE_SHIFT	12
-#define NFC_ECC_MODE		GENMASK(15, 12)
-#define NFC_RANDOM_SEED		GENMASK(30, 16)
+#define NFC_ECC_MODE_MSK	GENMASK(15, 12)
+#define NFC_ECC_MODE(x)		((x) << 12)
+#define NFC_RANDOM_SEED_MSK	GENMASK(30, 16)
+#define NFC_RANDOM_SEED(x)	((x) << 16)
+
+/* define bit use in NFC_ECC_ST */
+#define NFC_ECC_ERR(x)		BIT(x)
+#define NFC_ECC_PAT_FOUND(x)	BIT(x + 16)
+#define NFC_ECC_ERR_CNT(b, x)	(((x) >> ((b) * 8)) & 0xff)
 
 /* NFC_USER_DATA helper macros */
 #define NFC_BUF_TO_USER_DATA(buf)	((buf)[0] | ((buf)[1] << 8) | \
@@ -360,13 +369,13 @@ static int sunxi_nfc_dev_ready(struct mtd_info *mtd)
 	switch (rb->type) {
 	case RB_NATIVE:
 		ret = !!(readl(nfc->regs + NFC_REG_ST) &
-			 (NFC_RB_STATE0 << rb->info.nativeid));
+			 NFC_RB_STATE(rb->info.nativeid));
 		if (ret)
 			break;
 
 		sunxi_nfc_wait_int(nfc, NFC_RB_B2R, timeo);
 		ret = !!(readl(nfc->regs + NFC_REG_ST) &
-			 (NFC_RB_STATE0 << rb->info.nativeid));
+			 NFC_RB_STATE(rb->info.nativeid));
 		break;
 	case RB_GPIO:
 		ret = gpio_get_value(rb->info.gpio);
@@ -396,19 +405,19 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
 		return;
 
 	ctl = readl(nfc->regs + NFC_REG_CTL) &
-	      ~(NFC_CE_SEL | NFC_RB_SEL | NFC_EN);
+	      ~(NFC_PAGE_SHIFT_MSK | NFC_CE_SEL_MSK | NFC_RB_SEL_MSK | NFC_EN);
 
 	if (chip >= 0) {
 		sel = &sunxi_nand->sels[chip];
 
-		ctl |= (sel->cs << 24) | NFC_EN |
-		       (((nand->page_shift - 10) & 0xf) << 8);
+		ctl |= NFC_CE_SEL(sel->cs) | NFC_EN |
+		       NFC_PAGE_SHIFT(nand->page_shift - 10);
 		if (sel->rb.type == RB_NONE) {
 			nand->dev_ready = NULL;
 		} else {
 			nand->dev_ready = sunxi_nfc_dev_ready;
 			if (sel->rb.type == RB_NATIVE)
-				ctl |= (sel->rb.info.nativeid << 3);
+				ctl |= NFC_RB_SEL(sel->rb.info.nativeid);
 		}
 
 		writel(mtd->writesize, nfc->regs + NFC_REG_SPARE_AREA);
@@ -550,9 +559,8 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 	int cnt;
 
 	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE);
-	tmp |= NFC_ECC_EN | (data->mode << NFC_ECC_MODE_SHIFT) |
-	       NFC_ECC_EXCEPTION;
+	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
+	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
 
 	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
 
@@ -570,7 +578,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 		if (ret)
 			return ret;
 
-		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | (1 << 30);
+		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP;
 		writel(tmp, nfc->regs + NFC_REG_CMD);
 
 		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
@@ -580,11 +588,11 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 		memcpy_fromio(buf + (i * ecc->size),
 			      nfc->regs + NFC_RAM0_BASE, ecc->size);
 
-		if (readl(nfc->regs + NFC_REG_ECC_ST) & 0x1) {
+		if (readl(nfc->regs + NFC_REG_ECC_ST) & NFC_ECC_ERR(0)) {
 			mtd->ecc_stats.failed++;
 		} else {
-			tmp = readl(nfc->regs + NFC_REG_ECC_CNT0) & 0xff;
-			mtd->ecc_stats.corrected += tmp;
+			tmp = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(0));
+			mtd->ecc_stats.corrected += NFC_ECC_ERR_CNT(0, tmp);
 			max_bitflips = max_t(unsigned int, max_bitflips, tmp);
 		}
 
@@ -635,9 +643,8 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 	int cnt;
 
 	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE);
-	tmp |= NFC_ECC_EN | (data->mode << NFC_ECC_MODE_SHIFT) |
-	       NFC_ECC_EXCEPTION;
+	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
+	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
 
 	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
 
@@ -652,7 +659,7 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 		/* Fill OOB data in */
 		writel(NFC_BUF_TO_USER_DATA(chip->oob_poi +
 					    layout->oobfree[i].offset),
-		       nfc->regs + NFC_REG_USER_DATA_BASE);
+		       nfc->regs + NFC_REG_USER_DATA(0));
 
 		chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset, -1);
 
@@ -661,7 +668,7 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 			return ret;
 
 		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ACCESS_DIR |
-		      (1 << 30);
+		      NFC_ECC_OP;
 		writel(tmp, nfc->regs + NFC_REG_CMD);
 		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
 		if (ret)
@@ -704,16 +711,15 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 	int i;
 
 	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE);
-	tmp |= NFC_ECC_EN | (data->mode << NFC_ECC_MODE_SHIFT) |
-	       NFC_ECC_EXCEPTION;
+	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
+	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
 
 	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
 
 	for (i = 0; i < ecc->steps; i++) {
 		chip->read_buf(mtd, NULL, ecc->size);
 
-		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | (1 << 30);
+		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP;
 		writel(tmp, nfc->regs + NFC_REG_CMD);
 
 		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
@@ -724,11 +730,11 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 		buf += ecc->size;
 		offset += ecc->size;
 
-		if (readl(nfc->regs + NFC_REG_ECC_ST) & 0x1) {
+		if (readl(nfc->regs + NFC_REG_ECC_ST) & NFC_ECC_ERR(0)) {
 			mtd->ecc_stats.failed++;
 		} else {
-			tmp = readl(nfc->regs + NFC_REG_ECC_CNT0) & 0xff;
-			mtd->ecc_stats.corrected += tmp;
+			tmp = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(0));
+			mtd->ecc_stats.corrected += NFC_ECC_ERR_CNT(0, tmp);
 			max_bitflips = max_t(unsigned int, max_bitflips, tmp);
 		}
 
@@ -771,9 +777,8 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 	int i;
 
 	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE);
-	tmp |= NFC_ECC_EN | (data->mode << NFC_ECC_MODE_SHIFT) |
-	       NFC_ECC_EXCEPTION;
+	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
+	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
 
 	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
 
@@ -783,10 +788,10 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 
 		/* Fill OOB data in */
 		writel(NFC_BUF_TO_USER_DATA(oob),
-		       nfc->regs + NFC_REG_USER_DATA_BASE);
+		       nfc->regs + NFC_REG_USER_DATA(0));
 
 		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ACCESS_DIR |
-		      (1 << 30);
+		      NFC_ECC_OP;
 		writel(tmp, nfc->regs + NFC_REG_CMD);
 
 		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
-- 
1.9.1
