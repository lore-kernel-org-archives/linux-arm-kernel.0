From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Jan 2016 14:28:49 +0000
Subject: [PATCH 1/3] clk: Allow clocks to be marked as CRITICAL
In-Reply-To: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1453127331-20616-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Critical clocks are those which must not be gated, else undefined
or catastrophic failure would occur.  Here we have chosen to
ensure the prepare/enable counts are correctly incremented, so as
not to confuse users with enabled clocks with no visible users.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/clk.c            | 7 ++++++-
 include/linux/clk-provider.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f13c3f4..835cb85 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2576,8 +2576,13 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	}
 
 	ret = __clk_init(dev, hw->clk);
-	if (!ret)
+	if (!ret) {
+		if (core->flags & CLK_IS_CRITICAL) {
+			clk_core_prepare(core);
+			clk_core_enable(core);
+		}
 		return hw->clk;
+	}
 
 	__clk_free_clk(hw->clk);
 	hw->clk = NULL;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c56988a..ffa0b2e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -31,6 +31,7 @@
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
 #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
 #define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
+#define CLK_IS_CRITICAL		BIT(10) /* do not gate, ever */
 
 struct clk;
 struct clk_hw;
-- 
1.9.1
