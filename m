From: wdc@rock-chips.com (David Wu)
Date: Wed,  9 Dec 2015 17:11:46 +0800
Subject: [PATCH] i2c: rk3x: Add two new features for rk3399
Message-ID: <1449652306-33897-1-git-send-email-wdc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. support highspeed.
2. check i2c bus idle status.

Change-Id: I9c22e752af621c0f8dbcbd399c86b34fd810ec38
Signed-off-by: David Wu <wdc@rock-chips.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 336 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 320 insertions(+), 16 deletions(-)
 mode change 100644 => 100755 drivers/i2c/busses/i2c-rk3x.c

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
old mode 100644
new mode 100755
index c1935eb..b1aa702
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -25,6 +25,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/math64.h>
+#include <linux/delay.h>
 
 
 /* Register Map */
@@ -37,6 +38,7 @@
 #define REG_IEN        0x18 /* interrupt enable */
 #define REG_IPD        0x1c /* interrupt pending */
 #define REG_FCNT       0x20 /* finished count */
+#define I2C_ST         0x220 /* i2c pin status */
 
 /* Data buffer offsets */
 #define TXBUFFER_BASE 0x100
@@ -58,6 +60,12 @@ enum {
 #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last received byte */
 #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
 
+#define VERSION_MASK	  0xffff0000
+#define VERSION_SHIFT	  16
+
+#define RK3X_I2C_V0	  0x0
+#define RK3X_I2C_V1	  0x1
+
 /* REG_MRXADDR bits */
 #define REG_MRXADDR_VALID(x) BIT(24 + (x)) /* [x*8+7:x*8] of MRX[R]ADDR valid */
 
@@ -71,6 +79,13 @@ enum {
 #define REG_INT_NAKRCV    BIT(6) /* NACK received */
 #define REG_INT_ALL       0x7f
 
+enum {
+	I2C_IDLE = 0,
+	I2C_SDA_LOW,
+	I2C_SCL_LOW,
+	BOTH_LOW,
+};
+
 /* Constants */
 #define WAIT_TIMEOUT      1000 /* ms */
 #define DEFAULT_SCL_RATE  (100 * 1000) /* Hz */
@@ -90,10 +105,23 @@ struct rk3x_i2c_soc_data {
 	int grf_offset;
 };
 
+struct rk3x_i2c_ops {
+	int (*check_idle)(void __iomem *);
+	int (*calc_divs)(unsigned long,
+			 unsigned long,
+			 unsigned long,
+			 unsigned long,
+			 unsigned long,
+			 unsigned long *,
+			 unsigned long *,
+			 unsigned int *);
+};
+
 struct rk3x_i2c {
 	struct i2c_adapter adap;
 	struct device *dev;
 	struct rk3x_i2c_soc_data *soc_data;
+	struct rk3x_i2c_ops ops;
 
 	/* Hardware resources */
 	void __iomem *regs;
@@ -116,6 +144,7 @@ struct rk3x_i2c {
 	u8 addr;
 	unsigned int mode;
 	bool is_last_msg;
+	unsigned int time_con;
 
 	/* I2C state machine */
 	enum rk3x_i2c_state state;
@@ -151,7 +180,8 @@ static void rk3x_i2c_start(struct rk3x_i2c *i2c)
 	i2c_writel(i2c, REG_INT_START, REG_IEN);
 
 	/* enable adapter with correct mode, send START condition */
-	val = REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
+	val = i2c->time_con | REG_CON_EN | REG_CON_MOD(i2c->mode)
+		| REG_CON_START;
 
 	/* if we want to react to NACK, set ACTACK bit */
 	if (!(i2c->msg->flags & I2C_M_IGNORE_NAK))
@@ -443,16 +473,19 @@ out:
  * @sda_fall_ns: How many ns it takes for SDA to fall.
  * @div_low: Divider output for low
  * @div_high: Divider output for high
+ * @con: version0 is not used
  *
  * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
  * a best-effort divider value is returned in divs. If the target rate is
  * too high, we silently use the highest possible rate.
  */
-static int rk3x_i2c_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
-			      unsigned long scl_rise_ns,
-			      unsigned long scl_fall_ns,
-			      unsigned long sda_fall_ns,
-			      unsigned long *div_low, unsigned long *div_high)
+static int rk3x_i2c_v0_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
+				 unsigned long scl_rise_ns,
+				 unsigned long scl_fall_ns,
+				 unsigned long sda_fall_ns,
+				 unsigned long *div_low,
+				 unsigned long *div_high,
+				 unsigned int *con)
 {
 	unsigned long spec_min_low_ns, spec_min_high_ns;
 	unsigned long spec_setup_start, spec_max_data_hold_ns;
@@ -614,19 +647,244 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
 	return ret;
 }
 
+/**
+ * Calculate divider values for desired SCL frequency
+ *
+ * @clk_rate: I2C input clock rate
+ * @scl_rate: Desired SCL rate
+ * @scl_rise_ns: How many ns it takes for SCL to rise.
+ * @scl_fall_ns: How many ns it takes for SCL to fall.
+ * @sda_fall_ns: How many ns it takes for SDA to fall.
+ * @div_low: Divider output for low
+ * @div_high: Divider output for high
+ * @con: SDA update point config used to adjust setup/hold time,
+ * start setup config for setup_start and hold_start time,
+ * stop_setup config for setup_stop time.
+ *
+ * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
+ * a best-effort divider value is returned in divs. If the target rate is
+ * too high, we silently use the highest possible rate.
+
+ * l = divl + 1;
+ * h = divh + 1;
+ * s = data_upd_st + 1;
+ * u = start_setup_cnt + 1;
+ * p = stop_setup_cnt + 1;
+ * T:Tclk_i2c
+
+ * tHigh = 8 * h * T;
+ * tLow = 8 * l * T;
+
+ * tHD;sda  = (l * s + 1) * T;
+ * tSU;sda  = ((8 - l) * s + 1) * T;
+ * tI2C = 8 * (l + h) * T;
+
+ * tSU;sta  = (8h * u + 1) * T;
+ * tHD;sta = [8h * (u + 1) - 1]* T;
+ * tSU;sto =(8h * p + 1) * T;
+ */
+static int rk3x_i2c_v1_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
+				 unsigned long scl_rise_ns,
+				 unsigned long scl_fall_ns,
+				 unsigned long sda_fall_ns,
+				 unsigned long *div_low,
+				 unsigned long *div_high,
+				 unsigned int *con)
+{
+	unsigned long spec_min_low_ns, spec_min_high_ns;
+	unsigned long spec_min_setup_start, spec_min_hold_start;
+	unsigned long spec_min_data_setup, spec_max_data_hold_ns;
+	unsigned long spec_min_stop_setup;
+
+	unsigned long min_low_ns, min_high_ns, min_total_ns;
+	unsigned long min_setup_start_ns, min_hold_start_ns;
+	unsigned long min_stop_setup_ns, max_hold_data_ns, min_setup_data_ns;
+
+	unsigned long clk_rate_khz, scl_rate_khz;
+
+	unsigned long min_low_div, min_high_div;
+
+	unsigned long min_div_for_hold, min_total_div;
+	unsigned long extra_div, extra_low_div;
+	unsigned long start_setup_cnt, stop_setup_cnt, data_upd_st;
+
+	int ret = 0;
+
+	if (WARN_ON(scl_rate > 3400000))
+		scl_rate = 3400000;
+
+	if (WARN_ON(scl_rate < 100000))
+		scl_rate = 100000;
+
+	if (scl_rate <= 100000) {
+		spec_min_low_ns = 4700;
+		spec_min_high_ns = 4000;
+
+		spec_min_setup_start = 4700;
+		spec_min_hold_start = 4000;
+
+		spec_max_data_hold_ns = 3450;
+		spec_min_data_setup = 250;
+		spec_min_stop_setup = 4000;
+
+		start_setup_cnt = 0;
+		stop_setup_cnt = 0;
+	} else if (scl_rate <= 400000) {
+		spec_min_setup_start = 600;
+		spec_min_hold_start = 600;
+
+		spec_min_low_ns = 1300;
+		spec_min_high_ns = 600;
+
+		spec_min_data_setup = 100;
+		spec_max_data_hold_ns = 900;
+		spec_min_stop_setup = 600;
+
+		start_setup_cnt = 0;
+		stop_setup_cnt = 0;
+	} else if (scl_rate <= 1700000) {
+		spec_min_low_ns = 320;
+		spec_min_high_ns = 120;
+
+		spec_min_setup_start = 160;
+		spec_min_hold_start = 160;
+
+		spec_max_data_hold_ns = 150;
+		spec_min_data_setup = 10;
+		spec_min_stop_setup = 160;
+
+		start_setup_cnt = 1;
+		stop_setup_cnt = 1;
+	} else {
+		spec_min_low_ns = 160;
+		spec_min_high_ns = 60;
+
+		spec_min_setup_start = 160;
+		spec_min_hold_start = 160;
+
+		spec_min_data_setup = 10;
+		spec_max_data_hold_ns = 70;
+		spec_min_stop_setup = 160;
+
+		start_setup_cnt = 2;
+		stop_setup_cnt = 2;
+	}
+
+	clk_rate_khz = DIV_ROUND_UP(clk_rate, 1000);
+	scl_rate_khz = scl_rate / 1000;
+	min_total_div = DIV_ROUND_UP(clk_rate_khz, scl_rate_khz * 8);
+
+	/*tHigh = 8 * h *T;*/
+	min_high_ns = scl_rise_ns + spec_min_high_ns;
+	min_high_div = DIV_ROUND_UP(clk_rate_khz * min_high_ns, 8 * 1000000);
+
+	/*tSU;sta  = (u*8*h + 4)*T + T;*/
+	min_setup_start_ns = scl_rise_ns + spec_min_setup_start;
+	min_high_div = max(min_high_div,
+			   DIV_ROUND_UP(clk_rate_khz * min_setup_start_ns
+			   - 1000000, 8 * 1000000 * (1 + start_setup_cnt)));
+
+	/*tHD;sta = (u + 1) * 8h * T - T;*/
+	min_hold_start_ns = scl_rise_ns + spec_min_hold_start;
+	min_high_div = max(min_high_div,
+			   DIV_ROUND_UP(clk_rate_khz * min_hold_start_ns
+			   + 1000000, 8 * 1000000 * (2 + start_setup_cnt)));
+
+	/*tSU;sto = (p*8*h + 4)*T + T;*/
+	min_stop_setup_ns = scl_rise_ns + spec_min_stop_setup;
+	min_high_div = max(min_high_div,
+			   DIV_ROUND_UP(clk_rate_khz * min_stop_setup_ns
+			   - 1000000, 8 * 1000000 * (1 + stop_setup_cnt)));
+
+	min_low_ns = scl_fall_ns + spec_min_low_ns;
+
+	/* These are the min dividers needed for min hold times. */
+	min_low_div = DIV_ROUND_UP(clk_rate_khz * min_low_ns, 8 * 1000000);
+
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
+		*div_low = min_low_div;
+		*div_high = min_high_div;
+	} else {
+		/*
+		 * We've got to distribute some time among the low and high
+		 * so we don't run too fast.
+		 */
+		extra_div = min_total_div - min_div_for_hold;
+		extra_low_div = DIV_ROUND_UP(min_low_div * extra_div,
+					     min_div_for_hold);
+
+		*div_low = min_low_div + extra_low_div;
+		*div_high = min_high_div + (extra_div - extra_low_div);
+	}
+
+	/*
+	 * tHD;sda  = (l * s + 1) * T;
+	 * tSU;sda  = ((8 - l) * s + 1) * T;
+	 */
+	for (data_upd_st = 2; data_upd_st >= 0; data_upd_st--) {
+		max_hold_data_ns =  DIV_ROUND_UP(((data_upd_st + 1)
+						 * (*div_low) + 1) * 1000000,
+						 clk_rate_khz);
+		min_setup_data_ns =  DIV_ROUND_UP(((9 - data_upd_st)
+						 * (*div_low) + 1) * 1000000,
+						 clk_rate_khz);
+		if ((max_hold_data_ns < spec_max_data_hold_ns) &&
+		    (min_setup_data_ns > spec_min_data_setup))
+			break;
+	}
+
+	/*
+	 * Adjust to the fact that the hardware has an implicit "+1".
+	 * NOTE: Above calculations always produce div_low > 0 and div_high > 0.
+	 */
+	*div_low = *div_low - 1;
+	*div_high = *div_high - 1;
+
+	/* Maximum divider supported by hw is 0xffff */
+	if (*div_low > 0xffff) {
+		*div_low = 0xffff;
+		ret = -EINVAL;
+	}
+
+	if (*div_high > 0xffff) {
+		*div_high = 0xffff;
+		ret = -EINVAL;
+	}
+
+	*con = *con & 0x00ff;
+	*con |= data_upd_st << 8;
+	*con |= start_setup_cnt << 12;
+	*con |= stop_setup_cnt << 14;
+
+	return ret;
+}
+
 static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 {
+	unsigned int con = 0;
 	unsigned long div_low, div_high;
 	u64 t_low_ns, t_high_ns;
 	int ret;
 
-	ret = rk3x_i2c_calc_divs(clk_rate, i2c->scl_frequency, i2c->scl_rise_ns,
+	ret = i2c->ops.calc_divs(clk_rate, i2c->scl_frequency, i2c->scl_rise_ns,
 				 i2c->scl_fall_ns, i2c->sda_fall_ns,
-				 &div_low, &div_high);
+				 &div_low, &div_high, &con);
 	WARN_ONCE(ret != 0, "Could not reach SCL freq %u", i2c->scl_frequency);
 
 	clk_enable(i2c->clk);
 	i2c_writel(i2c, (div_high << 16) | (div_low & 0xffff), REG_CLKDIV);
+	i2c->time_con = con;
 	clk_disable(i2c->clk);
 
 	t_low_ns = div_u64(((u64)div_low + 1) * 8 * 1000000000, clk_rate);
@@ -661,13 +919,14 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 	struct clk_notifier_data *ndata = data;
 	struct rk3x_i2c *i2c = container_of(nb, struct rk3x_i2c, clk_rate_nb);
 	unsigned long div_low, div_high;
+	unsigned int con = 0;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
-		if (rk3x_i2c_calc_divs(ndata->new_rate, i2c->scl_frequency,
+		if (i2c->ops.calc_divs(ndata->new_rate, i2c->scl_frequency,
 				       i2c->scl_rise_ns, i2c->scl_fall_ns,
 				       i2c->sda_fall_ns,
-				       &div_low, &div_high) != 0)
+				       &div_low, &div_high, &con) != 0)
 			return NOTIFY_STOP;
 
 		/* scale up */
@@ -690,6 +949,11 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 	}
 }
 
