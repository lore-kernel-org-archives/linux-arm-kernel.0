From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 6 Apr 2016 14:45:53 +0300
Subject: [RFC PATCH] PM / wakeirq: fix wakeirq setting after wakup
 re-configuration from sysfs
Message-ID: <1459943153-2553-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now wakeirq stops working for device if wakeup option for
this device will be reconfigured through sysfs, like:

echo disabled > /sys/devices/platform/extcon_usb1/power/wakeup
echo enabled > /sys/devices/platform/extcon_usb1/power/wakeup

Once above set of commands is executed the device's wakeup_source
opject will be recreated and dev->power.wakeup->wakeirq field will
contain NULL. As result, device_wakeup_arm_wake_irqs() will not arm
wakeirq for the affected device.

Hece, lets try to fix it in the following way:
  check for dev->wakeirq field when device_wakeup_attach() is called
  and if !NULL re-attach wakeirq to the device

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/base/power/wakeup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index a2657f1..52a0c25 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -246,6 +246,8 @@ static int device_wakeup_attach(struct device *dev, struct wakeup_source *ws)
 		return -EEXIST;
 	}
 	dev->power.wakeup = ws;
+	if (dev->power.wakeirq)
+		device_wakeup_attach_irq(dev, dev->power.wakeirq);
 	spin_unlock_irq(&dev->power.lock);
 	return 0;
 }
-- 
2.8.0
