From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 7 Mar 2012 15:57:49 +0530
Subject: [PATCH 08/15] watchdog/mpcore_wdt: handle module param mpcore_margin
 in probe
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
Message-ID: <1a4d3c2c9d58e5cc0d3770fd57d0d870cfd681c4.1331115752.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently mpcore_margin is handled in mpcore_wdt_init routine, which will be
called even if we don't have added any device for watchdog. Probably this is not
we want.

This patch moves this code into probe routine, so that it only gets hit once we
add device for this driver.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 209c81d..9c58c63 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -306,6 +306,9 @@ static struct miscdevice mpcore_wdt_miscdev = {
 	.fops		= &mpcore_wdt_fops,
 };
 
+static char banner[] __initdata = KERN_INFO "MPcore Watchdog Timer: 0.1. "
+		"mpcore_noboot=%d mpcore_margin=%d sec (nowayout= %d)\n";
+
 static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 {
 	struct mpcore_wdt *wdt;
@@ -341,6 +344,18 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * Check that the margin value is within it's range;
+	 * if not reset to the default
+	 */
+	if (mpcore_wdt_set_heartbeat(mpcore_margin)) {
+		mpcore_wdt_set_heartbeat(TIMER_MARGIN);
+		printk(KERN_INFO "mpcore_margin value must be 0 < mpcore_margin < 65536, using %d\n",
+			TIMER_MARGIN);
+	}
+
+	printk(banner, mpcore_noboot, mpcore_margin, nowayout);
+
 	mpcore_wdt_miscdev.parent = &pdev->dev;
 	ret = misc_register(&mpcore_wdt_miscdev);
 	if (ret) {
@@ -406,23 +421,8 @@ static struct platform_driver mpcore_wdt_driver = {
 	},
 };
 
-static char banner[] __initdata = KERN_INFO "MPcore Watchdog Timer: 0.1. "
-		"mpcore_noboot=%d mpcore_margin=%d sec (nowayout= %d)\n";
-
 static int __init mpcore_wdt_init(void)
 {
-	/*
-	 * Check that the margin value is within it's range;
-	 * if not reset to the default
-	 */
-	if (mpcore_wdt_set_heartbeat(mpcore_margin)) {
-		mpcore_wdt_set_heartbeat(TIMER_MARGIN);
-		printk(KERN_INFO "mpcore_margin value must be 0 < mpcore_margin < 65536, using %d\n",
-			TIMER_MARGIN);
-	}
-
-	printk(banner, mpcore_noboot, mpcore_margin, nowayout);
-
 	return platform_driver_register(&mpcore_wdt_driver);
 }
 
-- 
1.7.8.110.g4cb5d