+static int rockchip_i2c_v1_check_idle(void __iomem *regs)
+{
+	return readl(regs + I2C_ST) & 0x03;
+}
+
 /**
  * Setup I2C registers for an I2C operation specified by msgs, num.
  *
@@ -777,6 +1041,7 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 {
 	struct rk3x_i2c *i2c = (struct rk3x_i2c *)adap->algo_data;
 	unsigned long timeout, flags;
+	int state, retry = 10;
 	int ret = 0;
 	int i;
 
@@ -784,6 +1049,21 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 
 	clk_enable(i2c->clk);
 
+	if (i2c->ops.check_idle) {
+		while (retry) {
+			state = i2c->ops.check_idle(i2c);
+			if (state == I2C_IDLE)
+				break;
+			mdelay(10);
+			retry--;
+		}
+		if (retry == 0) {
+			dev_err(i2c->dev, "i2c is not in idle(state = %d)\n",
+				state);
+			return -EIO;
+		}
+	}
+
 	i2c->is_last_msg = false;
 
 	/*
@@ -816,7 +1096,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 
 			/* Force a STOP condition without interrupt */
 			i2c_writel(i2c, 0, REG_IEN);
-			i2c_writel(i2c, REG_CON_EN | REG_CON_STOP, REG_CON);
+			i2c_writel(i2c, i2c->time_con | REG_CON_EN |
+				   REG_CON_STOP, REG_CON);
 
 			i2c->state = STATE_IDLE;
 
