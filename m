From: johan@kernel.org (Johan Hovold)
Date: Thu,  9 Oct 2014 21:06:30 +0200
Subject: [PATCH 08/12] rtc: omap: restore irq state after reading TC registers
In-Reply-To: <1412881594-25678-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
Message-ID: <1412881594-25678-9-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to restore local irq state when reading the timer/calendar
(TC) registers, so that omap_rtc_read_time() can be called with
interrupts disabled.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 0ef016553a97..62e2e9a9887a 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -239,8 +239,10 @@ static void bcd2tm(struct rtc_time *tm)
 
 static int omap_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
+	unsigned long flags;
+
 	/* we don't report wday/yday/isdst ... */
-	local_irq_disable();
+	local_irq_save(flags);
 	rtc_wait_not_busy();
 
 	tm->tm_sec = rtc_read(OMAP_RTC_SECONDS_REG);
@@ -250,7 +252,7 @@ static int omap_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_mon = rtc_read(OMAP_RTC_MONTHS_REG);
 	tm->tm_year = rtc_read(OMAP_RTC_YEARS_REG);
 
-	local_irq_enable();
+	local_irq_restore(flags);
 
 	bcd2tm(tm);
 	return 0;
-- 
2.0.4
