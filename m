From: david.wu@rock-chips.com (David Wu)
Date: Mon, 16 May 2016 22:05:03 +0800
Subject: [PATCH v10 7/8] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1463407503-41466-1-git-send-email-david.wu@rock-chips.com>
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
Tested-by: Caesar Wang <wxt@rock-chips.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
Change in v10:
- fix the clean of con register in rk3x_i2c_stop()

Change in v9:
- add spin lock for tuning updated in rk3x_i2c_adapt_div() (Doug) 

Changes in v8:
- update tuning in RKI2C_CON register by doing a read-modify-write (Doug)
- new method to use pclk and clk (Doug)

Changes in v7:
- transform into a 9 series patches (Doug)
- drop highspeed with mastercode, and support fast-mode plus (Doug)

 drivers/i2c/busses/i2c-rk3x.c | 294 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 274 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 9791797..a96b516 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -58,6 +58,12 @@ enum {
 #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last received byte */
 #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
 
+#define REG_CON_TUNING_MASK GENMASK(15, 8)
+
+#define REG_CON_SDA_CFG(cfg) ((cfg) << 8)
+#define REG_CON_STA_CFG(cfg) ((cfg) << 12)
+#define REG_CON_STO_CFG(cfg) ((cfg) << 14)
+
 /* REG_MRXADDR bits */
 #define REG_MRXADDR_VALID(x) BIT(24 + (x)) /* [x*8+7:x*8] of MRX[R]ADDR valid */
 
@@ -77,40 +83,62 @@ enum {
 
 /**
  * struct i2c_spec_values:
+ * @min_hold_start_ns: min hold time (repeated) START condition
  * @min_low_ns: min LOW period of the SCL clock
  * @min_high_ns: min HIGH period of the SCL cloc
  * @min_setup_start_ns: min set-up time for a repeated START conditio
  * @max_data_hold_ns: max data hold time
+ * @min_data_setup_ns: min data set-up time
+ * @min_setup_stop_ns: min set-up time for STOP condition
+ * @min_hold_buffer_ns: min bus free time between a STOP and
+ * START condition
  */
 struct i2c_spec_values {
+	unsigned long min_hold_start_ns;
 	unsigned long min_low_ns;
 	unsigned long min_high_ns;
 	unsigned long min_setup_start_ns;
 	unsigned long max_data_hold_ns;
+	unsigned long min_data_setup_ns;
+	unsigned long min_setup_stop_ns;
+	unsigned long min_hold_buffer_ns;
 };
 
 static const struct i2c_spec_values standard_mode_spec = {
+	.min_hold_start_ns = 4000,
 	.min_low_ns = 4700,
 	.min_high_ns = 4000,
 	.min_setup_start_ns = 4700,
 	.max_data_hold_ns = 3450,
+	.min_data_setup_ns = 250,
+	.min_setup_stop_ns = 4000,
+	.min_hold_buffer_ns = 4700,
 };
 
 static const struct i2c_spec_values fast_mode_spec = {
+	.min_hold_start_ns = 600,
 	.min_low_ns = 1300,
 	.min_high_ns = 600,
 	.min_setup_start_ns = 600,
 	.max_data_hold_ns = 900,
+	.min_data_setup_ns = 100,
+	.min_setup_stop_ns = 600,
+	.min_hold_buffer_ns = 1300,
 };
 
 /**
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
@@ -123,9 +151,12 @@ enum rk3x_i2c_state {
 
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
@@ -134,7 +165,8 @@ struct rk3x_i2c_soc_data {
  * @dev: device for this controller
  * @soc_data: related soc data struct
  * @regs: virtual memory area
- * @clk: clock of i2c bus
+ * @clk: function clk for rk3399 or function & Bus clks for others
+ * @pclk: Bus clk for rk3399
  * @clk_rate_nb: i2c clk rate change notify
  * @t: I2C known timing information
  * @lock: spinlock for the i2c bus
@@ -156,6 +188,7 @@ struct rk3x_i2c {
 	/* Hardware resources */
 	void __iomem *regs;
 	struct clk *clk;
+	struct clk *pclk;
 	struct notifier_block clk_rate_nb;
 
 	/* Settings */
@@ -200,12 +233,12 @@ static inline void rk3x_i2c_clean_ipd(struct rk3x_i2c *i2c)
  */
 static void rk3x_i2c_start(struct rk3x_i2c *i2c)
 {
-	u32 val;
+	u32 val = i2c_readl(i2c, REG_CON) & REG_CON_TUNING_MASK;
 
 	i2c_writel(i2c, REG_INT_START, REG_IEN);
 
 	/* enable adapter with correct mode, send START condition */
-	val = REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
+	val |= REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
 
 	/* if we want to react to NACK, set ACTACK bit */
 	if (!(i2c->msg->flags & I2C_M_IGNORE_NAK))
@@ -246,7 +279,8 @@ static void rk3x_i2c_stop(struct rk3x_i2c *i2c, int error)
 		 * get the intended effect by resetting its internal state
 		 * and issuing an ordinary START.
 		 */
-		i2c_writel(i2c, 0, REG_CON);
+		ctrl = i2c_readl(i2c, REG_CON) & REG_CON_TUNING_MASK;
+		i2c_writel(i2c, ctrl, REG_CON);
 
 		/* signal that we are finished with the current msg */
 		wake_up(&i2c->wait);
@@ -513,9 +547,9 @@ static const struct i2c_spec_values *rk3x_i2c_get_spec(unsigned int speed)
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
@@ -661,20 +695,191 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 	return ret;
 }
 
+/**
+ * Calculate timing values for desired SCL frequency
+ *
+ * @clk_rate: I2C input clock rate
+ * @t: Known I2C timing information
+ * @t_calc: Caculated rk3x private timings that would be written into regs
+ *
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
+ *
+ * tHigh = 8 * h * T;
+ * tLow = 8 * l * T;
+ *
+ * tHD;sda = (l * s + 1) * T;
+ * tSU;sda = [(8 - s) * l + 1] * T;
+ * tI2C = 8 * (l + h) * T;
+ *
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
+	/*
+	 * Final divh and divl must be greater than 0, otherwise the
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
 	struct rk3x_i2c_calced_timings calc;
 	u64 t_low_ns, t_high_ns;
+	unsigned long flags;
+	u32 val;
 	int ret;
 
-	ret = rk3x_i2c_calc_divs(clk_rate, t, &calc);
+	ret = i2c->soc_data->calc_timings(clk_rate, t, &calc);
 	WARN_ONCE(ret != 0, "Could not reach SCL freq %u", t->bus_freq_hz);
 
-	clk_enable(i2c->clk);
+	clk_enable(i2c->pclk);
+
+	spin_lock_irqsave(&i2c->lock, flags);
+	val = i2c_readl(i2c, REG_CON);
+	val &= ~REG_CON_TUNING_MASK;
+	val |= calc.tuning;
+	i2c_writel(i2c, val, REG_CON);
 	i2c_writel(i2c, (calc.div_high << 16) | (calc.div_low & 0xffff),
 		   REG_CLKDIV);
-	clk_disable(i2c->clk);
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	clk_disable(i2c->pclk);
 
 	t_low_ns = div_u64(((u64)calc.div_low + 1) * 8 * 1000000000, clk_rate);
 	t_high_ns = div_u64(((u64)calc.div_high + 1) * 8 * 1000000000,
@@ -712,7 +917,13 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
-		if (rk3x_i2c_calc_divs(ndata->new_rate, &i2c->t, &calc) != 0)
+		/*
+		 * Try the calculation (but don't store the result) ahead of
+		 * time to see if we need to block the clock change.  Timings
+		 * shouldn't actually take effect until rk3x_i2c_adapt_div().
+		 */
+		if (i2c->soc_data->calc_timings(ndata->new_rate, &i2c->t,
+						&calc) != 0)
 			return NOTIFY_STOP;
 
 		/* scale up */
@@ -822,12 +1033,14 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 {
 	struct rk3x_i2c *i2c = (struct rk3x_i2c *)adap->algo_data;
 	unsigned long timeout, flags;
+	u32 val;
 	int ret = 0;
 	int i;
 
 	spin_lock_irqsave(&i2c->lock, flags);
 
 	clk_enable(i2c->clk);
+	clk_enable(i2c->pclk);
 
 	i2c->is_last_msg = false;
 
@@ -861,7 +1074,9 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 
 			/* Force a STOP condition without interrupt */
 			i2c_writel(i2c, 0, REG_IEN);
-			i2c_writel(i2c, REG_CON_EN | REG_CON_STOP, REG_CON);
+			val = i2c_readl(i2c, REG_CON) & REG_CON_TUNING_MASK;
+			val |= REG_CON_EN | REG_CON_STOP;
+			i2c_writel(i2c, val, REG_CON);
 
 			i2c->state = STATE_IDLE;
 
@@ -875,7 +1090,9 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 		}
 	}
 
+	clk_disable(i2c->pclk);
 	clk_disable(i2c->clk);
+
 	spin_unlock_irqrestore(&i2c->lock, flags);
 
 	return ret < 0 ? ret : num;
@@ -893,18 +1110,27 @@ static const struct i2c_algorithm rk3x_i2c_algorithm = {
 
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
@@ -924,6 +1150,10 @@ static const struct of_device_id rk3x_i2c_match[] = {
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
@@ -963,12 +1193,6 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
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
@@ -1022,17 +1246,44 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
+	if (i2c->soc_data->calc_timings == rk3x_i2c_v0_calc_timings) {
+		/* Only one clock to use for bus clock and peripheral clock */
+		i2c->clk = devm_clk_get(&pdev->dev, NULL);
+		i2c->pclk = i2c->clk;
+	} else {
+		i2c->clk = devm_clk_get(&pdev->dev, "i2c");
+		i2c->pclk = devm_clk_get(&pdev->dev, "pclk");
+	}
+
+	if (IS_ERR(i2c->clk)) {
+		ret = PTR_ERR(i2c->clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Can't get bus clk: %d\n", ret);
+		return ret;
+	}
+	if (IS_ERR(i2c->pclk)) {
+		ret = PTR_ERR(i2c->pclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Can't get periph clk: %d\n", ret);
+		return ret;
+	}
+
 	ret = clk_prepare(i2c->clk);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Could not prepare clock\n");
+		dev_err(&pdev->dev, "Can't prepare bus clk: %d\n", ret);
 		return ret;
 	}
+	ret = clk_prepare(i2c->pclk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Can't prepare periph clock: %d\n", ret);
+		goto err_clk;
+	}
 
 	i2c->clk_rate_nb.notifier_call = rk3x_i2c_clk_notifier_cb;
 	ret = clk_notifier_register(i2c->clk, &i2c->clk_rate_nb);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Unable to register clock notifier\n");
-		goto err_clk;
+		goto err_pclk;
 	}
 
 	clk_rate = clk_get_rate(i2c->clk);
@@ -1050,6 +1301,8 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 err_clk_notifier:
 	clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
+err_pclk:
+	clk_unprepare(i2c->pclk);
 err_clk:
 	clk_unprepare(i2c->clk);
 	return ret;
@@ -1062,6 +1315,7 @@ static int rk3x_i2c_remove(struct platform_device *pdev)
 	i2c_del_adapter(&i2c->adap);
 
 	clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
+	clk_unprepare(i2c->pclk);
 	clk_unprepare(i2c->clk);
 
 	return 0;
-- 
1.9.1
