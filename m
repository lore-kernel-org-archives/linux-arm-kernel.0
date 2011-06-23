From: simon@sequanux.org (Simon Guinot)
Date: Thu, 23 Jun 2011 16:31:25 +0200
Subject: [PATCH] rtc-mv: add check for valid year range
Message-ID: <1308839485-20116-1-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

Return -EINVAL when trying to set the RTC time with a date out of the
21th century. The on-chip RTC don't support such dates.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 drivers/rtc/rtc-mv.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index 60627a7..4a4b6c9 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -47,6 +47,9 @@ static int mv_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	void __iomem *ioaddr = pdata->ioaddr;
 	u32	rtc_reg;
 
+	if (tm->tm_year < 100 || tm->tm_year > 199)
+		return -EINVAL;
+
 	rtc_reg = (bin2bcd(tm->tm_sec) << RTC_SECONDS_OFFS) |
 		(bin2bcd(tm->tm_min) << RTC_MINUTES_OFFS) |
 		(bin2bcd(tm->tm_hour) << RTC_HOURS_OFFS) |
@@ -55,7 +58,7 @@ static int mv_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	rtc_reg = (bin2bcd(tm->tm_mday) << RTC_MDAY_OFFS) |
 		(bin2bcd(tm->tm_mon + 1) << RTC_MONTH_OFFS) |
-		(bin2bcd(tm->tm_year % 100) << RTC_YEAR_OFFS);
+		(bin2bcd(tm->tm_year - 100) << RTC_YEAR_OFFS);
 	writel(rtc_reg, ioaddr + RTC_DATE_REG_OFFS);
 
 	return 0;
-- 
1.7.5.1
