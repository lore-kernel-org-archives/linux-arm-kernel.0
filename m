From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 23:16:41 +0100
Subject: [PATCH 1/9] clk: vt8500: Fix "fix device clock divisor calculations"
In-Reply-To: <1362521809-22989-1-git-send-email-arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
Message-ID: <1362521809-22989-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 72480014b8 "Fix device clock divisor calculations" was apparently
rebased incorrectly before it got upstream, causing a build error.

Replacing the "prate" pointer with the local parent_rate is most
likely the correct solution.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/clk-vt8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index b5538bb..09c6331 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -157,7 +157,7 @@ static int vt8500_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
 	divisor =  parent_rate / rate;
 
 	/* If prate / rate would be decimal, incr the divisor */
-	if (rate * divisor < *prate)
+	if (rate * divisor < parent_rate)
 		divisor++;
 
 	if (divisor == cdev->div_mask + 1)
-- 
1.8.1.2
