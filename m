From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 20 Jun 2017 11:35:20 +0200
Subject: [PATCH 12/51] rtc: coh901331: stop using rtc deprecated functions
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1497951359-13334-13-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Linus Walleij <linus.walleij@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux at googlegroups.com
CC: linux-kernel at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 drivers/rtc/rtc-coh901331.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index cfc4141..5645011 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -80,7 +80,8 @@ static int coh901331_read_time(struct device *dev, struct rtc_time *tm)
 	clk_enable(rtap->clk);
 	/* Check if the time is valid */
 	if (readl(rtap->virtbase + COH901331_VALID)) {
-		rtc_time_to_tm(readl(rtap->virtbase + COH901331_CUR_TIME), tm);
+		rtc_time64_to_tm(
+			(u64)readl(rtap->virtbase + COH901331_CUR_TIME), tm);
 		clk_disable(rtap->clk);
 		return rtc_valid_tm(tm);
 	}
@@ -88,7 +89,7 @@ static int coh901331_read_time(struct device *dev, struct rtc_time *tm)
 	return -EINVAL;
 }
 
-static int coh901331_set_mmss(struct device *dev, unsigned long secs)
+static int coh901331_set_mmss64(struct device *dev, time64_t secs)
 {
 	struct coh901331_port *rtap = dev_get_drvdata(dev);
 
@@ -104,7 +105,8 @@ static int coh901331_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	struct coh901331_port *rtap = dev_get_drvdata(dev);
 
 	clk_enable(rtap->clk);
-	rtc_time_to_tm(readl(rtap->virtbase + COH901331_ALARM), &alarm->time);
+	rtc_time64_to_tm(
+		(u64)readl(rtap->virtbase + COH901331_ALARM), &alarm->time);
 	alarm->pending = readl(rtap->virtbase + COH901331_IRQ_EVENT) & 1U;
 	alarm->enabled = readl(rtap->virtbase + COH901331_IRQ_MASK) & 1U;
 	clk_disable(rtap->clk);
@@ -115,9 +117,9 @@ static int coh901331_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 static int coh901331_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct coh901331_port *rtap = dev_get_drvdata(dev);
-	unsigned long time;
+	unsigned long long time;
 
-	rtc_tm_to_time(&alarm->time, &time);
+	time = rtc_tm_to_time64(&alarm->time);
 	clk_enable(rtap->clk);
 	writel(time, rtap->virtbase + COH901331_ALARM);
 	writel(alarm->enabled, rtap->virtbase + COH901331_IRQ_MASK);
@@ -142,7 +144,7 @@ static int coh901331_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static const struct rtc_class_ops coh901331_ops = {
 	.read_time = coh901331_read_time,
-	.set_mmss = coh901331_set_mmss,
+	.set_mmss64 = coh901331_set_mmss64,
 	.read_alarm = coh901331_read_alarm,
 	.set_alarm = coh901331_set_alarm,
 	.alarm_irq_enable = coh901331_alarm_irq_enable,
-- 
1.9.1
