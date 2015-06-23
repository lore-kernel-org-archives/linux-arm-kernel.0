From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 23 Jun 2015 16:09:19 +0200
Subject: [PATCH 1/9] drivers: clk: st: Incorrect clocks status
In-Reply-To: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1435068567-30995-2-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the clk_summary output, the h/w status of DivMux is incorrect
(Parent and Enable status), since the clk_mux_ops.get_parent()
returns -ERRCODE when clock is OFF.

Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/clk/st/clkgen-mux.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index 4fbe6e0..c94b56b 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -128,7 +128,7 @@ static int clkgena_divmux_is_enabled(struct clk_hw *hw)
 
 	__clk_hw_set_clk(mux_hw, hw);
 
-	return (s8)clk_mux_ops.get_parent(mux_hw) > 0;
+	return ((s8)clk_mux_ops.get_parent(mux_hw) >= 0);
 }
 
 static u8 clkgena_divmux_get_parent(struct clk_hw *hw)
@@ -138,11 +138,13 @@ static u8 clkgena_divmux_get_parent(struct clk_hw *hw)
 
 	__clk_hw_set_clk(mux_hw, hw);
 
-	genamux->muxsel = clk_mux_ops.get_parent(mux_hw);
-	if ((s8)genamux->muxsel < 0) {
-		pr_debug("%s: %s: Invalid parent, setting to default.\n",
-		      __func__, __clk_get_name(hw->clk));
-		genamux->muxsel = 0;
+	if (genamux->muxsel == CKGAX_CLKOPSRC_SWITCH_OFF) {
+		genamux->muxsel = clk_mux_ops.get_parent(mux_hw);
+		if ((s8)genamux->muxsel < 0) {
+			pr_debug("%s: %s: Invalid parent, setting to default.\n",
+				  __func__, __clk_get_name(hw->clk));
+			genamux->muxsel = 0;
+		}
 	}
 
 	return genamux->muxsel;
@@ -254,6 +256,7 @@ static struct clk *clk_register_genamux(const char *name,
 	} else {
 		genamux->mux.reg   = reg + muxdata->mux_offset;
 	}
+	genamux->muxsel = CKGAX_CLKOPSRC_SWITCH_OFF;
 
 	for (i = 0; i < NUM_INPUTS; i++) {
 		/*
-- 
1.9.1
