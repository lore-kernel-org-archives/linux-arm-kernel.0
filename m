From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Jan 2018 13:18:35 +0100
Subject: [PATCH v4 1/6] clk: renesas: rcar-gen3: Add Z clock divider support
In-Reply-To: <20180103121840.29316-1-horms+renesas@verge.net.au>
References: <20180103121840.29316-1-horms+renesas@verge.net.au>
Message-ID: <20180103121840.29316-2-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds Z clock divider support for R-Car Gen3 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---

v4 [Simon Horman]
* Rebase
* Divide parent clock by 2 to give correct rate (again)
* Take care not to overflow multiplication on 32 but platforms

v3 [Simon Horman]
* Use DIV_ROUND_CLOSEST_ULL instead of open-coding the same behaviour
  using div_u64()
* Do not round rate to 100MHz in cpg_z_clk_recalc_rate
* Remove calculation for PLL post-divider, this is bogus.
  Instead do not round to closest in cpg_z_clk_round_rate()
* Drop check for !prate in cpg_z_clk_round_rate

v1 [Simon Horman]
* Divide parent clock by 2 to give correct rate
* Use GENMASK, FIELD_{GET,PREP}
* Correct whitespace
* Arrange local variables in reverse Christmas tree order

v0 [Takeshi Kihara]
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 133 ++++++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rcar-gen3-cpg.h |   1 +
 2 files changed, 134 insertions(+)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 0904886f5501..b85918fa62c6 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/bug.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
@@ -62,6 +63,134 @@ static void cpg_simple_notifier_register(struct raw_notifier_head *notifiers,
 }
 
 /*
+ * Z Clock
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare only ensures that parents are prepared
+ * enable - clk_enable only ensures that parents are enabled
+ * rate - rate is adjustable.  clk->rate = (parent->rate * mult / 32 ) / 2
+ * parent - fixed parent.  No clk_set_parent support
+ */
+#define CPG_FRQCRB			0x00000004
+#define CPG_FRQCRB_KICK			BIT(31)
+#define CPG_FRQCRC			0x000000e0
+#define CPG_FRQCRC_ZFC_MASK		GENMASK(12, 8)
+
+struct cpg_z_clk {
+	struct clk_hw hw;
+	void __iomem *reg;
+	void __iomem *kick_reg;
+};
+
+#define to_z_clk(_hw)	container_of(_hw, struct cpg_z_clk, hw)
+
+static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct cpg_z_clk *zclk = to_z_clk(hw);
+	unsigned int mult;
+
+	mult = 32 - FIELD_GET(CPG_FRQCRC_ZFC_MASK, clk_readl(zclk->reg));
+
+	/* Factor of 2 is for fixed divider */
+	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, 32 * 2);
+}
+
+static long cpg_z_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *parent_rate)
+{
+	/* Factor of 2 is for fixed divider */
+	unsigned long prate = *parent_rate / 2;
+	unsigned int mult;
+
+	mult = div_u64(rate * 32ULL, prate);
+	mult = clamp(mult, 1U, 32U);
+
+	return (u64)prate * mult / 32;
+}
+
+static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct cpg_z_clk *zclk = to_z_clk(hw);
+	unsigned int mult;
+	unsigned int i;
+	u32 val, kick;
+
+	/* Factor of 2 is for fixed divider */
+	mult = DIV_ROUND_CLOSEST_ULL(rate * 32ULL * 2, parent_rate);
+	mult = clamp(mult, 1U, 32U);
+
+	if (clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
+		return -EBUSY;
+
+	val = clk_readl(zclk->reg) & ~CPG_FRQCRC_ZFC_MASK;
+	val |= FIELD_PREP(CPG_FRQCRC_ZFC_MASK, 32 - mult);
+	clk_writel(val, zclk->reg);
+
+	/*
+	 * Set KICK bit in FRQCRB to update hardware setting and wait for
+	 * clock change completion.
+	 */
+	kick = clk_readl(zclk->kick_reg);
+	kick |= CPG_FRQCRB_KICK;
+	clk_writel(kick, zclk->kick_reg);
+
+	/*
+	 * Note: There is no HW information about the worst case latency.
+	 *
+	 * Using experimental measurements, it seems that no more than
+	 * ~10 iterations are needed, independently of the CPU rate.
+	 * Since this value might be dependent of external xtal rate, pll1
+	 * rate or even the other emulation clocks rate, use 1000 as a
+	 * "super" safe value.
+	 */
+	for (i = 1000; i; i--) {
+		if (!(clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK))
+			return 0;
+
+		cpu_relax();
+	}
+
+	return -ETIMEDOUT;
+}
+
+static const struct clk_ops cpg_z_clk_ops = {
+	.recalc_rate = cpg_z_clk_recalc_rate,
+	.round_rate = cpg_z_clk_round_rate,
+	.set_rate = cpg_z_clk_set_rate,
+};
+
+static struct clk * __init cpg_z_clk_register(const char *name,
+					      const char *parent_name,
+					      void __iomem *reg)
+{
+	struct clk_init_data init;
+	struct cpg_z_clk *zclk;
+	struct clk *clk;
+
+	zclk = kzalloc(sizeof(*zclk), GFP_KERNEL);
+	if (!zclk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &cpg_z_clk_ops;
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	zclk->reg = reg + CPG_FRQCRC;
+	zclk->kick_reg = reg + CPG_FRQCRB;
+	zclk->hw.init = &init;
+
+	clk = clk_register(NULL, &zclk->hw);
+	if (IS_ERR(clk))
+		kfree(zclk);
+
+	return clk;
+}
+
+/*
  * SDn Clock
  */
 #define CPG_SD_STP_HCK		BIT(9)
@@ -420,6 +549,10 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 		mult = 1;
 		break;
 
+	case CLK_TYPE_GEN3_Z:
+		return cpg_z_clk_register(core->name, __clk_get_name(parent),
+					  base);
+
 	default:
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index 2e4284399f53..c73d4d6fdc85 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -21,6 +21,7 @@ enum rcar_gen3_clk_types {
 	CLK_TYPE_GEN3_SD,
 	CLK_TYPE_GEN3_R,
 	CLK_TYPE_GEN3_PE,
+	CLK_TYPE_GEN3_Z,
 };
 
 #define DEF_GEN3_SD(_name, _id, _parent, _offset)	\
-- 
2.11.0
