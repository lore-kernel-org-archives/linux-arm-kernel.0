From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 13 May 2014 17:24:54 +0100
Subject: [PATCH v2] of/platform: Add of_platform_depopulate() helper
In-Reply-To: <1399997324.3657.35.camel@hornet>
References: <1399997324.3657.35.camel@hornet>
Message-ID: <1399998294-24447-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers can us of_platform_populate() to create
platform devices for children of the device
main node (this can particularly happen in case
of MFD devices). Unfortunately, there was no
standard way of removing such sub-devices when
the main one is being removed.

This patch adds of_platform_depopulate() as
a complementary operation for the _populate()
one. It removes all platform and amba devices
that have been created from the Device Tree,
but leaves all other ones untouched (returning
-EBUSY in such case).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
Changes since v1:

- using bool rather than int to signal remaining children
- recursing using of_platform_depopulate() itself

 drivers/of/platform.c       | 50 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_platform.h |  5 +++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 236f47e..3b51e04 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -495,4 +495,54 @@ int of_platform_populate(struct device_node *root,
 	return rc;
 }
 EXPORT_SYMBOL_GPL(of_platform_populate);
+
+static int of_platform_device_destroy(struct device *dev, void *data)
+{
+	bool *children_left = data;
+
+	/* Do not touch devices not populated from the device tree */
+	if (!dev->of_node || !of_node_check_flag(dev->of_node, OF_POPULATED)) {
+		*children_left = true;
+		return 0;
+	}
+
+	/* Recurse, but don't touch this device if it has any children left */
+	if (of_platform_depopulate(dev) != 0) {
+		*children_left = true;
+		return 0;
+	}
+
+	if (dev->bus == &platform_bus_type)
+		platform_device_unregister(to_platform_device(dev));
+	else if (dev->bus == &amba_bustype)
+		amba_device_unregister(to_amba_device(dev));
+	else
+		*children_left = true;
+
+	return 0;
+}
+
+/**
+ * of_platform_depopulate() - Remove devices populated from device tree
+ * @parent: device which childred will be removed
+ *
+ * Complementary to of_platform_populate(), this function removes children
+ * of the given device (and, recurrently, their children) that have been
+ * created from their respective device tree nodes (and only those,
+ * leaving others - eg. manually created - unharmed).
+ *
+ * Returns 0 when all children devices have been removed or
+ * -EBUSY when some children remained.
+ */
+int of_platform_depopulate(struct device *parent)
+{
+	bool children_left = false;
+
+	device_for_each_child(parent, &children_left,
+			of_platform_device_destroy);
+
+	return children_left ? -EBUSY : 0;
+}
+EXPORT_SYMBOL_GPL(of_platform_depopulate);
+
 #endif /* CONFIG_OF_ADDRESS */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 05cb4a9..b1010ee 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -72,6 +72,7 @@ extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
 				const struct of_dev_auxdata *lookup,
 				struct device *parent);
+extern int of_platform_depopulate(struct device *parent);
 #else
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
@@ -80,6 +81,10 @@ static inline int of_platform_populate(struct device_node *root,
 {
 	return -ENODEV;
 }
+static inline int of_platform_depopulate(struct device *parent)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif	/* _LINUX_OF_PLATFORM_H */
-- 
1.9.1
