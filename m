From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Tue, 12 Apr 2016 17:45:46 +0530
Subject: [PATCH 3/3] RTC: Update seconds time programming logic
In-Reply-To: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
References: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
Message-ID: <1460463346-24923-3-git-send-email-anuragku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We programe RTC time using SET_TIME_WRITE register and read the RTC
current time using CURRENT_TIME register. When we set the time by
writing into SET_TIME_WRITE Register and immediately try to read the
rtc time from CURRENT_TIME register, the previous old value is
returned instead of the new loaded time. This is because RTC takes
nearly 1 sec to update the  new loaded value into the CURRENT_TIME
register. This behaviour is expected in our RTC IP.

This patch updates the driver to read the current time from SET_TIME_WRITE
register instead of CURRENT_TIME when rtc time is requested within an 1sec
period after setting the RTC time. Doing so will ensure the correct time
is given to the user.

Since there is an delay of 1sec in updating the CURRENT_TIME we are loading
set time +1sec while programming the SET_TIME_WRITE register, doing this
will give correct time without any delay when read from CURRENT_TIME.

This patch updates the above said.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 drivers/rtc/rtc-zynqmp.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index f87f971..b98cebe 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -57,6 +57,7 @@ struct xlnx_rtc_dev {
 	int			alarm_irq;
 	int			sec_irq;
 	int			calibval;
+	int			time_updated;
 };
 
 static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
@@ -64,6 +65,12 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
 	unsigned long new_time;
 
+	/*
+	 * The value written will be updated after 1 sec into the
+	 * seconds read register, so we need to program time +1 sec
+	 * to get the correct time on read.
+	 */
+	tm->tm_sec += 1;
 	new_time = rtc_tm_to_time64(tm);
 
 	if (new_time > RTC_SEC_MAX_VAL)
@@ -78,6 +85,17 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR);
 
+	/*
+	 * Clear the rtc interrupt status register after setting the
+	 * time. During a read_time function, the code should read the
+	 * RTC_INT_STATUS register and if bit 0 is still 0, it means
+	 * that one second has not elapsed yet since RTC was set and
+	 * the current time should be read from SET_TIME_READ register;
+	 * otherwise, CURRENT_TIME register is read to report the time
+	 */
+	writel(RTC_INT_SEC | RTC_INT_ALRM, xrtcdev->reg_base + RTC_INT_STS);
+	xrtcdev->time_updated = 0;
+
 	return 0;
 }
 
@@ -85,7 +103,17 @@ static int xlnx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
 
-	rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
+	if (xrtcdev->time_updated == 0) {
+		/*
+		 * Time written in SET_TIME_WRITE has not yet updated into
+		 * the seconds read register, so read the time from the
+		 * SET_TIME_WRITE instead of CURRENT_TIME register.
+		 */
+		rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_SET_TM_RD), tm);
+		tm->tm_sec -= 1;
+	} else {
+		rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
+	}
 
 	return rtc_valid_tm(tm);
 }
@@ -133,6 +161,9 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev)
 {
 	u32 rtc_ctrl;
 
+	/* Enable RTC SEC interrupts */
+	writel(RTC_INT_SEC, xrtcdev->reg_base + RTC_INT_EN);
+
 	/* Enable RTC switch to battery when VCC_PSAUX is not available */
 	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
 	rtc_ctrl |= RTC_BATT_EN;
@@ -169,8 +200,13 @@ static irqreturn_t xlnx_rtc_interrupt(int irq, void *id)
 	/* Clear interrupt */
 	writel(status, xrtcdev->reg_base + RTC_INT_STS);
 
-	if (status & RTC_INT_SEC)
+	if (status & RTC_INT_SEC) {
+		if (xrtcdev->time_updated == 0) {
+			/* RTC updated the seconds read register */
+			xrtcdev->time_updated = 1;
+		}
 		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_UF);
+	}
 	if (status & RTC_INT_ALRM)
 		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_AF);
 
-- 
2.1.2
