From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 20 Jun 2017 11:35:25 +0200
Subject: [PATCH 17/51] rtc: digicolor: stop using rtc deprecated functions
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1497951359-13334-18-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Baruch Siach <baruch@tkos.co.il>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux at googlegroups.com
CC: linux-kernel at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 drivers/rtc/rtc-digicolor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-digicolor.c b/drivers/rtc/rtc-digicolor.c
index b253bf1..01b0fe8 100644
--- a/drivers/rtc/rtc-digicolor.c
+++ b/drivers/rtc/rtc-digicolor.c
@@ -106,7 +106,7 @@ static int dc_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static int dc_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int dc_rtc_set_mmss64(struct device *dev, time64_t secs)
 {
 	struct dc_rtc *rtc = dev_get_drvdata(dev);
 
@@ -161,7 +161,7 @@ static int dc_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static const struct rtc_class_ops dc_rtc_ops = {
 	.read_time		= dc_rtc_read_time,
-	.set_mmss		= dc_rtc_set_mmss,
+	.set_mmss64		= dc_rtc_set_mmss64,
 	.read_alarm		= dc_rtc_read_alarm,
 	.set_alarm		= dc_rtc_set_alarm,
 	.alarm_irq_enable	= dc_rtc_alarm_irq_enable,
-- 
1.9.1
