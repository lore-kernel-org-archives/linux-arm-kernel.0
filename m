From: david.wu@rock-chips.com (David Wu)
Date: Thu, 17 Mar 2016 00:57:18 +0800
Subject: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Wu <wdc@rock-chips.com>

- new method to caculate i2c timings for rk3399:
  There was an timing issue about "repeated start" time at the I2C
  controller of version0, controller appears to drop SDA at .875x (7/8)
  programmed clk high. On version 1 of the controller, the rule(.875x)
  isn't enough to meet tSU;STA
  requirements on 100k's Standard-mode. To resolve this issue,
  sda_update_config, start_setup_config and stop_setup_config for I2C
  timing information are added, new rules are designed to calculate
  the timing information at new v1.
- pclk and function clk are separated at rk3399.
- support i2c highspeed mode: 1.7MHz for rk3399

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
Change in v5:
- use compatible to seperate from different version
- can caculate highspeed clk rate

Changes in v4:
- pclk and sclk are treated individually
- use switch-case to seperate from different version (Andy)
- fix dead loop form Julia's notice

Change in v3:
- Too many arguments for ops func, use struct for them (Andy)

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  32 +-
 drivers/i2c/busses/i2c-rk3x.c                      | 449 ++++++++++++++++++---
 2 files changed, 422 insertions(+), 59 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
index f0d71bc..7a5d988 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
@@ -6,10 +6,16 @@ RK3xxx SoCs.
 Required properties :
 
  - reg : Offset and length of the register set for the device
- - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2c" or
-		"rockchip,rk3288-i2c".
+ - compatible: should be one of the followings
+   - "rockchip,rk3066-i2c": for rk3066
+   - "rockchip,rk3188-i2c": for rk3188
+   - "rockchip,rk3288-i2c": for rk3288
+   - "rockchip,rk3399-i2c": for rk3399
  - interrupts : interrupt number
- - clocks : parent clock
+ - clocks:
+   - clk(function): APB clock and function clock is the same clock for rk3066,
+		    rk3188 and rk3288. but separated at rk3399.
+   - pclk(APB): It is just required for rk3399.
 
 Required on RK3066, RK3188 :
 
@@ -32,6 +38,8 @@ Optional properties :
  - i2c-sda-falling-time-ns : Number of nanoseconds the SDA signal takes to fall
 	(t(f) in the I2C specification). If not specified we'll use the SCL
 	value since they are the same in nearly all cases.
+ - input-clk-rate : frequency rate of function clock used(in Hz). If omitted,
+	the default clock rate is used. It is just used at rk3399 soc.
 
 Example:
 
@@ -39,6 +47,7 @@ aliases {
 	i2c0 = &i2c0;
 }
 
