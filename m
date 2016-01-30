From: dirk.behme@gmail.com (Dirk Behme)
Date: Sat, 30 Jan 2016 07:33:59 +0100
Subject: [PATCH v2] clk: shmobile: r8a7795: Add SD divider support
Message-ID: <1454135639-4102-1-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SD[0..3] clock divider support for R-Car Gen3 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
Changes in v2: Incorporate review comments and merge with
               "clk: shmobile: r8a7795: Add SDHI clocks"

 drivers/clk/shmobile/r8a7795-cpg-mssr.c | 230 ++++++++++++++++++++++++++++++++
 drivers/clk/shmobile/renesas-cpg-mssr.h |   2 +
 2 files changed, 232 insertions(+)

diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
index 23e98fe..9bf7035 100644
--- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
+++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 #include <dt-bindings/clock/r8a7795-cpg-mssr.h>
 
@@ -61,6 +62,7 @@ enum r8a7795_clk_types {
 	CLK_TYPE_GEN3_PLL2,
 	CLK_TYPE_GEN3_PLL3,
 	CLK_TYPE_GEN3_PLL4,
+	CLK_TYPE_GEN3_SD,
 };
 
 static const struct cpg_core_clk r8a7795_core_clks[] __initconst = {
@@ -99,6 +101,12 @@ static const struct cpg_core_clk r8a7795_core_clks[] __initconst = {
 	DEF_FIXED("s3d1",       R8A7795_CLK_S3D1,  CLK_S3,         1, 1),
 	DEF_FIXED("s3d2",       R8A7795_CLK_S3D2,  CLK_S3,         2, 1),
 	DEF_FIXED("s3d4",       R8A7795_CLK_S3D4,  CLK_S3,         4, 1),
+
+	DEF_SD("sd0",           R8A7795_CLK_SD0,   CLK_PLL1_DIV2, 0x0074),
+	DEF_SD("sd1",           R8A7795_CLK_SD1,   CLK_PLL1_DIV2, 0x0078),
+	DEF_SD("sd2",           R8A7795_CLK_SD2,   CLK_PLL1_DIV2, 0x0268),
+	DEF_SD("sd3",           R8A7795_CLK_SD3,   CLK_PLL1_DIV2, 0x026c),
+
 	DEF_FIXED("cl",         R8A7795_CLK_CL,    CLK_PLL1_DIV2, 48, 1),
 	DEF_FIXED("cp",         R8A7795_CLK_CP,    CLK_EXTAL,      2, 1),
 
@@ -120,6 +128,10 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S3D1),
 	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S3D1),
 	DEF_MOD("scif2",		 310,	R8A7795_CLK_S3D4),
+	DEF_MOD("sdif3",	       	 311,	R8A7795_CLK_SD3),
+	DEF_MOD("sdif2",	       	 312,	R8A7795_CLK_SD2),
+	DEF_MOD("sdif1",	      	 313,	R8A7795_CLK_SD1),
+	DEF_MOD("sdif0",	     	 314,	R8A7795_CLK_SD0),
 	DEF_MOD("pcie1",		 318,	R8A7795_CLK_S3D1),
 	DEF_MOD("pcie0",		 319,	R8A7795_CLK_S3D1),
 	DEF_MOD("intc-ap",		 408,	R8A7795_CLK_S3D1),
@@ -199,6 +211,221 @@ static const unsigned int r8a7795_crit_mod_clks[] __initconst = {
 	MOD_CLK_ID(408),	/* INTC-AP (GIC) */
 };
 
