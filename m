From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 19 Feb 2017 14:12:49 +0100
Subject: [PATCH] soc: mediatek: PMIC wrap: Fix error handling
Message-ID: <20170219131249.12010-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to error handling in this function, it is likely that going to
'err_out2' was expected here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index a5f10936fb9c..285b434449a6 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1200,7 +1200,8 @@ static int pwrap_probe(struct platform_device *pdev)
 
 	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & PWRAP_STATE_INIT_DONE0)) {
 		dev_dbg(wrp->dev, "initialization isn't finished\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_out2;
 	}
 
 	/* Initialize watchdog, may not be done by the bootloader */
@@ -1220,8 +1221,10 @@ static int pwrap_probe(struct platform_device *pdev)
 		goto err_out2;
 
 	wrp->regmap = devm_regmap_init(wrp->dev, NULL, wrp, &pwrap_regmap_config);
-	if (IS_ERR(wrp->regmap))
-		return PTR_ERR(wrp->regmap);
+	if (IS_ERR(wrp->regmap)) {
+		ret = PTR_ERR(wrp->regmap);
+		goto err_out2;
+	}
 
 	ret = of_platform_populate(np, NULL, NULL, wrp->dev);
 	if (ret) {
-- 
2.9.3
