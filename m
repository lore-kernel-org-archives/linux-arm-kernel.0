From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Sep 2015 23:45:23 +0200
Subject: [PATCH v2 1/7] mtd: nand: sunxi: create
 sunxi_nfc_hw_ecc_enable()/disable() functions
In-Reply-To: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1443649529-9852-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code used to enable/disable the hardware ECC engine is repeated in a
lot of places. Create two functions to avoid code duplication.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 70 ++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index dc44435..471fc2b 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -543,6 +543,30 @@ static void sunxi_nfc_cmd_ctrl(struct mtd_info *mtd, int dat,
 	sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
 }
 
+static void sunxi_nfc_hw_ecc_enable(struct mtd_info *mtd)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct sunxi_nand_hw_ecc *data = nand->ecc.priv;
+	u32 ecc_ctl;
+
+	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
+	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE |
+		     NFC_ECC_BLOCK_SIZE_MSK);
+	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
+
+	writel(ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
+}
+
+static void sunxi_nfc_hw_ecc_disable(struct mtd_info *mtd)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+
+	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_ECC_EN,
+	       nfc->regs + NFC_REG_ECC_CTL);
+}
+
 static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 				      struct nand_chip *chip, uint8_t *buf,
 				      int oob_required, int page)
@@ -550,7 +574,6 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct nand_ecclayout *layout = ecc->layout;
-	struct sunxi_nand_hw_ecc *data = ecc->priv;
 	unsigned int max_bitflips = 0;
 	int offset;
 	int ret;
@@ -558,11 +581,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 	int i;
 	int cnt;
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
-	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
-
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
 		if (i)
@@ -620,10 +639,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 		}
 	}
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~NFC_ECC_EN;
-
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_disable(mtd);
 
 	return max_bitflips;
 }
@@ -635,18 +651,13 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct nand_ecclayout *layout = ecc->layout;
-	struct sunxi_nand_hw_ecc *data = ecc->priv;
 	int offset;
 	int ret;
 	u32 tmp;
 	int i;
 	int cnt;
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
-	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
-
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
 		if (i)
@@ -686,10 +697,7 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 		}
 	}
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~NFC_ECC_EN;
-
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_disable(mtd);
 
 	return 0;
 }
@@ -701,7 +709,6 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct sunxi_nand_hw_ecc *data = ecc->priv;
 	unsigned int max_bitflips = 0;
 	uint8_t *oob = chip->oob_poi;
 	int offset = 0;
@@ -710,11 +717,7 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 	u32 tmp;
 	int i;
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
-	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
-
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
 		chip->read_buf(mtd, NULL, ecc->size);
@@ -755,8 +758,7 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 		}
 	}
 
-	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_ECC_EN,
-	       nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_disable(mtd);
 
 	return max_bitflips;
 }
@@ -768,7 +770,6 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct sunxi_nand_hw_ecc *data = ecc->priv;
 	uint8_t *oob = chip->oob_poi;
 	int offset = 0;
 	int ret;
@@ -776,11 +777,7 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 	u32 tmp;
 	int i;
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
-	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
-
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
 		chip->write_buf(mtd, buf + (i * ecc->size), ecc->size);
@@ -810,10 +807,7 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 		}
 	}
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~NFC_ECC_EN;
-
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_disable(mtd);
 
 	return 0;
 }
-- 
2.1.4
