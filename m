From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Sun,  9 Sep 2018 22:38:48 +0200
Subject: [PATCH 3/3] rtc: pl031: switch to
 devm_rtc_allocate_device/rtc_register_device
In-Reply-To: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
References: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
Message-ID: <20180909203848.3470-3-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to devm_rtc_allocate_device to simplify the erro and driver removal
paths.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pl031.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 82eb7da2c478..30943d200c5e 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -310,7 +310,6 @@ static int pl031_remove(struct amba_device *adev)
 	device_init_wakeup(&adev->dev, false);
 	if (adev->irq[0])
 		free_irq(adev->irq[0], ldata);
-	rtc_device_unregister(ldata->rtc);
 	amba_release_regions(adev);
 
 	return 0;
@@ -383,24 +382,25 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	device_init_wakeup(&adev->dev, true);
-	ldata->rtc = rtc_device_register("pl031", &adev->dev, ops,
-					THIS_MODULE);
-	if (IS_ERR(ldata->rtc)) {
-		ret = PTR_ERR(ldata->rtc);
+	ldata->rtc = devm_rtc_allocate_device(&adev->dev);
+	if (IS_ERR(ldata->rtc))
+		return PTR_ERR(ldata->rtc);
+
+	ldata->rtc->ops = ops;
+
+	ret = rtc_register_device(ldata->rtc);
+	if (ret)
 		goto out;
-	}
 
 	if (adev->irq[0]) {
 		ret = request_irq(adev->irq[0], pl031_interrupt,
 				  vendor->irqflags, "rtc-pl031", ldata);
 		if (ret)
-			goto out_no_irq;
+			goto out;
 		dev_pm_set_wake_irq(&adev->dev, adev->irq[0]);
 	}
 	return 0;
 
-out_no_irq:
-	rtc_device_unregister(ldata->rtc);
 out:
 	amba_release_regions(adev);
 err_req:
-- 
2.19.0.rc2
