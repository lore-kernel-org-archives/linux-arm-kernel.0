From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 27 Dec 2012 13:14:30 +1300
Subject: [PATCH 2/3] clk: vt8500: Fix device clock divisor calculations
In-Reply-To: <1356567272-3420-1-git-send-email-linux@prisktech.co.nz>
References: <1356567272-3420-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1356567272-3420-3-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When calculating device clock divisor values in set_rate and
round_rate, we do a simple integer divide. If parent_rate / rate
has a fraction, this is dropped which results in the device clock
being set too high.

This patch corrects the problem by adding 1 to the calculated
divisor if the division would have had a decimal result.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/clk/clk-vt8500.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index 0cb26be..3306c2b 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -123,6 +123,10 @@ static long vt8500_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_device *cdev = to_clk_device(hw);
 	u32 divisor = *prate / rate;
 
+	/* If prate / rate would be decimal, incr the divisor */
+	if (rate * divisor < *prate)
+		divisor++;
+
 	/*
 	 * If this is a request for SDMMC we have to adjust the divisor
 	 * when >31 to use the fixed predivisor
@@ -141,6 +145,10 @@ static int vt8500_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 divisor = parent_rate / rate;
 	unsigned long flags = 0;
 
+	/* If prate / rate would be decimal, incr the divisor */
+	if (rate * divisor < *prate)
+		divisor++;
+
 	if (divisor == cdev->div_mask + 1)
 		divisor = 0;
 
-- 
1.7.9.5
