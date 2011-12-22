From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 22 Dec 2011 16:54:10 +0800
Subject: [PATCH 2/3] rtc: rtc-max8925: fix alarm->enabled related mistake in
 max8925_rtc_read_alarm/max8925_rtc_set_alarm
In-Reply-To: <1324544051-1494-1-git-send-email-haojian.zhuang@marvell.com>
References: <1324544051-1494-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1324544051-1494-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Liu <kliu5@marvell.com>

max8925_rtc_read_alarm should set alrm->enabled based on both ALARM_IRQ_MASK and ALARM_CTRL setting.
max8925_rtc_set_alarm should enable/disable alarm according to ALARM_CTRL reg setting.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/rtc/rtc-max8925.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-max8925.c b/drivers/rtc/rtc-max8925.c
index d93bd40..8564749 100644
--- a/drivers/rtc/rtc-max8925.c
+++ b/drivers/rtc/rtc-max8925.c
@@ -193,10 +193,17 @@ static int max8925_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	ret = max8925_reg_read(info->rtc, MAX8925_RTC_IRQ_MASK);
 	if (ret < 0)
 		goto out;
-	if ((ret & ALARM0_IRQ) == 0)
-		alrm->enabled = 1;
-	else
+	if (ret & ALARM0_IRQ) {
 		alrm->enabled = 0;
+	} else {
+		ret = max8925_reg_read(info->rtc, MAX8925_ALARM0_CNTL);
+		if (ret < 0)
+			goto out;
+		if (!ret)
+			alrm->enabled = 0;
+		else
+			alrm->enabled = 1;
+	}
 	ret = max8925_reg_read(info->rtc, MAX8925_RTC_STATUS);
 	if (ret < 0)
 		goto out;
@@ -221,8 +228,11 @@ static int max8925_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	ret = max8925_bulk_write(info->rtc, MAX8925_ALARM0_SEC, TIME_NUM, buf);
 	if (ret < 0)
 		goto out;
-	/* only enable alarm on year/month/day/hour/min/sec */
-	ret = max8925_reg_write(info->rtc, MAX8925_ALARM0_CNTL, 0x77);
+	if (alrm->enabled)
+		/* only enable alarm on year/month/day/hour/min/sec */
+		ret = max8925_reg_write(info->rtc, MAX8925_ALARM0_CNTL, 0x77);
+	else
+		ret = max8925_reg_write(info->rtc, MAX8925_ALARM0_CNTL, 0x0);
 	if (ret < 0)
 		goto out;
 out:
-- 
1.7.0.4
