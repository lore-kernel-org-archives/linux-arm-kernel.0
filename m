From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Thu,  5 Nov 2015 10:29:49 +0100
Subject: [PATCH] rtc: sunxi: fix some misceanellous problems
Message-ID: <1446715789-10460-1-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

year must be set as unsigned since it is use with
sunxi_rtc_data_year{.min|.max} and as parameter of is_leap_year() which
wait for unsigned int.
Only tm_year is not unsigned, but it is long.
This patch fix also the format of printing of min/max. (must %u since
they are unsigned)

The parameter to of sunxi_rtc_setaie() must be set to uint since callers
give always uint data.

The struct data_year_param is never modified, so it can be set const.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/rtc/rtc-sunxi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index 52543ae..9287afc 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -133,7 +133,7 @@ struct sunxi_rtc_data_year {
 	unsigned char leap_shift;	/* bit shift to get the leap year */
 };
 
-static struct sunxi_rtc_data_year data_year_param[] = {
+static const struct sunxi_rtc_data_year data_year_param[] = {
 	[0] = {
 		.min		= 2010,
 		.max		= 2073,
@@ -175,7 +175,7 @@ static irqreturn_t sunxi_rtc_alarmirq(int irq, void *id)
 	return IRQ_NONE;
 }
 
-static void sunxi_rtc_setaie(int to, struct sunxi_rtc_dev *chip)
+static void sunxi_rtc_setaie(unsigned int to, struct sunxi_rtc_dev *chip)
 {
 	u32 alrm_val = 0;
 	u32 alrm_irq_val = 0;
@@ -343,7 +343,7 @@ static int sunxi_rtc_settime(struct device *dev, struct rtc_time *rtc_tm)
 	struct sunxi_rtc_dev *chip = dev_get_drvdata(dev);
 	u32 date = 0;
 	u32 time = 0;
-	int year;
+	unsigned int year;
 
 	/*
 	 * the input rtc_tm->tm_year is the offset relative to 1900. We use
@@ -353,8 +353,8 @@ static int sunxi_rtc_settime(struct device *dev, struct rtc_time *rtc_tm)
 
 	year = rtc_tm->tm_year + 1900;
 	if (year < chip->data_year->min || year > chip->data_year->max) {
-		dev_err(dev, "rtc only supports year in range %d - %d\n",
-				chip->data_year->min, chip->data_year->max);
+		dev_err(dev, "rtc only supports year in range %u - %u\n",
+			chip->data_year->min, chip->data_year->max);
 		return -EINVAL;
 	}
 
-- 
2.4.10
