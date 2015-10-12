From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 12 Oct 2015 09:17:57 +0800
Subject: [PATCH] rtc: at91rm9200: clear RTC alarm status flag prior to
 suspending
Message-ID: <1444612677-26178-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to clear the RTC alarm status flag prior to suspending
to avoid the erroneous wake-up activity.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 drivers/rtc/rtc-at91rm9200.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index cb62e21..b60fd47 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -495,6 +495,8 @@ static int at91_rtc_suspend(struct device *dev)
 	/* this IRQ is shared with DBGU and other hardware which isn't
 	 * necessarily doing PM like we are...
 	 */
+	at91_rtc_write(AT91_RTC_SCCR, AT91_RTC_ALARM);
+
 	at91_rtc_imr = at91_rtc_read_imr()
 			& (AT91_RTC_ALARM|AT91_RTC_SECEV);
 	if (at91_rtc_imr) {
-- 
1.7.9.5
