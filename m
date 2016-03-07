From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:20:40 +0100
Subject: [PATCH 08/16] mtd: nand: sunxi: improve ->cmd_ctrl() function
In-Reply-To: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367640-26243-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to pack address and command cycles into a single NAND controller
command to avoid polling the status register for each single change
on the NAND bus.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 52 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index df73e55..db5446e 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -239,6 +239,10 @@ struct sunxi_nand_chip {
 	u32 timing_cfg;
 	u32 timing_ctl;
 	int selected;
+	int addr_cycles;
+	u32 addr[2];
+	int cmd_cycles;
+	u8 cmd[2];
 	int nsels;
 	struct sunxi_nand_chip_sel sels[0];
 };
@@ -526,17 +530,49 @@ static void sunxi_nfc_cmd_ctrl(struct mtd_info *mtd, int dat,
 		writel(tmp, nfc->regs + NFC_REG_CTL);
 	}
 
-	if (dat == NAND_CMD_NONE)
-		return;
+	if (dat == NAND_CMD_NONE && (ctrl & NAND_NCE) &&
+	    !(ctrl & (NAND_CLE | NAND_ALE))) {
+		u32 cmd = 0;
 
-	if (ctrl & NAND_CLE) {
-		writel(NFC_SEND_CMD1 | dat, nfc->regs + NFC_REG_CMD);
-	} else {
-		writel(dat, nfc->regs + NFC_REG_ADDR_LOW);
-		writel(NFC_SEND_ADR, nfc->regs + NFC_REG_CMD);
+		if (!sunxi_nand->addr_cycles && !sunxi_nand->cmd_cycles)
+			return;
+
+		if (sunxi_nand->cmd_cycles--)
+			cmd |= NFC_SEND_CMD1 | sunxi_nand->cmd[0];
+
+		if (sunxi_nand->cmd_cycles--) {
+			cmd |= NFC_SEND_CMD2;
+			writel(sunxi_nand->cmd[1],
+			       nfc->regs + NFC_REG_RCMD_SET);
+		}
+
+		sunxi_nand->cmd_cycles = 0;
+
+		if (sunxi_nand->addr_cycles) {
+			cmd |= NFC_SEND_ADR |
+			       NFC_ADR_NUM(sunxi_nand->addr_cycles);
+			writel(sunxi_nand->addr[0],
+			       nfc->regs + NFC_REG_ADDR_LOW);
+		}
+
+		if (sunxi_nand->addr_cycles > 4)
+			writel(sunxi_nand->addr[1],
+			       nfc->regs + NFC_REG_ADDR_HIGH);
+
+		writel(cmd, nfc->regs + NFC_REG_CMD);
+		sunxi_nand->addr[0] = 0;
+		sunxi_nand->addr[1] = 0;
+		sunxi_nand->addr_cycles = 0;
+		sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
 	}
 
-	sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+	if (ctrl & NAND_CLE) {
+		sunxi_nand->cmd[sunxi_nand->cmd_cycles++] = dat;
+	} else if (ctrl & NAND_ALE) {
+		sunxi_nand->addr[sunxi_nand->addr_cycles / 4] |=
+				dat << ((sunxi_nand->addr_cycles % 4) * 8);
+		sunxi_nand->addr_cycles++;
+	}
 }
 
 /* These seed values have been extracted from Allwinner's BSP */
-- 
2.1.4
