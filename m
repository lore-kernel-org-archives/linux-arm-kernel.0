From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 13 May 2014 12:48:36 +0100
Subject: [PATCH v3] of: Keep track of populated platform devices
In-Reply-To: <Message-ID: <1399473437.3706.25.camel@hornet>
References: <Message-ID: <1399473437.3706.25.camel@hornet>
Message-ID: <1399981716-24618-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In "Device Tree powered" systems, platform devices are usually
massively populated with of_platform_populate() call, executed
at some level of initcalls, either by generic architecture
or by platform-specific code.

There are situations though where certain devices must be
created (and bound with drivers) before all the others.
This presents a challenge, as devices created explicitly
would be created again by of_platform_populate().

This patch tries to solve that issue in a generic way,
adding a "populated" flag for a DT node description.
Once set, this device will never be created again via
of_* API, so of_platform_populate() will skip such nodes
(and its children) in a similar way to the non-available
ones.

The flag is cleared when a device is being removed and
returns the DT node by calling of_device_node_put() (it
was missing from the amba device release function, added).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
Changes since v2:

- the populated flag is now cleared when the device
  is being removed by platform or amba bus code
- added missing of_device_node_put() to amba_device_release()
- renamed of_node_check_and_set_flag() to
  of_node_check_test_and_set_flag() to follow the
  bitops naming convention
- didn't add Rob's ack as the patch changed too much

Changes since v1:

- added of_node_check_and_set_flag()... (atomic test and set)
- ... used it to atomically mark a node...
- ... clearing the bit on error path.

 drivers/amba/bus.c        |  2 ++
 drivers/of/platform.c     | 18 +++++++++++++-----
 include/linux/of.h        |  7 +++++++
 include/linux/of_device.h |  2 ++
 4 files changed, 24 insertions(+), 5 deletions(-)

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
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index bd47fbc..2d0c8b7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -206,12 +206,13 @@ static struct platform_device *of_platform_device_create_pdata(
 {
 	struct platform_device *dev;
 
-	if (!of_device_is_available(np))
+	if (!of_device_is_available(np) ||
+			of_node_test_and_set_flag(np, OF_POPULATED))
 		return NULL;
 
 	dev = of_device_alloc(np, bus_id, parent);
 	if (!dev)
-		return NULL;
+		goto err_clear_flag;
 
 #if defined(CONFIG_MICROBLAZE)
 	dev->archdata.dma_mask = 0xffffffffUL;
@@ -229,10 +230,14 @@ static struct platform_device *of_platform_device_create_pdata(
 
 	if (of_device_add(dev) != 0) {
 		platform_device_put(dev);
-		return NULL;
+		goto err_clear_flag;
 	}
 
 	return dev;
+
+err_clear_flag:
+	of_node_clear_flag(np, OF_POPULATED);
+	return NULL;
 }
 
 /**
@@ -264,14 +269,15 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 
 	pr_debug("Creating amba device %s\n", node->full_name);
 
-	if (!of_device_is_available(node))
+	if (!of_device_is_available(node) ||
+			of_node_test_and_set_flag(node, OF_POPULATED))
 		return NULL;
 
 	dev = amba_device_alloc(NULL, 0, 0);
 	if (!dev) {
 		pr_err("%s(): amba_device_alloc() failed for %s\n",
 		       __func__, node->full_name);
-		return NULL;
+		goto err_clear_flag;
 	}
 
 	/* setup generic device info */
@@ -311,6 +317,8 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 
 err_free:
 	amba_device_put(dev);
+err_clear_flag:
+	of_node_clear_flag(node, OF_POPULATED);
 	return NULL;
 }
 #else /* CONFIG_ARM_AMBA */
diff --git a/include/linux/of.h b/include/linux/of.h
index 3bad8d1..3fd6079 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -130,6 +130,12 @@ static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
 	return test_bit(flag, &n->_flags);
 }
 
+static inline int of_node_test_and_set_flag(struct device_node *n,
+		unsigned long flag)
+{
+	return test_and_set_bit(flag, &n->_flags);
+}
+
 static inline void of_node_set_flag(struct device_node *n, unsigned long flag)
 {
 	set_bit(flag, &n->_flags);
@@ -197,6 +203,7 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
 /* flag descriptions */
 #define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
 #define OF_DETACHED	2 /* node has been detached from the device tree */
+#define OF_POPULATED	3 /* device already created for the node */
 
 #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
 #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index ef37021..fd14d46 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -41,6 +41,8 @@ extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env
 
 static inline void of_device_node_put(struct device *dev)
 {
+	if (dev->of_node)
+		of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_put(dev->of_node);
 }
 
-- 
1.9.1
