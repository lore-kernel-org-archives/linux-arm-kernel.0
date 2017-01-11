From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jan 2017 14:40:52 +0100
Subject: [PATCH] clk: stm32f4: avoid uninitialized variable access
Message-ID: <20170111134107.3821564-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The failure path in the newly added function tries to free an
uninitialized pointer:

drivers/clk/clk-stm32f4.c: In function 'stm32f4_rcc_init':
drivers/clk/clk-stm32f4.c:1106:4: error: 'gate' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I'm adding an initialization to NULL here to make the kfree()
succeed, and I'm also rearranging the cleanup so that the
same kfree() is used for any error path, making the function
slightly more robust against newly introduced bugs in the
error handling.

Fixes: daf2d117cbca ("clk: stm32f4: Add lcd-tft clock")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/clk-stm32f4.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 42f8534996de..4a3bb6e63525 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -1080,7 +1080,7 @@ static struct clk_hw *stm32_register_aux_clk(const char *name,
 		unsigned long flags, spinlock_t *lock)
 {
 	struct clk_hw *hw;
-	struct clk_gate *gate;
+	struct clk_gate *gate = NULL;
 	struct clk_mux *mux = NULL;
 	struct clk_hw *mux_hw = NULL, *gate_hw = NULL;
 	const struct clk_ops *mux_ops = NULL, *gate_ops = NULL;
@@ -1103,7 +1103,6 @@ static struct clk_hw *stm32_register_aux_clk(const char *name,
 	if (offset_mux != NO_MUX) {
 		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 		if (!mux) {
-			kfree(gate);
 			hw = ERR_PTR(-EINVAL);
 			goto fail;
 		}
@@ -1116,8 +1115,10 @@ static struct clk_hw *stm32_register_aux_clk(const char *name,
 		mux_ops = &clk_mux_ops;
 	}
 
-	if (mux_hw == NULL && gate_hw == NULL)
-		return ERR_PTR(-EINVAL);
+	if (mux_hw == NULL && gate_hw == NULL) {
+		hw = ERR_PTR(-EINVAL);
+		goto fail;
+	}
 
 	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 			mux_hw, mux_ops,
@@ -1125,11 +1126,12 @@ static struct clk_hw *stm32_register_aux_clk(const char *name,
 			gate_hw, gate_ops,
 			flags);
 
+fail:
 	if (IS_ERR(hw)) {
 		kfree(gate);
 		kfree(mux);
 	}
-fail:
+
 	return hw;
 }
 
-- 
2.9.0
