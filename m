From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:12:56 +0100
Subject: [PATCH v2 03/11] clk: berlin: use regmap
In-Reply-To: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654784-27354-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin clock driver was sharing a DT node with the pin controller
and the reset driver. All these device are now a sub-node of the chip
and system controllers and a regmap is available thanks to syscon to
access the registers safely.

Rework the Berlin clock driver to use the regmap provided by syscon.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/clk/berlin/berlin2-avpll.c |  72 +++++++++++++-----------
 drivers/clk/berlin/berlin2-avpll.h |  13 +++--
 drivers/clk/berlin/berlin2-div.c   |  82 +++++++++------------------
 drivers/clk/berlin/berlin2-div.h   |   4 +-
 drivers/clk/berlin/berlin2-pll.c   |  16 ++++--
 drivers/clk/berlin/berlin2-pll.h   |   7 ++-
 drivers/clk/berlin/bg2.c           | 112 +++++++++++++++++++------------------
 drivers/clk/berlin/bg2q.c          |  64 +++++++++++++--------
 8 files changed, 188 insertions(+), 182 deletions(-)

diff --git a/drivers/clk/berlin/berlin2-avpll.c b/drivers/clk/berlin/berlin2-avpll.c
index fd0f26c38465..7244afb2251f 100644
--- a/drivers/clk/berlin/berlin2-avpll.c
+++ b/drivers/clk/berlin/berlin2-avpll.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include "berlin2-avpll.h"
@@ -115,7 +116,8 @@
 
 struct berlin2_avpll_vco {
 	struct clk_hw hw;
-	void __iomem *base;
+	struct regmap *regmap;
+	unsigned int offset;
 	u8 flags;
 };
 
@@ -126,7 +128,7 @@ static int berlin2_avpll_vco_is_enabled(struct clk_hw *hw)
 	struct berlin2_avpll_vco *vco = to_avpll_vco(hw);
 	u32 reg;
 
-	reg = readl_relaxed(vco->base + VCO_CTRL0);
+	regmap_read(vco->regmap, vco->offset + VCO_CTRL0, &reg);
 	if (vco->flags & BERLIN2_AVPLL_BIT_QUIRK)
 		reg >>= 4;
 
@@ -138,12 +140,12 @@ static int berlin2_avpll_vco_enable(struct clk_hw *hw)
 	struct berlin2_avpll_vco *vco = to_avpll_vco(hw);
 	u32 reg;
 
-	reg = readl_relaxed(vco->base + VCO_CTRL0);
+	regmap_read(vco->regmap, vco->offset + VCO_CTRL0, &reg);
 	if (vco->flags & BERLIN2_AVPLL_BIT_QUIRK)
 		reg |= VCO_POWERUP << 4;
 	else
 		reg |= VCO_POWERUP;
-	writel_relaxed(reg, vco->base + VCO_CTRL0);
+	regmap_write(vco->regmap, vco->offset + VCO_CTRL0, reg);
 
 	return 0;
 }
@@ -153,12 +155,12 @@ static void berlin2_avpll_vco_disable(struct clk_hw *hw)
 	struct berlin2_avpll_vco *vco = to_avpll_vco(hw);
 	u32 reg;
 
-	reg = readl_relaxed(vco->base + VCO_CTRL0);
+	regmap_read(vco->regmap, vco->offset + VCO_CTRL0, &reg);
 	if (vco->flags & BERLIN2_AVPLL_BIT_QUIRK)
 		reg &= ~(VCO_POWERUP << 4);
 	else
 		reg &= ~VCO_POWERUP;
-	writel_relaxed(reg, vco->base + VCO_CTRL0);
+	regmap_write(vco->regmap, vco->offset + VCO_CTRL0, reg);
 }
 
 static u8 vco_refdiv[] = { 1, 2, 4, 3 };
@@ -171,7 +173,7 @@ berlin2_avpll_vco_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	u64 freq = parent_rate;
 
 	/* AVPLL VCO frequency: Fvco = (Fref / refdiv) * fbdiv */
-	reg = readl_relaxed(vco->base + VCO_CTRL1);
+	regmap_read(vco->regmap, vco->offset + VCO_CTRL1, &reg);
 	refdiv = (reg & VCO_REFDIV_MASK) >> VCO_REFDIV_SHIFT;
 	refdiv = vco_refdiv[refdiv];
 	fbdiv = (reg & VCO_FBDIV_MASK) >> VCO_FBDIV_SHIFT;
@@ -188,9 +190,10 @@ static const struct clk_ops berlin2_avpll_vco_ops = {
 	.recalc_rate	= berlin2_avpll_vco_recalc_rate,
 };
 
