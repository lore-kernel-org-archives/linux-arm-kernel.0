From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:24 +0200
Subject: [PATCH 11/40] mtd mxc_nand: prepare/unprepare clock
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-12-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index cc0678a..9e374e9 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -690,7 +690,7 @@ static void mxc_nand_select_chip(struct mtd_info *mtd, int chip)
 	if (chip == -1) {
 		/* Disable the NFC clock */
 		if (host->clk_act) {
-			clk_disable(host->clk);
+			clk_disable_unprepare(host->clk);
 			host->clk_act = 0;
 		}
 		return;
@@ -698,7 +698,7 @@ static void mxc_nand_select_chip(struct mtd_info *mtd, int chip)
 
 	if (!host->clk_act) {
 		/* Enable the NFC clock */
-		clk_enable(host->clk);
+		clk_prepare_enable(host->clk);
 		host->clk_act = 1;
 	}
 
@@ -1078,7 +1078,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		goto eclk;
 	}
 
-	clk_enable(host->clk);
+	clk_prepare_enable(host->clk);
 	host->clk_act = 1;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.9.5
