From: erin.lo@mediatek.com (Erin Lo)
Date: Mon, 26 Sep 2016 17:26:29 +0800
Subject: [PATCH v13 2/4] reset: mediatek: Add MT2701 reset driver
In-Reply-To: <1474881991-17429-1-git-send-email-erin.lo@mediatek.com>
References: <1474881991-17429-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1474881991-17429-3-git-send-email-erin.lo@mediatek.com>
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
 drivers/clk/mediatek/clk-mt2701-hif.c |  6 +++++-
 drivers/clk/mediatek/clk-mt2701.c     | 12 ++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index e2b0039..4c0688f 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -53,8 +53,12 @@ static int mtk_hifsys_init(struct platform_device *pdev)
 						clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		return r;
 
-	return r;
+	mtk_register_reset_controller(node, 1, 0x34);
+
+	return 0;
 }
 
 static const struct of_device_id of_match_clk_mt2701_hif[] = {
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index c225256..b2148b6 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -802,8 +802,12 @@ static int mtk_infrasys_init(struct platform_device *pdev)
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
@@ -920,8 +924,12 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 			&lock, clk_data);
 
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
