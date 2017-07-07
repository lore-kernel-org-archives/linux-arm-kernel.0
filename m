From: jun.gao@mediatek.com (Jun Gao)
Date: Fri, 7 Jul 2017 10:12:19 +0800
Subject: [PATCH v1] i2c: mediatek: send i2c master code at 400k
Message-ID: <1499393539-1102-1-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Gao <jun.gao@mediatek.com>

The speed of sending i2c master code in high-speed mode depends on
source clock, clock-div and TIMING register. The source clock and
clock-div of different SoC are not all the same. In order to send
i2c master code at 400k in high-speed mode, a appropriate value
should be set to TIMING register for a certain source clock and
clock-div.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 65 +++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 45d6171..9bedf0b 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -50,7 +50,6 @@
 #define I2C_FS_START_CON		0x1800
 #define I2C_TIME_CLR_VALUE		0x0000
 #define I2C_TIME_DEFAULT_VALUE		0x0003
-#define I2C_FS_TIME_INIT_VALUE		0x1303
 #define I2C_WRRD_TRANAC_VALUE		0x0002
 #define I2C_RD_TRANAC_VALUE		0x0001
 
@@ -154,6 +153,7 @@ struct mtk_i2c {
 	bool use_push_pull;		/* IO config push-pull mode */
 
 	u16 irq_stat;			/* interrupt status */
+	unsigned int clk_src_div;
 	unsigned int speed_hz;		/* The speed in transfer */
 	enum mtk_trans_op op;
 	u16 timing_reg;
@@ -285,23 +285,20 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
  * less than or equal to i2c->speed_hz. The calculation try to get
  * sample_cnt and step_cn
  */
-static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk,
-			     unsigned int clock_div)
+static int mtk_i2c_calculate_speed(struct mtk_i2c *i2c, unsigned int clk_src,
+				   unsigned int target_speed,
+				   unsigned int *timing_step_cnt,
+				   unsigned int *timing_sample_cnt)
 {
-	unsigned int clk_src;
 	unsigned int step_cnt;
 	unsigned int sample_cnt;
 	unsigned int max_step_cnt;
-	unsigned int target_speed;
 	unsigned int base_sample_cnt = MAX_SAMPLE_CNT_DIV;
 	unsigned int base_step_cnt;
 	unsigned int opt_div;
 	unsigned int best_mul;
 	unsigned int cnt_mul;
 
-	clk_src = parent_clk / clock_div;
-	target_speed = i2c->speed_hz;
-
 	if (target_speed > MAX_HS_MODE_SPEED)
 		target_speed = MAX_HS_MODE_SPEED;
 
@@ -347,16 +344,48 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk,
 		return -EINVAL;
 	}
 
-	step_cnt--;
-	sample_cnt--;
+	*timing_step_cnt = step_cnt - 1;
+	*timing_sample_cnt = sample_cnt - 1;
+
+	return 0;
+}
+
+static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
+{
+	unsigned int clk_src;
+	unsigned int step_cnt;
+	unsigned int sample_cnt;
+	unsigned int target_speed;
+	int ret;
+
+	clk_src = parent_clk / i2c->clk_src_div;
+	target_speed = i2c->speed_hz;
 
 	if (target_speed > MAX_FS_MODE_SPEED) {
+		/* Set master code speed register */
+		ret = mtk_i2c_calculate_speed(i2c, clk_src, MAX_FS_MODE_SPEED,
+					      &step_cnt, &sample_cnt);
+		if (ret < 0)
+			return ret;
+
+		i2c->timing_reg = (sample_cnt << 8) | step_cnt;
+
 		/* Set the high speed mode register */
-		i2c->timing_reg = I2C_FS_TIME_INIT_VALUE;
+		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
+					      &step_cnt, &sample_cnt);
+		if (ret < 0)
+			return ret;
+
 		i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
 			(sample_cnt << 12) | (step_cnt << 8);
 	} else {
-		i2c->timing_reg = (sample_cnt << 8) | (step_cnt << 0);
+		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
+					      &step_cnt, &sample_cnt);
+		if (ret < 0)
+			return ret;
+
+		i2c->timing_reg = (sample_cnt << 8) | step_cnt;
+
 		/* Disable the high speed transaction */
 		i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
 	}
@@ -647,8 +676,7 @@ static u32 mtk_i2c_functionality(struct i2c_adapter *adap)
 	.functionality = mtk_i2c_functionality,
 };
 
-static int mtk_i2c_parse_dt(struct device_node *np, struct mtk_i2c *i2c,
-			    unsigned int *clk_src_div)
+static int mtk_i2c_parse_dt(struct device_node *np, struct mtk_i2c *i2c)
 {
 	int ret;
 
@@ -656,11 +684,11 @@ static int mtk_i2c_parse_dt(struct device_node *np, struct mtk_i2c *i2c,
 	if (ret < 0)
 		i2c->speed_hz = I2C_DEFAULT_SPEED;
 
-	ret = of_property_read_u32(np, "clock-div", clk_src_div);
+	ret = of_property_read_u32(np, "clock-div", &i2c->clk_src_div);
 	if (ret < 0)
 		return ret;
 
-	if (*clk_src_div == 0)
+	if (i2c->clk_src_div == 0)
 		return -EINVAL;
 
 	i2c->have_pmic = of_property_read_bool(np, "mediatek,have-pmic");
@@ -676,7 +704,6 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 	int ret = 0;
 	struct mtk_i2c *i2c;
 	struct clk *clk;
-	unsigned int clk_src_div;
 	struct resource *res;
 	int irq;
 
@@ -684,7 +711,7 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
-	ret = mtk_i2c_parse_dt(pdev->dev.of_node, i2c, &clk_src_div);
+	ret = mtk_i2c_parse_dt(pdev->dev.of_node, i2c);
 	if (ret)
 		return -EINVAL;
 
@@ -745,7 +772,7 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 
 	strlcpy(i2c->adap.name, I2C_DRV_NAME, sizeof(i2c->adap.name));
 
-	ret = mtk_i2c_set_speed(i2c, clk_get_rate(clk), clk_src_div);
+	ret = mtk_i2c_set_speed(i2c, clk_get_rate(clk));
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to set the speed.\n");
 		return -EINVAL;
-- 
1.8.1.1
