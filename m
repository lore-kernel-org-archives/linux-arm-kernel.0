From: david.wu@rock-chips.com (David Wu)
Date: Wed,  4 May 2016 22:34:32 +0800
Subject: [PATCH v7 6/9] i2c: rk3x: Move spec timing data to "static const"
 structs
In-Reply-To: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1462372472-6396-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 100 ++++++++++++++++++++++++++++++------------
 1 file changed, 72 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 9686c81..408f9ab 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -76,6 +76,51 @@ enum {
 #define DEFAULT_SCL_RATE  (100 * 1000) /* Hz */
 
 /**
+ * struct i2c_spec_values:
+ * @min_hold_start_ns: min hold time (repeated) START condition
+ * @min_low_ns: min LOW period of the SCL clock
+ * @min_high_ns: min HIGH period of the SCL cloc
+ * @min_setup_start_ns: min set-up time for a repeated START conditio
+ * @max_data_hold_ns: max data hold time
+ * @min_data_setup_ns: min data set-up time
+ * @min_setup_stop_ns: min set-up time for STOP condition
+ * @min_hold_buffer_ns: min bus free time between a STOP and
+ * START condition
+ */
+struct i2c_spec_values {
+	unsigned long min_hold_start_ns;
+	unsigned long min_low_ns;
+	unsigned long min_high_ns;
+	unsigned long min_setup_start_ns;
+	unsigned long max_data_hold_ns;
+	unsigned long min_data_setup_ns;
+	unsigned long min_setup_stop_ns;
+	unsigned long min_hold_buffer_ns;
+};
+
+static const struct i2c_spec_values standard_mode_spec = {
+	.min_hold_start_ns = 4000,
+	.min_low_ns = 4700,
+	.min_high_ns = 4000,
+	.min_setup_start_ns = 4700,
+	.max_data_hold_ns = 3450,
+	.min_data_setup_ns = 250,
+	.min_setup_stop_ns = 4000,
+	.min_hold_buffer_ns = 4700,
+};
+
+static const struct i2c_spec_values fast_mode_spec = {
+	.min_hold_start_ns = 600,
+	.min_low_ns = 1300,
+	.min_high_ns = 600,
+	.min_setup_start_ns = 600,
+	.max_data_hold_ns = 900,
+	.min_data_setup_ns = 100,
+	.min_setup_stop_ns = 600,
+	.min_hold_buffer_ns = 1300,
+};
+
+/**
  * struct rk3x_i2c_calced_timings:
  * @div_low: Divider output for low
  * @div_high: Divider output for high
@@ -463,6 +508,21 @@ out:
 }
 
 /**
+ * Get timing values of I2C specification
+ *
+ * @speed: Desired SCL frequency
+ *
+ * Returns: Matched i2c spec values.
+ */
+static const struct i2c_spec_values *rk3x_i2c_get_spec(unsigned int speed)
+{
+	if (speed <= 100000)
+		return &standard_mode_spec;
+	else
+		return &fast_mode_spec;
+}
+
+/**
  * Calculate divider values for desired SCL frequency
  *
  * @clk_rate: I2C input clock rate
@@ -477,10 +537,6 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 			      struct i2c_timings *t,
 			      struct rk3x_i2c_calced_timings *t_calc)
 {
-	unsigned long spec_min_low_ns, spec_min_high_ns;
-	unsigned long spec_setup_start, spec_max_data_hold_ns;
-	unsigned long data_hold_buffer_ns;
-
 	unsigned long min_low_ns, min_high_ns;
 	unsigned long max_low_ns, min_total_ns;
 
@@ -492,6 +548,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 	unsigned long min_div_for_hold, min_total_div;
 	unsigned long extra_div, extra_low_div, ideal_low_div;
 
+	unsigned long data_hold_buffer_ns = 50;
+	const struct i2c_spec_values *spec;
 	int ret = 0;
 
 	/* Only support standard-mode and fast-mode */
@@ -514,22 +572,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 	 *	 This is because the i2c host on Rockchip holds the data line
 	 *	 for half the low time.
 	 */
-	if (t->bus_freq_hz <= 100000) {
-		/* Standard-mode */
-		spec_min_low_ns = 4700;
-		spec_setup_start = 4700;
-		spec_min_high_ns = 4000;
-		spec_max_data_hold_ns = 3450;
-		data_hold_buffer_ns = 50;
-	} else {
-		/* Fast-mode */
-		spec_min_low_ns = 1300;
-		spec_setup_start = 600;
-		spec_min_high_ns = 600;
-		spec_max_data_hold_ns = 900;
-		data_hold_buffer_ns = 50;
-	}
-	min_high_ns = t->scl_rise_ns + spec_min_high_ns;
+	spec = rk3x_i2c_get_spec(t->bus_freq_hz);
+	min_high_ns = t->scl_rise_ns + spec->min_high_ns;
 
 	/*
 	 * Timings for repeated start:
@@ -539,14 +583,14 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 	 * We need to account for those rules in picking our "high" time so
 	 * we meet tSU;STA and tHD;STA times.
 	 */
-	min_high_ns = max(min_high_ns,
-		DIV_ROUND_UP((t->scl_rise_ns + spec_setup_start) * 1000, 875));
-	min_high_ns = max(min_high_ns,
-		DIV_ROUND_UP((t->scl_rise_ns + spec_setup_start +
-			      t->sda_fall_ns + spec_min_high_ns), 2));
-
-	min_low_ns = t->scl_fall_ns + spec_min_low_ns;
-	max_low_ns = spec_max_data_hold_ns * 2 - data_hold_buffer_ns;
+	min_high_ns = max(min_high_ns, DIV_ROUND_UP(
+		(t->scl_rise_ns + spec->min_setup_start_ns) * 1000, 875));
+	min_high_ns = max(min_high_ns, DIV_ROUND_UP(
+		(t->scl_rise_ns + spec->min_setup_start_ns + t->sda_fall_ns +
+		spec->min_high_ns), 2));
+
+	min_low_ns = t->scl_fall_ns + spec->min_low_ns;
+	max_low_ns =  spec->max_data_hold_ns * 2 - data_hold_buffer_ns;
 	min_total_ns = min_low_ns + min_high_ns;
 
 	/* Adjust to avoid overflow */
-- 
1.9.1
