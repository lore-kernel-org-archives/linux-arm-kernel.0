From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 19 Jan 2013 19:23:27 +1300
Subject: [PATCH] rtc: vt8500: Fix year field in vt8500_rtc_set_time
Message-ID: <1358576607-27185-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

year field is incorrectly masked when setting the date. If the year
is beyond 2099, the year field will be incorrectly updated in hardware.

This patch masks the year field correctly.

Signed-off-by: Edgar Toernig <froese@gmx.de>
Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
Hi Andrew,

This patch has been floating around since -rc1, but looks like it may have been
missed. I have rebased it onto -rc4 to make applying it easier. Trivial fix.

Regards
Tony P

 drivers/rtc/rtc-vt8500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index 00c930f..2730533 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -137,7 +137,7 @@ static int vt8500_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		return -EINVAL;
 	}
 
-	writel((bin2bcd(tm->tm_year - 100) << DATE_YEAR_S)
+	writel((bin2bcd(tm->tm_year % 100) << DATE_YEAR_S)
 		| (bin2bcd(tm->tm_mon + 1) << DATE_MONTH_S)
 		| (bin2bcd(tm->tm_mday))
 		| ((tm->tm_year >= 200) << DATE_CENTURY_S),
-- 
1.7.9.5
