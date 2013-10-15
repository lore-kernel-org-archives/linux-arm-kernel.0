From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 15 Oct 2013 17:52:49 +0300
Subject: [PATCH v3 04/19] clk: tegra: Add TEGRA_PERIPH_NO_DIV flag
In-Reply-To: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1381848794-11761-5-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag indicates the peripheral clock does not have a divider. It will
simply the initialization tables and avoids some very similar code.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-periph.c |    8 +++++---
 drivers/clk/tegra/clk.h        |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
index 5102d5e..22ca12e 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -173,12 +173,13 @@ const struct clk_ops tegra_clk_periph_nodiv_ops = {
 static struct clk *_tegra_clk_register_periph(const char *name,
 			const char **parent_names, int num_parents,
 			struct tegra_clk_periph *periph,
-			void __iomem *clk_base, u32 offset, bool div,
+			void __iomem *clk_base, u32 offset,
 			unsigned long flags)
 {
 	struct clk *clk;
 	struct clk_init_data init;
 	struct tegra_clk_periph_regs *bank;
+	bool div = !(periph->gate.flags & TEGRA_PERIPH_NO_DIV);
 
 	init.name = name;
 	init.ops = div ? &tegra_clk_periph_ops : &tegra_clk_periph_nodiv_ops;
@@ -216,7 +217,7 @@ struct clk *tegra_clk_register_periph(const char *name,
 		u32 offset, unsigned long flags)
 {
 	return _tegra_clk_register_periph(name, parent_names, num_parents,
-			periph, clk_base, offset, true, flags);
+			periph, clk_base, offset, flags);
 }
 
 struct clk *tegra_clk_register_periph_nodiv(const char *name,
@@ -224,6 +225,7 @@ struct clk *tegra_clk_register_periph_nodiv(const char *name,
 		struct tegra_clk_periph *periph, void __iomem *clk_base,
 		u32 offset)
 {
+	periph->gate.flags |= TEGRA_PERIPH_NO_DIV;
 	return _tegra_clk_register_periph(name, parent_names, num_parents,
-			periph, clk_base, offset, false, CLK_SET_RATE_PARENT);
+			periph, clk_base, offset, CLK_SET_RATE_PARENT);
 }
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index e67a1f3..da8baa2 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -397,6 +397,7 @@ struct tegra_clk_periph_gate {
 #define TEGRA_PERIPH_MANUAL_RESET BIT(1)
 #define TEGRA_PERIPH_ON_APB BIT(2)
 #define TEGRA_PERIPH_WAR_1005168 BIT(3)
+#define TEGRA_PERIPH_NO_DIV BIT(4)
 
 void tegra_periph_reset(struct tegra_clk_periph_gate *gate, bool assert);
 extern const struct clk_ops tegra_clk_periph_gate_ops;
-- 
1.7.7.rc0.72.g4b5ea.dirty
