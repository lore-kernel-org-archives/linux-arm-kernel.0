From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 20 Mar 2018 11:16:51 +0800
Subject: [PATCH 1/2] clk: mediatek: add devm_of_platform_populate() for MT7622
 audsys
Message-ID: <004f07aef08148321c320ea09f8169982f73dd2b.1521514928.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devm_of_platform_populate() to populate devices which are children
of the root node.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7622-aud.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 13f752d..4f3d47b 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -150,11 +150,23 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 			       clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
+		goto err_clk_provider;
+	}
+
+	r = devm_of_platform_populate(&pdev->dev);
+	if (r)
+		goto err_plat_populate;
+
+	return 0;
+
+err_plat_populate:
+	of_clk_del_provider(node);
+err_clk_provider:
 	return r;
 }
 
-- 
1.9.1
