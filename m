From: david.wu@rock-chips.com (David Wu)
Date: Wed,  4 May 2016 22:37:48 +0800
Subject: [PATCH v7 9/9] i2c: rk3x: support fast-mode plus for rk3399
In-Reply-To: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1462372668-6583-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 47368c4..c66cc39 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -124,6 +124,17 @@ static const struct i2c_spec_values fast_mode_spec = {
 	.min_hold_buffer_ns = 1300,
 };
 
+static const struct i2c_spec_values fast_mode_plus_spec = {
+	.min_hold_start_ns = 260,
+	.min_low_ns = 500,
+	.min_high_ns = 260,
+	.min_setup_start_ns = 260,
+	.max_data_hold_ns = 400,
+	.min_data_setup_ns = 50,
+	.min_setup_stop_ns = 260,
+	.min_hold_buffer_ns = 500,
+};
+
 /**
  * struct rk3x_i2c_calced_timings:
  * @div_low: Divider output for low
@@ -534,8 +545,10 @@ static const struct i2c_spec_values *rk3x_i2c_get_spec(unsigned int speed)
 {
 	if (speed <= 100000)
 		return &standard_mode_spec;
-	else
+	else if (speed <= 400000)
 		return &fast_mode_spec;
+	else
+		return &fast_mode_plus_spec;
 }
 
 /**
@@ -746,9 +759,9 @@ static int rk3x_i2c_v1_calc_timings(unsigned long clk_rate,
 	const struct i2c_spec_values *spec;
 	int ret = 0;
 
-	/* Support standard-mode and fast-mode */
-	if (WARN_ON(t->bus_freq_hz > 400000))
-		t->bus_freq_hz = 400000;
+	/* Support standard-mode, fast-mode and fast-mode plus */
+	if (WARN_ON(t->bus_freq_hz > 1000000))
+		t->bus_freq_hz = 1000000;
 
 	/* prevent scl_rate_khz from becoming 0 */
 	if (WARN_ON(t->bus_freq_hz < 1000))
-- 
1.9.1
