From: guy.shapiro@mobi-wize.com (Guy Shapiro)
Date: Sun, 29 Jan 2017 11:57:19 +0200
Subject: [PATCH] rtc: snvs: add a missing write sync
Message-ID: <1485683839-8843-1-git-send-email-guy.shapiro@mobi-wize.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clear of the LPTA_EN flag should be synced before writing to the
alarm register. Omitting this synchronization creates a race when
trying to change existing alarm.

Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
---
 drivers/rtc/rtc-snvs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 0f11c2a..d51b07d 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -184,6 +184,7 @@ static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	rtc_tm_to_time(alrm_tm, &time);
 
 	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR, SNVS_LPCR_LPTA_EN, 0);
+	rtc_write_sync_lp(data);
 	regmap_write(data->regmap, data->offset + SNVS_LPTAR, time);
 
 	/* Clear alarm interrupt status bit */
-- 
2.1.4
