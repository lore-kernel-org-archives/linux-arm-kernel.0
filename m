From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 20 Jun 2017 11:35:51 +0200
Subject: [PATCH 43/51] rtc: sun6i: stop using rtc deprecated functions
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1497951359-13334-44-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Chen-Yu Tsai <wens@csie.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux at googlegroups.com
CC: linux-kernel at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 drivers/rtc/rtc-sun6i.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 39cbc12..9928f74 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -120,7 +120,7 @@ struct sun6i_rtc_dev {
 	struct device *dev;
 	void __iomem *base;
 	int irq;
-	unsigned long alarm;
+	unsigned long long alarm;
 
 	struct clk_hw hw;
 	struct clk_hw *int_osc;
@@ -342,7 +342,7 @@ static int sun6i_rtc_getalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 
 	wkalrm->enabled = !!(alrm_en & SUN6I_ALRM_EN_CNT_EN);
 	wkalrm->pending = !!(alrm_st & SUN6I_ALRM_EN_CNT_EN);
-	rtc_time_to_tm(chip->alarm, &wkalrm->time);
+	rtc_time64_to_tm(chip->alarm, &wkalrm->time);
 
 	return 0;
 }
@@ -352,9 +352,9 @@ static int sun6i_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 	struct sun6i_rtc_dev *chip = dev_get_drvdata(dev);
 	struct rtc_time *alrm_tm = &wkalrm->time;
 	struct rtc_time tm_now;
-	unsigned long time_now = 0;
-	unsigned long time_set = 0;
-	unsigned long time_gap = 0;
+	unsigned long long time_now = 0;
+	unsigned long long time_set = 0;
+	unsigned long long time_gap = 0;
 	int ret = 0;
 
 	ret = sun6i_rtc_gettime(dev, &tm_now);
@@ -363,8 +363,8 @@ static int sun6i_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 		return -EINVAL;
 	}
 
-	rtc_tm_to_time(alrm_tm, &time_set);
-	rtc_tm_to_time(&tm_now, &time_now);
+	time_set = rtc_tm_to_time64(alrm_tm);
+	time_now = rtc_tm_to_time64(&tm_now);
 	if (time_set <= time_now) {
 		dev_err(dev, "Date to set in the past\n");
 		return -EINVAL;
-- 
1.9.1
