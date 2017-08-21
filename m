From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 21 Aug 2017 13:59:00 +0200
Subject: [RESEND PATCH v8 1/3] clk: nxp: clk-lpc32xx: rename
 clk_gate_is_enabled()
In-Reply-To: <1503316742-22145-1-git-send-email-gabriel.fernandez@st.com>
References: <1503316742-22145-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1503316742-22145-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

We need to export clk_gate_is_enabled() from clk framework, then
to avoid compilation issue we have to rename clk_gate_is_enabled()
in NXP LPC32xx clock driver.
We changed all gate op with 'lpc32xx_' prefix:
lpc32xx_clk_gate_enable(),
lpc32xx_clk_gate_disable(),
lpc32xx_clk_gate_is_enabled().

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/clk/nxp/clk-lpc32xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index 5b98ff9..7b359af 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -885,7 +885,7 @@ static unsigned long clk_usb_i2c_recalc_rate(struct clk_hw *hw,
 	.recalc_rate = clk_usb_i2c_recalc_rate,
 };
 
-static int clk_gate_enable(struct clk_hw *hw)
+static int lpc32xx_clk_gate_enable(struct clk_hw *hw)
 {
 	struct lpc32xx_clk_gate *clk = to_lpc32xx_gate(hw);
 	u32 mask = BIT(clk->bit_idx);
@@ -894,7 +894,7 @@ static int clk_gate_enable(struct clk_hw *hw)
 	return regmap_update_bits(clk_regmap, clk->reg, mask, val);
 }
 
-static void clk_gate_disable(struct clk_hw *hw)
+static void lpc32xx_clk_gate_disable(struct clk_hw *hw)
 {
 	struct lpc32xx_clk_gate *clk = to_lpc32xx_gate(hw);
 	u32 mask = BIT(clk->bit_idx);
@@ -903,7 +903,7 @@ static void clk_gate_disable(struct clk_hw *hw)
 	regmap_update_bits(clk_regmap, clk->reg, mask, val);
 }
 
-static int clk_gate_is_enabled(struct clk_hw *hw)
+static int lpc32xx_clk_gate_is_enabled(struct clk_hw *hw)
 {
 	struct lpc32xx_clk_gate *clk = to_lpc32xx_gate(hw);
 	u32 val;
@@ -916,9 +916,9 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
 }
 
 static const struct clk_ops lpc32xx_clk_gate_ops = {
-	.enable = clk_gate_enable,
-	.disable = clk_gate_disable,
-	.is_enabled = clk_gate_is_enabled,
+	.enable = lpc32xx_clk_gate_enable,
+	.disable = lpc32xx_clk_gate_disable,
+	.is_enabled = lpc32xx_clk_gate_is_enabled,
 };
 
 #define div_mask(width)	((1 << (width)) - 1)
-- 
1.9.1
