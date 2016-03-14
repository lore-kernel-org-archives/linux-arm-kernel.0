From: wdc@rock-chips.com (David Wu)
Date: Tue, 15 Mar 2016 06:52:29 +0800
Subject: [PATCH v4 2/3] i2c: rk3x: add new method to caculate i2c timings for
 rk3399
In-Reply-To: <1457995950-46710-1-git-send-email-wdc@rock-chips.com>
References: <1457995950-46710-1-git-send-email-wdc@rock-chips.com>
Message-ID: <1457995950-46710-3-git-send-email-wdc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was an timing issue about "repeated start" time at the I2C
controller of version0, controller appears to drop SDA at .875x (7/8)
programmed clk high. On version 1 of the controller, the rule(.875x)
isn't enough to meet tSU;STA
requirements on 100k's Standard-mode. To resolve this issue,
sda_update_config, start_setup_config and stop_setup_config for I2C
timing information are added, new rules are designed to calculate
the timing information at new v1.

And pclk and sclk are treated individually at new v1.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
Changes in v4:
- pclk and sclk are treated individually
- use switch-case to seperate from different version (Andy)
- fix dead loop form Julia's notice

Change in v3:
- Too many arguments for ops func, use struct for them(Andy)

 drivers/i2c/busses/i2c-rk3x.c | 380 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 328 insertions(+), 52 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index c4b0d89..c82c2f9 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -25,6 +25,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/math64.h>
+#include <linux/property.h>
 
 
 /* Register Map */
