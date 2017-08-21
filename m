From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 21 Aug 2017 13:59:01 +0200
Subject: [RESEND PATCH v8 2/3] clk: gate: expose clk_gate_ops::is_enabled
In-Reply-To: <1503316742-22145-1-git-send-email-gabriel.fernandez@st.com>
References: <1503316742-22145-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1503316742-22145-3-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch exposes clk_gate_ops::is_enabled as functions
that can be directly called and assigned in places like this so
we don't need wrapper functions that do nothing besides forward
the call.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-gate.c       | 3 ++-
 include/linux/clk-provider.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 4e0c054a..dd82485 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -86,7 +86,7 @@ static void clk_gate_disable(struct clk_hw *hw)
 	clk_gate_endisable(hw, 0);
 }
 
-static int clk_gate_is_enabled(struct clk_hw *hw)
+int clk_gate_is_enabled(struct clk_hw *hw)
 {
 	u32 reg;
 	struct clk_gate *gate = to_clk_gate(hw);
@@ -101,6 +101,7 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
 
 	return reg ? 1 : 0;
 }
+EXPORT_SYMBOL_GPL(clk_gate_is_enabled);
 
 const struct clk_ops clk_gate_ops = {
 	.enable = clk_gate_enable,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c59c625..e9587ab 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -343,6 +343,7 @@ struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
 		u8 clk_gate_flags, spinlock_t *lock);
 void clk_unregister_gate(struct clk *clk);
 void clk_hw_unregister_gate(struct clk_hw *hw);
+int clk_gate_is_enabled(struct clk_hw *hw);
 
 struct clk_div_table {
 	unsigned int	val;
-- 
1.9.1
