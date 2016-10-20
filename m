From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 10:12:42 +0200
Subject: [PATCH 1/8] mtd: nand: sunxi: fix support for 512bytes ECC chunks
In-Reply-To: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
References: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
Message-ID: <f1cb6efb6817c11b235f073639a137bec6ac17e5.1476951078.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

The driver is incorrectly assuming that the ECC block size is always 1k
which is not always true.

Also take the other cases into account.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 4 ++++
 1 file changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 8b8470c4e6d0..e40482a65de6 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -145,6 +145,7 @@
 #define NFC_ECC_PIPELINE	BIT(3)
 #define NFC_ECC_EXCEPTION	BIT(4)
 #define NFC_ECC_BLOCK_SIZE_MSK	BIT(5)
+#define NFC_ECC_BLOCK_512	BIT(5)
 #define NFC_RANDOM_EN		BIT(9)
 #define NFC_RANDOM_DIRECTION	BIT(10)
 #define NFC_ECC_MODE_MSK	GENMASK(15, 12)
@@ -817,6 +818,9 @@ static void sunxi_nfc_hw_ecc_enable(struct mtd_info *mtd)
 	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION |
 		   NFC_ECC_PIPELINE;
 
+	if (nand->ecc.size == 512)
+		ecc_ctl |= NFC_ECC_BLOCK_512;
+
 	writel(ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
 }
 
-- 
git-series 0.8.10
