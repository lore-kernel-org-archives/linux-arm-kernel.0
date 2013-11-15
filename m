From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:25 -0700
Subject: [PATCH 30/31] clk: tegra: remove legacy reset APIs
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-31-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Now that no code uses the custom Tegra module reset API, we can remove
its implementation.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 drivers/clk/tegra/clk-periph-gate.c | 22 --------------------
 drivers/clk/tegra/clk-periph.c      | 40 -------------------------------------
 drivers/clk/tegra/clk.h             |  1 -
 include/linux/clk/tegra.h           |  7 -------
 4 files changed, 70 deletions(-)

diff --git a/drivers/clk/tegra/clk-periph-gate.c b/drivers/clk/tegra/clk-periph-gate.c
index f38f33e3c65d..507015314827 100644
--- a/drivers/clk/tegra/clk-periph-gate.c
+++ b/drivers/clk/tegra/clk-periph-gate.c
@@ -36,8 +36,6 @@ static DEFINE_SPINLOCK(periph_ref_lock);
 
 #define read_rst(gate) \
 	readl_relaxed(gate->clk_base + (gate->regs->rst_reg))
-#define write_rst_set(val, gate) \
-	writel_relaxed(val, gate->clk_base + (gate->regs->rst_set_reg))
 #define write_rst_clr(val, gate) \
 	writel_relaxed(val, gate->clk_base + (gate->regs->rst_clr_reg))
 
@@ -123,26 +121,6 @@ static void clk_periph_disable(struct clk_hw *hw)
 	spin_unlock_irqrestore(&periph_ref_lock, flags);
 }
 
-void tegra_periph_reset(struct tegra_clk_periph_gate *gate, bool assert)
-{
-	if (gate->flags & TEGRA_PERIPH_NO_RESET)
-		return;
-
-	if (assert) {
-		/*
-		 * If peripheral is in the APB bus then read the APB bus to
-		 * flush the write operation in apb bus. This will avoid the
-		 * peripheral access after disabling clock
-		 */
-		if (gate->flags & TEGRA_PERIPH_ON_APB)
-			tegra_read_chipid();
-
-		write_rst_set(periph_clk_to_bit(gate), gate);
-	} else {
-		write_rst_clr(periph_clk_to_bit(gate), gate);
-	}
-}
-
 const struct clk_ops tegra_clk_periph_gate_ops = {
 	.is_enabled = clk_periph_is_enabled,
 	.enable = clk_periph_enable,
diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
index b5feccca2f1e..d8ed9f79708b 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -111,46 +111,6 @@ static void clk_periph_disable(struct clk_hw *hw)
 	gate_ops->disable(gate_hw);
 }
 
-void tegra_periph_reset_deassert(struct clk *c)
-{
-	struct clk_hw *hw = __clk_get_hw(c);
-	struct tegra_clk_periph *periph = to_clk_periph(hw);
-	struct tegra_clk_periph_gate *gate;
-
-	if (periph->magic != TEGRA_CLK_PERIPH_MAGIC) {
-		gate = to_clk_periph_gate(hw);
-		if (gate->magic != TEGRA_CLK_PERIPH_GATE_MAGIC) {
-			WARN_ON(1);
-			return;
-		}
-	} else {
-		gate = &periph->gate;
-	}
-
-	tegra_periph_reset(gate, 0);
-}
-EXPORT_SYMBOL(tegra_periph_reset_deassert);
-
-void tegra_periph_reset_assert(struct clk *c)
-{
-	struct clk_hw *hw = __clk_get_hw(c);
-	struct tegra_clk_periph *periph = to_clk_periph(hw);
-	struct tegra_clk_periph_gate *gate;
-
-	if (periph->magic != TEGRA_CLK_PERIPH_MAGIC) {
-		gate = to_clk_periph_gate(hw);
-		if (gate->magic != TEGRA_CLK_PERIPH_GATE_MAGIC) {
-			WARN_ON(1);
-			return;
-		}
-	} else {
-		gate = &periph->gate;
-	}
-
-	tegra_periph_reset(gate, 1);
-}
-EXPORT_SYMBOL(tegra_periph_reset_assert);
-
 const struct clk_ops tegra_clk_periph_ops = {
 	.get_parent = clk_periph_get_parent,
 	.set_parent = clk_periph_set_parent,
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 39f24959daf7..57bd0d3090e3 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -392,7 +392,6 @@ struct tegra_clk_periph_gate {
 #define TEGRA_PERIPH_WAR_1005168 BIT(3)
 #define TEGRA_PERIPH_NO_DIV BIT(4)
 
-void tegra_periph_reset(struct tegra_clk_periph_gate *gate, bool assert);
 extern const struct clk_ops tegra_clk_periph_gate_ops;
 struct clk *tegra_clk_register_periph_gate(const char *name,
 		const char *parent_name, u8 gate_flags, void __iomem *clk_base,
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index 23a0ceee831f..3ca9fca827a2 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -120,13 +120,6 @@ static inline void tegra_cpu_clock_resume(void)
 }
 #endif
 
-#ifdef CONFIG_ARCH_TEGRA
-void tegra_periph_reset_deassert(struct clk *c);
-void tegra_periph_reset_assert(struct clk *c);
-#else
-static inline void tegra_periph_reset_deassert(struct clk *c) {}
-static inline void tegra_periph_reset_assert(struct clk *c) {}
-#endif
 void tegra_clocks_apply_init_table(void);
 
 #endif /* __LINUX_CLK_TEGRA_H_ */
-- 
1.8.1.5
