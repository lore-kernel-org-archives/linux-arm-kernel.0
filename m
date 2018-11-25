From: hao5781286@gmail.com (Hao Zhang)
Date: Mon, 26 Nov 2018 00:21:18 +0800
Subject: [PATCH v3 4/6] DEV: CLK: add function to check the using clock name
 of driver.
Message-ID: <20181125162118.GA5358@arx-s1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some situation we want to check clock whether is we want
and after the driver been probed use to change different clock source.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 drivers/clk/clk.c            | 6 ++++++
 include/linux/clk-provider.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d31055a..3d2c2cd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3466,6 +3466,12 @@ static int devm_clk_hw_match(struct device *dev, void *res, void *data)
 	return hw == data;
 }
 
+bool devm_clk_name_match(struct clk *clk, const char *string)
+{
+	return match_string(&clk->con_id, 1, string) == 0;
+}
+EXPORT_SYMBOL_GPL(devm_clk_name_match);
+
 /**
  * devm_clk_unregister - resource managed clk_unregister()
  * @clk: clock to unregister
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08b1aa7..5cd2eed 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -764,6 +764,7 @@ struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
 int __must_check clk_hw_register(struct device *dev, struct clk_hw *hw);
 int __must_check devm_clk_hw_register(struct device *dev, struct clk_hw *hw);
 
+bool devm_clk_name_match(struct clk *clk, const char *string);
 void clk_unregister(struct clk *clk);
 void devm_clk_unregister(struct device *dev, struct clk *clk);
 
-- 
2.7.4