+rk3066, rk3188 and rk3288:
 i2c0: i2c at 2002d000 {
 	compatible = "rockchip,rk3188-i2c";
 	reg = <0x2002d000 0x1000>;
@@ -54,3 +63,20 @@ i2c0: i2c at 2002d000 {
 	i2c-scl-rising-time-ns = <800>;
 	i2c-scl-falling-time-ns = <100>;
 };
+
+rk3399:
+i2c0: i2c at 2002d000 {
+	compatible = "rockchip,rk3399-i2c";
+	reg = <0x2002d000 0x1000>;
+	interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	clock-names = "i2c", "pclk";
+	clocks = <&cru SCLK_I2C0_PMU>, <&cru PCLK_I2C0_PMU>;
+	input-clk-rate = <200000000>;
+
+	i2c-scl-rising-time-ns = <50>;
+	i2c-scl-falling-time-ns = <20>;
+	clock-frequency = <1700000>;
+};
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index c4b0d89..fd28df1 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -25,6 +25,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/math64.h>
+#include <linux/property.h>
 
 
 /* Register Map */
@@ -58,6 +59,10 @@ enum {
 #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last received byte */
 #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
 
+#define REG_CON_SDA_CNT(cnt)  ((cnt) << 8)
+#define REG_CON_STA_CNT(cnt)  ((cnt) << 12)
+#define REG_CON_STO_CNT(cnt)  ((cnt) << 14)
+
 /* REG_MRXADDR bits */
 #define REG_MRXADDR_VALID(x) BIT(24 + (x)) /* [x*8+7:x*8] of MRX[R]ADDR valid */
 
@@ -83,11 +88,34 @@ enum rk3x_i2c_state {
 	STATE_STOP
 };
 
+struct rk3x_i2c;
+
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
 /**
  * @grf_offset: offset inside the grf regmap for setting the i2c type
  */
 struct rk3x_i2c_soc_data {
 	int grf_offset;
+
+	int (*clk_init)(struct rk3x_i2c *, unsigned long *);
+	int (*calc_timings)(unsigned long, struct i2c_timings *,
+			    struct rk3x_i2c_calced_timings *);
 };
 
 struct rk3x_i2c {
@@ -97,11 +125,13 @@ struct rk3x_i2c {
 
 	/* Hardware resources */
 	void __iomem *regs;
-	struct clk *clk;
+	struct clk *pclk; /* APB clock */
+	struct clk *clk; /* Func clk for rk3399 or Func & APB clks for others */
 	struct notifier_block clk_rate_nb;
 
 	/* Settings */
 	struct i2c_timings t;
+	struct rk3x_i2c_calced_timings t_calc;
 
 	/* Synchronization & notification */
 	spinlock_t lock;
@@ -131,6 +161,13 @@ static inline u32 i2c_readl(struct rk3x_i2c *i2c, unsigned int offset)
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
@@ -142,13 +179,13 @@ static inline void rk3x_i2c_clean_ipd(struct rk3x_i2c *i2c)
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
@@ -189,7 +226,7 @@ static void rk3x_i2c_stop(struct rk3x_i2c *i2c, int error)
 		 * get the intended effect by resetting its internal state
 		 * and issuing an ordinary START.
 		 */
-		i2c_writel(i2c, 0, REG_CON);
+		i2c_writel(i2c, rk3x_i2c_get_con_count(i2c), REG_CON);
 
 		/* signal that we are finished with the current msg */
 		wake_up(&i2c->wait);
@@ -431,21 +468,22 @@ out:
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
@@ -552,8 +590,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
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
@@ -582,25 +620,222 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 
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
+		ret = -EINVAL;
+	}
+
+	if (t_calc->div_high > 0xffff) {
+		t_calc->div_high = 0xffff;
 		ret = -EINVAL;
 	}
 
-	if (*div_high > 0xffff) {
-		*div_high = 0xffff;
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
+	/* Support standard-mode, fast-mode and highspeed-mode */
+	if (WARN_ON(t->bus_freq_hz > 3400000))
+		t->bus_freq_hz = 3400000;
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
+	} else if (t->bus_freq_hz <= 1700000) {
+		spec_min_low_ns = 320;
+		spec_min_high_ns = 120;
+
+		spec_min_setup_start_ns = 160;
+		spec_min_stop_setup_ns = 160;
+
+		spec_min_data_setup_ns = 10;
+		spec_max_data_hold_ns = 150;
+	} else {
+		spec_min_low_ns = 160;
+		spec_min_high_ns = 60;
+
+		spec_min_setup_start_ns = 160;
+		spec_min_stop_setup_ns = 160;
+
+		spec_min_data_setup_ns = 10;
+		spec_max_data_hold_ns = 70;
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
 
@@ -610,19 +845,31 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 {
 	struct i2c_timings *t = &i2c->t;
-	unsigned long div_low, div_high;
+	struct rk3x_i2c_calced_timings *t_calc = &i2c->t_calc;
 	u64 t_low_ns, t_high_ns;
-	int ret;
+	int ret = 0;
 
-	ret = rk3x_i2c_calc_divs(clk_rate, t, &div_low, &div_high);
+	if (i2c->soc_data->calc_timings)
+		ret = i2c->soc_data->calc_timings(clk_rate, t, t_calc);
 	WARN_ONCE(ret != 0, "Could not reach SCL freq %u", t->bus_freq_hz);
 
-	clk_enable(i2c->clk);
-	i2c_writel(i2c, (div_high << 16) | (div_low & 0xffff), REG_CLKDIV);
-	clk_disable(i2c->clk);
+	if (i2c->pclk)
+		clk_enable(i2c->pclk);
+	else
+		clk_enable(i2c->clk);
+
+	i2c_writel(i2c, (t_calc->div_high << 16) |
+		  (t_calc->div_low & 0xffff), REG_CLKDIV);
+
+	if (i2c->pclk)
+		clk_disable(i2c->pclk);
+	else
+		clk_disable(i2c->clk);
 
-	t_low_ns = div_u64(((u64)div_low + 1) * 8 * 1000000000, clk_rate);
-	t_high_ns = div_u64(((u64)div_high + 1) * 8 * 1000000000, clk_rate);
+	t_low_ns = div_u64(((u64)t_calc->div_low + 1) * 8 * 1000000000,
+			   clk_rate);
+	t_high_ns = div_u64(((u64)t_calc->div_high + 1) * 8 * 1000000000,
+			    clk_rate);
 	dev_dbg(i2c->dev,
 		"CLK %lukhz, Req %uns, Act low %lluns high %lluns\n",
 		clk_rate / 1000,
@@ -652,12 +899,13 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
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
+		if (i2c->soc_data->calc_timings(ndata->new_rate,
+						t, t_calc) != 0)
 			return NOTIFY_STOP;
 
 		/* scale up */
@@ -772,6 +1020,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 
 	spin_lock_irqsave(&i2c->lock, flags);
 
+	if (i2c->pclk)
+		clk_enable(i2c->pclk);
 	clk_enable(i2c->clk);
 
 	i2c->is_last_msg = false;
@@ -806,7 +1056,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 
 			/* Force a STOP condition without interrupt */
 			i2c_writel(i2c, 0, REG_IEN);
-			i2c_writel(i2c, REG_CON_EN | REG_CON_STOP, REG_CON);
+			i2c_writel(i2c, rk3x_i2c_get_con_count(i2c) |
+				   REG_CON_EN | REG_CON_STOP, REG_CON);
 
 			i2c->state = STATE_IDLE;
 
@@ -821,6 +1072,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 	}
 
 	clk_disable(i2c->clk);
+	if (i2c->pclk)
+		clk_disable(i2c->pclk);
 	spin_unlock_irqrestore(&i2c->lock, flags);
 
 	return ret < 0 ? ret : num;
@@ -836,16 +1089,110 @@ static const struct i2c_algorithm rk3x_i2c_algorithm = {
 	.functionality		= rk3x_i2c_func,
 };
 
-static struct rk3x_i2c_soc_data soc_data[3] = {
-	{ .grf_offset = 0x154 }, /* rk3066 */
-	{ .grf_offset = 0x0a4 }, /* rk3188 */
-	{ .grf_offset = -1 },    /* no I2C switching needed */
+static int rk3x_i2c_v0_clock_init(struct rk3x_i2c *i2c, unsigned long *clk_rate)
+{
+	int ret = 0;
+
+	i2c->clk = devm_clk_get(i2c->dev, "i2c");
+	if (IS_ERR(i2c->clk)) {
+		dev_err(i2c->dev, "Could not get i2c clk\n");
+		return PTR_ERR(i2c->clk);
+	}
+
+	ret = clk_prepare(i2c->clk);
+	if (ret < 0) {
+		dev_err(i2c->dev, "Could not prepare i2c clk\n");
+		return ret;
+	}
+
+	*clk_rate = clk_get_rate(i2c->clk);
+
+	i2c->clk_rate_nb.notifier_call = rk3x_i2c_clk_notifier_cb;
+	ret = clk_notifier_register(i2c->clk, &i2c->clk_rate_nb);
+	if (ret != 0) {
+		dev_err(i2c->dev, "Unable to register clk notifier\n");
+		clk_unprepare(i2c->clk);
+	}
+
+	return ret;
+}
+
+static int rk3x_i2c_v1_clock_init(struct rk3x_i2c *i2c, unsigned long *clk_rate)
+{
+	int ret = 0;
+	u32 rate = 0;
+
+	/* sclk and pclk need to do individually*/
+	i2c->pclk = devm_clk_get(i2c->dev, "pclk");
+	if (IS_ERR(i2c->pclk)) {
+		dev_err(i2c->dev, "Could not get i2c pclk\n");
+		return PTR_ERR(i2c->pclk);
+	}
+
+	ret = clk_prepare(i2c->pclk);
+	if (ret < 0) {
+		dev_err(i2c->dev, "Could not prepare pclk\n");
+		return ret;
+	}
+
+	i2c->clk = devm_clk_get(i2c->dev, "i2c");
+	if (IS_ERR(i2c->clk)) {
+		dev_err(i2c->dev, "cannot get i2c clk\n");
+		clk_unprepare(i2c->pclk);
+		return PTR_ERR(i2c->clk);
+	}
+	ret = clk_prepare(i2c->clk);
+	if (ret) {
+		dev_err(i2c->dev, "Could not prepare i2c clk\n");
+		clk_unprepare(i2c->pclk);
+		return ret;
+	}
+
+	if (!device_property_read_u32(i2c->dev, "input-clk-rate", &rate)) {
+		*clk_rate = rate;
+		ret = clk_set_rate(i2c->clk, *clk_rate);
+		if (ret) {
+			dev_err(i2c->dev, "i2c clk set rate failed\n");
+			clk_unprepare(i2c->clk);
+			clk_unprepare(i2c->pclk);
+			return ret;
+		}
+	} else {
+		/* use default input clock rate */
+		*clk_rate = clk_get_rate(i2c->clk);
+	}
+
+	return ret;
+}
+
+static struct rk3x_i2c_soc_data soc_data[] = {
+	{
+		.grf_offset = 0x154,
+		.clk_init = rk3x_i2c_v0_clock_init,
+		.calc_timings = rk3x_i2c_v0_calc_timings,
+	},
+	{
+		.grf_offset = 0x0a4,
+		.clk_init = rk3x_i2c_v0_clock_init,
+		.calc_timings = rk3x_i2c_v0_calc_timings,
+	},
+	{
+		.grf_offset = -1,
+		.clk_init = rk3x_i2c_v0_clock_init,
+		.calc_timings = rk3x_i2c_v0_calc_timings,
+	},
+	{
+		.grf_offset = -1,
+		.clk_init = rk3x_i2c_v1_clock_init,
+		.calc_timings = rk3x_i2c_v1_calc_timings,
+	},
 };
 
 static const struct of_device_id rk3x_i2c_match[] = {
 	{ .compatible = "rockchip,rk3066-i2c", .data = (void *)&soc_data[0] },
 	{ .compatible = "rockchip,rk3188-i2c", .data = (void *)&soc_data[1] },
 	{ .compatible = "rockchip,rk3288-i2c", .data = (void *)&soc_data[2] },
+	{ .compatible = "rockchip,rk3399-i2c", .data = (void *)&soc_data[3] },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rk3x_i2c_match);
@@ -879,18 +1226,11 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
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
@@ -944,22 +1284,15 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
-	ret = clk_prepare(i2c->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Could not prepare clock\n");
-		return ret;
-	}
-
-	i2c->clk_rate_nb.notifier_call = rk3x_i2c_clk_notifier_cb;
-	ret = clk_notifier_register(i2c->clk, &i2c->clk_rate_nb);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "Unable to register clock notifier\n");
-		goto err_clk;
+	if (i2c->soc_data->clk_init) {
+		ret = i2c->soc_data->clk_init(i2c, &clk_rate);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "clock init failed\n");
+			return ret;
+		}
 	}
 
-	clk_rate = clk_get_rate(i2c->clk);
 	rk3x_i2c_adapt_div(i2c, clk_rate);
-
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register adapter\n");
@@ -972,8 +1305,10 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 err_clk_notifier:
 	clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
-err_clk:
 	clk_unprepare(i2c->clk);
+	if (i2c->pclk)
+		clk_unprepare(i2c->pclk);
+
 	return ret;
 }
 
@@ -985,6 +1320,8 @@ static int rk3x_i2c_remove(struct platform_device *pdev)
 
 	clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
 	clk_unprepare(i2c->clk);
+	if (i2c->pclk)
+		clk_unprepare(i2c->pclk);
 
 	return 0;
 }
-- 
1.9.1
