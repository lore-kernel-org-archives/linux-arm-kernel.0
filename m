From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Apr 2014 15:05:17 +0100
Subject: [PATCH v2] of: Keep track of populated platform devices
In-Reply-To: <1398858529.24255.3.camel@hornet>
References: <1398858529.24255.3.camel@hornet>
Message-ID: <1398866717-20268-1-git-send-email-pawel.moll@arm.com>
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

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---

Changes since v1:

- added of_node_check_and_set_flag()... (atomic test and set)
- ... used it to atomically mark a node...
- ... clearing the bit on error path.

 drivers/of/platform.c | 18 +++++++++++++-----
 include/linux/of.h    |  7 +++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 404d1da..b33927a 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -204,12 +204,13 @@ static struct platform_device *of_platform_device_create_pdata(
 {
 	struct platform_device *dev;
 
-	if (!of_device_is_available(np))
+	if (!of_device_is_available(np) ||
+			of_node_check_and_set_flag(np, OF_POPULATED))
 		return NULL;
 
 	dev = of_device_alloc(np, bus_id, parent);
 	if (!dev)
-		return NULL;
+		goto err_clear_flag;
 
 #if defined(CONFIG_MICROBLAZE)
 	dev->archdata.dma_mask = 0xffffffffUL;
@@ -227,10 +228,14 @@ static struct platform_device *of_platform_device_create_pdata(
 
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
@@ -262,14 +267,15 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 
 	pr_debug("Creating amba device %s\n", node->full_name);
 
-	if (!of_device_is_available(node))
+	if (!of_device_is_available(node) ||
+			of_node_check_and_set_flag(node, OF_POPULATED))
 		return NULL;
 
 	dev = amba_device_alloc(NULL, 0, 0);
 	if (!dev) {
 		pr_err("%s(): amba_device_alloc() failed for %s\n",
 		       __func__, node->full_name);
-		return NULL;
+		goto err_clear_flag;
 	}
 
 	/* setup generic device info */
@@ -309,6 +315,8 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 
 err_free:
 	amba_device_put(dev);
+err_clear_flag:
+	of_node_clear_flag(node, OF_POPULATED);
 	return NULL;
 }
 #else /* CONFIG_ARM_AMBA */
diff --git a/include/linux/of.h b/include/linux/of.h
index 3bad8d1..534cab8 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -130,6 +130,12 @@ static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
 	return test_bit(flag, &n->_flags);
 }
 
+static inline int of_node_check_and_set_flag(struct device_node *n,
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
-- 
1.9.1
