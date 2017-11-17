From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 17 Nov 2017 16:02:33 +0800
Subject: [PATCH 2/5] i2c: meson: add configurable divider factors
In-Reply-To: <20171117080236.32504-1-yixun.lan@amlogic.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
Message-ID: <20171117080236.32504-3-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jian Hu <jian.hu@amlogic.com>

This patch try to add support for I2C controller in Meson-AXG SoC,
Due to the IP changes between I2C controller, we need to introduce
a compatible data to make the divider factor configurable.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/i2c/busses/i2c-meson.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 88d15b92ec35..517f2cddeff3 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
@@ -57,6 +58,10 @@ enum {
 	STATE_WRITE,
 };
 
+struct meson_i2c_data {
+	unsigned char div_factor;
+};
+
 /**
  * struct meson_i2c - Meson I2C device private data
  *
@@ -93,6 +98,8 @@ struct meson_i2c {
 	struct completion	done;
 	u32			tokens[2];
 	int			num_tokens;
+
+	struct meson_i2c_data *data;
 };
 
 static void meson_i2c_set_mask(struct meson_i2c *i2c, int reg, u32 mask,
@@ -128,7 +135,7 @@ static void meson_i2c_set_clk_div(struct meson_i2c *i2c, unsigned int freq)
 	unsigned long clk_rate = clk_get_rate(i2c->clk);
 	unsigned int div;
 
-	div = DIV_ROUND_UP(clk_rate, freq * 4);
+	div = DIV_ROUND_UP(clk_rate, freq * i2c->data->div_factor);
 
 	/* clock divider has 12 bits */
 	if (div >= (1 << 12)) {
@@ -376,6 +383,9 @@ static int meson_i2c_probe(struct platform_device *pdev)
 	spin_lock_init(&i2c->lock);
 	init_completion(&i2c->done);
 
+	i2c->data = (struct meson_i2c_data *)
+		of_device_get_match_data(&pdev->dev);
+
 	i2c->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c->clk)) {
 		dev_err(&pdev->dev, "can't get device clock\n");
@@ -440,11 +450,25 @@ static int meson_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct meson_i2c_data i2c_meson6_data = {
+	.div_factor = 4,
+};
+
+static const struct meson_i2c_data i2c_gxbb_data = {
+	.div_factor = 4,
+};
+
+static const struct meson_i2c_data i2c_axg_data = {
+	.div_factor = 3,
+};
+
 static const struct of_device_id meson_i2c_match[] = {
-	{ .compatible = "amlogic,meson6-i2c" },
-	{ .compatible = "amlogic,meson-gxbb-i2c" },
-	{ },
+	{ .compatible = "amlogic,meson6-i2c", .data = &i2c_meson6_data },
+	{ .compatible = "amlogic,meson-gxbb-i2c", .data = &i2c_gxbb_data },
+	{ .compatible = "amlogic,meson-axg-i2c", .data = &i2c_axg_data },
+	{},
 };
+
 MODULE_DEVICE_TABLE(of, meson_i2c_match);
 
 static struct platform_driver meson_i2c_driver = {
-- 
2.14.1