-struct clk * __init berlin2_avpll_vco_register(void __iomem *base,
-			       const char *name, const char *parent_name,
-			       u8 vco_flags, unsigned long flags)
+struct clk * __init berlin2_avpll_vco_register(struct regmap *regmap,
+			       unsigned int offset, const char *name,
+			       const char *parent_name, u8 vco_flags,
+			       unsigned long flags)
 {
 	struct berlin2_avpll_vco *vco;
 	struct clk_init_data init;
@@ -199,7 +202,8 @@ struct clk * __init berlin2_avpll_vco_register(void __iomem *base,
 	if (!vco)
 		return ERR_PTR(-ENOMEM);
 
-	vco->base = base;
+	vco->regmap = regmap;
+	vco->offset = offset;
 	vco->flags = vco_flags;
 	vco->hw.init = &init;
 	init.name = name;
@@ -213,7 +217,8 @@ struct clk * __init berlin2_avpll_vco_register(void __iomem *base,
 
 struct berlin2_avpll_channel {
 	struct clk_hw hw;
-	void __iomem *base;
+	struct regmap *regmap;
+	unsigned int offset;
 	u8 flags;
 	u8 index;
 };
@@ -228,7 +233,7 @@ static int berlin2_avpll_channel_is_enabled(struct clk_hw *hw)
 	if (ch->index == 7)
 		return 1;
 
-	reg = readl_relaxed(ch->base + VCO_CTRL10);
+	regmap_read(ch->regmap, ch->offset + VCO_CTRL10, &reg);
 	reg &= VCO_POWERUP_CH1 << ch->index;
 
 	return !!reg;
@@ -239,9 +244,9 @@ static int berlin2_avpll_channel_enable(struct clk_hw *hw)
 	struct berlin2_avpll_channel *ch = to_avpll_channel(hw);
 	u32 reg;
 
-	reg = readl_relaxed(ch->base + VCO_CTRL10);
+	regmap_read(ch->regmap, ch->offset + VCO_CTRL10, &reg);
 	reg |= VCO_POWERUP_CH1 << ch->index;
-	writel_relaxed(reg, ch->base + VCO_CTRL10);
+	regmap_write(ch->regmap, ch->offset + VCO_CTRL10, reg);
 
 	return 0;
 }
@@ -251,9 +256,9 @@ static void berlin2_avpll_channel_disable(struct clk_hw *hw)
 	struct berlin2_avpll_channel *ch = to_avpll_channel(hw);
 	u32 reg;
 
-	reg = readl_relaxed(ch->base + VCO_CTRL10);
+	regmap_read(ch->regmap, ch->offset + VCO_CTRL10, &reg);
 	reg &= ~(VCO_POWERUP_CH1 << ch->index);
-	writel_relaxed(reg, ch->base + VCO_CTRL10);
+	regmap_write(ch->regmap, ch->offset + VCO_CTRL10, reg);
 }
 
 static const u8 div_hdmi[] = { 1, 2, 4, 6 };
@@ -266,7 +271,7 @@ berlin2_avpll_channel_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	u32 reg, div_av2, div_av3, divider = 1;
 	u64 freq = parent_rate;
 
-	reg = readl_relaxed(ch->base + VCO_CTRL30);
+	regmap_read(ch->regmap, ch->offset + VCO_CTRL30, &reg);
 	if ((reg & (VCO_DPLL_CH1_ENABLE << ch->index)) == 0)
 		goto skip_div;
 
@@ -275,13 +280,13 @@ berlin2_avpll_channel_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	 *    (sync1 * div_hdmi * div_av1 * div_av2 * div_av3)
 	 */
 
-	reg = readl_relaxed(ch->base + VCO_SYNC1n(ch->index));
+	regmap_read(ch->regmap, ch->offset + VCO_SYNC1n(ch->index), &reg);
 	/* BG2/BG2CDs SYNC1 reg on AVPLL_B channel 1 is shifted by 4 */
 	if (ch->flags & BERLIN2_AVPLL_BIT_QUIRK && ch->index == 0)
 		reg >>= 4;
 	divider = reg & VCO_SYNC1_MASK;
 
-	reg = readl_relaxed(ch->base + VCO_SYNC2n(ch->index));
+	regmap_read(ch->regmap, ch->offset + VCO_SYNC2n(ch->index), &reg);
 	freq *= reg & VCO_SYNC2_MASK;
 
 	/* Channel 8 has no dividers */
@@ -292,7 +297,8 @@ berlin2_avpll_channel_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	 * HDMI divider start at VCO_CTRL11, bit 7; MSB is enable, lower 2 bit
 	 * determine divider.
 	 */
-	reg = readl_relaxed(ch->base + VCO_CTRL11) >> 7;
+	regmap_read(ch->regmap, ch->offset + VCO_CTRL11, &reg);
+	reg >>= 7;
 	reg = (reg >> (ch->index * 3));
 	if (reg & BIT(2))
 		divider *= div_hdmi[reg & 0x3];
@@ -302,10 +308,10 @@ berlin2_avpll_channel_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	 * determine divider.
 	 */
 	if (ch->index == 0) {
-		reg = readl_relaxed(ch->base + VCO_CTRL11);
+		regmap_read(ch->regmap, ch->offset + VCO_CTRL11, &reg);
 		reg >>= 28;
 	} else {
-		reg = readl_relaxed(ch->base + VCO_CTRL12);
+		regmap_read(ch->regmap, ch->offset + VCO_CTRL12, &reg);
 		reg >>= (ch->index-1) * 3;
 	}
 	if (reg & BIT(2))
@@ -316,13 +322,13 @@ berlin2_avpll_channel_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	 * zero is not a valid value.
 	 */
 	if (ch->index < 2) {
-		reg = readl_relaxed(ch->base + VCO_CTRL12);
+		regmap_read(ch->regmap, ch->offset + VCO_CTRL12, &reg);
 		reg >>= 18 + (ch->index * 7);
 	} else if (ch->index < 7) {
-		reg = readl_relaxed(ch->base + VCO_CTRL13);
+		regmap_read(ch->regmap, ch->offset + VCO_CTRL13, &reg);
 		reg >>= (ch->index - 2) * 7;
 	} else {
-		reg = readl_relaxed(ch->base + VCO_CTRL14);
+		regmap_read(ch->regmap, ch->offset + VCO_CTRL14, &reg);
 	}
 	div_av2 = reg & 0x7f;
 	if (div_av2)
@@ -334,10 +340,10 @@ berlin2_avpll_channel_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	 * are allowed. AV3 != 0 divides by AV2/2, AV3=0 is bypass.
 	 */
 	if (ch->index < 6) {
-		reg = readl_relaxed(ch->base + VCO_CTRL14);
+		regmap_read(ch->regmap, ch->offset + VCO_CTRL14, &reg);
 		reg >>= 7 + (ch->index * 4);
 	} else {
-		reg = readl_relaxed(ch->base + VCO_CTRL15);
+		regmap_read(ch->regmap, ch->offset + VCO_CTRL15, &reg);
 	}
 	div_av3 = reg & 0xf;
 	if (div_av2 && div_av3)
@@ -364,9 +370,10 @@ static const struct clk_ops berlin2_avpll_channel_ops = {
  */
 static const u8 quirk_index[] __initconst = { 0, 6, 5, 4, 3, 2, 1, 7 };
 
-struct clk * __init berlin2_avpll_channel_register(void __iomem *base,
-			   const char *name, u8 index, const char *parent_name,
-			   u8 ch_flags, unsigned long flags)
+struct clk * __init berlin2_avpll_channel_register(struct regmap *regmap,
+			   unsigned int offset, const char *name, u8 index,
+			   const char *parent_name, u8 ch_flags,
+			   unsigned long flags)
 {
 	struct berlin2_avpll_channel *ch;
 	struct clk_init_data init;
@@ -375,7 +382,8 @@ struct clk * __init berlin2_avpll_channel_register(void __iomem *base,
 	if (!ch)
 		return ERR_PTR(-ENOMEM);
 
-	ch->base = base;
+	ch->regmap = regmap;
+	ch->offset = offset;
 	if (ch_flags & BERLIN2_AVPLL_SCRAMBLE_QUIRK)
 		ch->index = quirk_index[index];
 	else
diff --git a/drivers/clk/berlin/berlin2-avpll.h b/drivers/clk/berlin/berlin2-avpll.h
index a37f5068d299..cdc2c5bd4706 100644
--- a/drivers/clk/berlin/berlin2-avpll.h
+++ b/drivers/clk/berlin/berlin2-avpll.h
@@ -19,18 +19,21 @@
 #ifndef __BERLIN2_AVPLL_H
 #define __BERLIN2_AVPLL_H
 
+#include <linux/regmap.h>
+
 struct clk;
 
 #define BERLIN2_AVPLL_BIT_QUIRK		BIT(0)
 #define BERLIN2_AVPLL_SCRAMBLE_QUIRK	BIT(1)
 
 struct clk * __init
-berlin2_avpll_vco_register(void __iomem *base, const char *name,
-	   const char *parent_name, u8 vco_flags, unsigned long flags);
+berlin2_avpll_vco_register(struct regmap *regmap, unsigned int offset,
+	   const char *name, const char *parent_name, u8 vco_flags,
+	   unsigned long flags);
 
 struct clk * __init
-berlin2_avpll_channel_register(void __iomem *base, const char *name,
-		       u8 index, const char *parent_name, u8 ch_flags,
-		       unsigned long flags);
+berlin2_avpll_channel_register(struct regmap *regmap, unsigned int offset,
+		       const char *name, u8 index, const char *parent_name,
+		       u8 ch_flags, unsigned long flags);
 
 #endif /* __BERLIN2_AVPLL_H */
diff --git a/drivers/clk/berlin/berlin2-div.c b/drivers/clk/berlin/berlin2-div.c
index 81ff97f8aa0b..ff708fe831d0 100644
--- a/drivers/clk/berlin/berlin2-div.c
+++ b/drivers/clk/berlin/berlin2-div.c
@@ -20,6 +20,7 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -63,9 +64,8 @@
 
 struct berlin2_div {
 	struct clk_hw hw;
-	void __iomem *base;
+	struct regmap *regmap;
 	struct berlin2_div_map map;
-	spinlock_t *lock;
 };
 
 #define to_berlin2_div(hw) container_of(hw, struct berlin2_div, hw)
@@ -78,15 +78,9 @@ static int berlin2_div_is_enabled(struct clk_hw *hw)
 	struct berlin2_div_map *map = &div->map;
 	u32 reg;
 
-	if (div->lock)
-		spin_lock(div->lock);
-
-	reg = readl_relaxed(div->base + map->gate_offs);
+	regmap_read(div->regmap, map->gate_offs, &reg);
 	reg >>= map->gate_shift;
 
-	if (div->lock)
-		spin_unlock(div->lock);
-
 	return (reg & 0x1);
 }
 
@@ -96,15 +90,9 @@ static int berlin2_div_enable(struct clk_hw *hw)
 	struct berlin2_div_map *map = &div->map;
 	u32 reg;
 
-	if (div->lock)
-		spin_lock(div->lock);
-
-	reg = readl_relaxed(div->base + map->gate_offs);
+	regmap_read(div->regmap, map->gate_offs, &reg);
 	reg |= BIT(map->gate_shift);
-	writel_relaxed(reg, div->base + map->gate_offs);
-
-	if (div->lock)
-		spin_unlock(div->lock);
+	regmap_write(div->regmap, map->gate_offs, reg);
 
 	return 0;
 }
@@ -115,15 +103,9 @@ static void berlin2_div_disable(struct clk_hw *hw)
 	struct berlin2_div_map *map = &div->map;
 	u32 reg;
 
-	if (div->lock)
-		spin_lock(div->lock);
-
-	reg = readl_relaxed(div->base + map->gate_offs);
+	regmap_read(div->regmap, map->gate_offs, &reg);
 	reg &= ~BIT(map->gate_shift);
-	writel_relaxed(reg, div->base + map->gate_offs);
-
-	if (div->lock)
-		spin_unlock(div->lock);
+	regmap_write(div->regmap, map->gate_offs, reg);
 }
 
 static int berlin2_div_set_parent(struct clk_hw *hw, u8 index)
@@ -132,28 +114,24 @@ static int berlin2_div_set_parent(struct clk_hw *hw, u8 index)
 	struct berlin2_div_map *map = &div->map;
 	u32 reg;
 
-	if (div->lock)
-		spin_lock(div->lock);
-
 	/* index == 0 is PLL_SWITCH */
-	reg = readl_relaxed(div->base + map->pll_switch_offs);
+	regmap_read(div->regmap, map->pll_switch_offs, &reg);
 	if (index == 0)
 		reg &= ~BIT(map->pll_switch_shift);
 	else
 		reg |= BIT(map->pll_switch_shift);
-	writel_relaxed(reg, div->base + map->pll_switch_offs);
+	regmap_write(div->regmap, map->pll_switch_offs, reg);
 
 	/* index > 0 is PLL_SELECT */
 	if (index > 0) {
-		reg = readl_relaxed(div->base + map->pll_select_offs);
+		regmap_read(div->regmap, map->pll_switch_offs,
+			    &reg);
 		reg &= ~(PLL_SELECT_MASK << map->pll_select_shift);
 		reg |= (index - 1) << map->pll_select_shift;
-		writel_relaxed(reg, div->base + map->pll_select_offs);
+		regmap_write(div->regmap, map->pll_switch_offs,
+			     reg);
 	}
 
-	if (div->lock)
-		spin_unlock(div->lock);
-
 	return 0;
 }
 
