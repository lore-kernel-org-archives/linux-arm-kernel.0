From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 00:00:33 +0200
Subject: [PATCH] rtc: armada38x: remove unused variables
Message-ID: <2116673.Ym6IPoTTaZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent bugfix introduced a new compiler warning in the rtc-armada38x
driver:

drivers/rtc/rtc-armada38x.c: In function 'armada38x_rtc_read_time':
drivers/rtc/rtc-armada38x.c:67:34: warning: unused variable 'flags' [-Wunused-variable]
  unsigned long time, time_check, flags;

This removes the now obsolete variables to get rid of the warning.
As the orginal fix was marked for stable backports [4.0], this one
should be backported as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 489405fe5ed38 ("rtc: armada38x: fix concurrency access in armada38x_rtc_set_time")
Cc: stable at vger.kernel.org

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index cb70ced7e0db..2b08cac62f07 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -64,7 +64,7 @@ static void rtc_delayed_write(u32 val, struct armada38x_rtc *rtc, int offset)
 static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time, time_check, flags;
+	unsigned long time, time_check;
 
 	mutex_lock(&rtc->mutex_time);
 	time = readl(rtc->regs + RTC_TIME);
@@ -88,7 +88,7 @@ static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
 	int ret = 0;
-	unsigned long time, flags;
+	unsigned long time;
 
 	ret = rtc_tm_to_time(tm, &time);
 
