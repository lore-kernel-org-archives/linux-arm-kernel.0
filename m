From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Tue, 12 Apr 2016 17:45:45 +0530
Subject: [PATCH 2/3] RTC: Write Calibration value before set time
In-Reply-To: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
References: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
Message-ID: <1460463346-24923-2-git-send-email-anuragku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is suggested to programe CALIB_WRITE register with the calibration
value before updating the SET_TIME_WRITE register, doing so will
clear the Tick Counter and force the next second to be signaled
exactly in 1 second.

This patch updates the same.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 drivers/rtc/rtc-zynqmp.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 6adb603..f87f971 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -56,6 +56,7 @@ struct xlnx_rtc_dev {
 	void __iomem		*reg_base;
 	int			alarm_irq;
 	int			sec_irq;
+	int			calibval;
 };
 
 static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
@@ -68,6 +69,13 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	if (new_time > RTC_SEC_MAX_VAL)
 		return -EINVAL;
 
+	/*
+	 * Writing into calibration register will clear the Tick Counter and
+	 * force the next second to be signaled exactly in 1 second period
+	 */
+	xrtcdev->calibval &= RTC_CALIB_MASK;
+	writel(xrtcdev->calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
+
 	writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR);
 
 	return 0;
@@ -121,7 +129,7 @@ static int xlnx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return 0;
 }
 
-static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev, u32 calibval)
+static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev)
 {
 	u32 rtc_ctrl;
 
@@ -136,8 +144,8 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev, u32 calibval)
 	 * to default value suggested as per design spec
 	 * to correct RTC delay in frequency over period of time.
 	 */
-	calibval &= RTC_CALIB_MASK;
-	writel(calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
+	xrtcdev->calibval &= RTC_CALIB_MASK;
+	writel(xrtcdev->calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
 }
 
 static const struct rtc_class_ops xlnx_rtc_ops = {
@@ -174,7 +182,6 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 	struct xlnx_rtc_dev *xrtcdev;
 	struct resource *res;
 	int ret;
-	unsigned int calibvalue;
 
 	xrtcdev = devm_kzalloc(&pdev->dev, sizeof(*xrtcdev), GFP_KERNEL);
 	if (!xrtcdev)
@@ -215,11 +222,11 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = of_property_read_u32(pdev->dev.of_node, "calibration",
-				   &calibvalue);
+				   &xrtcdev->calibval);
 	if (ret)
-		calibvalue = RTC_CALIB_DEF;
+		xrtcdev->calibval = RTC_CALIB_DEF;
 
-	xlnx_init_rtc(xrtcdev, calibvalue);
+	xlnx_init_rtc(xrtcdev);
 
 	device_init_wakeup(&pdev->dev, 1);
 
-- 
2.1.2
