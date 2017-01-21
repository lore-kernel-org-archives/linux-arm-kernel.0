From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 21 Jan 2017 23:50:54 +0100
Subject: [PATCH v4 5/8] clk: sunxi-ng: Implement global pre-divider
In-Reply-To: <cover.04f797fe015b05f19b1d69d0650680baffb27055.1485039043.git-series.maxime.ripard@free-electrons.com>
References: <cover.04f797fe015b05f19b1d69d0650680baffb27055.1485039043.git-series.maxime.ripard@free-electrons.com>
Message-ID: <10a00258fc227a775a52a4d6de79ba3c76fbc19e.1485039043.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks have a global pre-divider that applies to all their parents.

Since it might also apply to clocks that have a single parent, this is
merged in the ccu_common structure, unlike the other pre-divider settings
that are tied to a specific index, and thus a specific parent.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_common.h | 2 ++
 drivers/clk/sunxi-ng/ccu_mux.c    | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index b3d9abfbd721..cdd69eb2e0b9 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -21,6 +21,7 @@
 #define CCU_FEATURE_VARIABLE_PREDIV	BIT(1)
 #define CCU_FEATURE_FIXED_PREDIV	BIT(2)
 #define CCU_FEATURE_FIXED_POSTDIV	BIT(3)
+#define CCU_FEATURE_ALL_PREDIV		BIT(4)
 
 struct device_node;
 
@@ -56,6 +57,7 @@ struct device_node;
 struct ccu_common {
 	void __iomem	*base;
 	u16		reg;
+	u32		prediv;
 
 	unsigned long	features;
 	spinlock_t	*lock;
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index a43ad52a957d..858a48621631 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -25,9 +25,15 @@ void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
 	int i;
 
 	if (!((common->features & CCU_FEATURE_FIXED_PREDIV) ||
-	      (common->features & CCU_FEATURE_VARIABLE_PREDIV)))
+	      (common->features & CCU_FEATURE_VARIABLE_PREDIV) ||
+	      (common->features & CCU_FEATURE_ALL_PREDIV)))
 		return;
 
+	if (common->features & CCU_FEATURE_ALL_PREDIV) {
+		*parent_rate = *parent_rate / common->prediv;
+		return;
+	}
+
 	reg = readl(common->base + common->reg);
 	if (parent_index < 0) {
 		parent_index = reg >> cm->shift;
-- 
git-series 0.8.11
