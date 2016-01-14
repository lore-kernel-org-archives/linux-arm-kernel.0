From: david.wu@rock-chips.com (David Wu)
Date: Thu, 14 Jan 2016 20:31:37 +0800
Subject: [PATCH v3 2/4] i2c: rk3x: add ops to caculate i2c clocks
In-Reply-To: <1452774699-57455-1-git-send-email-david.wu@rock-chips.com>
References: <1452774699-57455-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1452774699-57455-3-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Wu <wdc@rock-chips.com>

I2c Controller of rk3x is updated for the rules to caculate clocks.
So it need a new method to caculate i2c clock timing information
for new version. The current method is defined as v0, and new is
v1, next maybe v2......

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
Changes in v3:
- use GENMASK(Andy)
- Too many arguments for ops func, use struct for them(Andy)

changes in v2:
- split patch to three patches(Heiko)

 drivers/i2c/busses/i2c-rk3x.c | 80 +++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 26 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 1d86e8c..185e0f9 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -58,6 +58,11 @@ enum {
 #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last received byte */
 #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
 
+#define VERSION_MASK	  GENMASK(31, 16)
+#define VERSION_SHIFT	  16
+
+#define RK3X_I2C_V0	  0x0
+
 /* REG_MRXADDR bits */
 #define REG_MRXADDR_VALID(x) BIT(24 + (x)) /* [x*8+7:x*8] of MRX[R]ADDR valid */
 
@@ -90,10 +95,27 @@ struct rk3x_i2c_soc_data {
 	int grf_offset;
 };
 
+/**
+ * struct rk3x_priv_i2c_timings - rk3x I2C timing information
+ * @div_low: Divider output for low
+ * @div_high: Divider output for high
+ */
+struct rk3x_priv_i2c_timings {
+	unsigned long div_low;
+	unsigned long div_high;
+};
+
+struct rk3x_i2c_ops {
+	int (*calc_clock)(unsigned long,
+			  struct i2c_timings *,
+			  struct rk3x_priv_i2c_timings *);
+};
+
 struct rk3x_i2c {
 	struct i2c_adapter adap;
 	struct device *dev;
 	struct rk3x_i2c_soc_data *soc_data;
+	struct rk3x_i2c_ops ops;
 
 	/* Hardware resources */
 	void __iomem *regs;
@@ -102,6 +124,7 @@ struct rk3x_i2c {
 
 	/* Settings */
 	struct i2c_timings t;
+	struct rk3x_priv_i2c_timings t_priv;
 
 	/* Synchronization & notification */
 	spinlock_t lock;
@@ -431,21 +454,20 @@ out:
 }
 
 /**
- * Calculate divider values for desired SCL frequency
+ * Calculate timing clock info values for desired SCL frequency
  *
  * @clk_rate: I2C input clock rate
- * @t_input: Known I2C timing information.
- * @div_low: Divider output for low
- * @div_high: Divider output for high
+ * @t_input: Known I2C timing information
+ * @t_output: Caculated rk3x private timing information that would
+ * be written into regs
  *
  * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
  * a best-effort divider value is returned in divs. If the target rate is
  * too high, we silently use the highest possible rate.
  */
-static int rk3x_i2c_calc_divs(unsigned long clk_rate,
-			      struct i2c_timings *t_input,
-			      unsigned long *div_low,
-			      unsigned long *div_high)
+static int rk3x_i2c_v0_calc_clock(unsigned long clk_rate,
+				  struct i2c_timings *t_input,
+				  struct rk3x_priv_i2c_timings *t_output)
 {
 	unsigned long spec_min_low_ns, spec_min_high_ns;
 	unsigned long spec_setup_start, spec_max_data_hold_ns;
@@ -553,8 +575,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 		 * Time needed to meet hold requirements is important.
 		 * Just use that.
 		 */
-		*div_low = min_low_div;
-		*div_high = min_high_div;
+		t_output->div_low = min_low_div;
+		t_output->div_high = min_high_div;
 	} else {
 		/*
 		 * We've got to distribute some time among the low and high
@@ -583,25 +605,25 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 
 		/* Give low the "ideal" and give high whatever extra is left */
 		extra_low_div = ideal_low_div - min_low_div;
-		*div_low = ideal_low_div;
-		*div_high = min_high_div + (extra_div - extra_low_div);
+		t_output->div_low = ideal_low_div;
+		t_output->div_high = min_high_div + (extra_div - extra_low_div);
 	}
 
 	/*
 	 * Adjust to the fact that the hardware has an implicit "+1".
 	 * NOTE: Above calculations always produce div_low > 0 and div_high > 0.
 	 */
-	*div_low = *div_low - 1;
-	*div_high = *div_high - 1;
+	t_output->div_low = t_output->div_low - 1;
+	t_output->div_high = t_output->div_high - 1;
 
 	/* Maximum divider supported by hw is 0xffff */
-	if (*div_low > 0xffff) {
-		*div_low = 0xffff;
+	if (t_output->div_low > 0xffff) {
+		t_output->div_low = 0xffff;
 		ret = -EINVAL;
 	}
 
-	if (*div_high > 0xffff) {
-		*div_high = 0xffff;
+	if (t_output->div_high > 0xffff) {
+		t_output->div_high = 0xffff;
 		ret = -EINVAL;
 	}
 
@@ -610,19 +632,21 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 
 static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 {
-	unsigned long div_low, div_high;
 	u64 t_low_ns, t_high_ns;
 	int ret;
 
-	ret = rk3x_i2c_calc_divs(clk_rate, &i2c->t, &div_low, &div_high);
+	ret = i2c->ops.calc_clock(clk_rate, &i2c->t, &i2c->t_priv);
 	WARN_ONCE(ret != 0, "Could not reach SCL freq %u", i2c->t.bus_freq_hz);
 
 	clk_enable(i2c->clk);
-	i2c_writel(i2c, (div_high << 16) | (div_low & 0xffff), REG_CLKDIV);
+	i2c_writel(i2c, (i2c->t_priv.div_high << 16) |
+		  (i2c->t_priv.div_low & 0xffff), REG_CLKDIV);
 	clk_disable(i2c->clk);
 
-	t_low_ns = div_u64(((u64)div_low + 1) * 8 * 1000000000, clk_rate);
-	t_high_ns = div_u64(((u64)div_high + 1) * 8 * 1000000000, clk_rate);
+	t_low_ns = div_u64(((u64)i2c->t_priv.div_low + 1) * 8 * 1000000000,
+			   clk_rate);
+	t_high_ns = div_u64(((u64)i2c->t_priv.div_high + 1) * 8 * 1000000000,
+			    clk_rate);
 	dev_dbg(i2c->dev,
 		"CLK %lukhz, Req %uns, Act low %lluns high %lluns\n",
 		clk_rate / 1000,
@@ -652,12 +676,11 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 {
 	struct clk_notifier_data *ndata = data;
 	struct rk3x_i2c *i2c = container_of(nb, struct rk3x_i2c, clk_rate_nb);
-	unsigned long div_low, div_high;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
-		if (rk3x_i2c_calc_divs(ndata->new_rate, &i2c->t,
-				       &div_low, &div_high) != 0)
+		if (i2c->ops.calc_clock(ndata->new_rate, &i2c->t,
+					&i2c->t_priv) != 0)
 			return NOTIFY_STOP;
 
 		/* scale up */
@@ -861,6 +884,7 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	u32 value;
 	int irq;
 	unsigned long clk_rate;
+	unsigned int version;
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(struct rk3x_i2c), GFP_KERNEL);
 	if (!i2c)
@@ -944,6 +968,10 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
+	version = (readl(i2c->regs + REG_CON) & VERSION_MASK) >> VERSION_SHIFT;
+	if (version == RK3X_I2C_V0)
+		i2c->ops.calc_clock = rk3x_i2c_v0_calc_clock;
+
 	ret = clk_prepare(i2c->clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not prepare clock\n");
-- 
1.9.1
