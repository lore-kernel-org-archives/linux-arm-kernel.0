From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 12 Oct 2015 16:39:23 +0800
Subject: [PATCH v2] rtc: at91rm9200: clear RTC alarm status flag prior to
 suspending
Message-ID: <1444639163-14255-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As said in the SAMA5D2 datasheet, "Prior to instructing the device
to enter ULP mode 1, ... and the internal sources of wake-up must
be cleared."

This patch is to clear the RTC alarm status flag prior to suspending
to avoid the erroneous wake-up activity, as it is often used as
the wake-up source for the ULP mode 1.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v2:
 - Add more detail commit log.

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
