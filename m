From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Sun, 20 May 2018 22:27:29 +0200
Subject: [PATCH 1/2] rtc: brcmstb-waketimer: switch to rtc_register_device
Message-ID: <20180520202730.28172-1-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to devm_rtc_allocate_device/rtc_register_device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index bdd6674a1054..ba49d9bcff12 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -229,6 +229,10 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 	if (IS_ERR(timer->base))
 		return PTR_ERR(timer->base);
 
+	timer->rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(timer->rtc))
+		return PTR_ERR(timer->rtc);
+
 	/*
 	 * Set wakeup capability before requesting wakeup interrupt, so we can
 	 * process boot-time "wakeups" (e.g., from S5 soft-off)
@@ -261,11 +265,11 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 	timer->reboot_notifier.notifier_call = brcmstb_waketmr_reboot;
 	register_reboot_notifier(&timer->reboot_notifier);
 
-	timer->rtc = rtc_device_register("brcmstb-waketmr", dev,
-					 &brcmstb_waketmr_ops, THIS_MODULE);
-	if (IS_ERR(timer->rtc)) {
+	timer->rtc->ops = &brcmstb_waketmr_ops;
+
+	ret = rtc_register_device(timer->rtc);
+	if (ret) {
 		dev_err(dev, "unable to register device\n");
-		ret = PTR_ERR(timer->rtc);
 		goto err_notifier;
 	}
 
@@ -288,7 +292,6 @@ static int brcmstb_waketmr_remove(struct platform_device *pdev)
 	struct brcmstb_waketmr *timer = dev_get_drvdata(&pdev->dev);
 
 	unregister_reboot_notifier(&timer->reboot_notifier);
-	rtc_device_unregister(timer->rtc);
 
 	return 0;
 }
-- 
2.17.0
