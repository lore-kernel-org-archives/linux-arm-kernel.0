From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 13 Jul 2017 16:02:31 +0200
Subject: [PATCH v5 1/2] clk: gate: expose clk_gate_ops::is_enabled
In-Reply-To: <1499954552-20075-1-git-send-email-gabriel.fernandez@st.com>
References: <1499954552-20075-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1499954552-20075-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch exposes clk_gate_ops::is_enabled as functions
that can be directly called and assigned in places like this so
we don't need wrapper functions that do nothing besides forward
the call.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Sugested by Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-gate.c       | 2 +-
 include/linux/clk-provider.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 4e0c054a..e27e28f 100644
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
