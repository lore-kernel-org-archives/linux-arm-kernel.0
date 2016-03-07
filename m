From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:21:32 +0100
Subject: [PATCH 13/16] mtd: nand: enable ECC pipelining
In-Reply-To: <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
 <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367695-26420-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the NAND controller operates in DMA mode it can pipeline ECC
operations which improves the throughput.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 931c33d..9816cda 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -743,7 +743,8 @@ static void sunxi_nfc_hw_ecc_enable(struct mtd_info *mtd)
 	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
 	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE |
 		     NFC_ECC_BLOCK_SIZE_MSK);
-	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
+	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION |
+		   NFC_ECC_PIPELINE;
 
 	writel(ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
 }
-- 
2.1.4
