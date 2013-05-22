From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 May 2013 13:40:16 -0700
Subject: [RFC/PATCH 1/2] of: Assign of_device_id to matching device_node
In-Reply-To: <1369255217-29764-1-git-send-email-sboyd@codeaurora.org>
References: <1369255217-29764-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1369255217-29764-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform drivers have to match the compatible field twice if they
want to use the .data field of the of_device_id struct when their
driver matches multiple devicetree compatible fields. The first
match happens when the driver core probes for a matching
device and the second match typically happens during their probe
routine when the driver calls of_match_device() to get the
of_device_id that this device matches.

Skip this duplicate search by assigning the of_device_id to a new
id_entry pointer in the device_node struct when the driver core
matches up an of_device_id with a device_node. Drivers can then
get the entry pointer via dev->of_node->id_entry and access the
.data field to differentiate which device they matched.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/of/device.c       | 18 ++++++++++++++++++
 include/linux/of.h        |  1 +
 include/linux/of_device.h | 12 ++----------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index f685e55..f3eab88 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -27,6 +27,24 @@ const struct of_device_id *of_match_device(const struct of_device_id *matches,
 }
 EXPORT_SYMBOL(of_match_device);
 
+/**
+ * of_driver_match_device - Tell if a driver's of_match_table matches a device.
+ * @drv: the device_driver structure to test
+ * @dev: the device structure to match against
+ */
+int of_driver_match_device(struct device *dev,
+			   const struct device_driver *drv)
+{
+	const struct of_device_id *id;
+
+	id = of_match_device(drv->of_match_table, dev);
+	if (id)
+		dev->of_node->id_entry = id;
+
+	return id != NULL;
+}
+EXPORT_SYMBOL(of_driver_match_device);
+
 struct platform_device *of_dev_get(struct platform_device *dev)
 {
 	struct device *tmp;
diff --git a/include/linux/of.h b/include/linux/of.h
index 1fd08ca..6c847af 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -59,6 +59,7 @@ struct device_node {
 	struct	proc_dir_entry *pde;	/* this node's proc directory */
 	struct	kref kref;
 	unsigned long _flags;
+	const struct  of_device_id *id_entry;
 	void	*data;
 #if defined(CONFIG_SPARC)
 	const char *path_component_name;
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 901b743..5b2a69a 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -14,16 +14,8 @@ extern const struct of_device_id *of_match_device(
 	const struct of_device_id *matches, const struct device *dev);
 extern void of_device_make_bus_id(struct device *dev);
 
-/**
- * of_driver_match_device - Tell if a driver's of_match_table matches a device.
- * @drv: the device_driver structure to test
- * @dev: the device structure to match against
- */
-static inline int of_driver_match_device(struct device *dev,
-					 const struct device_driver *drv)
-{
-	return of_match_device(drv->of_match_table, dev) != NULL;
-}
+extern int of_driver_match_device(struct device *dev,
+				  const struct device_driver *drv);
 
 extern struct platform_device *of_dev_get(struct platform_device *dev);
 extern void of_dev_put(struct platform_device *dev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
