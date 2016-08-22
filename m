From: erin.lo@mediatek.com (Erin Lo)
Date: Mon, 22 Aug 2016 16:29:23 +0800
Subject: [PATCH v12 2/4] reset: mediatek: Add MT2701 reset driver
In-Reply-To: <1471854565-19810-1-git-send-email-erin.lo@mediatek.com>
References: <1471854565-19810-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1471854565-19810-3-git-send-email-erin.lo@mediatek.com>
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
 drivers/clk/mediatek/clk-mt2701.c     | 16 ++++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 18b4ab5..702fd74 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -52,11 +52,15 @@ static int mtk_hifsys_init(struct device_node *node)
 						clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+		return r;
+	}
+
+	mtk_register_reset_controller(node, 1, 0x34);
 
-	return r;
+	return 0;
 }
 
 static const struct of_device_id of_match_clk_mt2701_hif[] = {
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index f6df578..c8cc583 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -790,11 +790,15 @@ static int mtk_infrasys_init(struct device_node *node)
 						infra_clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
-	if (r)
+	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+		return r;
+	}
 
-	return r;
+	mtk_register_reset_controller(node, 2, 0x30);
+
+	return 0;
 }
 
 static const struct mtk_gate_regs peri0_cg_regs = {
@@ -912,11 +916,15 @@ static int mtk_pericfg_init(struct device_node *node)
 			&lock, clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+		return r;
+	}
 
-	return r;
+	mtk_register_reset_controller(node, 2, 0x0);
+
+	return 0;
 }
 
 #define MT8590_PLL_FMAX		(2000 * MHZ)
-- 
1.9.1
