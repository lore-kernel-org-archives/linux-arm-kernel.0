From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 28 Jul 2017 18:32:28 +0200
Subject: [PATCH] clk: meson: mpll: fix mpll0 fractional part ignored
Message-ID: <20170728163228.10879-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mpll0 clock is special compared to the other mplls. It needs another
bit (ssen) to be set to activate the fractional part the mpll divider

Fixes: 007e6e5c5f01 ("clk: meson: mpll: add rw operation")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-mpll.c | 7 +++++++
 drivers/clk/meson/clkc.h     | 1 +
 drivers/clk/meson/gxbb.c     | 5 +++++
 drivers/clk/meson/meson8b.c  | 5 +++++
 4 files changed, 18 insertions(+)

diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index 39eab69fe51a..44a5a535ca63 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -161,6 +161,13 @@ static int mpll_set_rate(struct clk_hw *hw,
 	reg = PARM_SET(p->width, p->shift, reg, 1);
 	writel(reg, mpll->base + p->reg_off);
 
+	p = &mpll->ssen;
+	if (p->width != 0) {
+		reg = readl(mpll->base + p->reg_off);
+		reg = PARM_SET(p->width, p->shift, reg, 1);
+		writel(reg, mpll->base + p->reg_off);
+	}
+
 	p = &mpll->n2;
 	reg = readl(mpll->base + p->reg_off);
 	reg = PARM_SET(p->width, p->shift, reg, n2);
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index d6feafe8bd6c..1629da9b4141 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -118,6 +118,7 @@ struct meson_clk_mpll {
 	struct parm sdm_en;
 	struct parm n2;
 	struct parm en;
+	struct parm ssen;
 	spinlock_t *lock;
 };
 
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 59a296b119ea..79b195b4df03 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -528,6 +528,11 @@ static struct meson_clk_mpll gxbb_mpll0 = {
 		.shift   = 14,
 		.width	 = 1,
 	},
+	.ssen = {
+		.reg_off = HHI_MPLL_CNTL,
+		.shift   = 25,
+		.width	 = 1,
+	},
 	.lock = &clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0",
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index bb3f1de876b1..6ec512ad2598 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -267,6 +267,11 @@ static struct meson_clk_mpll meson8b_mpll0 = {
 		.shift   = 14,
 		.width   = 1,
 	},
+	.ssen = {
+		.reg_off = HHI_MPLL_CNTL,
+		.shift   = 25,
+		.width   = 1,
+	},
 	.lock = &clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0",
-- 
2.9.4
