From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:10:01 +0100
Subject: [PATCH 04/19] rtc: isl12057: enable support for the standard
 "wakeup-source" property
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1445422216-29375-5-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the isl12057 rtc driver should and will continue to support the
legacy "isil,irq2-can-wakeup-machine" property to enable RTC as the
wakeup source, we need to add support for the new standard property
"wakeup-source".

This patch adds support for "wakeup-source" property in addition to the
existing "isil,irq2-can-wakeup-machine" property.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux at googlegroups.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/rtc/rtc-isl12057.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index a0462e5430c7..54328d4ac0d3 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -466,9 +466,8 @@ static int isl12057_check_rtc_status(struct device *dev, struct regmap *regmap)
  * is for instance the case on ReadyNAS 102, 104 and 2120. On those
  * devices with no IRQ driectly connected to the SoC, the RTC chip
  * can be forced as a wakeup source by stating that explicitly in
- * the device's .dts file using the "isil,irq2-can-wakeup-machine"
- * boolean property. This will guarantee 'wakealarm' sysfs entry is
- * available on the device.
+ * the device's .dts file using the "wakeup-source" boolean property.
+ * This will guarantee 'wakealarm' sysfs entry is available on the device.
  *
  * The function below returns 1, i.e. the capability of the chip to
  * wakeup the device, based on IRQ availability or if the boolean
@@ -479,8 +478,9 @@ static bool isl12057_can_wakeup_machine(struct device *dev)
 {
 	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
 
-	return (data->irq || of_property_read_bool(dev->of_node,
-					      "isil,irq2-can-wakeup-machine"));
+	return data->irq || of_property_read_bool(dev->of_node, "wakeup-source")
+		|| of_property_read_bool(dev->of_node, /* legacy */
+					 "isil,irq2-can-wakeup-machine");
 }
 #else
 static bool isl12057_can_wakeup_machine(struct device *dev)
-- 
1.9.1
