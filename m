From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  6 Jan 2017 10:42:07 +0100
Subject: [PATCH 3/3] mtd: nand: sunxi: Improve sunxi_nfc_cmd_ctrl()
In-Reply-To: <1483695727-17415-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1483695727-17415-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1483695727-17415-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We only need to call sunxi_nfc_wait_cmd_fifo_empty() if we want to send
a new command. Move the sunxi_nfc_wait_cmd_fifo_empty() call to right
place to avoid extra register reads.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 76449f79d4c5..0eeeb8b889ea 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -604,10 +604,6 @@ static void sunxi_nfc_cmd_ctrl(struct mtd_info *mtd, int dat,
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	int ret;
 
-	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
-	if (ret)
-		return;
-
 	if (dat == NAND_CMD_NONE && (ctrl & NAND_NCE) &&
 	    !(ctrl & (NAND_CLE | NAND_ALE))) {
 		u32 cmd = 0;
@@ -637,6 +633,10 @@ static void sunxi_nfc_cmd_ctrl(struct mtd_info *mtd, int dat,
 			writel(sunxi_nand->addr[1],
 			       nfc->regs + NFC_REG_ADDR_HIGH);
 
+		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
+		if (ret)
+			return;
+
 		writel(cmd, nfc->regs + NFC_REG_CMD);
 		sunxi_nand->addr[0] = 0;
 		sunxi_nand->addr[1] = 0;
-- 
2.7.4
