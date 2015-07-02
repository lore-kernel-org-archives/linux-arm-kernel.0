From: wnhuang@chromium.org (Wei-Ning Huang)
Date: Thu,  2 Jul 2015 16:36:56 +0800
Subject: [PATCH] rtc-mt6397: enable wakeup before registering rtc device
Message-ID: <1435826216-11982-1-git-send-email-wnhuang@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc_sysfs_add_device checks if device can wakeup before creating the
wakealarm file in sysfs. Thus the driver must set wakeup capability
before registering the rtc device.

Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
---
 drivers/rtc/rtc-mt6397.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index c0090b6..eab230b 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -343,6 +343,8 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 		goto out_dispose_irq;
 	}
 
+	device_init_wakeup(&pdev->dev, 1);
+
 	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
 					   &mtk_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
@@ -351,8 +353,6 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 		goto out_free_irq;
 	}
 
-	device_init_wakeup(&pdev->dev, 1);
-
 	return 0;
 
 out_free_irq:
-- 
2.1.2
