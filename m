From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon,  4 Mar 2013 15:05:48 +0100
Subject: [PATCH 9/9] rtc: stmp3xxx: Replace wait_time function
In-Reply-To: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1362405948-12992-10-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the wait_time function with the more generic wait_copy_ctrl function.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/rtc/rtc-stmp3xxx.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index be4fd78..35a92cd 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -172,24 +172,13 @@ static inline void stmp3xxx_wait_copy_ctrl(const struct stmp3xxx_rtc_data *rtc_d
 			pr_warn("possible data loss of rtc shadow registers\n");
 }
 
-static void stmp3xxx_wait_time(struct stmp3xxx_rtc_data *rtc_data)
-{
-	/*
-	 * The datasheet doesn't say which way round the
-	 * NEW_REGS/STALE_REGS bitfields go. In fact it's 0x1=P0,
-	 * 0x2=P1, .., 0x20=P5, 0x40=ALARM, 0x80=SECONDS
-	 */
-	while (readl(rtc_data->io + STMP3XXX_RTC_STAT) &
-			(0x80 << STMP3XXX_RTC_STAT_STALE_SHIFT))
-		cpu_relax();
-}
-
 /* Time read/write */
 static int stmp3xxx_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	stmp3xxx_wait_time(rtc_data);
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_STALE_SHIFT,
+				STMP3XXX_RTC_STAT_SEC_MASK);
 	rtc_time_to_tm(readl(rtc_data->io + STMP3XXX_RTC_SECONDS), rtc_tm);
 	return 0;
 }
@@ -199,7 +188,8 @@ static int stmp3xxx_rtc_set_mmss(struct device *dev, unsigned long t)
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
 	writel(t, rtc_data->io + STMP3XXX_RTC_SECONDS);
-	stmp3xxx_wait_time(rtc_data);
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_NEW_SHIFT,
+				STMP3XXX_RTC_STAT_SEC_MASK);
 	return 0;
 }
 
-- 
1.7.10.4
