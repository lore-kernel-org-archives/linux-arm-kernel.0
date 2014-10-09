From: johan@kernel.org (Johan Hovold)
Date: Thu,  9 Oct 2014 21:06:32 +0200
Subject: [PATCH 10/12] rtc: omap: enable wake-up from power off
In-Reply-To: <1412881594-25678-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
Message-ID: <1412881594-25678-11-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ALARM interrupt must not be disabled during shutdown in order to be
able to power up the system using an RTC alarm.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index b0319864dd42..8836c58901b5 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -670,7 +670,15 @@ static SIMPLE_DEV_PM_OPS(omap_rtc_pm_ops, omap_rtc_suspend, omap_rtc_resume);
 
 static void omap_rtc_shutdown(struct platform_device *pdev)
 {
-	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
+	u8 mask;
+
+	/*
+	 * Keep the ALARM interrupt enabled to allow the system to power up on
+	 * alarm events.
+	 */
+	mask = rtc_read(OMAP_RTC_INTERRUPTS_REG);
+	mask &= OMAP_RTC_INTERRUPTS_IT_ALARM;
+	rtc_write(mask, OMAP_RTC_INTERRUPTS_REG);
 }
 
 MODULE_ALIAS("platform:omap_rtc");
-- 
2.0.4
