From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Wed, 18 Dec 2013 16:18:03 +0100
Subject: [PATCH] watchdog: mach-moxart: add restart handler
Message-ID: <1387379883-16525-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-moxart lacks a separate register for reset; as a workaround,
add a function that can be hooked to arm_pm_restart.

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---

Notes:
    During review of this driver, the restart handler for moxart was
    removed, and moved to platform code under arch/arm/mach-moxart/.
    
    Since then, new considerations arrived,
    see replies from Arnd and Guenter:
    
    "[PATCH v4 1/2] ARM: mach-moxart: add MOXA ART SoC platform files"
    http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/219175.html
    
    I can move this to a new power/restart driver, but first, I want to
    hear what Wim or others think.
    
    Until there is a better solution, my motivation is that this uses
    the watchdog. The way I see it, the problem is that there is no
    separate register for reset, this was always a workaround for that.
    
    Applies to next-20131218

 drivers/watchdog/moxart_wdt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 4166e4d..4aa3a8a 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -19,6 +19,8 @@
 #include <linux/watchdog.h>
 #include <linux/moduleparam.h>
 
+#include <asm/system_misc.h>
+
 #define REG_COUNT			0x4
 #define REG_MODE			0x8
 #define REG_ENABLE			0xC
@@ -29,8 +31,17 @@ struct moxart_wdt_dev {
 	unsigned int clock_frequency;
 };
 
+static struct moxart_wdt_dev *moxart_restart_ctx;
+
 static int heartbeat;
 
+static void moxart_wdt_restart(enum reboot_mode reboot_mode, const char *cmd)
+{
+	writel(1, moxart_restart_ctx->base + REG_COUNT);
+	writel(0x5ab9, moxart_restart_ctx->base + REG_MODE);
+	writel(0x03, moxart_restart_ctx->base + REG_ENABLE);
+}
+
 static int moxart_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct moxart_wdt_dev *moxart_wdt = watchdog_get_drvdata(wdt_dev);
@@ -125,6 +136,9 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	moxart_restart_ctx = moxart_wdt;
+	arm_pm_restart = moxart_wdt_restart;
+
 	dev_dbg(dev, "Watchdog enabled (heartbeat=%d sec, nowayout=%d)\n",
 		moxart_wdt->dev.timeout, nowayout);
 
@@ -135,6 +149,7 @@ static int moxart_wdt_remove(struct platform_device *pdev)
 {
 	struct moxart_wdt_dev *moxart_wdt = platform_get_drvdata(pdev);
 
+	arm_pm_restart = NULL;
 	moxart_wdt_stop(&moxart_wdt->dev);
 	watchdog_unregister_device(&moxart_wdt->dev);
 
-- 
1.8.2.1
