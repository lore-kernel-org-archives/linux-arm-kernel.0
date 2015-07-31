From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 31 Jul 2015 14:08:29 +0530
Subject: [PATCH 09/15] drivers: rtc: Drop unlikely before IS_ERR(_OR_NULL)
In-Reply-To: <cover.1438331416.git.viresh.kumar@linaro.org>
References: <cover.1438331416.git.viresh.kumar@linaro.org>
Message-ID: <cdfa3fb76901fe1c4a5756e7e64cb3370cf6317a.1438331416.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
is no need to do that again from its callers. Drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/rtc/interface.c  | 2 +-
 drivers/rtc/rtc-bfin.c   | 2 +-
 drivers/rtc/rtc-gemini.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 11b639067312..5836751b8203 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -564,7 +564,7 @@ enum hrtimer_restart rtc_pie_update_irq(struct hrtimer *timer)
 void rtc_update_irq(struct rtc_device *rtc,
 		unsigned long num, unsigned long events)
 {
-	if (unlikely(IS_ERR_OR_NULL(rtc)))
+	if (IS_ERR_OR_NULL(rtc))
 		return;
 
 	pm_stay_awake(rtc->dev.parent);
diff --git a/drivers/rtc/rtc-bfin.c b/drivers/rtc/rtc-bfin.c
index 3d44b11721ea..535a5f9338d0 100644
--- a/drivers/rtc/rtc-bfin.c
+++ b/drivers/rtc/rtc-bfin.c
@@ -361,7 +361,7 @@ static int bfin_rtc_probe(struct platform_device *pdev)
 	/* Register our RTC with the RTC framework */
 	rtc->rtc_dev = devm_rtc_device_register(dev, pdev->name, &bfin_rtc_ops,
 						THIS_MODULE);
-	if (unlikely(IS_ERR(rtc->rtc_dev)))
+	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);
 
 	/* Grab the IRQ and init the hardware */
diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index 35f4486738fc..2fed93e1114a 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -148,7 +148,7 @@ static int gemini_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtc_dev = rtc_device_register(pdev->name, dev,
 					   &gemini_rtc_ops, THIS_MODULE);
-	if (likely(IS_ERR(rtc->rtc_dev)))
+	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);
 
 	return 0;
-- 
2.4.0