@@ -164,22 +142,17 @@ static u8 berlin2_div_get_parent(struct clk_hw *hw)
 	u32 reg;
 	u8 index = 0;
 
-	if (div->lock)
-		spin_lock(div->lock);
-
 	/* PLL_SWITCH == 0 is index 0 */
-	reg = readl_relaxed(div->base + map->pll_switch_offs);
+	regmap_read(div->regmap, map->pll_switch_offs, &reg);
 	reg &= BIT(map->pll_switch_shift);
 	if (reg) {
-		reg = readl_relaxed(div->base + map->pll_select_offs);
+		regmap_read(div->regmap, map->pll_switch_offs,
+			    &reg);
 		reg >>= map->pll_select_shift;
 		reg &= PLL_SELECT_MASK;
 		index = 1 + reg;
 	}
 
-	if (div->lock)
-		spin_unlock(div->lock);
-
 	return index;
 }
 
@@ -190,13 +163,11 @@ static unsigned long berlin2_div_recalc_rate(struct clk_hw *hw,
 	struct berlin2_div_map *map = &div->map;
 	u32 divsw, div3sw, divider = 1;
 
-	if (div->lock)
-		spin_lock(div->lock);
+	regmap_read(div->regmap, map->div_switch_offs, &divsw);
+	divsw &= (1 << map->div_switch_shift);
 
-	divsw = readl_relaxed(div->base + map->div_switch_offs) &
-		(1 << map->div_switch_shift);
-	div3sw = readl_relaxed(div->base + map->div3_switch_offs) &
-		(1 << map->div3_switch_shift);
+	regmap_read(div->regmap, map->div3_switch_offs, &div3sw);
+	div3sw &= (1 << map->div3_switch_shift);
 
 	/* constant divide-by-3 (dominant) */
 	if (div3sw != 0) {
@@ -207,15 +178,13 @@ static unsigned long berlin2_div_recalc_rate(struct clk_hw *hw,
 	/* clock divider determined by DIV_SELECT */
 	} else {
 		u32 reg;
-		reg = readl_relaxed(div->base + map->div_select_offs);
+		regmap_read(div->regmap, map->div_select_offs,
+			    &reg);
 		reg >>= map->div_select_shift;
 		reg &= DIV_SELECT_MASK;
 		divider = clk_div[reg];
 	}
 
-	if (div->lock)
-		spin_unlock(div->lock);
-
 	return parent_rate / divider;
 }
 
@@ -236,9 +205,9 @@ static const struct clk_ops berlin2_div_mux_ops = {
 
 struct clk * __init
 berlin2_div_register(const struct berlin2_div_map *map,
-		     void __iomem *base, const char *name, u8 div_flags,
+		     struct regmap *regmap, const char *name, u8 div_flags,
 		     const char **parent_names, int num_parents,
-		     unsigned long flags, spinlock_t *lock)
+		     unsigned long flags)
 {
 	const struct clk_ops *mux_ops = &berlin2_div_mux_ops;
 	const struct clk_ops *rate_ops = &berlin2_div_rate_ops;
@@ -251,8 +220,7 @@ berlin2_div_register(const struct berlin2_div_map *map,
 
 	/* copy div_map to allow __initconst */
 	memcpy(&div->map, map, sizeof(*map));
-	div->base = base;
-	div->lock = lock;
+	div->regmap = regmap;
 
 	if ((div_flags & BERLIN2_DIV_HAS_GATE) == 0)
 		gate_ops = NULL;
diff --git a/drivers/clk/berlin/berlin2-div.h b/drivers/clk/berlin/berlin2-div.h
index 15e3384f3116..8b726561cd00 100644
--- a/drivers/clk/berlin/berlin2-div.h
+++ b/drivers/clk/berlin/berlin2-div.h
@@ -82,8 +82,8 @@ struct berlin2_div_data {
 
 struct clk * __init
 berlin2_div_register(const struct berlin2_div_map *map,
-	     void __iomem *base,  const char *name, u8 div_flags,
+	     struct regmap *regmap, const char *name, u8 div_flags,
 	     const char **parent_names, int num_parents,
-	     unsigned long flags,  spinlock_t *lock);
+	     unsigned long flags);
 
 #endif /* __BERLIN2_DIV_H */
diff --git a/drivers/clk/berlin/berlin2-pll.c b/drivers/clk/berlin/berlin2-pll.c
index bdc506b03824..96fbb643d37d 100644
--- a/drivers/clk/berlin/berlin2-pll.c
+++ b/drivers/clk/berlin/berlin2-pll.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <asm/div64.h>
 
@@ -36,7 +37,8 @@ struct berlin2_pll_map {
 
 struct berlin2_pll {
 	struct clk_hw hw;
-	void __iomem *base;
+	struct regmap *regmap;
+	unsigned int offset;
 	struct berlin2_pll_map map;
 };
 
@@ -64,7 +66,7 @@ berlin2_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	u32 val, fbdiv, rfdiv, vcodivsel, vcodiv;
 	u64 rate = parent_rate;
 
-	val = readl_relaxed(pll->base + SPLL_CTRL0);
+	regmap_read(pll->regmap, SPLL_CTRL0, &val);
 	fbdiv = (val >> map->fbdiv_shift) & FBDIV_MASK;
 	rfdiv = (val >> map->rfdiv_shift) & RFDIV_MASK;
 	if (rfdiv == 0) {
@@ -72,7 +74,7 @@ berlin2_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 		rfdiv = 1;
 	}
 
-	val = readl_relaxed(pll->base + SPLL_CTRL1);
+	regmap_read(pll->regmap, SPLL_CTRL1, &val);
 	vcodivsel = (val >> map->divsel_shift) & DIVSEL_MASK;
 	vcodiv = map->vcodiv[vcodivsel];
 	if (vcodiv == 0) {
@@ -93,8 +95,9 @@ static const struct clk_ops berlin2_pll_ops = {
 
 struct clk * __init
 berlin2_pll_register(const struct berlin2_pll_map *map,
-		     void __iomem *base, const char *name,
-		     const char *parent_name, unsigned long flags)
+		     struct regmap *regmap, unsigned int offset,
+		     const char *name, const char *parent_name,
+		     unsigned long flags)
 {
 	struct clk_init_data init;
 	struct berlin2_pll *pll;
@@ -105,7 +108,8 @@ berlin2_pll_register(const struct berlin2_pll_map *map,
 
 	/* copy pll_map to allow __initconst */
 	memcpy(&pll->map, map, sizeof(*map));
-	pll->base = base;
+	pll->regmap = regmap;
+	pll->offset = offset;
 	pll->hw.init = &init;
 	init.name = name;
 	init.ops = &berlin2_pll_ops;
diff --git a/drivers/clk/berlin/berlin2-pll.h b/drivers/clk/berlin/berlin2-pll.h
index 8831ce27ac1e..9e2f6b172e51 100644
--- a/drivers/clk/berlin/berlin2-pll.h
+++ b/drivers/clk/berlin/berlin2-pll.h
@@ -19,6 +19,8 @@
 #ifndef __BERLIN2_PLL_H
 #define __BERLIN2_PLL_H
 
+#include <linux/regmap.h>
+
 struct clk;
 
 struct berlin2_pll_map {
@@ -31,7 +33,8 @@ struct berlin2_pll_map {
 
 struct clk * __init
 berlin2_pll_register(const struct berlin2_pll_map *map,
-		     void __iomem *base, const char *name,
-		     const char *parent_name, unsigned long flags);
+		     struct regmap *regmap, unsigned int offset,
+		     const char *name, const char *parent_name,
+		     unsigned long flags);
 
 #endif /* __BERLIN2_PLL_H */
diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
index 515fb133495c..d6a379ac01a6 100644
--- a/drivers/clk/berlin/bg2.c
+++ b/drivers/clk/berlin/bg2.c
@@ -20,8 +20,10 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/clock/berlin2.h>
@@ -94,8 +96,6 @@
 #define	MAX_CLKS 41
 static struct clk *clks[MAX_CLKS];
 static struct clk_onecell_data clk_data;
-static DEFINE_SPINLOCK(lock);
-static void __iomem *gbase;
 
 enum {
 	REFCLK, VIDEO_EXT0,
@@ -502,14 +502,19 @@ static const struct berlin2_gate_data bg2_gates[] __initconst = {
 
 static void __init berlin2_clock_setup(struct device_node *np)
 {
+	struct device_node *parent_np = of_get_parent(np);
+	struct regmap *regmap;
 	const char *parent_names[9];
 	struct clk *clk;
 	u8 avpll_flags = 0;
 	int n;
 
-	gbase = of_iomap(np, 0);
-	if (!gbase)
+	regmap = syscon_node_to_regmap(parent_np);
+	of_node_put(parent_np);
+	if (IS_ERR(regmap)) {
+		pr_err("Unable to retrieve regmap: %ld\n", PTR_ERR(regmap));
 		return;
+	}
 
 	/* overwrite default clock names with DT provided ones */
 	clk = of_clk_get_by_name(np, clk_names[REFCLK]);
@@ -525,119 +530,119 @@ static void __init berlin2_clock_setup(struct device_node *np)
 	}
 
 	/* simple register PLLs */
-	clk = berlin2_pll_register(&bg2_pll_map, gbase + REG_SYSPLLCTL0,
+	clk = berlin2_pll_register(&bg2_pll_map, regmap, REG_SYSPLLCTL0,
 				   clk_names[SYSPLL], clk_names[REFCLK], 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 
-	clk = berlin2_pll_register(&bg2_pll_map, gbase + REG_MEMPLLCTL0,
+	clk = berlin2_pll_register(&bg2_pll_map, regmap, REG_MEMPLLCTL0,
 				   clk_names[MEMPLL], clk_names[REFCLK], 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 
-	clk = berlin2_pll_register(&bg2_pll_map, gbase + REG_CPUPLLCTL0,
+	clk = berlin2_pll_register(&bg2_pll_map, regmap, REG_CPUPLLCTL0,
 				   clk_names[CPUPLL], clk_names[REFCLK], 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 
 	if (of_device_is_compatible(np, "marvell,berlin2-global-register"))
 		avpll_flags |= BERLIN2_AVPLL_SCRAMBLE_QUIRK;
 
 	/* audio/video VCOs */
-	clk = berlin2_avpll_vco_register(gbase + REG_AVPLLCTL0, "avpll_vcoA",
+	clk = berlin2_avpll_vco_register(regmap, REG_AVPLLCTL0, "avpll_vcoA",
 			 clk_names[REFCLK], avpll_flags, 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 
 	for (n = 0; n < 8; n++) {
-		clk = berlin2_avpll_channel_register(gbase + REG_AVPLLCTL0,
+		clk = berlin2_avpll_channel_register(regmap, REG_AVPLLCTL0,
 			     clk_names[AVPLL_A1 + n], n, "avpll_vcoA",
 			     avpll_flags, 0);
 		if (IS_ERR(clk))
-			goto bg2_fail;
+			return;
 	}
 
-	clk = berlin2_avpll_vco_register(gbase + REG_AVPLLCTL31, "avpll_vcoB",
+	clk = berlin2_avpll_vco_register(regmap, REG_AVPLLCTL31, "avpll_vcoB",
 				 clk_names[REFCLK], BERLIN2_AVPLL_BIT_QUIRK |
 				 avpll_flags, 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 
 	for (n = 0; n < 8; n++) {
-		clk = berlin2_avpll_channel_register(gbase + REG_AVPLLCTL31,
+		clk = berlin2_avpll_channel_register(regmap, REG_AVPLLCTL31,
 			     clk_names[AVPLL_B1 + n], n, "avpll_vcoB",
 			     BERLIN2_AVPLL_BIT_QUIRK | avpll_flags, 0);
 		if (IS_ERR(clk))
-			goto bg2_fail;
+			return;
 	}
 
 	/* reference clock bypass switches */
 	parent_names[0] = clk_names[SYSPLL];
 	parent_names[1] = clk_names[REFCLK];
-	clk = clk_register_mux(NULL, "syspll_byp", parent_names, 2,
-			       0, gbase + REG_CLKSWITCH0, 0, 1, 0, &lock);
+	clk = clk_register_mux_regmap(NULL, "syspll_byp", parent_names, 2,
+				      0, regmap, REG_CLKSWITCH0, 0, 1, 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 	clk_names[SYSPLL] = __clk_get_name(clk);
 
 	parent_names[0] = clk_names[MEMPLL];
 	parent_names[1] = clk_names[REFCLK];
-	clk = clk_register_mux(NULL, "mempll_byp", parent_names, 2,
-			       0, gbase + REG_CLKSWITCH0, 1, 1, 0, &lock);
+	clk = clk_register_mux_regmap(NULL, "mempll_byp", parent_names, 2,
+				      0, regmap, REG_CLKSWITCH0, 1, 1, 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 	clk_names[MEMPLL] = __clk_get_name(clk);
 
 	parent_names[0] = clk_names[CPUPLL];
 	parent_names[1] = clk_names[REFCLK];
-	clk = clk_register_mux(NULL, "cpupll_byp", parent_names, 2,
-			       0, gbase + REG_CLKSWITCH0, 2, 1, 0, &lock);
+	clk = clk_register_mux_regmap(NULL, "cpupll_byp", parent_names, 2,
+				      0, regmap, REG_CLKSWITCH0, 2, 1, 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 	clk_names[CPUPLL] = __clk_get_name(clk);
 
 	/* clock muxes */
 	parent_names[0] = clk_names[AVPLL_B3];
 	parent_names[1] = clk_names[AVPLL_A3];
-	clk = clk_register_mux(NULL, clk_names[AUDIO1_PLL], parent_names, 2,
-			       0, gbase + REG_CLKSELECT2, 29, 1, 0, &lock);
+	clk = clk_register_mux_regmap(NULL, clk_names[AUDIO1_PLL], parent_names,
+				      2, 0, regmap, REG_CLKSELECT2, 29, 1, 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 
 	parent_names[0] = clk_names[VIDEO0_PLL];
 	parent_names[1] = clk_names[VIDEO_EXT0];
-	clk = clk_register_mux(NULL, clk_names[VIDEO0_IN], parent_names, 2,
-			       0, gbase + REG_CLKSELECT3, 4, 1, 0, &lock);
+	clk = clk_register_mux_regmap(NULL, clk_names[VIDEO0_IN], parent_names,
+				      2, 0, regmap, REG_CLKSELECT3, 4, 1, 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 
 	parent_names[0] = clk_names[VIDEO1_PLL];
 	parent_names[1] = clk_names[VIDEO_EXT0];
-	clk = clk_register_mux(NULL, clk_names[VIDEO1_IN], parent_names, 2,
-			       0, gbase + REG_CLKSELECT3, 6, 1, 0, &lock);
+	clk = clk_register_mux_regmap(NULL, clk_names[VIDEO1_IN], parent_names,
+				      2, 0, regmap, REG_CLKSELECT3, 6, 1, 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 
 	parent_names[0] = clk_names[AVPLL_A2];
 	parent_names[1] = clk_names[AVPLL_B2];
-	clk = clk_register_mux(NULL, clk_names[VIDEO1_PLL], parent_names, 2,
-			       0, gbase + REG_CLKSELECT3, 7, 1, 0, &lock);
+	clk = clk_register_mux_regmap(NULL, clk_names[VIDEO1_PLL], parent_names,
+				      2, 0,regmap, REG_CLKSELECT3, 7, 1, 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 
 	parent_names[0] = clk_names[VIDEO2_PLL];
 	parent_names[1] = clk_names[VIDEO_EXT0];
-	clk = clk_register_mux(NULL, clk_names[VIDEO2_IN], parent_names, 2,
-			       0, gbase + REG_CLKSELECT3, 9, 1, 0, &lock);
+	clk = clk_register_mux_regmap(NULL, clk_names[VIDEO2_IN], parent_names,
+				      2, 0, regmap, REG_CLKSELECT3, 9, 1, 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 
 	parent_names[0] = clk_names[AVPLL_B1];
 	parent_names[1] = clk_names[AVPLL_A5];
-	clk = clk_register_mux(NULL, clk_names[VIDEO2_PLL], parent_names, 2,
-			       0, gbase + REG_CLKSELECT3, 10, 1, 0, &lock);
+	clk = clk_register_mux_regmap(NULL, clk_names[VIDEO2_PLL], parent_names,
+				      2, 0, regmap, REG_CLKSELECT3, 10, 1, 0);
 	if (IS_ERR(clk))
-		goto bg2_fail;
+		return;
 
 	/* clock divider cells */
 	for (n = 0; n < ARRAY_SIZE(bg2_divs); n++) {
@@ -647,18 +652,18 @@ static void __init berlin2_clock_setup(struct device_node *np)
 		for (k = 0; k < dd->num_parents; k++)
 			parent_names[k] = clk_names[dd->parent_ids[k]];
 
-		clks[CLKID_SYS + n] = berlin2_div_register(&dd->map, gbase,
+		clks[CLKID_SYS + n] = berlin2_div_register(&dd->map, regmap,
 				dd->name, dd->div_flags, parent_names,
-				dd->num_parents, dd->flags, &lock);
+				dd->num_parents, dd->flags);
 	}
 
 	/* clock gate cells */
 	for (n = 0; n < ARRAY_SIZE(bg2_gates); n++) {
 		const struct berlin2_gate_data *gd = &bg2_gates[n];
 
-		clks[CLKID_GETH0 + n] = clk_register_gate(NULL, gd->name,
-			    gd->parent_name, gd->flags, gbase + REG_CLKENABLE,
-			    gd->bit_idx, 0, &lock);
+		clks[CLKID_GETH0 + n] = clk_register_gate_regmap(NULL, gd->name,
+			    gd->parent_name, gd->flags, regmap, REG_CLKENABLE,
+			    gd->bit_idx, 0);
 	}
 
 	/* twdclk is derived from cpu/3 */
@@ -672,7 +677,7 @@ static void __init berlin2_clock_setup(struct device_node *np)
 
 		pr_err("%s: Unable to register leaf clock %d\n",
 		       np->full_name, n);
-		goto bg2_fail;
+		return;
 	}
 
 	/* register clk-provider */
@@ -681,11 +686,8 @@ static void __init berlin2_clock_setup(struct device_node *np)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
 	return;
-
-bg2_fail:
-	iounmap(gbase);
 }
 CLK_OF_DECLARE(berlin2_clock, "marvell,berlin2-chip-ctrl",
 	       berlin2_clock_setup);
-CLK_OF_DECLARE(berlin2cd_clock, "marvell,berlin2cd-chip-ctrl",
+CLK_OF_DECLARE(berlin2cd_clock, "marvell,berlin2-clk",
 	       berlin2_clock_setup);
diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index 440ef81ab15c..25bedca9e350 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -19,9 +19,12 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/clock/berlin2q.h>
@@ -46,11 +49,9 @@
 #define REG_SDIO1XIN_CLKCTL	0x015c
 
 #define	MAX_CLKS 27
+
 static struct clk *clks[MAX_CLKS];
 static struct clk_onecell_data clk_data;
-static DEFINE_SPINLOCK(lock);
-static void __iomem *gbase;
-static void __iomem *cpupll_base;
 
 enum {
 	REFCLK,
@@ -290,24 +291,45 @@ static const struct berlin2_gate_data bg2q_gates[] __initconst = {
 
 static void __init berlin2q_clock_setup(struct device_node *np)
 {
+	struct device_node *parent_np = of_get_parent(np);
 	const char *parent_names[9];
+	struct regmap *regmap, *cpupll_regmap;
+	struct regmap_config *rmconfig;
+	struct resource res;
 	struct clk *clk;
+	void __iomem *cpupll_base;
 	int n;
 
-	gbase = of_iomap(np, 0);
-	if (!gbase) {
-		pr_err("%s: Unable to map global base\n", np->full_name);
+	regmap = syscon_node_to_regmap(parent_np);
+	of_node_put(parent_np);
+	if (IS_ERR(regmap)) {
+		pr_err("Unable to retrieve regmap: %ld\n", PTR_ERR(regmap));
 		return;
 	}
 
+	rmconfig = kzalloc(sizeof(*rmconfig), GFP_KERNEL);
+	if (!rmconfig)
+		return;
+
+	if (of_address_to_resource(parent_np, 1, &res))
+		return;
+
 	/* BG2Q CPU PLL is not part of global registers */
-	cpupll_base = of_iomap(np, 1);
+	cpupll_base = ioremap(res.start, resource_size(&res));
 	if (!cpupll_base) {
 		pr_err("%s: Unable to map cpupll base\n", np->full_name);
-		iounmap(gbase);
 		return;
 	}
 
+	rmconfig->reg_bits = 32;
+	rmconfig->val_bits = 32;
+	rmconfig->reg_stride = 4;
+	rmconfig->max_register = resource_size(&res);
+
+	cpupll_regmap = regmap_init_mmio(NULL, cpupll_base, rmconfig);
+	if (IS_ERR(cpupll_regmap))
+		return;
+
 	/* overwrite default clock names with DT provided ones */
 	clk = of_clk_get_by_name(np, clk_names[REFCLK]);
 	if (!IS_ERR(clk)) {
@@ -316,15 +338,15 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 	}
 
 	/* simple register PLLs */
-	clk = berlin2_pll_register(&bg2q_pll_map, gbase + REG_SYSPLLCTL0,
+	clk = berlin2_pll_register(&bg2q_pll_map, regmap, REG_SYSPLLCTL0,
 				   clk_names[SYSPLL], clk_names[REFCLK], 0);
 	if (IS_ERR(clk))
-		goto bg2q_fail;
+		return;
 
-	clk = berlin2_pll_register(&bg2q_pll_map, cpupll_base,
+	clk = berlin2_pll_register(&bg2q_pll_map, cpupll_regmap, 0,
 				   clk_names[CPUPLL], clk_names[REFCLK], 0);
 	if (IS_ERR(clk))
-		goto bg2q_fail;
+		return;
 
 	/* TODO: add BG2Q AVPLL */
 
@@ -341,18 +363,18 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 		for (k = 0; k < dd->num_parents; k++)
 			parent_names[k] = clk_names[dd->parent_ids[k]];
 
-		clks[CLKID_SYS + n] = berlin2_div_register(&dd->map, gbase,
+		clks[CLKID_SYS + n] = berlin2_div_register(&dd->map, regmap,
 				dd->name, dd->div_flags, parent_names,
-				dd->num_parents, dd->flags, &lock);
+				dd->num_parents, dd->flags);
 	}
 
 	/* clock gate cells */
 	for (n = 0; n < ARRAY_SIZE(bg2q_gates); n++) {
 		const struct berlin2_gate_data *gd = &bg2q_gates[n];
 
-		clks[CLKID_GFX2DAXI + n] = clk_register_gate(NULL, gd->name,
-			    gd->parent_name, gd->flags, gbase + REG_CLKENABLE,
-			    gd->bit_idx, 0, &lock);
+		clks[CLKID_GFX2DAXI + n] = clk_register_gate_regmap(NULL,
+				gd->name, gd->parent_name, gd->flags,
+				regmap, REG_CLKENABLE, gd->bit_idx, 0);
 	}
 
 	/*
@@ -370,7 +392,7 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 
 		pr_err("%s: Unable to register leaf clock %d\n",
 		       np->full_name, n);
-		goto bg2q_fail;
+		return;
 	}
 
 	/* register clk-provider */
@@ -379,10 +401,6 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
 	return;
-
-bg2q_fail:
-	iounmap(cpupll_base);
-	iounmap(gbase);
 }
-CLK_OF_DECLARE(berlin2q_clock, "marvell,berlin2q-chip-ctrl",
+CLK_OF_DECLARE(berlin2q_clock, "marvell,berlin2q-clk",
 	       berlin2q_clock_setup);
-- 
2.3.1
