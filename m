From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Fri, 7 May 2010 10:11:41 +0530
Subject: [PATCH 2/2] ARM mpcore_wdt: fix build failure and other fixes
Message-ID: <1273207301-22216-1-git-send-email-srinidhi.kasagar@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the build failures seen when building mpcore_wdt and it
also removes the nonexistent ARM_MPCORE_PLATFORM dependency, instead
make it dependent on HAVE_ARM_TWD.

Also this fixes spinlock usage appropriately.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/watchdog/Kconfig      |    2 +-
 drivers/watchdog/mpcore_wdt.c |   21 +++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 0bf5020..b87ba23 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -175,7 +175,7 @@ config SA1100_WATCHDOG
 
 config MPCORE_WATCHDOG
 	tristate "MPcore watchdog"
-	depends on ARM_MPCORE_PLATFORM && LOCAL_TIMERS
+	depends on HAVE_ARM_TWD
 	help
 	  Watchdog timer embedded into the MPcore system.
 
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 016c6a7..b8ec7ac 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -31,8 +31,9 @@
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 
-#include <asm/hardware/arm_twd.h>
+#include <asm/smp_twd.h>
 
 struct mpcore_wdt {
 	unsigned long	timer_alive;
@@ -44,7 +45,7 @@ struct mpcore_wdt {
 };
 
 static struct platform_device *mpcore_wdt_dev;
-extern unsigned int mpcore_timer_rate;
+static DEFINE_SPINLOCK(wdt_lock);
 
 #define TIMER_MARGIN	60
 static int mpcore_margin = TIMER_MARGIN;
@@ -94,13 +95,15 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
  */
 static void mpcore_wdt_keepalive(struct mpcore_wdt *wdt)
 {
-	unsigned int count;
+	unsigned long count;
 
+	spin_lock(&wdt_lock);
 	/* Assume prescale is set to 256 */
-	count = (mpcore_timer_rate / 256) * mpcore_margin;
+	count =  __raw_readl(wdt->base + TWD_WDOG_COUNTER);
+	count = (0xFFFFFFFFU - count) * (HZ / 5);
+	count = (count / 256) * mpcore_margin;
 
 	/* Reload the counter */
-	spin_lock(&wdt_lock);
 	writel(count + wdt->perturb, wdt->base + TWD_WDOG_LOAD);
 	wdt->perturb = wdt->perturb ? 0 : 1;
 	spin_unlock(&wdt_lock);
@@ -119,7 +122,6 @@ static void mpcore_wdt_start(struct mpcore_wdt *wdt)
 {
 	dev_printk(KERN_INFO, wdt->dev, "enabling watchdog.\n");
 
-	spin_lock(&wdt_lock);
 	/* This loads the count register but does NOT start the count yet */
 	mpcore_wdt_keepalive(wdt);
 
@@ -130,7 +132,6 @@ static void mpcore_wdt_start(struct mpcore_wdt *wdt)
 		/* Enable watchdog - prescale=256, watchdog mode=1, enable=1 */
 		writel(0x0000FF09, wdt->base + TWD_WDOG_CONTROL);
 	}
-	spin_unlock(&wdt_lock);
 }
 
 static int mpcore_wdt_set_heartbeat(int t)
@@ -360,7 +361,7 @@ static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 	mpcore_wdt_miscdev.parent = &dev->dev;
 	ret = misc_register(&mpcore_wdt_miscdev);
 	if (ret) {
-		dev_printk(KERN_ERR, _dev,
+		dev_printk(KERN_ERR, wdt->dev,
 			"cannot register miscdev on minor=%d (err=%d)\n",
 							WATCHDOG_MINOR, ret);
 		goto err_misc;
@@ -369,13 +370,13 @@ static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 	ret = request_irq(wdt->irq, mpcore_wdt_fire, IRQF_DISABLED,
 							"mpcore_wdt", wdt);
 	if (ret) {
-		dev_printk(KERN_ERR, _dev,
+		dev_printk(KERN_ERR, wdt->dev,
 			"cannot register IRQ%d for watchdog\n", wdt->irq);
 		goto err_irq;
 	}
 
 	mpcore_wdt_stop(wdt);
-	platform_set_drvdata(&dev->dev, wdt);
+	platform_set_drvdata(dev, wdt);
 	mpcore_wdt_dev = dev;
 
 	return 0;
-- 
1.7.0
