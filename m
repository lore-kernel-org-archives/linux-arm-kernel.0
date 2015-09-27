From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 27 Sep 2015 16:57:08 +0200
Subject: [PATCH] i2c: mv64xxx: The n clockdiv factor is 0 based on sunxi SoCs
Message-ID: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the datasheets to n factor for dividing the tclk is
2 to the power n on Allwinner?SoCs, not 2 to the power n + 1 as it is
on other mv64xxx implementations.

I've contacted Allwinner about this and they have confirmed that the
datasheet is correct.

This commit fixes the clk-divider calculations for Allwinner SoCs
accordingly.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 30059c1..e75cf6d 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -146,6 +146,8 @@ struct mv64xxx_i2c_data {
 	bool			errata_delay;
 	struct reset_control	*rstc;
 	bool			irq_clear_inverted;
+	/* Clk div is 2 to the power n, not 2 to the power n + 1 */
+	bool			clk_n_base_0;
 };
 
 static struct mv64xxx_i2c_regs mv64xxx_i2c_regs_mv64xxx = {
@@ -759,25 +761,29 @@ MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
 #ifdef CONFIG_OF
 #ifdef CONFIG_HAVE_CLK
 static int
-mv64xxx_calc_freq(const int tclk, const int n, const int m)
+mv64xxx_calc_freq(struct mv64xxx_i2c_data *drv_data,
+		  const int tclk, const int n, const int m)
 {
-	return tclk / (10 * (m + 1) * (2 << n));
+	if (drv_data->clk_n_base_0)
+		return tclk / (10 * (m + 1) * (1 << n));
+	else
+		return tclk / (10 * (m + 1) * (2 << n));
 }
 
 static bool
-mv64xxx_find_baud_factors(const u32 req_freq, const u32 tclk, u32 *best_n,
-			  u32 *best_m)
+mv64xxx_find_baud_factors(struct mv64xxx_i2c_data *drv_data,
+			  const u32 req_freq, const u32 tclk)
 {
 	int freq, delta, best_delta = INT_MAX;
 	int m, n;
 
 	for (n = 0; n <= 7; n++)
 		for (m = 0; m <= 15; m++) {
-			freq = mv64xxx_calc_freq(tclk, n, m);
+			freq = mv64xxx_calc_freq(drv_data, tclk, n, m);
 			delta = req_freq - freq;
 			if (delta >= 0 && delta < best_delta) {
-				*best_m = m;
-				*best_n = n;
+				drv_data->freq_m = m;
+				drv_data->freq_n = n;
 				best_delta = delta;
 			}
 			if (best_delta == 0)
@@ -815,8 +821,11 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	if (of_property_read_u32(np, "clock-frequency", &bus_freq))
 		bus_freq = 100000; /* 100kHz by default */
 
-	if (!mv64xxx_find_baud_factors(bus_freq, tclk,
-				       &drv_data->freq_n, &drv_data->freq_m)) {
+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-i2c") ||
+	    of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
+		drv_data->clk_n_base_0 = true;
+
+	if (!mv64xxx_find_baud_factors(drv_data, bus_freq, tclk)) {
 		rc = -EINVAL;
 		goto out;
 	}
-- 
2.5.0
