From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:37:03 +0000
Subject: [PATCH v5 12/20] clk: bcm2835: expose raw clock-registers via debugfs
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-13-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

For debugging purposes under some circumstance
it helps to be able to see the actual clock registers.

E.g: when looking at the clock divider it is helpful to
see what the actual clock divider is.

This patch exposes all the clock registers specific to each
clock/pll/pll-divider via debugfs.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |  101 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 211d231..366f975 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -38,6 +38,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/bcm2835.h>
+#include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -314,6 +315,27 @@ static inline u32 cprman_read(struct bcm2835_cprman *cprman, u32 reg)
 	return readl(cprman->regs + reg);
 }
 
+static int bcm2835_debugfs_regset(struct bcm2835_cprman *cprman, u32 base,
+				  struct debugfs_reg32 *regs, size_t nregs,
+				  struct dentry *dentry)
+{
+	struct dentry *regdump;
+	struct debugfs_regset32 *regset;
+
+	regset = devm_kzalloc(cprman->dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return -ENOMEM;
+
+	regset->regs = regs;
+	regset->nregs = nregs;
+	regset->base = cprman->regs + base;
+
+	regdump = debugfs_create_regset32("regdump", S_IRUGO, dentry,
+					  regset);
+
+	return regdump ? 0 : -ENOMEM;
+}
+
 /*
  * These are fixed clocks. They're probably not all root clocks and it may
  * be possible to turn them on and off but until this is mapped out better
@@ -627,6 +649,36 @@ static int bcm2835_pll_set_rate(struct clk_hw *hw,
 	return 0;
 }
 
+static int bcm2835_pll_debug_init(struct clk_hw *hw,
+				  struct dentry *dentry)
+{
+	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
+	struct bcm2835_cprman *cprman = pll->cprman;
+	const struct bcm2835_pll_data *data = pll->data;
+	struct debugfs_reg32 *regs;
+
+	regs = devm_kzalloc(cprman->dev, 7 * sizeof(*regs), GFP_KERNEL);
+	if (!regs)
+		return -ENOMEM;
+
+	regs[0].name = "cm_ctrl";
+	regs[0].offset = data->cm_ctrl_reg;
+	regs[1].name = "a2w_ctrl";
+	regs[1].offset = data->a2w_ctrl_reg;
+	regs[2].name = "frac";
+	regs[2].offset = data->frac_reg;
+	regs[3].name = "ana0";
+	regs[3].offset = data->ana_reg_base + 0 * 4;
+	regs[4].name = "ana1";
+	regs[4].offset = data->ana_reg_base + 1 * 4;
+	regs[5].name = "ana2";
+	regs[5].offset = data->ana_reg_base + 2 * 4;
+	regs[6].name = "ana3";
+	regs[6].offset = data->ana_reg_base + 3 * 4;
+
+	return bcm2835_debugfs_regset(cprman, 0, regs, 7, dentry);
+}
+
 static const struct clk_ops bcm2835_pll_clk_ops = {
 	.is_prepared = bcm2835_pll_is_on,
 	.prepare = bcm2835_pll_on,
@@ -634,6 +686,7 @@ static const struct clk_ops bcm2835_pll_clk_ops = {
 	.recalc_rate = bcm2835_pll_get_rate,
 	.set_rate = bcm2835_pll_set_rate,
 	.round_rate = bcm2835_pll_round_rate,
+	.debug_init = bcm2835_pll_debug_init,
 };
 
 struct bcm2835_pll_divider {
@@ -725,6 +778,26 @@ static int bcm2835_pll_divider_set_rate(struct clk_hw *hw,
 	return 0;
 }
 
+static int bcm2835_pll_divider_debug_init(struct clk_hw *hw,
+					  struct dentry *dentry)
+{
+	struct bcm2835_pll_divider *divider = bcm2835_pll_divider_from_hw(hw);
+	struct bcm2835_cprman *cprman = divider->cprman;
+	const struct bcm2835_pll_divider_data *data = divider->data;
+	struct debugfs_reg32 *regs;
+
+	regs = devm_kzalloc(cprman->dev, 7 * sizeof(*regs), GFP_KERNEL);
+	if (!regs)
+		return -ENOMEM;
+
+	regs[0].name = "cm";
+	regs[0].offset = data->cm_reg;
+	regs[1].name = "a2w";
+	regs[1].offset = data->a2w_reg;
+
+	return bcm2835_debugfs_regset(cprman, 0, regs, 2, dentry);
+}
+
 static const struct clk_ops bcm2835_pll_divider_clk_ops = {
 	.is_prepared = bcm2835_pll_divider_is_on,
 	.prepare = bcm2835_pll_divider_on,
@@ -732,6 +805,7 @@ static const struct clk_ops bcm2835_pll_divider_clk_ops = {
 	.recalc_rate = bcm2835_pll_divider_get_rate,
 	.set_rate = bcm2835_pll_divider_set_rate,
 	.round_rate = bcm2835_pll_divider_round_rate,
+	.debug_init = bcm2835_pll_divider_debug_init,
 };
 
 /*
@@ -971,6 +1045,31 @@ static u8 bcm2835_clock_get_parent(struct clk_hw *hw)
 	return (src & CM_SRC_MASK) >> CM_SRC_SHIFT;
 }
 
+static struct debugfs_reg32 bcm2835_debugfs_clock_reg32[] = {
+	{
+		.name = "ctl",
+		.offset = 0,
+	},
+	{
+		.name = "div",
+		.offset = 4,
+	},
+};
+
+static int bcm2835_clock_debug_init(struct clk_hw *hw,
+				    struct dentry *dentry)
+{
+	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
+	struct bcm2835_cprman *cprman = clock->cprman;
+	const struct bcm2835_clock_data *data = clock->data;
+
+	return bcm2835_debugfs_regset(
+		cprman, data->ctl_reg,
+		bcm2835_debugfs_clock_reg32,
+		ARRAY_SIZE(bcm2835_debugfs_clock_reg32),
+		dentry);
+}
+
 static const struct clk_ops bcm2835_clock_clk_ops = {
 	.is_prepared = bcm2835_clock_is_on,
 	.prepare = bcm2835_clock_on,
@@ -980,6 +1079,7 @@ static const struct clk_ops bcm2835_clock_clk_ops = {
 	.determine_rate = bcm2835_clock_determine_rate,
 	.set_parent = bcm2835_clock_set_parent,
 	.get_parent = bcm2835_clock_get_parent,
+	.debug_init = bcm2835_clock_debug_init,
 };
 
 static int bcm2835_vpu_clock_is_on(struct clk_hw *hw)
@@ -998,6 +1098,7 @@ static const struct clk_ops bcm2835_vpu_clock_clk_ops = {
 	.determine_rate = bcm2835_clock_determine_rate,
 	.set_parent = bcm2835_clock_set_parent,
 	.get_parent = bcm2835_clock_get_parent,
+	.debug_init = bcm2835_clock_debug_init,
 };
 
 static struct clk *bcm2835_register_pll(struct bcm2835_cprman *cprman,
-- 
1.7.10.4
