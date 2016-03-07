From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:21:33 +0100
Subject: [PATCH 14/16] mtd: nand: sunxi: fix ->dev_ready() implementation
In-Reply-To: <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
 <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367695-26420-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

->dev_ready() is not supposed to wait for busy to ready solution (this is
the role of ->waitfunc()).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 9816cda..79c90fd 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -358,7 +358,6 @@ static int sunxi_nfc_dev_ready(struct mtd_info *mtd)
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct sunxi_nand_rb *rb;
-	unsigned long timeo = (sunxi_nand->nand.state == FL_ERASING ? 400 : 20);
 	int ret;
 
 	if (sunxi_nand->selected < 0)
@@ -370,12 +369,6 @@ static int sunxi_nfc_dev_ready(struct mtd_info *mtd)
 	case RB_NATIVE:
 		ret = !!(readl(nfc->regs + NFC_REG_ST) &
 			 NFC_RB_STATE(rb->info.nativeid));
-		if (ret)
-			break;
-
-		sunxi_nfc_wait_int(nfc, NFC_RB_B2R, timeo);
-		ret = !!(readl(nfc->regs + NFC_REG_ST) &
-			 NFC_RB_STATE(rb->info.nativeid));
 		break;
 	case RB_GPIO:
 		ret = gpio_get_value(rb->info.gpio);
-- 
2.1.4
