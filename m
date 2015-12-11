From: wdc@rock-chips.com (David Wu)
Date: Fri, 11 Dec 2015 22:33:03 +0800
Subject: [PATCH v1 2/3] i2c: rk3x: new way to calc_divs for new version
In-Reply-To: <1449844384-6236-1-git-send-email-wdc@rock-chips.com>
References: <1449844384-6236-1-git-send-email-wdc@rock-chips.com>
Message-ID: <1449844384-6236-2-git-send-email-wdc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Wu <david.wu@rock-chips.com>

There was an issue about "repeated start" timing at the I2C controller
of old version:
   - controller appears to drop SDA at .875x (7/8) programmed clk high.
   - controller appears to keep SCL high for 2x programmed clk high.

The first rule isn't enough to meet tSU;STA requirements in Standard-mode
on the system. To resolve the issue, some configs for I2C timing is added,
and new rules is designed for cal_div.

Every i2c scl cycle includes 8 low FSM and 8 high FSM time.
    SCL = Pclk / SCL Divisor;
    SCL Divisor = 8 * (divl + 1 + divh + 1);

    l: how many Pclk cycles of every low FSM(finite state machine).
    h: how many Pclk cycles of every high FSM(finite state machine).
    s: how many l is it taken in the tLow time, it is a value between 1~8,
       determines the tHD;sda and tSU;sda time.
    u: start setup timing config, determines the tSU;sta and tHD;sta time.
    p: stop setup timing config, determines the tSU;sto time.

    T = 1000000000 / Pclk_i2c;
    l = divl + 1;
    h = divh + 1;
    s = data_upd_st + 1;
    u = start_setup_cnt + 1;
    p = stop_setup_cnt + 1;

    tHigh = 8 * h * T;
    tLow = 8 * l * T;

    tLow = tHD;sda + tSU;sda;
    tHD;sda = (l * s + 1) * T;
    tSU;sda = [(8 - l) * s + 1] * T;
    tI2C = 8 * (l + h) * T;

    tSU;sta = (8h * u + 1) * T;
    tHD;sta = [8h * (u + 1) - 1] * T;
    tSU;sto = (8h * p + 1) * T;

There are two examples of div calculated by the rules, not include
hardware elements like scl_rise time, scl_fall time and sda_rise time:
    1. Standard-mode:

       Source Pclk: 80M, Target scl:100K, Final scl = 100K;

       Tpclk = 12.5ns;
       divl = divh = 0x31;
       l = h = 0x32;
       tHigh = tLow = 5.0us

       start_setup_cnt = stop_setup_cnt = 0;
       u = p = 1;
       tSU;sta = (8h * u + 1) * T = 5.0125us;
       tHD;sta = [8h * (u + 1) - 1] * T = 9.9875us;
       tSU;sto = (8h * p + 1) * T = 5.0125us;

       data_upd_st = 2;
       s = data_upd_st + 1 = 3;
       tHD;sda = (l * s + 1) * T = 1.8875us;
       tSU;sda = [(8 - l) * s + 1] * T = 3.1125us;

    2. Fast-mode:

       Source Pclk: 80M, Target scl:400K, Final scl = 400K;

       Tpclk = 12.5ns;
       divl = 0xf;
       divh = 0x8;
       l = 0x10;
       h = 0x9;
       tHigh = 0.9us;
       tLow = 1.6us;

       start_setup_cnt = stop_setup_cnt = 0;
       u = p = 1;
       tSU;sta = (8h * u + 1) * T = 0.9125us;
       tHD;sta = [8h * (u + 1) - 1] * T = 1.5875us;
       tSU;sto = (8h * p + 1) * T = 0.9125us;

       data_upd_st = 1;
       s = data_upd_st + 1 = 2;
       tHD;sda = (l * s + 1) * T = 0.4125us;
       tSU;sda = [(8 - l) * s + 1] * T = 1.1875us;

The rules make the timing meet the I2C spec requirements whether
Standard-mode or Fast-mode.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---

 drivers/i2c/busses/i2c-rk3x.c | 201 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 200 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 0ff299f..fae5099 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -637,6 +637,203 @@ static int rk3x_i2c_v0_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
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
+ * T = Tclk_i2c;
+
+ * tHigh = 8 * h * T;
+ * tLow = 8 * l * T;
+
+ * tHD;sda = (l * s + 1) * T;
+ * tSU;sda = ((8 - l) * s + 1) * T;
+ * tI2C = 8 * (l + h) * T;
+
+ * tSU;sta = (8h * u + 1) * T;
+ * tHD;sta = [8h * (u + 1) - 1] * T;
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
+	if (WARN_ON(scl_rate > 400000))
+		scl_rate = 400000;
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
+	} else {
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
+	}
+
+	clk_rate_khz = DIV_ROUND_UP(clk_rate, 1000);
+	scl_rate_khz = scl_rate / 1000;
+	min_total_div = DIV_ROUND_UP(clk_rate_khz, scl_rate_khz * 8);
+
+	/* tHigh = 8 * h *T; */
+	min_high_ns = scl_rise_ns + spec_min_high_ns;
+	min_high_div = DIV_ROUND_UP(clk_rate_khz * min_high_ns, 8 * 1000000);
+
+	/* tSU;sta  = (u*8*h + 4)*T + T; */
+	min_setup_start_ns = scl_rise_ns + spec_min_setup_start;
+	min_high_div = max(min_high_div,
+			   DIV_ROUND_UP(clk_rate_khz * min_setup_start_ns
+			   - 1000000, 8 * 1000000 * (1 + start_setup_cnt)));
+
+	/* tHD;sta = (u + 1) * 8h * T - T; */
+	min_hold_start_ns = scl_rise_ns + spec_min_hold_start;
+	min_high_div = max(min_high_div,
+			   DIV_ROUND_UP(clk_rate_khz * min_hold_start_ns
+			   + 1000000, 8 * 1000000 * (2 + start_setup_cnt)));
+
+	/* tSU;sto = (p*8*h + 4)*T + T; */
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
 	unsigned int con = 0;
@@ -1012,7 +1209,9 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, i2c);
 
 	version = (readl(i2c->regs + REG_CON) & VERSION_MASK) >> VERSION_SHIFT;
-	if (version == RK3X_I2C_V0)
+	if (version == RK3X_I2C_V1)
+		i2c->ops.calc_divs = rk3x_i2c_v1_calc_divs;
+	else
 		i2c->ops.calc_divs = rk3x_i2c_v0_calc_divs;
 
 	ret = clk_prepare(i2c->clk);
-- 
1.9.1
