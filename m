From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:20:54 +0100
Subject: [PATCH 09/16] mtd: nand: sunxi: let the NAND controller control the
 CE line
In-Reply-To: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367654-26288-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to manually toggle the CE line since the controller handles
it for us. Moreover, keeping the CE line low when interacting with a DDR
NAND can be problematic (data loss in some corner cases).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index db5446e..25a167f 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -515,21 +515,11 @@ static void sunxi_nfc_cmd_ctrl(struct mtd_info *mtd, int dat,
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	int ret;
-	u32 tmp;
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 	if (ret)
 		return;
 
-	if (ctrl & NAND_CTRL_CHANGE) {
-		tmp = readl(nfc->regs + NFC_REG_CTL);
-		if (ctrl & NAND_NCE)
-			tmp |= NFC_CE_CTL;
-		else
-			tmp &= ~NFC_CE_CTL;
-		writel(tmp, nfc->regs + NFC_REG_CTL);
-	}
-
 	if (dat == NAND_CMD_NONE && (ctrl & NAND_NCE) &&
 	    !(ctrl & (NAND_CLE | NAND_ALE))) {
 		u32 cmd = 0;
-- 
2.1.4
