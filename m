From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 12:39:41 -0700
Subject: [PATCH V2] dma: add channel request API that supports deferred probe
Message-ID: <1384803581-23871-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

dma_request_slave_channel() simply returns NULL whenever DMA channel
lookup fails. Lookup could fail for two distinct reasons:

a) No DMA specification exists for the channel name.
   This includes situations where no DMA specifications exist at all, or
   other general lookup problems.

b) A DMA specification does exist, yet the driver for that channel is not
   yet registered.

Case (b) should trigger deferred probe in client drivers. However, since
they have no way to differentiate the two situations, it cannot.

Implement new function dma_request_slave_channel_or_err(), which performs
identically to dma_request_slave_channel(), except that it returns an
error-pointer rather than NULL, which allows callers to detect when
deferred probe should occur.

Eventually, all drivers should be converted to this new API, the old API
removed, and the new API renamed to the more desirable name. This patch
doesn't convert the existing API and all drivers in one go, since some
drivers call dma_request_slave_channel() then dma_request_channel() if
that fails. That would require modifying dma_request_channel() in the
same way, which would then require modifying close to 100 drivers at once,
rather than just the 15-20 or so that use dma_request_slave_channel(),
which might be tenable in a single patch.

acpi_dma_request_slave_chan_by_index() doesn't actually implement
deferred probe. Perhaps it should?

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Dan Williams <dan.j.williams@intel.com>
To: Vinod Koul <vinod.koul@intel.com>
To: Andriy Shevchenko <andriy.shevchenko@intel.com>
Cc: dmaengine at vger.kernel.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2:
* include <linux/err.h> in <linux/dmaengine.h>
* Return -ENODATA if slave_id or chan_id out-of-range.
* Return an error-pointer not NULL if we can't find a matching DMA
  controller or translate the channel.

This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
Note that I'm just reposting this one patch from the series for V2.

Alternatively, if this patch can be applied directly on top of 3.13-rc1
(once it appears) alone in a stable topic branch, I can merge that into
my Tegra tree and use it as a base.
---
 drivers/dma/acpi-dma.c    | 14 +++++++-------
 drivers/dma/dmaengine.c   | 44 ++++++++++++++++++++++++++++++++++++++++----
 drivers/dma/of-dma.c      | 12 +++++++-----
 include/linux/dmaengine.h |  8 ++++++++
 include/linux/of_dma.h    |  9 ++++++---
 5 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index e69b03c0fa50..e3d9568f31a3 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -334,7 +334,7 @@ static int acpi_dma_parse_fixed_dma(struct acpi_resource *res, void *data)
  * @dev:	struct device to get DMA request from
  * @index:	index of FixedDMA descriptor for @dev
  *
- * Returns pointer to appropriate dma channel on success or NULL on error.
+ * Returns pointer to appropriate dma channel on success or an error pointer.
  */
 struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
 		size_t index)
@@ -349,10 +349,10 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
 
 	/* Check if the device was enumerated by ACPI */
 	if (!dev || !ACPI_HANDLE(dev))
-		return NULL;
+		return ERR_PTR(-ENODEV);
 
 	if (acpi_bus_get_device(ACPI_HANDLE(dev), &adev))
-		return NULL;
+		return ERR_PTR(-ENODEV);
 
 	memset(&pdata, 0, sizeof(pdata));
 	pdata.index = index;
@@ -367,7 +367,7 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
 	acpi_dev_free_resource_list(&resource_list);
 
 	if (dma_spec->slave_id < 0 || dma_spec->chan_id < 0)
-		return NULL;
+		return ERR_PTR(-ENODATA);
 
 	mutex_lock(&acpi_dma_lock);
 
@@ -390,7 +390,7 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
 	}
 
 	mutex_unlock(&acpi_dma_lock);
-	return chan;
+	return chan ? chan : ERR_PTR(-ENOENT);
 }
 EXPORT_SYMBOL_GPL(acpi_dma_request_slave_chan_by_index);
 
@@ -403,7 +403,7 @@ EXPORT_SYMBOL_GPL(acpi_dma_request_slave_chan_by_index);
  * translate the names "tx" and "rx" here based on the most common case where
  * the first FixedDMA descriptor is TX and second is RX.
  *
- * Returns pointer to appropriate dma channel on success or NULL on error.
+ * Returns pointer to appropriate dma channel on success or an error pointer.
  */
 struct dma_chan *acpi_dma_request_slave_chan_by_name(struct device *dev,
 		const char *name)
@@ -415,7 +415,7 @@ struct dma_chan *acpi_dma_request_slave_chan_by_name(struct device *dev,
 	else if (!strcmp(name, "rx"))
 		index = 1;
 	else
-		return NULL;
+		return ERR_PTR(-ENODEV);
 
 	return acpi_dma_request_slave_chan_by_index(dev, index);
 }
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ea806bdc12ef..5e7f8af2f0ec 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -540,6 +540,8 @@ EXPORT_SYMBOL_GPL(dma_get_slave_channel);
  * @mask: capabilities that the channel must satisfy
  * @fn: optional callback to disposition available channels
  * @fn_param: opaque parameter to pass to dma_filter_fn
+ *
+ * Returns pointer to appropriate dma channel on success or NULL.
  */
 struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 				       dma_filter_fn fn, void *fn_param)
