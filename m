From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Apr 2012 10:09:57 +0800
Subject: [PATCH] ARM: imx: remove clk_hw from clk_busy
In-Reply-To: <1334065553-7565-26-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-26-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334282997-23071-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Hi Sascha,

I'm convinced by Richard that we do not need a clk_hw duplication
in clk_busy for a better OOP view.  So please consider to squash
the patch to "ARM: imx: add common clock support for clk busy".

Thanks,
Shawn

 arch/arm/mach-imx/clk-busy.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/clk-busy.c b/arch/arm/mach-imx/clk-busy.c
index 9450f0b..977d50a 100644
--- a/arch/arm/mach-imx/clk-busy.c
+++ b/arch/arm/mach-imx/clk-busy.c
@@ -29,14 +29,18 @@ static int clk_busy_wait(void __iomem *reg, u8 shift)
 }
 
 struct clk_busy_divider {
-	struct clk_hw hw;
-	void __iomem *reg;
-	u8 shift;
 	struct clk_divider div;
 	const struct clk_ops *div_ops;
+	void __iomem *reg;
+	u8 shift;
 };
 
-#define to_clk_busy_divider(_hw) container_of(_hw, struct clk_busy_divider, hw)
+static inline struct clk_busy_divider *to_clk_busy_divider(struct clk_hw *hw)
+{
+	struct clk_divider *div = container_of(hw, struct clk_divider, hw);
+
+	return container_of(div, struct clk_busy_divider, div);
+}
 
 static unsigned long clk_busy_divider_recalc_rate(struct clk_hw *hw,
 						  unsigned long parent_rate)
@@ -92,25 +96,27 @@ struct clk *imx_clk_busy_divider(const char *name, char *parent_name,
 	busy->div.lock = &imx_ccm_lock;
 	busy->div_ops = &clk_divider_ops;
 
-	clk = clk_register(NULL, name, &clk_busy_divider_ops, &busy->hw,
+	clk = clk_register(NULL, name, &clk_busy_divider_ops, &busy->div.hw,
 			   &parent_name, 1, CLK_SET_RATE_PARENT);
 	if (!clk)
 		kfree(busy);
 
-	busy->div.hw.clk = clk;
-
 	return clk;
 }
 
 struct clk_busy_mux {
-	struct clk_hw hw;
-	void __iomem *reg;
-	u8 shift;
 	struct clk_mux mux;
 	const struct clk_ops *mux_ops;
+	void __iomem *reg;
+	u8 shift;
 };
 
-#define to_clk_busy_mux(_hw) container_of(_hw, struct clk_busy_mux, hw)
+static inline struct clk_busy_mux *to_clk_busy_mux(struct clk_hw *hw)
+{
+	struct clk_mux *mux = container_of(hw, struct clk_mux, hw);
+
+	return container_of(mux, struct clk_busy_mux, mux);
+}
 
 static u8 clk_busy_mux_get_parent(struct clk_hw *hw)
 {
@@ -156,12 +162,10 @@ struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 	busy->mux.lock = &imx_ccm_lock;
 	busy->mux_ops = &clk_mux_ops;
 
-	clk = clk_register(NULL, name, &clk_busy_mux_ops, &busy->hw,
+	clk = clk_register(NULL, name, &clk_busy_mux_ops, &busy->mux.hw,
 			   parent_names, num_parents, 0);
 	if (!clk)
 		kfree(busy);
 
-	busy->mux.hw.clk = clk;
-
 	return clk;
 }
-- 
1.7.5.4
