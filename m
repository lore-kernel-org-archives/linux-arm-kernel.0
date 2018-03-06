From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 6 Mar 2018 17:09:27 +0800
Subject: [PATCH v4 2/6] clk: mediatek: add devm_of_platform_populate() for
 MT7622 audsys
In-Reply-To: <cover.1520327262.git.ryder.lee@mediatek.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
Message-ID: <3a3c198707a69297abc05d2a7fef97857e7fab5a.1520327262.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devm_of_platform_populate() to populate devices which are children
of the root node.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7622-aud.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 13f752d..0a1109f 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -142,6 +142,7 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
+
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
@@ -150,12 +151,15 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 			       clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	return r;
+		return r;
+	}
+
+	return devm_of_platform_populate(&pdev->dev);
 }
 
 static const struct of_device_id of_match_clk_mt7622_aud[] = {
-- 
1.9.1
