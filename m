From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:37:53 +0000
Subject: [PATCH 23/33] MFD: ucb1x00-core: scan drivers in same order they're
 registered
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3yz-0000ZJ-Cn@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cosmetic patch to scan the list of drivers in the order that the drivers
are registered, rather than the reverse order.  This avoids surprises
when drivers get probed in the reverse order, and input devices get
registered in a different order due to bind/unbind than from boot.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 30ef726..162496d 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -436,8 +436,8 @@ static int ucb1x00_add_dev(struct ucb1x00 *ucb, struct ucb1x00_driver *drv)
 		ret = drv->add(dev);
 
 		if (ret == 0) {
-			list_add(&dev->dev_node, &ucb->devs);
-			list_add(&dev->drv_node, &drv->devs);
+			list_add_tail(&dev->dev_node, &ucb->devs);
+			list_add_tail(&dev->drv_node, &drv->devs);
 		} else {
 			kfree(dev);
 		}
@@ -605,7 +605,7 @@ static int ucb1x00_probe(struct mcp *mcp)
 
 	INIT_LIST_HEAD(&ucb->devs);
 	mutex_lock(&ucb1x00_mutex);
-	list_add(&ucb->node, &ucb1x00_devices);
+	list_add_tail(&ucb->node, &ucb1x00_devices);
 	list_for_each_entry(drv, &ucb1x00_drivers, node) {
 		ucb1x00_add_dev(ucb, drv);
 	}
@@ -663,7 +663,7 @@ int ucb1x00_register_driver(struct ucb1x00_driver *drv)
 
 	INIT_LIST_HEAD(&drv->devs);
 	mutex_lock(&ucb1x00_mutex);
-	list_add(&drv->node, &ucb1x00_drivers);
+	list_add_tail(&drv->node, &ucb1x00_drivers);
 	list_for_each_entry(ucb, &ucb1x00_devices, node) {
 		ucb1x00_add_dev(ucb, drv);
 	}
-- 
1.7.4.4
