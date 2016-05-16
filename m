From: david.wu@rock-chips.com (David Wu)
Date: Mon, 16 May 2016 22:03:24 +0800
Subject: [PATCH v10 5/8] i2c: rk3x: Move spec timing data to "static const"
 structs
In-Reply-To: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1463407404-41370-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c timing specs are really just constant data. There's no reason
to write code to init them, so move them out to structures. This not
only is a cleaner solution but it will reduce code duplication when we
introduce a new variant of rk3x_i2c_calc_divs() in a future patch.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
Change in v10:
- none

Change in v9:
- none

Changes in v8:
- add commit description.
- remove the spec values that were not needed, then
  introduce the additional values in the rk3399 patch. 

 drivers/i2c/busses/i2c-rk3x.c | 83 ++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index d7a871f..9791797 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -76,6 +76,34 @@ enum {
 #define DEFAULT_SCL_RATE  (100 * 1000) /* Hz */
 
 /**
+ * struct i2c_spec_values:
+ * @min_low_ns: min LOW period of the SCL clock
+ * @min_high_ns: min HIGH period of the SCL cloc
+ * @min_setup_start_ns: min set-up time for a repeated START conditio
+ * @max_data_hold_ns: max data hold time
+ */
+struct i2c_spec_values {
+	unsigned long min_low_ns;
+	unsigned long min_high_ns;
+	unsigned long min_setup_start_ns;
+	unsigned long max_data_hold_ns;
+};
+
+static const struct i2c_spec_values standard_mode_spec = {
+	.min_low_ns = 4700,
+	.min_high_ns = 4000,
+	.min_setup_start_ns = 4700,
+	.max_data_hold_ns = 3450,
+};
+
+static const struct i2c_spec_values fast_mode_spec = {
+	.min_low_ns = 1300,
+	.min_high_ns = 600,
+	.min_setup_start_ns = 600,
+	.max_data_hold_ns = 900,
+};
+
+/**
  * struct rk3x_i2c_calced_timings:
  * @div_low: Divider output for low
  * @div_high: Divider output for high
@@ -460,6 +488,21 @@ out:
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
@@ -474,10 +517,6 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 			      struct i2c_timings *t,
 			      struct rk3x_i2c_calced_timings *t_calc)
 {
-	unsigned long spec_min_low_ns, spec_min_high_ns;
-	unsigned long spec_setup_start, spec_max_data_hold_ns;
-	unsigned long data_hold_buffer_ns;
-
 	unsigned long min_low_ns, min_high_ns;
 	unsigned long max_low_ns, min_total_ns;
 
@@ -489,6 +528,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 	unsigned long min_div_for_hold, min_total_div;
 	unsigned long extra_div, extra_low_div, ideal_low_div;
 
+	unsigned long data_hold_buffer_ns = 50;
+	const struct i2c_spec_values *spec;
 	int ret = 0;
 
 	/* Only support standard-mode and fast-mode */
@@ -511,22 +552,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
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
@@ -536,14 +563,14 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
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
