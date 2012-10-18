From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 18 Oct 2012 22:26:53 +1300
Subject: [PATCH] CLK: vt8500: Fix SDMMC clk special cases
Message-ID: <1350552413-24452-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds some additional handling for the SDMMC special case
in round_rate and set_rate which results in invalid divisor messages
at boot time.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/clk/clk-vt8500.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index a885600..fe25570 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -120,8 +120,17 @@ static unsigned long vt8500_dclk_recalc_rate(struct clk_hw *hw,
 static long vt8500_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *prate)
 {
+	struct clk_device *cdev = to_clk_device(hw);
 	u32 divisor = *prate / rate;
 
+	/*
+	 * If this is a request for SDMMC we have to adjust the divisor
+	 * when >31 to use the fixed predivisor
+	 */
+	if ((cdev->div_mask == 0x3F) && (divisor > 31)) {
+		divisor = 64 * ((divisor / 64) + 1);
+	}
+
 	return *prate / divisor;
 }
 
@@ -135,6 +144,15 @@ static int vt8500_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (divisor == cdev->div_mask + 1)
 		divisor = 0;
 
+	/* SDMMC mask may need to be corrected before testing if its valid */
+	if ((cdev->div_mask == 0x3F) && (divisor > 31)) {
+		/*
+		 * Bit 5 is a fixed /64 predivisor. If the requested divisor
+		 * is >31 then correct for the fixed divisor being required.
+		 */
+		divisor = 0x20 + (divisor / 64);
+	}
+
 	if (divisor > cdev->div_mask) {
 		pr_err("%s: invalid divisor for clock\n", __func__);
 		return -EINVAL;
-- 
1.7.9.5