@@ -588,24 +590,58 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 EXPORT_SYMBOL_GPL(__dma_request_channel);
 
 /**
- * dma_request_slave_channel - try to allocate an exclusive slave channel
+ * __dma_request_slave_channel - try to allocate an exclusive slave
+ *   channel
  * @dev:	pointer to client device structure
  * @name:	slave channel name
+ *
+ * Returns pointer to appropriate dma channel on success or an error pointer.
  */
-struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name)
+static struct dma_chan *__dma_request_slave_channel(struct device *dev,
+					const char *name, bool defer)
 {
 	/* If device-tree is present get slave info from here */
 	if (dev->of_node)
-		return of_dma_request_slave_channel(dev->of_node, name);
+		return of_dma_request_slave_channel(dev->of_node, name, defer);
 
 	/* If device was enumerated by ACPI get slave info from here */
 	if (ACPI_HANDLE(dev))
 		return acpi_dma_request_slave_chan_by_name(dev, name);
 
-	return NULL;
+	return ERR_PTR(-ENODEV);
+}
+
+/**
+ * dma_request_slave_channel - try to allocate an exclusive slave channel
+ * @dev:	pointer to client device structure
+ * @name:	slave channel name
+ *
+ * Returns pointer to appropriate dma channel on success or NULL.
+ */
+struct dma_chan *dma_request_slave_channel(struct device *dev,
+					   const char *name)
+{
+	struct dma_chan *ch = __dma_request_slave_channel(dev, name, false);
+	if (IS_ERR(ch))
+		return NULL;
+	return ch;
 }
 EXPORT_SYMBOL_GPL(dma_request_slave_channel);
 
+/**
+ * dma_request_slave_channel_or_err - try to allocate an exclusive slave channel
+ * @dev:	pointer to client device structure
+ * @name:	slave channel name
+ *
+ * Returns pointer to appropriate dma channel on success or an error pointer.
+ */
+struct dma_chan *dma_request_slave_channel_or_err(struct device *dev,
+						  const char *name)
+{
+	return __dma_request_slave_channel(dev, name, true);
+}
+EXPORT_SYMBOL_GPL(dma_request_slave_channel_or_err);
+
 void dma_release_channel(struct dma_chan *chan)
 {
 	mutex_lock(&dma_list_mutex);
diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 0b88dd3d05f4..928141f6f21b 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -143,10 +143,10 @@ static int of_dma_match_channel(struct device_node *np, const char *name,
  * @np:		device node to get DMA request from
  * @name:	name of desired channel
  *
- * Returns pointer to appropriate dma channel on success or NULL on error.
+ * Returns pointer to appropriate dma channel on success or an error pointer.
  */
 struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
-					      const char *name)
+					      const char *name, bool defer)
 {
 	struct of_phandle_args	dma_spec;
 	struct of_dma		*ofdma;
@@ -155,14 +155,14 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 
 	if (!np || !name) {
 		pr_err("%s: not enough information provided\n", __func__);
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	}
 
 	count = of_property_count_strings(np, "dma-names");
 	if (count < 0) {
 		pr_err("%s: dma-names property of node '%s' missing or empty\n",
 			__func__, np->full_name);
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	}
 
 	for (i = 0; i < count; i++) {
@@ -181,11 +181,13 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 
 		of_node_put(dma_spec.np);
 
+		if (!ofdma && defer)
+			return ERR_PTR(-EPROBE_DEFER);
 		if (chan)
 			return chan;
 	}
 
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 /**
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 41cf0c399288..f156c145fad2 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -22,6 +22,7 @@
 #define LINUX_DMAENGINE_H
 
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/uio.h>
 #include <linux/bug.h>
 #include <linux/scatterlist.h>
@@ -1041,6 +1042,8 @@ void dma_issue_pending_all(void);
 struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 					dma_filter_fn fn, void *fn_param);
 struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
+struct dma_chan *dma_request_slave_channel_or_err(struct device *dev,
+						  const char *name);
 void dma_release_channel(struct dma_chan *chan);
 #else
 static inline struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type)
@@ -1068,6 +1071,11 @@ static inline struct dma_chan *dma_request_slave_channel(struct device *dev,
 {
 	return NULL;
 }
+static inline struct dma_chan *dma_request_slave_channel_or_err(
+					struct device *dev, const char *name)
+{
+	return ERR_PTR(-ENODEV);
+}
 static inline void dma_release_channel(struct dma_chan *chan)
 {
 }
diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index ae36298ba076..0504461574c6 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -38,7 +38,8 @@ extern int of_dma_controller_register(struct device_node *np,
 		void *data);
 extern void of_dma_controller_free(struct device_node *np);
 extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
-						     const char *name);
+						     const char *name,
+						     bool defer);
 extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
 		struct of_dma *ofdma);
 #else
@@ -54,8 +55,10 @@ static inline void of_dma_controller_free(struct device_node *np)
 {
 }
 
-static inline struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
-						     const char *name)
+static inline struct dma_chan *of_dma_request_slave_channel(
+					struct device_node *np,
+					const char *name,
+					bool defer)
 {
 	return NULL;
 }
-- 
1.8.1.5