+/* -----------------------------------------------------------------------------
+ * SDn Clock
+ *
+ */
+#define CPG_SD_STP_HCK		BIT(9)
+#define CPG_SD_STP_CK		BIT(8)
+
+#define CPG_SD_STP_MASK		(CPG_SD_STP_HCK | CPG_SD_STP_CK)
+#define CPG_SD_FC_MASK		(0x7 << 2 | 0x3 << 0)
+
+#define CPG_SD_DIV_TABLE_DATA(stp_hck, stp_ck, sd_srcfc, sd_fc, sd_div) \
+{ \
+	.val = ((stp_hck) ? CPG_SD_STP_HCK : 0) | \
+	       ((stp_ck) ? CPG_SD_STP_CK : 0) | \
+	       ((sd_srcfc) << 2) | \
+	       ((sd_fc) << 0), \
+	.div = (sd_div), \
+}
+
+struct sd_div_table {
+	u32 val;
+	unsigned int div;
+};
+
+struct sd_clock {
+	struct clk_hw hw;
+	void __iomem *reg;
+	const struct sd_div_table *div_table;
+	unsigned int div_num;
+	unsigned int div_min;
+	unsigned int div_max;
+};
+
+/* SDn divider
+ *                     sd_srcfc   sd_fc   div
+ * stp_hck   stp_ck    (div)      (div)     = sd_srcfc x sd_fc
+ *-------------------------------------------------------------------
+ *  0         0         0 (1)      1 (4)      4
+ *  0         0         1 (2)      1 (4)      8
+ *  1         0         2 (4)      1 (4)     16
+ *  1         0         3 (8)      1 (4)     32
+ *  1         0         4 (16)     1 (4)     64
+ *  0         0         0 (1)      0 (2)      2
+ *  0         0         1 (2)      0 (2)      4
+ *  1         0         2 (4)      0 (2)      8
+ *  1         0         3 (8)      0 (2)     16
+ *  1         0         4 (16)     0 (2)     32
+ */
+static const struct sd_div_table cpg_sd_div_table[] = {
+/*	CPG_SD_DIV_TABLE_DATA(stp_hck,  stp_ck,   sd_srcfc,   sd_fc,  sd_div) */
+	CPG_SD_DIV_TABLE_DATA(0,        0,        0,          1,        4),
+	CPG_SD_DIV_TABLE_DATA(0,        0,        1,          1,        8),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        2,          1,       16),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        3,          1,       32),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        4,          1,       64),
+	CPG_SD_DIV_TABLE_DATA(0,        0,        0,          0,        2),
+	CPG_SD_DIV_TABLE_DATA(0,        0,        1,          0,        4),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        2,          0,        8),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        3,          0,       16),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        4,          0,       32),
+};
+
+#define to_sd_clock(_hw) container_of(_hw, struct sd_clock, hw)
+
+static int cpg_sd_clock_enable(struct clk_hw *hw)
+{
+	struct sd_clock *clock = to_sd_clock(hw);
+	u32 val, sd_fc;
+	unsigned int i;
+
+	val = clk_readl(clock->reg);
+
+	sd_fc = val & CPG_SD_FC_MASK;
+	for (i = 0; i < clock->div_num; i++)
+		if (sd_fc == (clock->div_table[i].val & CPG_SD_FC_MASK))
+			break;
+
+	if (i >= clock->div_num)
+		return -EINVAL;
+
+	val &= ~(CPG_SD_STP_MASK);
+	val |= clock->div_table[i].val & CPG_SD_STP_MASK;
+
+	clk_writel(val, clock->reg);
+
+	return 0;
+}
+
+static void cpg_sd_clock_disable(struct clk_hw *hw)
+{
+	struct sd_clock *clock = to_sd_clock(hw);
+
+	clk_writel(clk_readl(clock->reg) | CPG_SD_STP_MASK, clock->reg);
+}
+
+static int cpg_sd_clock_is_enabled(struct clk_hw *hw)
+{
+	struct sd_clock *clock = to_sd_clock(hw);
+
+	return !(clk_readl(clock->reg) & CPG_SD_STP_MASK);
+}
+
+static unsigned long cpg_sd_clock_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct sd_clock *clock = to_sd_clock(hw);
+	unsigned long rate = parent_rate;
+	u32 val, sd_fc;
+	unsigned int i;
+
+	val = clk_readl(clock->reg);
+
+	sd_fc = val & CPG_SD_FC_MASK;
+	for (i = 0; i < clock->div_num; i++)
+		if (sd_fc == (clock->div_table[i].val & CPG_SD_FC_MASK))
+			break;
+
+	if (i >= clock->div_num)
+		return -EINVAL;
+
+	return DIV_ROUND_CLOSEST(rate, clock->div_table[i].div);
+}
+
+static unsigned int cpg_sd_clock_calc_div(struct sd_clock *clock,
+					  unsigned long rate,
+					  unsigned long parent_rate)
+{
+	unsigned int div;
+
+	if (!rate)
+		rate = 1;
+
+	div = DIV_ROUND_CLOSEST(parent_rate, rate);
+
+	return clamp_t(unsigned int, div, clock->div_min, clock->div_max);
+}
+
+static long cpg_sd_clock_round_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long *parent_rate)
+{
+	struct sd_clock *clock = to_sd_clock(hw);
+	unsigned int div = cpg_sd_clock_calc_div(clock, rate, *parent_rate);
+
+	return DIV_ROUND_CLOSEST(*parent_rate, div);
+}
+
+static int cpg_sd_clock_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	struct sd_clock *clock = to_sd_clock(hw);
+	unsigned int div = cpg_sd_clock_calc_div(clock, rate, parent_rate);
+	u32 val;
+	unsigned int i;
+
+	for (i = 0; i < clock->div_num; i++)
+		if (div == clock->div_table[i].div)
+			break;
+
+	if (i >= clock->div_num)
+		return -EINVAL;
+
+	val = clk_readl(clock->reg);
+	val &= ~(CPG_SD_STP_MASK | CPG_SD_FC_MASK);
+	val |= clock->div_table[i].val & (CPG_SD_STP_MASK | CPG_SD_FC_MASK);
+	clk_writel(val, clock->reg);
+
+	return 0;
+}
+
+static const struct clk_ops cpg_sd_clock_ops = {
+	.enable = cpg_sd_clock_enable,
+	.disable = cpg_sd_clock_disable,
+	.is_enabled = cpg_sd_clock_is_enabled,
+	.recalc_rate = cpg_sd_clock_recalc_rate,
+	.round_rate = cpg_sd_clock_round_rate,
+	.set_rate = cpg_sd_clock_set_rate,
+};
+
+static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
+					       void __iomem *base,
+					       const char *parent_name)
+{
+	struct clk_init_data init;
+	struct sd_clock *clock;
+	struct clk *clk;
+	unsigned int i;
+
+	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
+	if (!clock)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = core->name;
+	init.ops = &cpg_sd_clock_ops;
+	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	clock->reg = base + core->offset;
+	clock->hw.init = &init;
+	clock->div_table = cpg_sd_div_table;
+	clock->div_num = ARRAY_SIZE(cpg_sd_div_table);
+
+	clock->div_max = clock->div_table[0].div;
+	clock->div_min = clock->div_max;
+	for (i = 1; i < clock->div_num; i++) {
+		clock->div_max = max(clock->div_max, clock->div_table[i].div);
+		clock->div_min = min(clock->div_min, clock->div_table[i].div);
+	}
+
+	clk = clk_register(NULL, &clock->hw);
+	if (IS_ERR(clk))
+		kfree(clock);
+
+	return clk;
+}
 
 #define CPG_PLL0CR	0x00d8
 #define CPG_PLL2CR	0x002c
@@ -324,6 +551,9 @@ struct clk * __init r8a7795_cpg_clk_register(struct device *dev,
 		mult = (((value >> 24) & 0x7f) + 1) * 2;
 		break;
 
+	case CLK_TYPE_GEN3_SD:
+		return cpg_sd_clk_register(core, base, __clk_get_name(parent));
+
 	default:
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/clk/shmobile/renesas-cpg-mssr.h b/drivers/clk/shmobile/renesas-cpg-mssr.h
index e09f03c..952b695 100644
--- a/drivers/clk/shmobile/renesas-cpg-mssr.h
+++ b/drivers/clk/shmobile/renesas-cpg-mssr.h
@@ -53,6 +53,8 @@ enum clk_types {
 	DEF_BASE(_name, _id, CLK_TYPE_FF, _parent, .div = _div, .mult = _mult)
 #define DEF_DIV6P1(_name, _id, _parent, _offset)	\
 	DEF_BASE(_name, _id, CLK_TYPE_DIV6P1, _parent, .offset = _offset)
+#define DEF_SD(_name, _id, _parent, _offset)	\
+	DEF_BASE(_name, _id, CLK_TYPE_GEN3_SD, _parent, .offset = _offset)
 
 
     /*
-- 
2.7.0
