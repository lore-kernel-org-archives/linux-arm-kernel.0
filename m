From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 29 Sep 2017 11:22:05 +0100
Subject: [PATCH v2 2/4] rtc: pl031: use devm_* for allocating memory and
 mapping resource
In-Reply-To: <20170929102116.GX20805@n2100.armlinux.org.uk>
References: <20170929102116.GX20805@n2100.armlinux.org.uk>
Message-ID: <E1dxsQn-0006Nd-IQ@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the devm_* APIs for allocating memory and mapping the memory in
the probe function to relieve the driver from having to deal with
this in the cleanup paths.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/rtc/rtc-pl031.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 0d87b90b1903..777da06d53ee 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -310,8 +310,6 @@ static int pl031_remove(struct amba_device *adev)
 	device_init_wakeup(&adev->dev, false);
 	free_irq(adev->irq[0], ldata);
 	rtc_device_unregister(ldata->rtc);
-	iounmap(ldata->base);
-	kfree(ldata);
 	amba_release_regions(adev);
 
 	return 0;
@@ -329,18 +327,19 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ret)
 		goto err_req;
 
-	ldata = kzalloc(sizeof(struct pl031_local), GFP_KERNEL);
+	ldata = devm_kzalloc(&adev->dev, sizeof(struct pl031_local),
+			     GFP_KERNEL);
 	if (!ldata) {
 		ret = -ENOMEM;
 		goto out;
 	}
 	ldata->vendor = vendor;
 
-	ldata->base = ioremap(adev->res.start, resource_size(&adev->res));
-
+	ldata->base = devm_ioremap(&adev->dev, adev->res.start,
+				   resource_size(&adev->res));
 	if (!ldata->base) {
 		ret = -ENOMEM;
-		goto out_no_remap;
+		goto out;
 	}
 
 	amba_set_drvdata(adev, ldata);
@@ -378,7 +377,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 					THIS_MODULE);
 	if (IS_ERR(ldata->rtc)) {
 		ret = PTR_ERR(ldata->rtc);
-		goto out_no_rtc;
+		goto out;
 	}
 
 	if (request_irq(adev->irq[0], pl031_interrupt,
@@ -391,10 +390,6 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 
 out_no_irq:
 	rtc_device_unregister(ldata->rtc);
-out_no_rtc:
-	iounmap(ldata->base);
-out_no_remap:
-	kfree(ldata);
 out:
 	amba_release_regions(adev);
 err_req:
-- 
2.7.4
