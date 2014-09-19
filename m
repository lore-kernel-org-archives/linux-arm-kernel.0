From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 19 Sep 2014 12:26:16 +0200
Subject: [PATCH v10 5/6] rtc: max77686: Use ffs() to calculate tm_wday
In-Reply-To: <1411122377-10426-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1411122377-10426-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1411122377-10426-6-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function max77686_rtc_calculate_wday() is used to
calculate the day of the week to be filled in struct
rtc_time but that function only calculates the number
of bits shifted. So the ffs() function can be used to
find the first bit set instead of a special function.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/rtc/rtc-max77686.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index b177ba1..2659bd3 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -70,16 +70,6 @@ enum MAX77686_RTC_OP {
 	MAX77686_RTC_READ,
 };
 
-static inline int max77686_rtc_calculate_wday(u8 shifted)
-{
-	int counter = -1;
-	while (shifted) {
-		shifted >>= 1;
-		counter++;
-	}
-	return counter;
-}
-
 static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
 				   int rtc_24hr_mode)
 {
@@ -93,7 +83,7 @@ static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
 			tm->tm_hour += 12;
 	}
 
-	tm->tm_wday = max77686_rtc_calculate_wday(data[RTC_WEEKDAY] & 0x7f);
+	tm->tm_wday = ffs(data[RTC_WEEKDAY] & 0x7f) - 1;
 	tm->tm_mday = data[RTC_DATE] & 0x1f;
 	tm->tm_mon = (data[RTC_MONTH] & 0x0f) - 1;
 	tm->tm_year = (data[RTC_YEAR] & 0x7f) + 100;
-- 
2.1.0
