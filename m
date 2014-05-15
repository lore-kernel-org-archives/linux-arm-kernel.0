From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 15 May 2014 18:07:32 +0100
Subject: [PATCH] amba: Put the device's of_node on its release
Message-ID: <1400173652-30583-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An amba device created from Device Tree, when released, does not
decrease of_node's reference counter.

Fixed by adding a call to of_device_node_put() on the release
path, in a similar way to what platform_device_release() is doing.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/amba/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 3cf61a1..0f489fb 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -17,6 +17,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/amba/bus.h>
 #include <linux/sizes.h>
+#include <linux/of_device.h>
 
 #include <asm/irq.h>
 
@@ -268,6 +269,7 @@ static void amba_device_release(struct device *dev)
 {
 	struct amba_device *d = to_amba_device(dev);
 
+	of_device_node_put(dev);
 	if (d->res.parent)
 		release_resource(&d->res);
 	kfree(d);
-- 
1.9.1