@@ -871,6 +1152,7 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	u32 value;
 	int irq;
 	unsigned long clk_rate;
+	unsigned int version;
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(struct rk3x_i2c), GFP_KERNEL);
 	if (!i2c)
@@ -901,15 +1183,29 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 				 &i2c->scl_rise_ns)) {
 		if (i2c->scl_frequency <= 100000)
 			i2c->scl_rise_ns = 1000;
-		else
+		else if (i2c->scl_frequency <= 400000)
 			i2c->scl_rise_ns = 300;
+		else if (i2c->scl_frequency <= 1700000)
+			i2c->scl_rise_ns = 80;
+		else
+			i2c->scl_rise_ns = 40;
 	}
 	if (of_property_read_u32(pdev->dev.of_node, "i2c-scl-falling-time-ns",
-				 &i2c->scl_fall_ns))
-		i2c->scl_fall_ns = 300;
+				 &i2c->scl_fall_ns)) {
+		if (i2c->scl_frequency <= 400000)
+			i2c->scl_fall_ns = 300;
+		else if (i2c->scl_frequency <= 1700000)
+			i2c->scl_fall_ns = 80;
+		else
+			i2c->scl_fall_ns = 40;
+	}
 	if (of_property_read_u32(pdev->dev.of_node, "i2c-sda-falling-time-ns",
-				 &i2c->scl_fall_ns))
-		i2c->sda_fall_ns = i2c->scl_fall_ns;
+				 &i2c->scl_fall_ns)) {
+		if (i2c->scl_frequency <= 400000)
+			i2c->sda_fall_ns = i2c->scl_fall_ns;
+		else
+			i2c->sda_fall_ns = 2 * i2c->scl_fall_ns;
+	}
 
 	strlcpy(i2c->adap.name, "rk3x-i2c", sizeof(i2c->adap.name));
 	i2c->adap.owner = THIS_MODULE;
@@ -983,6 +1279,14 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
+	version = (readl(i2c->regs + REG_CON) & VERSION_MASK) >> VERSION_SHIFT;
+	if (version == RK3X_I2C_V1) {
+		i2c->ops.calc_divs = rk3x_i2c_v1_calc_divs;
+		i2c->ops.check_idle = rockchip_i2c_v1_check_idle;
+	} else {
+		i2c->ops.calc_divs = rk3x_i2c_v0_calc_divs;
+	}
+
 	ret = clk_prepare(i2c->clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not prepare clock\n");
-- 
1.9.1
