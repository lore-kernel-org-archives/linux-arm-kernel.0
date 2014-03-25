From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:29 +0000
Subject: [RFC 12/47] mtd: nand: stm_nand_bch: scan for NAND devices
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the core nand_scan_ident() routine to locate connected NAND chips.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index e1ebf92..1de13bd 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -374,6 +374,7 @@ static int stm_nand_bch_probe(struct platform_device *pdev)
 	struct nandi_info *info;
 	struct nand_chip *chip;
 	struct mtd_info *mtd;
+	int err;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data found\n");
@@ -403,6 +404,10 @@ static int stm_nand_bch_probe(struct platform_device *pdev)
 
 	nandi_set_mtd_defaults(nandi, mtd, chip);
 
+	err = nand_scan_ident(mtd, 1, NULL);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -410,6 +415,8 @@ static int stm_nand_bch_remove(struct platform_device *pdev)
 {
 	struct nandi_controller *nandi = platform_get_drvdata(pdev);
 
+	nand_release(&nandi->info.mtd);
+
 	nandi_clk_disable(nandi);
 
 	return 0;
-- 
1.8.3.2
