From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Tue, 12 Apr 2016 17:45:44 +0530
Subject: [PATCH 1/3] RTC: Enable RTC switching to battery power when VCC_PSAUX
 is N/A
Message-ID: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to conserve battery energy, during the PS operation,
it is expected that the supply for the battery-powered domain
to be switched from the battery (VCC_PSBATT) to (VCC_PSAUX) and
automatically be switched back to battery when VCC_PSAUX voltage
drops below a limit, doing so prevents the logic within
the battery-powered domain from functioning incorrectly.

This patch enables that feature.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 drivers/rtc/rtc-zynqmp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 8b28762..6adb603 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -45,6 +45,7 @@
 #define RTC_INT_SEC		BIT(0)
 #define RTC_INT_ALRM		BIT(1)
 #define RTC_OSC_EN		BIT(24)
+#define RTC_BATT_EN		BIT(31)
 
 #define RTC_CALIB_DEF		0x198233
 #define RTC_CALIB_MASK		0x1FFFFF
@@ -122,6 +123,13 @@ static int xlnx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev, u32 calibval)
 {
+	u32 rtc_ctrl;
+
+	/* Enable RTC switch to battery when VCC_PSAUX is not available */
+	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
+	rtc_ctrl |= RTC_BATT_EN;
+	writel(rtc_ctrl, xrtcdev->reg_base + RTC_CTRL);
+
 	/*
 	 * Based on crystal freq of 33.330 KHz
 	 * set the seconds counter and enable, set fractions counter
-- 
2.1.2
