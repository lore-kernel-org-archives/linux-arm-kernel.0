From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 11 Nov 2013 21:33:44 +0100
Subject: [PATCH] watchdog: sirf: don't depend on dummy value of CLOCK_TICK_RATE
Message-ID: <1384202024-16811-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As CSR SiRF is converted to multi platform CLOCK_TICK_RATE is a dummy
value that seems to match the right value is used.
(arch/arm/mach-prima2/include/mach/timex.h which defined CLOCK_TICK_RATE
to 1000000 was removed in commit cf82e0e (ARM: sirf: enable
multiplatform support); marco used the same file.)

To not depend on that dummy value use a local #define instead.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/sirfsoc_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index 3b8d739..ced3edc 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -14,6 +14,8 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 
+#define CLOCK_FREQ	1000000
+
 #define SIRFSOC_TIMER_COUNTER_LO	0x0000
 #define SIRFSOC_TIMER_MATCH_0		0x0008
 #define SIRFSOC_TIMER_INT_EN		0x0024
@@ -50,7 +52,7 @@ static unsigned int sirfsoc_wdt_gettimeleft(struct watchdog_device *wdd)
 
 	time_left = match - counter;
 
-	return time_left / CLOCK_TICK_RATE;
+	return time_left / CLOCK_FREQ;
 }
 
 static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
@@ -58,7 +60,7 @@ static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
 	u32 counter, timeout_ticks;
 	void __iomem *wdt_base;
 
-	timeout_ticks = wdd->timeout * CLOCK_TICK_RATE;
+	timeout_ticks = wdd->timeout * CLOCK_FREQ;
 	wdt_base = watchdog_get_drvdata(wdd);
 
 	/* Enable the latch before reading the LATCH_LO register */
-- 
1.8.4.2
