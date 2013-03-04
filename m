From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon,  4 Mar 2013 15:05:42 +0100
Subject: [PATCH 3/9] MXS/i.MX28: prepare different clocking of the built-in RTC
In-Reply-To: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1362405948-12992-4-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Beisert <jbe@pengutronix.de>

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
---
 drivers/rtc/rtc-stmp3xxx.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 98f0d3c..7311292 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -53,18 +53,26 @@
 #define STMP3XXX_RTC_PERSISTENT0		0x60
 #define STMP3XXX_RTC_PERSISTENT0_SET		0x64
 #define STMP3XXX_RTC_PERSISTENT0_CLR		0x68
+#define STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE	(1 << 0)
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN	0x00000002
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_EN	0x00000004
+#define STMP3XXX_RTC_PERSISTENT0_XTAL24MHZ_PWRUP (1 << 4)
+#define STMP3XXX_RTC_PERSISTENT0_XTAL32KHZ_PWRUP (1 << 5)
+#define STMP3XXX_RTC_PERSISTENT0_XTAL32_FREQ	(1 << 6)
+
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE	0x00000080
 
 #define STMP3XXX_RTC_PERSISTENT1		0x70
 /* missing bitmask in headers */
 #define STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER	0x80000000
 
+enum clock_source { MXS_UNKNOWN, MXS_OSC_24M, MXS_OSC_32K, MXS_OSC_32K768 };
+
 struct stmp3xxx_rtc_data {
 	struct rtc_device *rtc;
 	void __iomem *io;
 	int irq_alarm;
+	enum clock_source clk_src;
 };
 
 #if IS_ENABLED(CONFIG_STMP3XXX_RTC_WATCHDOG)
-- 
1.7.10.4
