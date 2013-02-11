From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 11 Feb 2013 13:04:56 +0200
Subject: [PATCH v6 06/10] clk: tegra: Workaround for Tegra114 MSENC problem
In-Reply-To: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com>
References: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1360580700-10245-7-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Workaround a hardware bug in MSENC during clock enable.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-periph-gate.c |    9 +++++++++
 drivers/clk/tegra/clk.h             |    2 ++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk-periph-gate.c b/drivers/clk/tegra/clk-periph-gate.c
index 6dd5332..c9083fb 100644
--- a/drivers/clk/tegra/clk-periph-gate.c
+++ b/drivers/clk/tegra/clk-periph-gate.c
@@ -43,6 +43,8 @@ static DEFINE_SPINLOCK(periph_ref_lock);
 
 #define periph_clk_to_bit(periph) (1 << (gate->clk_num % 32))
 
+#define LVL2_CLK_GATE_OVRE 0x554
+
 /* Peripheral gate clock ops */
 static int clk_periph_is_enabled(struct clk_hw *hw)
 {
@@ -83,6 +85,13 @@ static int clk_periph_enable(struct clk_hw *hw)
 		}
 	}
 
+	if (gate->flags & TEGRA_PERIPH_WAR_1005168) {
+		writel_relaxed(0, gate->clk_base + LVL2_CLK_GATE_OVRE);
+		writel_relaxed(BIT(22), gate->clk_base + LVL2_CLK_GATE_OVRE);
+		udelay(1);
+		writel_relaxed(0, gate->clk_base + LVL2_CLK_GATE_OVRE);
+	}
+
 	spin_unlock_irqrestore(&periph_ref_lock, flags);
 
 	return 0;
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 4c4bf9a..fa21c88 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -356,6 +356,7 @@ struct tegra_clk_periph_regs {
  * TEGRA_PERIPH_ON_APB - If peripheral is in the APB bus then read the
  *     bus to flush the write operation in apb bus. This flag indicates
  *     that this peripheral is in apb bus.
+ * TEGRA_PERIPH_WAR_1005168 - Apply workaround for Tegra114 MSENC bug
  */
 struct tegra_clk_periph_gate {
 	u32			magic;
@@ -375,6 +376,7 @@ struct tegra_clk_periph_gate {
 #define TEGRA_PERIPH_NO_RESET BIT(0)
 #define TEGRA_PERIPH_MANUAL_RESET BIT(1)
 #define TEGRA_PERIPH_ON_APB BIT(2)
+#define TEGRA_PERIPH_WAR_1005168 BIT(3)
 
 void tegra_periph_reset(struct tegra_clk_periph_gate *gate, bool assert);
 extern const struct clk_ops tegra_clk_periph_gate_ops;
-- 
1.7.1
