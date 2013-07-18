From: gsi@denx.de (Gerhard Sittig)
Date: Thu, 18 Jul 2013 19:00:34 +0200
Subject: [PATCH v2 03/24] mtd: mpc5121_nfc: prepare clocks before enabling them
In-Reply-To: <1374166855-7280-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1374166855-7280-1-git-send-email-gsi@denx.de>
Message-ID: <1374166855-7280-4-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

must prepare clocks before enabling them, unprepare after disable

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/mtd/nand/mpc5121_nfc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 3c9cdcb..eb7771d 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -618,7 +618,7 @@ static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)
 	struct mpc5121_nfc_prv *prv = chip->priv;
 
 	if (prv->clk) {
-		clk_disable(prv->clk);
+		clk_disable_unprepare(prv->clk);
 		clk_put(prv->clk);
 	}
 
@@ -737,7 +737,7 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 		goto error;
 	}
 
-	clk_enable(prv->clk);
+	clk_prepare_enable(prv->clk);
 
 	/* Reset NAND Flash controller */
 	nfc_set(mtd, NFC_CONFIG1, NFC_RESET);
-- 
1.7.10.4
