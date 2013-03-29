From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:37 +0800
Subject: [PATCH 01/13] rtc: stmp3xxx: use stmp_reset_block() instead
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function stmp_reset_block() provides the exactly same functionality
as mxs_reset_block().  So use stmp_reset_block() instead, so that
<mach/common.h> inclusion can be removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: rtc-linux at googlegroups.com
---
 drivers/rtc/rtc-stmp3xxx.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 98f0d3c..67d2612 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -30,8 +30,6 @@
 #include <linux/stmp_device.h>
 #include <linux/stmp3xxx_rtc_wdt.h>
 
-#include <mach/common.h>
-
 #define STMP3XXX_RTC_CTRL			0x0
 #define STMP3XXX_RTC_CTRL_SET			0x4
 #define STMP3XXX_RTC_CTRL_CLR			0x8
@@ -271,7 +269,7 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc_data);
 
-	mxs_reset_block(rtc_data->io);
+	stmp_reset_block(rtc_data->io);
 	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
@@ -319,7 +317,7 @@ static int stmp3xxx_rtc_resume(struct platform_device *dev)
 {
 	struct stmp3xxx_rtc_data *rtc_data = platform_get_drvdata(dev);
 
-	mxs_reset_block(rtc_data->io);
+	stmp_reset_block(rtc_data->io);
 	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
-- 
1.7.9.5
