From: johan@kernel.org (Johan Hovold)
Date: Tue, 21 Oct 2014 19:38:02 +0200
Subject: [PATCH v2 16/20] rtc: omap: enable wake-up from power off
In-Reply-To: <1413913086-12730-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
Message-ID: <1413913086-12730-17-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ALARM interrupt must not be disabled during shutdown in order to be
able to power up the system using an RTC alarm.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index f6c93f877857..cb5ef3c845d1 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -687,8 +687,15 @@ static SIMPLE_DEV_PM_OPS(omap_rtc_pm_ops, omap_rtc_suspend, omap_rtc_resume);
 static void omap_rtc_shutdown(struct platform_device *pdev)
 {
 	struct omap_rtc *rtc = platform_get_drvdata(pdev);
+	u8 mask;
 
-	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
+	/*
+	 * Keep the ALARM interrupt enabled to allow the system to power up on
+	 * alarm events.
+	 */
+	mask = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
+	mask &= OMAP_RTC_INTERRUPTS_IT_ALARM;
+	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, mask);
 }
 
 static struct platform_driver omap_rtc_driver = {
-- 
2.0.4
