From: amit.kachhap@arm.com (Amit Daniel Kachhap)
Date: Tue, 31 Jul 2018 11:25:55 +0530
Subject: [PATCH] clk: scmi: Fix the rounding of clock rate
In-Reply-To: <153296797329.17365.14490424418553594815@swboyd.mtv.corp.google.com>
References: <153296797329.17365.14490424418553594815@swboyd.mtv.corp.google.com>
Message-ID: <1533016555-3731-1-git-send-email-amit.kachhap@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fix rounds the clock rate properly by using quotient and not
remainder in the calculation. This issue was found while testing HDMI
in the Juno platform.

Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 drivers/clk/clk-scmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index bb2a6f2..a985bf5 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -38,7 +38,6 @@ static unsigned long scmi_clk_recalc_rate(struct clk_hw *hw,
 static long scmi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *parent_rate)
 {
-	int step;
 	u64 fmin, fmax, ftmp;
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
@@ -60,9 +59,9 @@ static long scmi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	ftmp = rate - fmin;
 	ftmp += clk->info->range.step_size - 1; /* to round up */
-	step = do_div(ftmp, clk->info->range.step_size);
+	do_div(ftmp, clk->info->range.step_size);
 
-	return step * clk->info->range.step_size + fmin;
+	return ftmp * clk->info->range.step_size + fmin;
 }
 
 static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.7.4
