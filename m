From: erin.lo@mediatek.com (Erin Lo)
Date: Fri, 4 Nov 2016 15:43:06 +0800
Subject: [PATCH v15 2/4] reset: mediatek: Add MT2701 reset driver
In-Reply-To: <1478245388-1412-1-git-send-email-erin.lo@mediatek.com>
References: <1478245388-1412-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1478245388-1412-3-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shunli Wang <shunli.wang@mediatek.com>

In infrasys and perifsys, there are many reset
control bits for kinds of modules. These bits are
used as actual reset controllers to be registered
into kernel's generic reset controller framework.

Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Tested-by: John Crispin <blogic@openwrt.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/clk/mediatek/clk-mt2701-hif.c |  8 ++++++--
 drivers/clk/mediatek/clk-mt2701.c     | 12 ++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 452581c..18f3723 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -58,12 +58,16 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 						clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
+		return r;
+	}
+
+	mtk_register_reset_controller(node, 1, 0x34);
 
-	return r;
+	return 0;
 }
 
 static struct platform_driver clk_mt2701_hif_drv = {
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 6d2f82f..6f26e6a 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -787,8 +787,12 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 						infra_clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
+	if (r)
+		return r;
 
-	return r;
+	mtk_register_reset_controller(node, 2, 0x30);
+
+	return 0;
 }
 
 static const struct mtk_gate_regs peri0_cg_regs = {
@@ -906,8 +910,12 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 			&mt2701_clk_lock, clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		return r;
 
-	return r;
+	mtk_register_reset_controller(node, 2, 0x0);
+
+	return 0;
 }
 
 #define MT8590_PLL_FMAX		(2000 * MHZ)
-- 
1.9.1
