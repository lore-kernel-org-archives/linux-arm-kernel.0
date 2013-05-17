From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 18 May 2013 09:18:51 +1200
Subject: [PATCH 3/4] clk: vt8500: Remove unnecessary divisor adjustment in
 vtwm_dclk_set_rate()
In-Reply-To: <1368825532-30917-1-git-send-email-linux@prisktech.co.nz>
References: <1368825532-30917-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1368825532-30917-4-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The divisor adjustment code to ensure that a divisor is not rounded down,
thereby giving a rate higher than requested, is unnecessary and in some
instances results in the actual rate being much lower than requested due to
rounding errors.

The test is already performed in vtwm_dclk_round_rate(), which is always
called when clk_set_rate is called. Due to rounding errors in the line:
divisor = parent_rate / rate (clk-vt8500.c:160) we will sometimes end up
adjusting the divisor twice - first in round_rate and then again in set_rate.

This patch removes the test/adjustment in vtwm_dclk_set_rate.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/clk/clk-vt8500.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index ce401cf..82306f5 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -157,10 +157,6 @@ static int vt8500_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	divisor =  parent_rate / rate;
 
-	/* If prate / rate would be decimal, incr the divisor */
-	if (rate * divisor < parent_rate)
-		divisor++;
-
 	if (divisor == cdev->div_mask + 1)
 		divisor = 0;
 
-- 
1.7.9.5
