From: david.wu@rock-chips.com (David Wu)
Date: Thu, 14 Jan 2016 20:31:39 +0800
Subject: [PATCH v3 4/4] i2c: rk3x: support I2C Highspeed Mode
In-Reply-To: <1452774699-57455-1-git-send-email-david.wu@rock-chips.com>
References: <1452774699-57455-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1452774699-57455-5-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c controller of new version1 supports highspeed mode,
1.7M and 3.4M rate. It also could be calculated clocks by the rules.

Note: The final divs would be effected a lot by hardware elements like
scl_rise_ns, scl_fall_ns and sda_rise_ns.

There are two examples of div calculated by the rules, not contain
hardware elements like scl_rise time, scl_fall time and sda_rise time:

    1. scl: 1.7M:
       Source Pclk: 200M, Target scl: 1700K, Final scl: 1.667K;
       Tpclk = 5ns;

       divl = 9, divh = 4;
       l = 10, h = 5;
       tLow = 400ns, tHigh = 200ns;

       start_setup_cnt = stop_setup_cnt = 0;
       u = p = 1;
       tSU;sta = (8h * u + 1) * T = 205ns;
       tHD;sta = [8h * (u + 1) - 1] * T = 395ns;
       tSU;sto = (8h * p + 1) * T = 205ns;

       data_upd_st = 1;
       s = data_upd_st + 1 = 2;
       tHD;sda = (l * s + 1) * T = 105;
       tSU;sda = [(8 - s) * l + 1] * T = 295;

    2. scl: 3.4M
       Source Pclk: 200M, Target scl: 3400K, Final scl: 3125K;
       Tpclk = 5ns;

       divl = 4, divh = 2;
       l = 5, h = 3;
       tLow = 200ns, tHigh = 120ns;

       start_setup_cnt = stop_setup_cnt = 1;
       u = p = 2;
       tSU;sta = (8h * u + 1) * T = 245ns;
       tHD;sta = [8h * (u + 1) - 1] * T = 355ns;
       tSU;sto = (8h * p + 1) * T = 245ns;

       data_upd_st = 1;
       s = data_upd_st + 1 = 2;
       tHD;sda = (l * s + 1) * T = 55ns;
       tSU;sda = [(8 - l) * s + 1] * T = 145ns;

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
Changes in v3: None

changes in v2:     
- split patch to three patches(Heiko)

 drivers/i2c/busses/i2c-rk3x.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index b7229a7..bb041aa 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -700,9 +700,9 @@ static int rk3x_i2c_v1_calc_clock(unsigned long clk_rate,
 
 	int ret = 0;
 
-	/* Support standard-mode and fast-mode */
-	if (WARN_ON(t_input->bus_freq_hz > 400000))
-		t_input->bus_freq_hz = 400000;
+	/* Support standard-mode, fast-mode and highspeed-mode */
+	if (WARN_ON(t_input->bus_freq_hz > 3400000))
+		t_input->bus_freq_hz = 3400000;
 
 	/* prevent scl_rate_khz from becoming 0 */
 	if (WARN_ON(t_input->bus_freq_hz < 1000))
@@ -732,6 +732,24 @@ static int rk3x_i2c_v1_calc_clock(unsigned long clk_rate,
 
 		spec_min_data_setup_ns = 100;
 		spec_max_data_hold_ns = 900;
+	} else if (t_input->bus_freq_hz <= 1700000) {
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
 	}
 
 	/* caculate min-divh and min-divl */
-- 
1.9.1
