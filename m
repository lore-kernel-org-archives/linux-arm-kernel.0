From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 14 Nov 2018 23:57:21 +0100
Subject: [RFC v1 3/7] clk: meson: clk-pll: check if the clock is already
 enabled
In-Reply-To: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181114225725.2821-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 6f888e7bc7bd58 ("clk: meson: clk-pll: add enable bit") our
PLLs also support the "enable" bit. Currently meson_clk_pll_enable
unconditionally resets the PLL, enables it, takes it out of reset and
waits until it is locked.

This works fine for our current clock trees. However, there will be a
problem once we allow modifications to sys_pll on Meson8, Meson8b and
Meson8m2 (which will be required for CPU frequency scaling):
the CPU clock is derived from the sys_pll clock. Once clk_enable is
called on the CPU clock this will be propagated by the common clock
framework up until the sys_pll clock. If we reset the PLL
unconditionally in meson_clk_pll_enable the CPU will be stopped (on
Meson8, Meson8b and Meson8m2).
To prevent this we simply check if the PLL is already enabled and do
reset the PLL if it's already enabled and locked.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-pll.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index f5b5b3fabe3c..b46cca953f4f 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -200,11 +200,32 @@ static void meson_clk_pll_init(struct clk_hw *hw)
 	}
 }
 
+static int meson_clk_pll_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+
+	if (meson_parm_read(clk->map, &pll->rst))
+		return 0;
+
+	if (!meson_parm_read(clk->map, &pll->en))
+		return 0;
+
+	if (!meson_parm_read(clk->map, &pll->l))
+		return 0;
+
+	return 1;
+}
+
 static int meson_clk_pll_enable(struct clk_hw *hw)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 
+	/* do nothing if the PLL is already enabled */
+	if (meson_clk_pll_is_enabled(hw))
+		return 0;
+
 	/* Make sure the pll is in reset */
 	meson_parm_write(clk->map, &pll->rst, 1);
 
-- 
2.19.1
