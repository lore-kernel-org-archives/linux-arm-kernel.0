From: addy.ke@rock-chips.com (Addy Ke)
Date: Wed,  3 Dec 2014 10:37:17 +0800
Subject: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns doesn't
 meet I2C spec
In-Reply-To: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

high_ns calculated from the low division of CLKDIV register is the sum
of actual measured high_ns and rise_ns. The rise time which related to
external pull-up resistor can be up to the maximum rise time in I2C spec.

In my test, if external pull-up resistor is 4.7K, rise_ns is about
700ns. So the actual measured high_ns is about 3900ns, which is less
than 4000ns(the minimum high_ns in I2C spec).

To fix this bug, min_low_ns should include fall time and min_high_ns
should include rise time too.

This patch merged the patch that Doug submitted to chromium, which
can get the rise and fall times for signals from the device tree.
This allows us to more accurately calculate timings. see:
https://chromium-review.googlesource.com/#/c/232774/

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
Changes in v2:
- merged the patch that Doug submitted to chromium

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 10 ++++
 drivers/i2c/busses/i2c-rk3x.c                      | 55 +++++++++++++++-------
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
index dde6c22..faf5997 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
@@ -21,6 +21,13 @@ Required on RK3066, RK3188 :
 Optional properties :
 
  - clock-frequency : SCL frequency to use (in Hz). If omitted, 100kHz is used.
+ - rise-ns : Number of nanoseconds the signal takes to rise (t(r) in i2c spec).
+	     If not specified this is assumed to be the max the spec allows
+	     (1000 ns for standard mode, 300 ns for fast mode) which might
+	     cause slightly slower communication.
+ - fall-ns : Number of nanoseconds the signal takes to fall (t(f) in the i2c0
+	     spec).  If not specified this is assumed to be the max the spec
+	     allows (300 ns) which might cause slightly slower communication.
 
 Example:
 
@@ -39,4 +46,7 @@ i2c0: i2c at 2002d000 {
 
 	clock-names = "i2c";
 	clocks = <&cru PCLK_I2C0>;
+
+	rise-ns = <800>;
+	fall-ns = <100>;
 };
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 0ee5802..025d4b5 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -102,6 +102,8 @@ struct rk3x_i2c {
 
 	/* Settings */
 	unsigned int scl_frequency;
+	unsigned int rise_ns;
+	unsigned int fall_ns;
 
 	/* Synchronization & notification */
 	spinlock_t lock;
@@ -435,6 +437,8 @@ out:
  *
  * @clk_rate: I2C input clock rate
  * @scl_rate: Desired SCL rate
+ * @rise_ns: How many ns it takes for signals to rise.
+ * @fall_ns: How many ns it takes for signals to fall.
  * @div_low: Divider output for low
  * @div_high: Divider output for high
  *
@@ -443,11 +447,14 @@ out:
  * too high, we silently use the highest possible rate.
  */
 static int rk3x_i2c_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
+			      unsigned long rise_ns, unsigned long fall_ns,
 			      unsigned long *div_low, unsigned long *div_high)
 {
+	unsigned long spec_min_low_ns, spec_min_high_ns;
+	unsigned long spec_max_data_hold_ns;
+	unsigned long spec_data_hold_buffer_ns;
+
 	unsigned long min_low_ns, min_high_ns;
-	unsigned long max_data_hold_ns;
-	unsigned long data_hold_buffer_ns;
 	unsigned long max_low_ns, min_total_ns;
 
 	unsigned long clk_rate_khz, scl_rate_khz;
@@ -470,28 +477,30 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
 
 	/*
 	 * min_low_ns:  The minimum number of ns we need to hold low
-	 *		to meet i2c spec
+	 *		to meet i2c spec, should include fall time.
 	 * min_high_ns: The minimum number of ns we need to hold high
-	 *		to meet i2c spec
+	 *		to meet i2c spec, should include rise time.
 	 * max_low_ns:  The maximum number of ns we can hold low
-	 *		to meet i2c spec
+	 *		to meet i2c spec.
 	 *
 	 * Note: max_low_ns should be (max data hold time * 2 - buffer)
 	 *	 This is because the i2c host on Rockchip holds the data line
 	 *	 for half the low time.
 	 */
 	if (scl_rate <= 100000) {
-		min_low_ns = 4700;
-		min_high_ns = 4000;
-		max_data_hold_ns = 3450;
-		data_hold_buffer_ns = 50;
+		spec_min_low_ns = 4700;
+		spec_min_high_ns = 4000;
+		spec_max_data_hold_ns = 3450;
+		spec_data_hold_buffer_ns = 50;
 	} else {
-		min_low_ns = 1300;
-		min_high_ns = 600;
-		max_data_hold_ns = 900;
-		data_hold_buffer_ns = 50;
+		spec_min_low_ns = 1300;
+		spec_min_high_ns = 600;
+		spec_max_data_hold_ns = 900;
+		spec_data_hold_buffer_ns = 50;
 	}
-	max_low_ns = max_data_hold_ns * 2 - data_hold_buffer_ns;
+	min_low_ns = spec_min_low_ns + fall_ns;
+	min_high_ns = spec_min_high_ns + rise_ns;
+	max_low_ns = spec_max_data_hold_ns * 2 - spec_data_hold_buffer_ns;
 	min_total_ns = min_low_ns + min_high_ns;
 
 	/* Adjust to avoid overflow */
@@ -588,8 +597,8 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 	u64 t_low_ns, t_high_ns;
 	int ret;
 
-	ret = rk3x_i2c_calc_divs(clk_rate, i2c->scl_frequency, &div_low,
-				 &div_high);
+	ret = rk3x_i2c_calc_divs(clk_rate, i2c->scl_frequency, i2c->rise_ns,
+				 i2c->fall_ns, &div_low, &div_high);
 
 	WARN_ONCE(ret != 0, "Could not reach SCL freq %u", i2c->scl_frequency);
 
@@ -633,9 +642,9 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 	switch (event) {
 	case PRE_RATE_CHANGE:
 		if (rk3x_i2c_calc_divs(ndata->new_rate, i2c->scl_frequency,
-				      &div_low, &div_high) != 0) {
+				       i2c->rise_ns, i2c->fall_ns, &div_low,
+				       &div_high) != 0)
 			return NOTIFY_STOP;
-		}
 
 		/* scale up */
 		if (ndata->new_rate > ndata->old_rate)
@@ -859,6 +868,16 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 		i2c->scl_frequency = DEFAULT_SCL_RATE;
 	}
 
+	/* Read rise and fall ns; if not there use the default max from spec */
+	if (of_property_read_u32(pdev->dev.of_node, "rise-ns", &i2c->rise_ns)) {
+		if (i2c->scl_frequency <= 100000)
+			i2c->rise_ns = 1000;
+		else
+			i2c->rise_ns = 300;
+	}
+	if (of_property_read_u32(pdev->dev.of_node, "fall-ns", &i2c->fall_ns))
+		i2c->fall_ns = 300;
+
 	strlcpy(i2c->adap.name, "rk3x-i2c", sizeof(i2c->adap.name));
 	i2c->adap.owner = THIS_MODULE;
 	i2c->adap.algo = &rk3x_i2c_algorithm;
-- 
1.8.3.2
