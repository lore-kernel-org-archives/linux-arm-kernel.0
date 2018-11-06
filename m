From: sboyd@kernel.org (Stephen Boyd)
Date: Tue,  6 Nov 2018 10:36:09 -0800
Subject: [PATCH 4/4] clk: mediatek: Simplify single driver probes
In-Reply-To: <20181106183609.207702-1-sboyd@kernel.org>
References: <20181106183609.207702-1-sboyd@kernel.org>
Message-ID: <20181106183609.207702-5-sboyd@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to do the multiplex probe design here when we only have
one compatible string. Just setup probe to point at the one probe
function for now.

Cc: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mt2701-g3d.c | 28 +++------------------------
 drivers/clk/mediatek/clk-mt7622-aud.c | 28 +++------------------------
 2 files changed, 6 insertions(+), 50 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 1328c112a38f..58b13f12051a 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -58,34 +58,12 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_match_clk_mt2701_g3d[] = {
-	{
-		.compatible = "mediatek,mt2701-g3dsys",
-		.data = clk_mt2701_g3dsys_init,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt2701-g3dsys", },
+	{ /* sentinel */ }
 };
 
-static int clk_mt2701_g3d_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt2701_g3d_drv = {
-	.probe = clk_mt2701_g3d_probe,
+	.probe = clk_mt2701_g3dsys_init,
 	.driver = {
 		.name = "clk-mt2701-g3d",
 		.of_match_table = of_match_clk_mt2701_g3d,
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 4f3d47b41b3e..2b10d13a8a37 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -171,34 +171,12 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_match_clk_mt7622_aud[] = {
-	{
-		.compatible = "mediatek,mt7622-audsys",
-		.data = clk_mt7622_audiosys_init,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt7622-audsys", },
+	{ /* sentinel */ }
 };
 
-static int clk_mt7622_aud_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt7622_aud_drv = {
-	.probe = clk_mt7622_aud_probe,
+	.probe = clk_mt7622_audiosys_init,
 	.driver = {
 		.name = "clk-mt7622-aud",
 		.of_match_table = of_match_clk_mt7622_aud,
-- 
Sent by a computer through tubes
