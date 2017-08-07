From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon,  7 Aug 2017 11:29:48 +0100
Subject: [UPDATE PATCH v3 3/5] ACPI: Introduce DMA ranges parsing
Message-ID: <20170807102949.29701-1-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices have limited addressing capabilities and cannot
reference the whole memory address space while carrying out DMA
operations (eg some devices with bus address bits range smaller than
system bus - which prevents them from using bus addresses that are
otherwise valid for the system).

The ACPI _DMA object allows bus devices to define the DMA window that is
actually addressable by devices that sit upstream the bus, therefore
providing a means to parse and initialize the devices DMA masks and
addressable DMA range size.

By relying on the generic ACPI kernel layer to retrieve and parse
resources, introduce ACPI core code to parse the _DMA object.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/resource.c | 35 ++++++++++++++++++++++
 drivers/acpi/scan.c     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  2 ++
 include/linux/acpi.h    |  8 +++++
 4 files changed, 124 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 93f1b5c..d85e010 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -635,6 +635,41 @@ int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_resources);
 
+static int is_memory(struct acpi_resource *ares, void *not_used)
+{
+	struct resource_win win;
+	struct resource *res = &win.res;
+
+	memset(&win, 0, sizeof(win));
+
+	return !(acpi_dev_resource_memory(ares, res)
+	       || acpi_dev_resource_address_space(ares, &win)
+	       || acpi_dev_resource_ext_address_space(ares, &win));
+}
+
+/**
+ * acpi_dev_get_dma_resources - Get current DMA resources of a device.
+ * @adev: ACPI device node to get the resources for.
+ * @list: Head of the resultant list of resources (must be empty).
+ *
+ * Evaluate the _DMA method for the given device node and process its
+ * output.
+ *
+ * The resultant struct resource objects are put on the list pointed to
+ * by @list, that must be empty initially, as members of struct
+ * resource_entry objects.  Callers of this routine should use
+ * %acpi_dev_free_resource_list() to free that list.
+ *
+ * The number of resources in the output list is returned on success,
+ * an error code reflecting the error condition is returned otherwise.
+ */
+int acpi_dev_get_dma_resources(struct acpi_device *adev, struct list_head *list)
+{
+	return __acpi_dev_get_resources(adev, list, is_memory, NULL,
+					METHOD_NAME__DMA);
+}
+EXPORT_SYMBOL_GPL(acpi_dev_get_dma_resources);
+
 /**
  * acpi_dev_filter_resource_type - Filter ACPI resource according to resource
  *				   types
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3389729..842658c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1360,6 +1360,85 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 }
 
 /**
+ * acpi_dma_get_range() - Get device DMA parameters.
+ *
+ * @dev: device to configure
+ * @dma_addr: pointer device DMA address result
+ * @offset: pointer to the DMA offset result
+ * @size: pointer to DMA range size result
+ *
+ * Evaluate DMA regions and return respectively DMA region start, offset
+ * and size in dma_addr, offset and size on parsing success; it does not
+ * update the passed in values on failure.
+ *
+ * Return 0 on success, < 0 on failure.
+ */
+int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
+		       u64 *size)
+{
+	struct acpi_device *adev;
+	LIST_HEAD(list);
+	struct resource_entry *rentry;
+	int ret;
+	struct device *dma_dev = dev;
+	u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
+
+	/*
+	 * Walk the device tree chasing an ACPI companion with a _DMA
+	 * object while we go. Stop if we find a device with an ACPI
+	 * companion containing a _DMA method.
+	 */
+	do {
+		adev = ACPI_COMPANION(dma_dev);
+		if (adev && acpi_has_method(adev->handle, METHOD_NAME__DMA))
+			break;
+
+		dma_dev = dma_dev->parent;
+	} while (dma_dev);
+
+	if (!dma_dev)
+		return -ENODEV;
+
+	if (!acpi_has_method(adev->handle, METHOD_NAME__CRS)) {
+		acpi_handle_warn(adev->handle, "_DMA object only valid in object with valid _CRS\n");
+		return -EINVAL;
+	}
+
+	ret = acpi_dev_get_dma_resources(adev, &list);
+	if (ret > 0) {
+		list_for_each_entry(rentry, &list, node) {
+			if (dma_offset && rentry->offset != dma_offset) {
+				ret = -EINVAL;
+				dev_warn(dma_dev, "Can't handle multiple windows with different offsets\n");
+				goto out;
+			}
+			dma_offset = rentry->offset;
+
+			/* Take lower and upper limits */
+			if (rentry->res->start < dma_start)
+				dma_start = rentry->res->start;
+			if (rentry->res->end > dma_end)
+				dma_end = rentry->res->end;
+		}
+
+		if (dma_start >= dma_end) {
+			ret = -EINVAL;
+			dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
+			goto out;
+		}
+
+		*dma_addr = dma_start - dma_offset;
+		len = dma_end - dma_start;
+		*size = max(len, len + 1);
+		*offset = dma_offset;
+	}
+ out:
+	acpi_dev_free_resource_list(&list);
+
+	return ret >= 0 ? 0 : ret;
+}
+
+/**
  * acpi_dma_configure - Set-up DMA configuration for the device.
  * @dev: The pointer to the device
  * @attr: device dma attributes
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 68bc6be..07eb963 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -578,6 +578,8 @@ struct acpi_pci_root {
 
 bool acpi_dma_supported(struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
+int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
+		       u64 *size);
 int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
 void acpi_dma_deconfigure(struct device *dev);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c749eef..a5eaff9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -427,6 +427,8 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
 			   int (*preproc)(struct acpi_resource *, void *),
 			   void *preproc_data);
+int acpi_dev_get_dma_resources(struct acpi_device *adev,
+			       struct list_head *list);
 int acpi_dev_filter_resource_type(struct acpi_resource *ares,
 				  unsigned long types);
 
@@ -774,6 +776,12 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 	return DEV_DMA_NOT_SUPPORTED;
 }
 
+static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
+				     u64 *offset, u64 *size)
+{
+	return -ENODEV;
+}
+
 static inline int acpi_dma_configure(struct device *dev,
 				     enum dev_dma_attr attr)
 {
-- 
1.9.1
