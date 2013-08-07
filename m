From: markz@nvidia.com (Mark Zhang)
Date: Wed, 7 Aug 2013 19:25:06 +0800
Subject: [PATCH 2/5] clk: tegra: Add reset only clock node flag and COP
In-Reply-To: <1375874709-10438-1-git-send-email-markz@nvidia.com>
References: <1375874709-10438-1-git-send-email-markz@nvidia.com>
Message-ID: <1375874709-10438-2-git-send-email-markz@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter De Schrijver <pdeschrijver@nvidia.com>

COP is a reset only clock. So this patch adds NO_CLK support
then adds the COP clock.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 drivers/clk/tegra/clk-periph-gate.c |   15 +++++++++++++++
 drivers/clk/tegra/clk-tegra114.c    |    9 ++++++++-
 drivers/clk/tegra/clk.h             |    2 ++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-periph-gate.c b/drivers/clk/tegra/clk-periph-gate.c
index bafee98..092f256 100644
--- a/drivers/clk/tegra/clk-periph-gate.c
+++ b/drivers/clk/tegra/clk-periph-gate.c
@@ -51,6 +51,11 @@ static int clk_periph_is_enabled(struct clk_hw *hw)
 	struct tegra_clk_periph_gate *gate = to_clk_periph_gate(hw);
 	int state = 1;
 
+	if (gate->flags & TEGRA_PERIPH_NO_CLK) {
+		WARN_ON(1);
+		return 0;
+	}
+
 	if (!(read_enb(gate) & periph_clk_to_bit(gate)))
 		state = 0;
 
@@ -66,6 +71,11 @@ static int clk_periph_enable(struct clk_hw *hw)
 	struct tegra_clk_periph_gate *gate = to_clk_periph_gate(hw);
 	unsigned long flags = 0;
 
+	if (gate->flags & TEGRA_PERIPH_NO_CLK) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	spin_lock_irqsave(&periph_ref_lock, flags);
 
 	gate->enable_refcnt[gate->clk_num]++;
@@ -102,6 +112,11 @@ static void clk_periph_disable(struct clk_hw *hw)
 	struct tegra_clk_periph_gate *gate = to_clk_periph_gate(hw);
 	unsigned long flags = 0;
 
+	if (gate->flags & TEGRA_PERIPH_NO_CLK) {
+		WARN_ON(1);
+		return;
+	}
+
 	spin_lock_irqsave(&periph_ref_lock, flags);
 
 	gate->enable_refcnt[gate->clk_num]--;
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 71db736..7172faf 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -863,7 +863,7 @@ static unsigned long tegra114_input_freq[] = {
 			mux_d_audio_clk_idx, 0)
 
 enum tegra114_clk {
-	rtc = 4, timer = 5, uarta = 6, sdmmc2 = 9, i2s1 = 11, i2c1 = 12,
+	cop = 1, rtc = 4, timer = 5, uarta = 6, sdmmc2 = 9, i2s1 = 11, i2c1 = 12,
 	ndflash = 13, sdmmc1 = 14, sdmmc4 = 15, pwm = 17, i2s2 = 18, epp = 19,
 	gr_2d = 21, usbd = 22, isp = 23, gr_3d = 24, disp2 = 26, disp1 = 27,
 	host1x = 28, vcp = 29, i2s0 = 30, apbdma = 34, kbc = 36, kfuse = 40,
@@ -1921,6 +1921,13 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base)
 	int i;
 	u32 val;
 
+	/* cop */
+	clk = tegra_clk_register_periph_gate("cop", NULL, TEGRA_PERIPH_NO_CLK,
+						clk_base, CLK_IGNORE_UNUSED, 1,
+						&periph_l_regs,
+						periph_clk_enb_refcnt);
+	clks[cop] = clk;
+
 	/* apbdma */
 	clk = tegra_clk_register_periph_gate("apbdma", "clk_m", 0, clk_base,
 				  0, 34, &periph_h_regs,
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 07cfacd..0124e11 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -375,6 +375,7 @@ struct tegra_clk_periph_regs {
  *     bus to flush the write operation in apb bus. This flag indicates
  *     that this peripheral is in apb bus.
  * TEGRA_PERIPH_WAR_1005168 - Apply workaround for Tegra114 MSENC bug
+ * TEGRA_PERIPH_NO_CLK - Reset only clock node
  */
 struct tegra_clk_periph_gate {
 	u32			magic;
@@ -395,6 +396,7 @@ struct tegra_clk_periph_gate {
 #define TEGRA_PERIPH_MANUAL_RESET BIT(1)
 #define TEGRA_PERIPH_ON_APB BIT(2)
 #define TEGRA_PERIPH_WAR_1005168 BIT(3)
+#define TEGRA_PERIPH_NO_CLK BIT(4)
 
 void tegra_periph_reset(struct tegra_clk_periph_gate *gate, bool assert);
 extern const struct clk_ops tegra_clk_periph_gate_ops;
-- 
1.7.9.5
