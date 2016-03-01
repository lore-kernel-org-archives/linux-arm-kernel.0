From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  1 Mar 2016 18:00:01 +0100
Subject: [PATCH 5/6] sh: rtc: provide rtc_class_ops directly
In-Reply-To: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
Message-ID: <1456851608-3374907-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rtc-generic driver provides an architecture specific
wrapper on top of the generic rtc_class_ops abstraction,
and on sh, that goes through another indirection using
the rtc_sh_get_time/rtc_sh_set_time functions.

This changes the sh rtc-generic device to provide its
rtc_class_ops directly, skipping one of the abstraction
levels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/kernel/time.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index d6d0a986c6e9..92cd676970d9 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -50,27 +50,30 @@ int update_persistent_clock(struct timespec now)
 }
 #endif
 
-unsigned int get_rtc_time(struct rtc_time *tm)
+static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
 {
-	if (rtc_sh_get_time != null_rtc_get_time) {
-		struct timespec tv;
+	struct timespec tv;
 
-		rtc_sh_get_time(&tv);
-		rtc_time_to_tm(tv.tv_sec, tm);
-	}
-
-	return RTC_24H;
+	rtc_sh_get_time(&tv);
+	rtc_time_to_tm(tv.tv_sec, tm);
+	return 0;
 }
-EXPORT_SYMBOL(get_rtc_time);
 
-int set_rtc_time(struct rtc_time *tm)
+static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long secs;
 
 	rtc_tm_to_time(tm, &secs);
-	return rtc_sh_set_time(secs);
+	if (!rtc_sh_set_time || rtc_sh_set_time(secs) < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
 }
-EXPORT_SYMBOL(set_rtc_time);
+
+static const struct rtc_class_ops rtc_generic_ops = {
+	.read_time = rtc_generic_get_time,
+	.set_time = rtc_generic_set_time,
+};
 
 static int __init rtc_generic_init(void)
 {
@@ -79,7 +82,10 @@ static int __init rtc_generic_init(void)
 	if (rtc_sh_get_time == null_rtc_get_time)
 		return -ENODEV;
 
-	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &rtc_generic_ops,
+					     sizeof(rtc_generic_ops));
+
 
 	return PTR_ERR_OR_ZERO(pdev);
 }
-- 
2.7.0
