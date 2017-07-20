From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 21 Jul 2017 00:18:36 +0100
Subject: [PATCH 3/4] rtc: pl031: avoid exposing alarm if no interrupt
In-Reply-To: <20170720231745.GE31807@n2100.armlinux.org.uk>
References: <20170720231745.GE31807@n2100.armlinux.org.uk>
Message-ID: <E1dYKiK-0001kZ-6E@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the RTC has no interrupt, there is little point in exposing the RTC
alarm capabilities, as it can't be used as a wakeup source nor can it
deliver an event to userspace.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/rtc/rtc-pl031.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 5960fbd08b05..64c77ec1b4ea 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -329,12 +329,14 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 
 	ldata = devm_kzalloc(&adev->dev, sizeof(struct pl031_local),
 			     GFP_KERNEL);
-	if (!ldata) {
+	ops = devm_kmemdup(&adev->dev, &vendor->ops, sizeof(vendor->ops),
+			   GFP_KERNEL);
+	if (!ldata || !ops) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	ldata->vendor = vendor;
 
+	ldata->vendor = vendor;
 	ldata->base = devm_ioremap(&adev->dev, adev->res.start,
 				   resource_size(&adev->res));
 	if (!ldata->base) {
@@ -372,6 +374,13 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 		}
 	}
 
+	if (!adev->irq[0]) {
+		/* When there's no interrupt, no point in exposing the alarm */
+		ops->read_alarm = NULL;
+		ops->set_alarm = NULL;
+		ops->alarm_irq_enable = NULL;
+	}
+
 	device_init_wakeup(&adev->dev, true);
 	ldata->rtc = rtc_device_register("pl031", &adev->dev, ops,
 					THIS_MODULE);
-- 
2.7.4
