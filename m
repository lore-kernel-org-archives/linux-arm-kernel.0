From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 27 Dec 2012 13:21:34 +1300
Subject: [PATCH fix-3.8] rtc: vt8500: Correct handling of CR_24H bitfield
Message-ID: <1356567694-3657-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Control register bitfield for 12H/24H mode is handled incorrectly.
Setting CR_24H actually enables 12H mode. This patch renames the
define and changes the initialization code to correctly set
24H mode.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/rtc/rtc-vt8500.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index 14e2d8c..387edf6 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -70,7 +70,7 @@
 				| ALARM_SEC_BIT)
 
 #define VT8500_RTC_CR_ENABLE	(1 << 0)	/* Enable RTC */
-#define VT8500_RTC_CR_24H	(1 << 1)	/* 24h time format */
+#define VT8500_RTC_CR_12H	(1 << 1)	/* 12h time format */
 #define VT8500_RTC_CR_SM_ENABLE	(1 << 2)	/* Enable periodic irqs */
 #define VT8500_RTC_CR_SM_SEC	(1 << 3)	/* 0: 1Hz/60, 1: 1Hz */
 #define VT8500_RTC_CR_CALIB	(1 << 4)	/* Enable calibration */
@@ -247,7 +247,7 @@ static int __devinit vt8500_rtc_probe(struct platform_device *pdev)
 	}
 
 	/* Enable RTC and set it to 24-hour mode */
-	writel(VT8500_RTC_CR_ENABLE | VT8500_RTC_CR_24H,
+	writel(VT8500_RTC_CR_ENABLE,
 	       vt8500_rtc->regbase + VT8500_RTC_CR);
 
 	vt8500_rtc->rtc = rtc_device_register("vt8500-rtc", &pdev->dev,
-- 
1.7.9.5
