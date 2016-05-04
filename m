From: david.wu@rock-chips.com (David Wu)
Date: Wed,  4 May 2016 22:36:49 +0800
Subject: [PATCH v7 8/9] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1462372609-6535-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- new method to caculate i2c timings for rk3399:
  There was an timing issue about "repeated start" time at the I2C
  controller of version0, controller appears to drop SDA at .875x (7/8)
  programmed clk high. On version 1 of the controller, the rule(.875x)
  isn't enough to meet tSU;STA
  requirements on 100k's Standard-mode. To resolve this issue,
  sda_update_config, start_setup_config and stop_setup_config for I2C
  timing information are added, new rules are designed to calculate
  the timing information at new v1.
- pclk and function clk are separated at rk3399

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
Changes in v7:
- transform into a 9 series patches (Doug)
- drop highspeed with mastercode, and support fast-mode plus (Doug)

Changes in v6:
- add master code send for HS mode
- use assigned-clocks mechanism for clock rate set form DT (Heiko)

Changes in v5:
- use compatible to seperate from different version
- can caculate highspeed clk rate

Changes in v4:
- pclk and sclk are treated individually
- use switch-case to seperate from different version (Andy)
- fix dead loop form Julia's notice

Change in v3:
- Too many arguments for ops func, use struct for them (Andy)

 drivers/i2c/busses/i2c-rk3x.c | 266 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 243 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 408f9ab..47368c4 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -58,6 +58,10 @@ enum {
 #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last received byte */
 #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
 
+#define REG_CON_SDA_CFG(cfg) ((cfg) << 8)
+#define REG_CON_STA_CFG(cfg) ((cfg) << 12)
+#define REG_CON_STO_CFG(cfg) ((cfg) << 14)
+
 /* REG_MRXADDR bits */
 #define REG_MRXADDR_VALID(x) BIT(24 + (x)) /* [x*8+7:x*8] of MRX[R]ADDR valid */
 
@@ -124,10 +128,15 @@ static const struct i2c_spec_values fast_mode_spec = {
  * struct rk3x_i2c_calced_timings:
  * @div_low: Divider output for low
  * @div_high: Divider output for high
+ * @tuning: Used to adjust setup/hold data time,
+ * setup/hold start time and setup stop time for
+ * v1's calc_timings, the tuning should all be 0
+ * for old hardware anyone using v0's calc_timings.
  */
 struct rk3x_i2c_calced_timings {
 	unsigned long div_low;
 	unsigned long div_high;
+	unsigned int tuning;
 };
 
 enum rk3x_i2c_state {
@@ -141,9 +150,12 @@ enum rk3x_i2c_state {
 
 /**
  * @grf_offset: offset inside the grf regmap for setting the i2c type
+ * @calc_timings: Callback function for i2c timing information calculated
  */
 struct rk3x_i2c_soc_data {
 	int grf_offset;
+	int (*calc_timings)(unsigned long, struct i2c_timings *,
+			    struct rk3x_i2c_calced_timings *);
 };
 
 /**
@@ -152,9 +164,11 @@ struct rk3x_i2c_soc_data {
  * @dev: device for this controller
  * @soc_data: related soc data struct
  * @regs: virtual memory area
- * @clk: clock of i2c bus
+ * @clk: function clk for rk3399 or function & Bus clks for others
+ * @pclk: Bus clk for rk3399
  * @clk_rate_nb: i2c clk rate change notify
  * @t: I2C known timing information
+ * @t_calc: I2C timing information need to be calculated
  * @lock: spinlock for the i2c bus
  * @wait: the waitqueue to wait for i2c transfer
  * @busy: the condition for the event to wait for
@@ -174,10 +188,12 @@ struct rk3x_i2c {
 	/* Hardware resources */
 	void __iomem *regs;
 	struct clk *clk;
+	struct clk *pclk;
 	struct notifier_block clk_rate_nb;
 
 	/* Settings */
 	struct i2c_timings t;
+	struct rk3x_i2c_calced_timings t_calc;
 
 	/* Synchronization & notification */
 	spinlock_t lock;
@@ -218,13 +234,13 @@ static inline void rk3x_i2c_clean_ipd(struct rk3x_i2c *i2c)
  */
 static void rk3x_i2c_start(struct rk3x_i2c *i2c)
 {
-	u32 val;
+	u32 val = i2c->t_calc.tuning;
 
 	i2c->state = STATE_START;
 	i2c_writel(i2c, REG_INT_START, REG_IEN);
 
 	/* enable adapter with correct mode, send START condition */
-	val = REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
+	val |= REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
 
 	/* if we want to react to NACK, set ACTACK bit */
 	if (!(i2c->msg->flags & I2C_M_IGNORE_NAK))
@@ -533,9 +549,9 @@ static const struct i2c_spec_values *rk3x_i2c_get_spec(unsigned int speed)
  * a best-effort divider value is returned in divs. If the target rate is
  * too high, we silently use the highest possible rate.
  */
-static int rk3x_i2c_calc_divs(unsigned long clk_rate,
-			      struct i2c_timings *t,
-			      struct rk3x_i2c_calced_timings *t_calc)
+static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
+				    struct i2c_timings *t,
+				    struct rk3x_i2c_calced_timings *t_calc)
 {
 	unsigned long min_low_ns, min_high_ns;
 	unsigned long max_low_ns, min_total_ns;
@@ -681,23 +697,189 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 	return ret;
 }
 
+/**
+ * Calculate timing values for desired SCL frequency
+ *
+ * @clk_rate: I2C input clock rate
+ * @t: Known I2C timing information
+ * @t_calc: Caculated rk3x private timings that would be written into regs
+
+ * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
+ * a best-effort divider value is returned in divs. If the target rate is
+ * too high, we silently use the highest possible rate.
+ * The following formulas are v1's method to calculate timings.
+ *
+ * l = divl + 1;
+ * h = divh + 1;
+ * s = sda_update_config + 1;
+ * u = start_setup_config + 1;
+ * p = stop_setup_config + 1;
+ * T = Tclk_i2c;
+
+ * tHigh = 8 * h * T;
+ * tLow = 8 * l * T;
+
+ * tHD;sda = (l * s + 1) * T;
+ * tSU;sda = [(8 - s) * l + 1] * T;
+ * tI2C = 8 * (l + h) * T;
+
+ * tSU;sta = (8h * u + 1) * T;
+ * tHD;sta = [8h * (u + 1) - 1] * T;
+ * tSU;sto = (8h * p + 1) * T;
+ */
+static int rk3x_i2c_v1_calc_timings(unsigned long clk_rate,
+				    struct i2c_timings *t,
+				    struct rk3x_i2c_calced_timings *t_calc)
+{
+	unsigned long min_low_ns, min_high_ns, min_total_ns;
+	unsigned long min_setup_start_ns, min_setup_data_ns;
+	unsigned long min_setup_stop_ns, max_hold_data_ns;
+
+	unsigned long clk_rate_khz, scl_rate_khz;
+
+	unsigned long min_low_div, min_high_div;
+
+	unsigned long min_div_for_hold, min_total_div;
+	unsigned long extra_div, extra_low_div;
+	unsigned long sda_update_cfg, stp_sta_cfg, stp_sto_cfg;
+
+	const struct i2c_spec_values *spec;
+	int ret = 0;
+
+	/* Support standard-mode and fast-mode */
+	if (WARN_ON(t->bus_freq_hz > 400000))
+		t->bus_freq_hz = 400000;
+
+	/* prevent scl_rate_khz from becoming 0 */
+	if (WARN_ON(t->bus_freq_hz < 1000))
+		t->bus_freq_hz = 1000;
+
+	/*
+	 * min_low_ns: The minimum number of ns we need to hold low to
+	 *	       meet I2C specification, should include fall time.
+	 * min_high_ns: The minimum number of ns we need to hold high to
+	 *	        meet I2C specification, should include rise time.
+	 */
+	spec = rk3x_i2c_get_spec(t->bus_freq_hz);
+
+	/* calculate min-divh and min-divl */
+	clk_rate_khz = DIV_ROUND_UP(clk_rate, 1000);
+	scl_rate_khz = t->bus_freq_hz / 1000;
+	min_total_div = DIV_ROUND_UP(clk_rate_khz, scl_rate_khz * 8);
+
+	min_high_ns = t->scl_rise_ns + spec->min_high_ns;
+	min_high_div = DIV_ROUND_UP(clk_rate_khz * min_high_ns, 8 * 1000000);
+
+	min_low_ns = t->scl_fall_ns + spec->min_low_ns;
+	min_low_div = DIV_ROUND_UP(clk_rate_khz * min_low_ns, 8 * 1000000);
+
+	/* Final divh and divl must be greater than 0, otherwise the
+	 * hardware would not output the i2c clk.
+	 */
+	min_high_div = (min_high_div < 1) ? 2 : min_high_div;
+	min_low_div = (min_low_div < 1) ? 2 : min_low_div;
+
+	/* These are the min dividers needed for min hold times. */
+	min_div_for_hold = (min_low_div + min_high_div);
+	min_total_ns = min_low_ns + min_high_ns;
+
+	/*
+	 * This is the maximum divider so we don't go over the maximum.
+	 * We don't round up here (we round down) since this is a maximum.
+	 */
+	 if (min_div_for_hold >= min_total_div) {
+		/*
+		 * Time needed to meet hold requirements is important.
+		 * Just use that.
+		 */
+		t_calc->div_low = min_low_div;
+		t_calc->div_high = min_high_div;
+	} else {
+		/*
+		 * We've got to distribute some time among the low and high
+		 * so we don't run too fast.
+		 * We'll try to split things up by the scale of min_low_div and
+		 * min_high_div, biasing slightly towards having a higher div
+		 * for low (spend more time low).
+		 */
+		extra_div = min_total_div - min_div_for_hold;
+		extra_low_div = DIV_ROUND_UP(min_low_div * extra_div,
+					     min_div_for_hold);
+
+		t_calc->div_low = min_low_div + extra_low_div;
+		t_calc->div_high = min_high_div + (extra_div - extra_low_div);
+	}
+
+	/*
+	 * calculate sda data hold count by the rules, data_upd_st:3
+	 * is a appropriate value to reduce calculated times.
+	 */
+	for (sda_update_cfg = 3; sda_update_cfg > 0; sda_update_cfg--) {
+		max_hold_data_ns =  DIV_ROUND_UP((sda_update_cfg
+						 * (t_calc->div_low) + 1)
+						 * 1000000, clk_rate_khz);
+		min_setup_data_ns =  DIV_ROUND_UP(((8 - sda_update_cfg)
+						 * (t_calc->div_low) + 1)
+						 * 1000000, clk_rate_khz);
+		if ((max_hold_data_ns < spec->max_data_hold_ns) &&
+		    (min_setup_data_ns > spec->min_data_setup_ns))
+			break;
+	}
+
+	/* calculate setup start config */
+	min_setup_start_ns = t->scl_rise_ns + spec->min_setup_start_ns;
+	stp_sta_cfg = DIV_ROUND_UP(clk_rate_khz * min_setup_start_ns
+			   - 1000000, 8 * 1000000 * (t_calc->div_high));
+
+	/* calculate setup stop config */
+	min_setup_stop_ns = t->scl_rise_ns + spec->min_setup_stop_ns;
+	stp_sto_cfg = DIV_ROUND_UP(clk_rate_khz * min_setup_stop_ns
+			   - 1000000, 8 * 1000000 * (t_calc->div_high));
+
+	t_calc->tuning = REG_CON_SDA_CFG(--sda_update_cfg) |
+			 REG_CON_STA_CFG(--stp_sta_cfg) |
+			 REG_CON_STO_CFG(--stp_sto_cfg);
+
+	t_calc->div_low--;
+	t_calc->div_high--;
+
+	/* Maximum divider supported by hw is 0xffff */
+	if (t_calc->div_low > 0xffff) {
+		t_calc->div_low = 0xffff;
+		ret = -EINVAL;
+	}
+
+	if (t_calc->div_high > 0xffff) {
+		t_calc->div_high = 0xffff;
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 {
 	struct i2c_timings *t = &i2c->t;
-	struct rk3x_i2c_calced_timings calc;
+	struct rk3x_i2c_calced_timings *calc = &i2c->t_calc;
 	u64 t_low_ns, t_high_ns;
 	int ret;
 
-	ret = rk3x_i2c_calc_divs(clk_rate, t, &calc);
+	ret = i2c->soc_data->calc_timings(clk_rate, t, calc);
 	WARN_ONCE(ret != 0, "Could not reach SCL freq %u", t->bus_freq_hz);
 
-	clk_enable(i2c->clk);
-	i2c_writel(i2c, (calc.div_high << 16) | (calc.div_low & 0xffff),
+	if (i2c->pclk)
+		clk_enable(i2c->pclk);
+	else
+		clk_enable(i2c->clk);
+	i2c_writel(i2c, (calc->div_high << 16) | (calc->div_low & 0xffff),
 		   REG_CLKDIV);
-	clk_disable(i2c->clk);
+	if (i2c->pclk)
+		clk_disable(i2c->pclk);
+	else
+		clk_disable(i2c->clk);
 
-	t_low_ns = div_u64(((u64)calc.div_low + 1) * 8 * 1000000000, clk_rate);
-	t_high_ns = div_u64(((u64)calc.div_high + 1) * 8 * 1000000000,
+	t_low_ns = div_u64(((u64)calc->div_low + 1) * 8 * 1000000000, clk_rate);
+	t_high_ns = div_u64(((u64)calc->div_high + 1) * 8 * 1000000000,
 			    clk_rate);
 	dev_dbg(i2c->dev,
 		"CLK %lukhz, Req %uns, Act low %lluns high %lluns\n",
@@ -728,11 +910,11 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 {
 	struct clk_notifier_data *ndata = data;
 	struct rk3x_i2c *i2c = container_of(nb, struct rk3x_i2c, clk_rate_nb);
-	struct rk3x_i2c_calced_timings calc;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
-		if (rk3x_i2c_calc_divs(ndata->new_rate, &i2c->t, &calc) != 0)
+		if (i2c->soc_data->calc_timings(ndata->new_rate, &i2c->t,
+						&i2c->t_calc) != 0)
 			return NOTIFY_STOP;
 
 		/* scale up */
@@ -847,6 +1029,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 
 	spin_lock_irqsave(&i2c->lock, flags);
 
+	if (i2c->pclk)
+		clk_enable(i2c->pclk);
 	clk_enable(i2c->clk);
 
 	i2c->is_last_msg = false;
@@ -881,7 +1065,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 
 			/* Force a STOP condition without interrupt */
 			i2c_writel(i2c, 0, REG_IEN);
-			i2c_writel(i2c, REG_CON_EN | REG_CON_STOP, REG_CON);
+			i2c_writel(i2c, i2c->t_calc.tuning | REG_CON_EN |
+				   REG_CON_STOP, REG_CON);
 
 			i2c->state = STATE_IDLE;
 
@@ -896,6 +1081,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 	}
 
 	clk_disable(i2c->clk);
+	if (i2c->pclk)
+		clk_disable(i2c->pclk);
 	spin_unlock_irqrestore(&i2c->lock, flags);
 
 	return ret < 0 ? ret : num;
@@ -913,18 +1100,27 @@ static const struct i2c_algorithm rk3x_i2c_algorithm = {
 
 static const struct rk3x_i2c_soc_data rk3066_soc_data = {
 	.grf_offset = 0x154,
+	.calc_timings = rk3x_i2c_v0_calc_timings,
 };
 
 static const struct rk3x_i2c_soc_data rk3188_soc_data = {
 	.grf_offset = 0x0a4,
+	.calc_timings = rk3x_i2c_v0_calc_timings,
 };
 
 static const struct rk3x_i2c_soc_data rk3228_soc_data = {
 	.grf_offset = -1,
+	.calc_timings = rk3x_i2c_v0_calc_timings,
 };
 
 static const struct rk3x_i2c_soc_data rk3288_soc_data = {
 	.grf_offset = -1,
+	.calc_timings = rk3x_i2c_v0_calc_timings,
+};
+
+static const struct rk3x_i2c_soc_data rk3399_soc_data = {
+	.grf_offset = -1,
+	.calc_timings = rk3x_i2c_v1_calc_timings,
 };
 
 static const struct of_device_id rk3x_i2c_match[] = {
@@ -944,6 +1140,10 @@ static const struct of_device_id rk3x_i2c_match[] = {
 		.compatible = "rockchip,rk3288-i2c",
 		.data = (void *)&rk3288_soc_data
 	},
+	{
+		.compatible = "rockchip,rk3399-i2c",
+		.data = (void *)&rk3399_soc_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rk3x_i2c_match);
@@ -983,12 +1183,6 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
 
-	i2c->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(i2c->clk)) {
-		dev_err(&pdev->dev, "cannot get clock\n");
-		return PTR_ERR(i2c->clk);
-	}
-
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2c->regs = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(i2c->regs))
@@ -1042,17 +1236,38 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
+	i2c->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(i2c->clk)) {
+		dev_err(&pdev->dev, "cannot get clock\n");
+		return PTR_ERR(i2c->clk);
+	}
+
 	ret = clk_prepare(i2c->clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not prepare clock\n");
 		return ret;
 	}
 
+	if (i2c->soc_data->calc_timings == rk3x_i2c_v1_calc_timings) {
+		i2c->pclk = devm_clk_get(&pdev->dev, "pclk");
+		if (IS_ERR(i2c->pclk)) {
+			dev_err(i2c->dev, "Could not get i2c pclk\n");
+			ret = PTR_ERR(i2c->pclk);
+			goto err_clk;
+		}
+
+		ret = clk_prepare(i2c->pclk);
+		if (ret) {
+			dev_err(i2c->dev, "Could not prepare pclk\n");
+			goto err_clk;
+		}
+	}
+
 	i2c->clk_rate_nb.notifier_call = rk3x_i2c_clk_notifier_cb;
 	ret = clk_notifier_register(i2c->clk, &i2c->clk_rate_nb);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Unable to register clock notifier\n");
-		goto err_clk;
+		goto err_pclk;
 	}
 
 	clk_rate = clk_get_rate(i2c->clk);
@@ -1070,6 +1285,9 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 err_clk_notifier:
 	clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
+err_pclk:
+	if (i2c->pclk)
+		clk_unprepare(i2c->pclk);
 err_clk:
 	clk_unprepare(i2c->clk);
 	return ret;
@@ -1082,6 +1300,8 @@ static int rk3x_i2c_remove(struct platform_device *pdev)
 	i2c_del_adapter(&i2c->adap);
 
 	clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
+	if (i2c->pclk)
+		clk_unprepare(i2c->pclk);
 	clk_unprepare(i2c->clk);
 
 	return 0;
-- 
1.9.1
