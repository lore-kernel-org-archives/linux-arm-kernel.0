From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 25 Jan 2017 16:41:55 +0800
Subject: [PATCH 2/4] rtc: st-lpc: using devm_rtc_device_register helper
In-Reply-To: <1485333717-47536-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1485333717-47536-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1485333717-47536-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using devm_rtc_device_register() helper to simplify code.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/rtc/rtc-st-lpc.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 74c0a33..4f81124 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -272,8 +272,8 @@ static int st_rtc_probe(struct platform_device *pdev)
 		st_rtc_set_time(&pdev->dev, &tm_check);
 	}
 
-	rtc->rtc_dev = rtc_device_register("st-lpc-rtc", &pdev->dev,
-					   &st_rtc_ops, THIS_MODULE);
+	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, "st-lpc-rtc",
+						&st_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
 		clk_disable_unprepare(rtc->clk);
 		return PTR_ERR(rtc->rtc_dev);
@@ -282,16 +282,6 @@ static int st_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int st_rtc_remove(struct platform_device *pdev)
-{
-	struct st_rtc *rtc = platform_get_drvdata(pdev);
-
-	if (likely(rtc->rtc_dev))
-		rtc_device_unregister(rtc->rtc_dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int st_rtc_suspend(struct device *dev)
 {
@@ -344,7 +334,6 @@ static int st_rtc_resume(struct device *dev)
 		.of_match_table = st_rtc_match,
 	},
 	.probe = st_rtc_probe,
-	.remove = st_rtc_remove,
 };
 
 module_platform_driver(st_rtc_platform_driver);
-- 
1.7.12.4
