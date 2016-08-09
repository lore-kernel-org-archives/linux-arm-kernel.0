From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 09 Aug 2016 10:33:48 +0100
Subject: [PATCH] OF: mark released devices as no longer populated
Message-ID: <E1bX3Pw-00088i-KU@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a Linux device is released and cleaned up, we left the OF device
node marked as populated.  This causes the Freescale CAAM driver
(drivers/crypto/caam) problems when the module is removed and re-
inserted:

JR0 Platform device creation error
JR0 Platform device creation error
caam 2100000.caam: no queues configured, terminating
caam: probe of 2100000.caam failed with error -12

The reason is that CAAM creates platform devices for each job ring:

        for_each_available_child_of_node(nprop, np)
                if (of_device_is_compatible(np, "fsl,sec-v4.0-job-ring") ||
                    of_device_is_compatible(np, "fsl,sec4.0-job-ring")) {
                        ctrlpriv->jrpdev[ring] =
                                of_platform_device_create(np, NULL, dev);

which sets OF_POPULATED on the device node, but then it cleans these
up:

        /* Remove platform devices for JobRs */
        for (ring = 0; ring < ctrlpriv->total_jobrs; ring++) {
                if (ctrlpriv->jrpdev[ring])
                        of_device_unregister(ctrlpriv->jrpdev[ring]);
        }

which leaves OF_POPULATED set.

Arrange for platform devices with a device node to clear the
OF_POPULATED bit when they are released.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Please check this carefully - it may have issues where an of_node
pointer is copied from one platform device to another, but IMHO
doing that is itself buggy behaviour.

Resending due to wrong list address, sorry.

 include/linux/of_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index cc7dd687a89d..7a8362d0c6d2 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -43,6 +43,7 @@ extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env
 
 static inline void of_device_node_put(struct device *dev)
 {
+	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_put(dev->of_node);
 }
 
-- 
2.1.0
