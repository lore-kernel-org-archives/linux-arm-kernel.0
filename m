From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 15 May 2014 10:01:59 +0530
Subject: [PATCH] watchdog: sp805: Set watchdog_device->timeout from
 ->set_timeout()
Message-ID: <c78a7ad282aff9bd1b88c55c2590438e17ef95e1.1400127943.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementation of ->set_timeout() is supposed to set 'timeout' field of 'struct
watchdog_device' passed to it. sp805 was rather setting this in a local
variable. Fix it.

Cc: <stable@vger.kernel.org> # 2.6.36+
Reported-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Greg,

This driver was introduced in 2.6.36 and WDIOC_GETTIMEOUT is broken since then.
So added it for such an old stable release. Not sure if it should only be worth
applying to 3.0+

 drivers/watchdog/sp805_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 47629d2..c1b03f4 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -59,7 +59,6 @@
  * @adev: amba device structure of wdt
  * @status: current status of wdt
  * @load_val: load value to be set for current timeout
- * @timeout: current programmed timeout
  */
 struct sp805_wdt {
 	struct watchdog_device		wdd;
@@ -68,7 +67,6 @@ struct sp805_wdt {
 	struct clk			*clk;
 	struct amba_device		*adev;
 	unsigned int			load_val;
-	unsigned int			timeout;
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -98,7 +96,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 	spin_lock(&wdt->lock);
 	wdt->load_val = load;
 	/* roundup timeout to closest positive integer value */
-	wdt->timeout = div_u64((load + 1) * 2 + (rate / 2), rate);
+	wdd->timeout = div_u64((load + 1) * 2 + (rate / 2), rate);
 	spin_unlock(&wdt->lock);
 
 	return 0;
-- 
2.0.0.rc2
