From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:07 +0200
Subject: [RFC 10/17] clk: composite: Switch to new clock controller API
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-11-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate a clock controller and use new clk_register_with_ctrl() API.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-composite.c  | 8 +++++---
 include/linux/clk-provider.h | 6 ++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 00269de2f390..8ad5c2c4a329 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -211,7 +211,8 @@ static void clk_composite_disable(struct clk_hw *hw)
 	gate_ops->disable(gate_hw);
 }
 
-struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_composite(struct device *dev, struct clk_ctrl *ctrl,
+			const char *name,
 			const char * const *parent_names, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
@@ -324,7 +325,8 @@ err:
 	return hw;
 }
 
-struct clk *clk_register_composite(struct device *dev, const char *name,
+struct clk *clk_register_composite(struct device *dev, struct clk_ctrl *ctrl,
+			const char *name,
 			const char * const *parent_names, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
@@ -333,7 +335,7 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 {
 	struct clk_hw *hw;
 
-	hw = clk_hw_register_composite(dev, name, parent_names, num_parents,
+	hw = clk_hw_register_composite(dev, ctrl, name, parent_names, num_parents,
 			mux_hw, mux_ops, rate_hw, rate_ops, gate_hw, gate_ops,
 			flags);
 	if (IS_ERR(hw))
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index cfb3aa3912c5..2bd0a8cb7a9c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -663,14 +663,16 @@ struct clk_composite {
 
 #define to_clk_composite(_hw) container_of(_hw, struct clk_composite, hw)
 
-struct clk *clk_register_composite(struct device *dev, const char *name,
+struct clk *clk_register_composite(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char * const *parent_names, int num_parents,
 		struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
 		unsigned long flags);
 void clk_unregister_composite(struct clk *clk);
-struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_composite(struct device *dev,
+		struct clk_ctrl *ctrl, const char *name,
 		const char * const *parent_names, int num_parents,
 		struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
-- 
1.9.1
