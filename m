From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:08 +0200
Subject: [RFC 11/17] clk: gpio: Switch to new clock controller API
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-12-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate a clock controller and use new clk_register_with_ctrl() API.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-gpio.c       | 29 +++++++++++++++++------------
 include/linux/clk-provider.h | 12 ++++++++----
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 86b245746a6b..8ebd520c1aa0 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -94,7 +94,8 @@ const struct clk_ops clk_gpio_mux_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_gpio_mux_ops);
 
-static struct clk_hw *clk_register_gpio(struct device *dev, const char *name,
+static struct clk_hw *clk_register_gpio(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char * const *parent_names, u8 num_parents, unsigned gpio,
 		bool active_low, unsigned long flags,
 		const struct clk_ops *clk_gpio_ops)
@@ -168,25 +169,27 @@ static struct clk_hw *clk_register_gpio(struct device *dev, const char *name,
  * @active_low: true if gpio should be set to 0 to enable clock
  * @flags: clock flags
  */
-struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char *parent_name, unsigned gpio, bool active_low,
 		unsigned long flags)
 {
-	return clk_register_gpio(dev, name,
+	return clk_register_gpio(dev, ctrl, name,
 			(parent_name ? &parent_name : NULL),
 			(parent_name ? 1 : 0), gpio, active_low, flags,
 			&clk_gpio_gate_ops);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_gpio_gate);
 
-struct clk *clk_register_gpio_gate(struct device *dev, const char *name,
+struct clk *clk_register_gpio_gate(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char *parent_name, unsigned gpio, bool active_low,
 		unsigned long flags)
 {
 	struct clk_hw *hw;
 
-	hw = clk_hw_register_gpio_gate(dev, name, parent_name, gpio, active_low,
-				       flags);
+	hw = clk_hw_register_gpio_gate(dev, ctrl, name, parent_name, gpio,
+				       active_low, flags);
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 	return hw->clk;
@@ -203,7 +206,8 @@ EXPORT_SYMBOL_GPL(clk_register_gpio_gate);
  * @active_low: true if gpio should be set to 0 to enable clock
  * @flags: clock flags
  */
-struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char * const *parent_names, u8 num_parents, unsigned gpio,
 		bool active_low, unsigned long flags)
 {
@@ -212,18 +216,19 @@ struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
 		return ERR_PTR(-EINVAL);
 	}
 
-	return clk_register_gpio(dev, name, parent_names, num_parents,
+	return clk_register_gpio(dev, ctrl, name, parent_names, num_parents,
 			gpio, active_low, flags, &clk_gpio_mux_ops);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_gpio_mux);
 
-struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
+struct clk *clk_register_gpio_mux(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char * const *parent_names, u8 num_parents, unsigned gpio,
 		bool active_low, unsigned long flags)
 {
 	struct clk_hw *hw;
 
-	hw = clk_hw_register_gpio_mux(dev, name, parent_names, num_parents,
+	hw = clk_hw_register_gpio_mux(dev, ctrl, name, parent_names, num_parents,
 			gpio, active_low, flags);
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
@@ -271,10 +276,10 @@ static int gpio_clk_driver_probe(struct platform_device *pdev)
 	active_low = of_flags & OF_GPIO_ACTIVE_LOW;
 
 	if (is_mux)
-		clk = clk_register_gpio_mux(&pdev->dev, node->name,
+		clk = clk_register_gpio_mux(&pdev->dev, NULL, node->name,
 				parent_names, num_parents, gpio, active_low, 0);
 	else
-		clk = clk_register_gpio_gate(&pdev->dev, node->name,
+		clk = clk_register_gpio_gate(&pdev->dev, NULL, node->name,
 				parent_names ?  parent_names[0] : NULL, gpio,
 				active_low, 0);
 	if (IS_ERR(clk))
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2bd0a8cb7a9c..c39760cba9ac 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -698,10 +698,12 @@ struct clk_gpio {
 #define to_clk_gpio(_hw) container_of(_hw, struct clk_gpio, hw)
 
 extern const struct clk_ops clk_gpio_gate_ops;
-struct clk *clk_register_gpio_gate(struct device *dev, const char *name,
+struct clk *clk_register_gpio_gate(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char *parent_name, unsigned gpio, bool active_low,
 		unsigned long flags);
-struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char *parent_name, unsigned gpio, bool active_low,
 		unsigned long flags);
 void clk_hw_unregister_gpio_gate(struct clk_hw *hw);
@@ -717,10 +719,12 @@ void clk_hw_unregister_gpio_gate(struct clk_hw *hw);
  */
 
 extern const struct clk_ops clk_gpio_mux_ops;
-struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
+struct clk *clk_register_gpio_mux(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char * const *parent_names, u8 num_parents, unsigned gpio,
 		bool active_low, unsigned long flags);
-struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char * const *parent_names, u8 num_parents, unsigned gpio,
 		bool active_low, unsigned long flags);
 void clk_hw_unregister_gpio_mux(struct clk_hw *hw);
-- 
1.9.1
