From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 29 Jul 2015 14:52:27 +0800
Subject: [PATCH v5 03/10] clk: mediatek: Add __initdata and __init for data
 and functions
In-Reply-To: <1438152754-11970-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1438152754-11970-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1438152754-11970-4-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add __init for clock registration functions, and add __initdata for
mtk_gate_regs initial structures.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-gate.c   |  2 +-
 drivers/clk/mediatek/clk-mt8173.c |  6 +++---
 drivers/clk/mediatek/clk-mtk.c    | 13 +++++++------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 5702036..576bdb7 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -97,7 +97,7 @@ const struct clk_ops mtk_clk_gate_ops_setclr_inv = {
 	.disable	= mtk_cg_disable_inv,
 };
 
-struct clk *mtk_clk_register_gate(
+struct clk * __init mtk_clk_register_gate(
 		const char *name,
 		const char *parent_name,
 		struct regmap *regmap,
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 4478849..a33a531 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -586,7 +586,7 @@ static const struct mtk_composite top_muxes[] __initconst = {
 	MUX(CLK_TOP_I2S3_B_SEL, "i2s3_b_ck_sel", i2s3_b_ck_parents, 0x120, 8, 1),
 };
 
-static const struct mtk_gate_regs infra_cg_regs = {
+static const struct mtk_gate_regs infra_cg_regs __initconst = {
 	.set_ofs = 0x0040,
 	.clr_ofs = 0x0044,
 	.sta_ofs = 0x0048,
@@ -615,13 +615,13 @@ static const struct mtk_gate infra_clks[] __initconst = {
 	GATE_ICG(CLK_INFRA_PMICWRAP, "infra_pmicwrap", "axi_sel", 23),
 };
 
-static const struct mtk_gate_regs peri0_cg_regs = {
+static const struct mtk_gate_regs peri0_cg_regs __initconst = {
 	.set_ofs = 0x0008,
 	.clr_ofs = 0x0010,
 	.sta_ofs = 0x0018,
 };
 
-static const struct mtk_gate_regs peri1_cg_regs = {
+static const struct mtk_gate_regs peri1_cg_regs __initconst = {
 	.set_ofs = 0x000c,
 	.clr_ofs = 0x0014,
 	.sta_ofs = 0x001c,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 18444ae..268b6ff 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -24,7 +24,7 @@
 #include "clk-mtk.h"
 #include "clk-gate.h"
 
-struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
+struct clk_onecell_data * __init mtk_alloc_clk_data(unsigned int clk_num)
 {
 	int i;
 	struct clk_onecell_data *clk_data;
@@ -49,8 +49,8 @@ err_out:
 	return NULL;
 }
 
-void mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
-		struct clk_onecell_data *clk_data)
+void __init mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
+		int num, struct clk_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
@@ -72,7 +72,8 @@ void mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 	}
 }
 
-int mtk_clk_register_gates(struct device_node *node, const struct mtk_gate *clks,
+int __init mtk_clk_register_gates(struct device_node *node,
+		const struct mtk_gate *clks,
 		int num, struct clk_onecell_data *clk_data)
 {
 	int i;
@@ -111,7 +112,7 @@ int mtk_clk_register_gates(struct device_node *node, const struct mtk_gate *clks
 	return 0;
 }
 
-struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
+struct clk * __init mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
 {
 	struct clk *clk;
@@ -196,7 +197,7 @@ err_out:
 	return ERR_PTR(ret);
 }
 
-void mtk_clk_register_composites(const struct mtk_composite *mcs,
+void __init mtk_clk_register_composites(const struct mtk_composite *mcs,
 		int num, void __iomem *base, spinlock_t *lock,
 		struct clk_onecell_data *clk_data)
 {
-- 
1.8.1.1.dirty
