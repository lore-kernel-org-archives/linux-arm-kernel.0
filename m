From: wdc@rock-chips.com (David Wu)
Date: Fri, 11 Dec 2015 22:33:04 +0800
Subject: [PATCH v1 3/3] i2c: rk3x: support I2C Hs-mode for rk3399
In-Reply-To: <1449844384-6236-1-git-send-email-wdc@rock-chips.com>
References: <1449844384-6236-1-git-send-email-wdc@rock-chips.com>
Message-ID: <1449844384-6236-3-git-send-email-wdc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Wu <david.wu@rock-chips.com>

The i2c controller of new version1 supports highspeed mode,
1.7M and 3.4M rate. It also could be calculated divs by the rules.

The final divs would be effected a lot by hardware elements like
scl_rise_ns, scl_fall_ns and sda_rise_ns,sds_fall_ns.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---

 drivers/i2c/busses/i2c-rk3x.c | 56 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index fae5099..ec0e37f 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -700,8 +700,8 @@ static int rk3x_i2c_v1_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
 
 	int ret = 0;
 
-	if (WARN_ON(scl_rate > 400000))
-		scl_rate = 400000;
+	if (WARN_ON(scl_rate > 3400000))
+		scl_rate = 3400000;
 
 	if (WARN_ON(scl_rate < 100000))
 		scl_rate = 100000;
@@ -719,7 +719,7 @@ static int rk3x_i2c_v1_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
 
 		start_setup_cnt = 0;
 		stop_setup_cnt = 0;
-	} else {
+	} else if (scl_rate <= 400000) {
 		spec_min_setup_start = 600;
 		spec_min_hold_start = 600;
 
@@ -732,6 +732,32 @@ static int rk3x_i2c_v1_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
 
 		start_setup_cnt = 0;
 		stop_setup_cnt = 0;
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
 	}
 
 	clk_rate_khz = DIV_ROUND_UP(clk_rate, 1000);
@@ -1126,15 +1152,29 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
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
-- 
1.9.1
