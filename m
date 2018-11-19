From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Mon, 19 Nov 2018 12:03:32 +0100
Subject: [PATCH v2 2/2] i2c: i2c-stm32f7: SYSCFG Fast Mode Plus support for
 I2C STM32F7
In-Reply-To: <1542625412-4277-1-git-send-email-pierre-yves.mordret@st.com>
References: <1542625412-4277-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1542625412-4277-3-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read SYSCFG bindings to set Fast Mode Plus bits if Fast Mode Plus
speed is selected.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v2:
       * Missing header file inclusion
    v1:
       * Initial
---
---
 drivers/i2c/busses/i2c-stm32f7.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 62d023e..e9f0c0b 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -21,12 +21,14 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 
@@ -276,6 +278,7 @@ struct stm32f7_i2c_msg {
  * slave)
  * @dma: dma data
  * @use_dma: boolean to know if dma is used in the current transfer
+ * @regmap: holds SYSCFG phandle for Fast Mode Plus bits
  */
 struct stm32f7_i2c_dev {
 	struct i2c_adapter adap;
@@ -296,6 +299,7 @@ struct stm32f7_i2c_dev {
 	bool master_mode;
 	struct stm32_i2c_dma *dma;
 	bool use_dma;
+	struct regmap *regmap;
 };
 
 /**
@@ -1763,6 +1767,30 @@ static int stm32f7_i2c_unreg_slave(struct i2c_client *slave)
 	return 0;
 }
 
+static int stm32f7_i2c_setup_fm_plus_bits(struct platform_device *pdev,
+					  struct stm32f7_i2c_dev *i2c_dev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+	u32 reg, mask;
+
+	i2c_dev->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg-fmp");
+	if (IS_ERR(i2c_dev->regmap)) {
+		/* Optional */
+		return 0;
+	}
+
+	ret = of_property_read_u32_index(np, "st,syscfg-fmp", 1, &reg);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_index(np, "st,syscfg-fmp", 2, &mask);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(i2c_dev->regmap, reg, mask, mask);
+}
+
 static u32 stm32f7_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SLAVE |
@@ -1828,12 +1856,16 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	i2c_dev->speed = STM32_I2C_SPEED_STANDARD;
 	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
 				       &clk_rate);
-	if (!ret && clk_rate >= 1000000)
+	if (!ret && clk_rate >= 1000000) {
 		i2c_dev->speed = STM32_I2C_SPEED_FAST_PLUS;
-	else if (!ret && clk_rate >= 400000)
+		ret = stm32f7_i2c_setup_fm_plus_bits(pdev, i2c_dev);
+		if (ret)
+			goto clk_free;
+	} else if (!ret && clk_rate >= 400000) {
 		i2c_dev->speed = STM32_I2C_SPEED_FAST;
-	else if (!ret && clk_rate >= 100000)
+	} else if (!ret && clk_rate >= 100000) {
 		i2c_dev->speed = STM32_I2C_SPEED_STANDARD;
+	}
 
 	rst = devm_reset_control_get(&pdev->dev, NULL);
 	if (IS_ERR(rst)) {
-- 
2.7.4
