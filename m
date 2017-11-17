From: khoroshilov@ispras.ru (Alexey Khoroshilov)
Date: Sat, 18 Nov 2017 00:15:58 +0300
Subject: [PATCH] rtc: brcmstb-waketimer: fix error handling in
 brcmstb_waketmr_probe()
Message-ID: <1510953358-7043-1-git-send-email-khoroshilov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

brcmstb_waketmr_probe() does not disable timer->clk on error paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index 796ac792a381..6cee61201c30 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -253,7 +253,7 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, timer->irq, brcmstb_waketmr_irq, 0,
 			       "brcmstb-waketimer", timer);
 	if (ret < 0)
-		return ret;
+		goto err_clk;
 
 	timer->reboot_notifier.notifier_call = brcmstb_waketmr_reboot;
 	register_reboot_notifier(&timer->reboot_notifier);
@@ -262,12 +262,21 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 					 &brcmstb_waketmr_ops, THIS_MODULE);
 	if (IS_ERR(timer->rtc)) {
 		dev_err(dev, "unable to register device\n");
-		unregister_reboot_notifier(&timer->reboot_notifier);
-		return PTR_ERR(timer->rtc);
+		ret = PTR_ERR(timer->rtc);
+		goto err_notifier;
 	}
 
 	dev_info(dev, "registered, with irq %d\n", timer->irq);
 
+	return 0;
+
+err_notifier:
+	unregister_reboot_notifier(&timer->reboot_notifier);
+
+err_clk:
+	if (timer->clk)
+		clk_disable_unprepare(timer->clk);
+
 	return ret;
 }
 
-- 
2.7.4