@@ -58,6 +59,16 @@ enum {
 #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last received byte */
 #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
 
+#define REG_CON_SDA_CNT(cnt)  ((cnt) << 8)
+#define REG_CON_STA_CNT(cnt)  ((cnt) << 12)
+#define REG_CON_STO_CNT(cnt)  ((cnt) << 14)
+
+#define VERSION_MASK	  GENMASK(31, 16)
+#define VERSION_SHIFT	  16
+
+#define RK3X_I2C_V0	  0x0
+#define RK3X_I2C_V1	  0x1
+
 /* REG_MRXADDR bits */
 #define REG_MRXADDR_VALID(x) BIT(24 + (x)) /* [x*8+7:x*8] of MRX[R]ADDR valid */
 
@@ -90,18 +101,44 @@ struct rk3x_i2c_soc_data {
 	int grf_offset;
 };
 
+/**
+ * struct rk3x_i2c_calced_timings:
+ * @div_low: Divider output for low
+ * @div_high: Divider output for high
+ * @sda_update_cfg: Used to config sda change state when scl is low,
+ * used to adjust setup/hold time
+ * @stp_sta_cfg: Start setup config for setup start time and hold start time
+ * @stp_sto_cfg: Stop setup config for setup stop time
+ */
+struct rk3x_i2c_calced_timings {
+	unsigned long div_low;
+	unsigned long div_high;
+	unsigned int sda_update_cfg;
+	unsigned int stp_sta_cfg;
+	unsigned int stp_sto_cfg;
+};
+
+struct rk3x_i2c_ops {
+	int (*calc_timings)(unsigned long,
+			    struct i2c_timings *,
+			    struct rk3x_i2c_calced_timings *);
+};
+
 struct rk3x_i2c {
 	struct i2c_adapter adap;
 	struct device *dev;
 	struct rk3x_i2c_soc_data *soc_data;
+	struct rk3x_i2c_ops ops;
 
 	/* Hardware resources */
 	void __iomem *regs;
-	struct clk *clk;
+	struct clk *pclk;
+	struct clk *sclk;
 	struct notifier_block clk_rate_nb;
 
 	/* Settings */
 	struct i2c_timings t;
+	struct rk3x_i2c_calced_timings t_calc;
 
 	/* Synchronization & notification */
 	spinlock_t lock;
@@ -131,6 +168,13 @@ static inline u32 i2c_readl(struct rk3x_i2c *i2c, unsigned int offset)
 	return readl(i2c->regs + offset);
 }
 
+static inline u32 rk3x_i2c_get_con_count(struct rk3x_i2c *i2c)
+{
+	return REG_CON_SDA_CNT(i2c->t_calc.sda_update_cfg) |
+	       REG_CON_STA_CNT(i2c->t_calc.stp_sta_cfg) |
+	       REG_CON_STO_CNT(i2c->t_calc.stp_sto_cfg);
+}
+
 /* Reset all interrupt pending bits */
 static inline void rk3x_i2c_clean_ipd(struct rk3x_i2c *i2c)
 {
@@ -142,13 +186,13 @@ static inline void rk3x_i2c_clean_ipd(struct rk3x_i2c *i2c)
  */
 static void rk3x_i2c_start(struct rk3x_i2c *i2c)
 {
-	u32 val;
+	u32 val = rk3x_i2c_get_con_count(i2c);
 
 	rk3x_i2c_clean_ipd(i2c);
 	i2c_writel(i2c, REG_INT_START, REG_IEN);
 
 	/* enable adapter with correct mode, send START condition */
-	val = REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
+	val = val | REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
 
 	/* if we want to react to NACK, set ACTACK bit */
 	if (!(i2c->msg->flags & I2C_M_IGNORE_NAK))
@@ -189,7 +233,7 @@ static void rk3x_i2c_stop(struct rk3x_i2c *i2c, int error)
 		 * get the intended effect by resetting its internal state
 		 * and issuing an ordinary START.
 		 */
-		i2c_writel(i2c, 0, REG_CON);
+		i2c_writel(i2c, rk3x_i2c_get_con_count(i2c), REG_CON);
 
 		/* signal that we are finished with the current msg */
 		wake_up(&i2c->wait);
@@ -431,21 +475,22 @@ out:
 }
 
 /**
- * Calculate divider values for desired SCL frequency
+ * Calculate timing values for desired SCL frequency
  *
  * @clk_rate: I2C input clock rate
  * @t: Known I2C timing information.
  * @div_low: Divider output for low
  * @div_high: Divider output for high
+ * @t_calc: Caculated rk3x private timings  that would
+ * be written into regs
  *
  * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
  * a best-effort divider value is returned in divs. If the target rate is
  * too high, we silently use the highest possible rate.
  */
-static int rk3x_i2c_calc_divs(unsigned long clk_rate,
-			      struct i2c_timings *t,
-			      unsigned long *div_low,
-			      unsigned long *div_high)
+static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
+				    struct i2c_timings *t,
+				    struct rk3x_i2c_calced_timings *t_calc)
 {
 	unsigned long spec_min_low_ns, spec_min_high_ns;
 	unsigned long spec_setup_start, spec_max_data_hold_ns;
@@ -552,8 +597,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 		 * Time needed to meet hold requirements is important.
 		 * Just use that.
 		 */
-		*div_low = min_low_div;
-		*div_high = min_high_div;
+		t_calc->div_low = min_low_div;
+		t_calc->div_high = min_high_div;
 	} else {
 		/*
 		 * We've got to distribute some time among the low and high
@@ -582,25 +627,204 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 
 		/* Give low the "ideal" and give high whatever extra is left */
 		extra_low_div = ideal_low_div - min_low_div;
-		*div_low = ideal_low_div;
-		*div_high = min_high_div + (extra_div - extra_low_div);
+		t_calc->div_low = ideal_low_div;
+		t_calc->div_high = min_high_div + (extra_div - extra_low_div);
 	}
 
 	/*
 	 * Adjust to the fact that the hardware has an implicit "+1".
 	 * NOTE: Above calculations always produce div_low > 0 and div_high > 0.
 	 */
-	*div_low = *div_low - 1;
-	*div_high = *div_high - 1;
+	t_calc->div_low -= 1;
+	t_calc->div_high -=  1;
 
 	/* Maximum divider supported by hw is 0xffff */
-	if (*div_low > 0xffff) {
-		*div_low = 0xffff;
+	if (t_calc->div_low > 0xffff) {
+		t_calc->div_low = 0xffff;
 		ret = -EINVAL;
 	}
 
-	if (*div_high > 0xffff) {
-		*div_high = 0xffff;
+	if (t_calc->div_high > 0xffff) {
+		t_calc->div_high = 0xffff;
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * Calculate timing values for desired SCL frequency
+ *
+ * @clk_rate: I2C input clock rate
+ * @t: Known I2C timing information
+ * @t_calc: Caculated rk3x private timings that would
+ * be written into regs
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
+	unsigned long spec_min_low_ns, spec_min_high_ns;
+	unsigned long spec_min_setup_start_ns, spec_min_stop_setup_ns;
+	unsigned long spec_min_data_setup_ns, spec_max_data_hold_ns;
+
+	unsigned long min_low_ns, min_high_ns, min_total_ns;
+	unsigned long min_setup_start_ns, min_setup_data_ns;
+	unsigned long min_stop_setup_ns, max_hold_data_ns;
+
+	unsigned long clk_rate_khz, scl_rate_khz;
+
+	unsigned long min_low_div, min_high_div;
+
+	unsigned long min_div_for_hold, min_total_div;
+	unsigned long extra_div, extra_low_div;
+	unsigned long sda_update_cfg;
+
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
+	if (t->bus_freq_hz <= 100000) {
+		spec_min_low_ns = 4700;
+		spec_min_high_ns = 4000;
+
+		spec_min_setup_start_ns = 4700;
+		spec_min_stop_setup_ns = 4000;
+
+		spec_min_data_setup_ns = 250;
+                spec_max_data_hold_ns = 3450;
+	} else if (t->bus_freq_hz <= 400000) {
+		spec_min_low_ns = 1300;
+		spec_min_high_ns = 600;
+
+		spec_min_setup_start_ns = 600;
+		spec_min_stop_setup_ns = 600;
+
+		spec_min_data_setup_ns = 100;
+		spec_max_data_hold_ns = 900;
+	}
+
+	/* caculate min-divh and min-divl */
+	clk_rate_khz = DIV_ROUND_UP(clk_rate, 1000);
+	scl_rate_khz = t->bus_freq_hz / 1000;
+	min_total_div = DIV_ROUND_UP(clk_rate_khz, scl_rate_khz * 8);
+
+	min_high_ns = t->scl_rise_ns + spec_min_high_ns;
+	min_high_div = DIV_ROUND_UP(clk_rate_khz * min_high_ns, 8 * 1000000);
+
+	min_low_ns = t->scl_fall_ns + spec_min_low_ns;
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
+		if ((max_hold_data_ns < spec_max_data_hold_ns) &&
+		    (min_setup_data_ns > spec_min_data_setup_ns)) {
+			t_calc->sda_update_cfg = sda_update_cfg;
+			break;
+		}
+	}
+
+	/* caculate setup start config */
+	min_setup_start_ns = t->scl_rise_ns + spec_min_setup_start_ns;
+	t_calc->stp_sta_cfg = DIV_ROUND_UP(clk_rate_khz * min_setup_start_ns
+			   - 1000000, 8 * 1000000 * (t_calc->div_high));
+
+	/* caculate setup stop config */
+	min_stop_setup_ns = t->scl_rise_ns + spec_min_stop_setup_ns;
+	t_calc->stp_sto_cfg = DIV_ROUND_UP(clk_rate_khz * min_stop_setup_ns
+			   - 1000000, 8 * 1000000 * (t_calc->div_high));
+
+	t_calc->stp_sta_cfg -= 1;
+	t_calc->stp_sto_cfg -= 1;
+	t_calc->sda_update_cfg -= 1;
+
+	t_calc->div_low -= 1;
+	t_calc->div_high -= 1;
+
+	/* Maximum divider supported by hw is 0xffff */
+	if ((t_calc->div_low > 0xffff) || (t_calc->div_high > 0xffff)) {
+		t_calc->div_low = 0xffff;
+		t_calc->div_high = 0xffff;
 		ret = -EINVAL;
 	}
 
@@ -610,19 +834,22 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 {
 	struct i2c_timings *t = &i2c->t;
-	unsigned long div_low, div_high;
+	struct rk3x_i2c_calced_timings *t_calc = &i2c->t_calc;
 	u64 t_low_ns, t_high_ns;
 	int ret;
 
-	ret = rk3x_i2c_calc_divs(clk_rate, t, &div_low, &div_high);
+	ret = i2c->ops.calc_timings(clk_rate, t, t_calc);
 	WARN_ONCE(ret != 0, "Could not reach SCL freq %u", t->bus_freq_hz);
 
-	clk_enable(i2c->clk);
-	i2c_writel(i2c, (div_high << 16) | (div_low & 0xffff), REG_CLKDIV);
-	clk_disable(i2c->clk);
+	clk_enable(i2c->pclk);
+	i2c_writel(i2c, (t_calc->div_high << 16) |
+		  (t_calc->div_low & 0xffff), REG_CLKDIV);
+	clk_disable(i2c->pclk);
 
-	t_low_ns = div_u64(((u64)div_low + 1) * 8 * 1000000000, clk_rate);
-	t_high_ns = div_u64(((u64)div_high + 1) * 8 * 1000000000, clk_rate);
+	t_low_ns = div_u64(((u64)t_calc->div_low + 1) * 8 * 1000000000,
+			   clk_rate);
+	t_high_ns = div_u64(((u64)t_calc->div_high + 1) * 8 * 1000000000,
+			    clk_rate);
 	dev_dbg(i2c->dev,
 		"CLK %lukhz, Req %uns, Act low %lluns high %lluns\n",
 		clk_rate / 1000,
@@ -652,12 +879,12 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 {
 	struct clk_notifier_data *ndata = data;
 	struct rk3x_i2c *i2c = container_of(nb, struct rk3x_i2c, clk_rate_nb);
-	unsigned long div_low, div_high;
+	struct i2c_timings *t = &i2c->t;
+	struct rk3x_i2c_calced_timings *t_calc = &i2c->t_calc;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
-		if (rk3x_i2c_calc_divs(ndata->new_rate, &i2c->t,
-				       &div_low, &div_high) != 0)
+		if (i2c->ops.calc_timings(ndata->new_rate, t, t_calc) != 0)
 			return NOTIFY_STOP;
 
 		/* scale up */
@@ -772,7 +999,9 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 
 	spin_lock_irqsave(&i2c->lock, flags);
 
-	clk_enable(i2c->clk);
+	clk_enable(i2c->pclk);
+	if (i2c->sclk)
+		clk_enable(i2c->sclk);
 
 	i2c->is_last_msg = false;
 
@@ -806,7 +1035,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 
 			/* Force a STOP condition without interrupt */
 			i2c_writel(i2c, 0, REG_IEN);
-			i2c_writel(i2c, REG_CON_EN | REG_CON_STOP, REG_CON);
+			i2c_writel(i2c, rk3x_i2c_get_con_count(i2c) |
+				   REG_CON_EN | REG_CON_STOP, REG_CON);
 
 			i2c->state = STATE_IDLE;
 
@@ -820,7 +1050,9 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 		}
 	}
 
-	clk_disable(i2c->clk);
+	if (i2c->sclk)
+		clk_disable(i2c->sclk);
+	clk_disable(i2c->pclk);
 	spin_unlock_irqrestore(&i2c->lock, flags);
 
 	return ret < 0 ? ret : num;
@@ -860,7 +1092,8 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	int bus_nr;
 	u32 value;
 	int irq;
-	unsigned long clk_rate;
+	struct clk *sclk;
+	unsigned int clk_rate;
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(struct rk3x_i2c), GFP_KERNEL);
 	if (!i2c)
@@ -879,18 +1112,11 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	i2c->adap.dev.of_node = np;
 	i2c->adap.algo_data = i2c;
 	i2c->adap.dev.parent = &pdev->dev;
-
 	i2c->dev = &pdev->dev;
 
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
@@ -944,22 +1170,63 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
-	ret = clk_prepare(i2c->clk);
+	i2c->pclk = devm_clk_get(&pdev->dev, "i2c");
+	if (IS_ERR(i2c->pclk)) {
+		dev_err(&pdev->dev, "cannot get i2c pclk\n");
+		return PTR_ERR(i2c->pclk);
+	}
+
+	ret = clk_prepare(i2c->pclk);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Could not prepare clock\n");
+		dev_err(&pdev->dev, "Could not prepare pclk\n");
 		return ret;
 	}
 
+	value = readl(i2c->regs + REG_CON);
+	switch ((value & VERSION_MASK) >> VERSION_SHIFT) {
+	case RK3X_I2C_V1:
+		i2c->ops.calc_timings = rk3x_i2c_v1_calc_timings;
+		/* sclk and pclk need to do individually*/
+		i2c->sclk = devm_clk_get(&pdev->dev, "i2c_sclk");
+		if (IS_ERR(i2c->sclk)) {
+			dev_err(&pdev->dev, "cannot get i2c sclk\n");
+			ret = PTR_ERR(i2c->sclk);
+			goto err_pclk;
+		}
+		ret = clk_prepare(i2c->sclk);
+		if (ret) {
+			dev_err(i2c->dev, "pclk prepare failed %d\n", ret);
+			goto err_pclk;
+		}
+		if (!device_property_read_u32(&pdev->dev, "input-clk-rate",
+					      &clk_rate)) {
+			ret = clk_set_rate(i2c->sclk, clk_rate);
+			if (ret)
+				goto err_pclk;
+		} else {
+			/* use default input clock rate */
+			clk_rate = clk_get_rate(i2c->sclk);
+		}
+
+		break;
+	case RK3X_I2C_V0:
+	default:
+		i2c->ops.calc_timings = rk3x_i2c_v0_calc_timings;
+		/* sclk and pclk are the same clock */
+		sclk = i2c->pclk;
+		clk_rate = clk_get_rate(sclk);
+
+		break;
+	}
+
 	i2c->clk_rate_nb.notifier_call = rk3x_i2c_clk_notifier_cb;
-	ret = clk_notifier_register(i2c->clk, &i2c->clk_rate_nb);
+	ret = clk_notifier_register(sclk, &i2c->clk_rate_nb);
 	if (ret != 0) {
-		dev_err(&pdev->dev, "Unable to register clock notifier\n");
-		goto err_clk;
+		dev_err(&pdev->dev, "Unable to register clk notifier\n");
+		goto err_sclk;
 	}
 
-	clk_rate = clk_get_rate(i2c->clk);
 	rk3x_i2c_adapt_div(i2c, clk_rate);
-
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register adapter\n");
@@ -971,9 +1238,12 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk_notifier:
-	clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
-err_clk:
-	clk_unprepare(i2c->clk);
+	clk_notifier_unregister(sclk, &i2c->clk_rate_nb);
+err_sclk:
+	if (i2c->sclk)
+		clk_unprepare(i2c->sclk);
+err_pclk:
+	clk_unprepare(i2c->pclk);
 	return ret;
 }
 
@@ -983,8 +1253,14 @@ static int rk3x_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adap);
 
-	clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
-	clk_unprepare(i2c->clk);
+	if (i2c->sclk) {
+		clk_notifier_unregister(i2c->sclk, &i2c->clk_rate_nb);
+		clk_unprepare(i2c->sclk);
+	} else {
+		clk_notifier_unregister(i2c->pclk, &i2c->clk_rate_nb);
+	}
+
+	clk_unprepare(i2c->pclk);
 
 	return 0;
 }
-- 
1.9.1
