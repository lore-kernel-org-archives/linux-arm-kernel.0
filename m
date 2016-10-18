From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 18 Oct 2016 17:03:59 +0100
Subject: [PATCH v6 01/16] drivers: acpi: add FWNODE_ACPI_STATIC fwnode type
In-Reply-To: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
Message-ID: <20161018160414.1228-2-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems booting with a device tree, every struct device is associated
with a struct device_node, that provides its DT firmware representation.
The device node can be used in generic kernel contexts (eg IRQ
translation, IOMMU streamid mapping), to retrieve the properties
associated with the device and carry out kernel operations accordingly.
Owing to the 1:1 relationship between the device and its device_node,
the device_node can also be used as a look-up token for the device (eg
looking up a device through its device_node), to retrieve the device in
kernel paths where the device_node is available.

On systems booting with ACPI, the same abstraction provided by
the device_node is required to provide look-up functionality.

The struct acpi_device, that represents firmware objects in the
ACPI namespace already includes a struct fwnode_handle of
type FWNODE_ACPI as their member; the same abstraction is missing
though for devices that are instantiated out of static ACPI tables
entries (eg ARM SMMU devices).

Add a new fwnode_handle type to associate devices created out
of static ACPI table entries to the respective firmware components
and create a simple ACPI core layer interface to dynamically allocate
and free the corresponding firmware nodes so that kernel subsystems
can use it to instantiate the nodes and associate them with the
respective devices.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 include/linux/acpi.h   | 21 +++++++++++++++++++++
 include/linux/fwnode.h |  3 ++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddbeda6..a284273 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -56,6 +56,27 @@ static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 	acpi_fwnode_handle(adev) : NULL)
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
 
+static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
+{
+	struct fwnode_handle *fwnode;
+
+	fwnode = kzalloc(sizeof(struct fwnode_handle), GFP_KERNEL);
+	if (!fwnode)
+		return NULL;
+
+	fwnode->type = FWNODE_ACPI_STATIC;
+
+	return fwnode;
+}
+
+static inline void acpi_free_fwnode_static(struct fwnode_handle *fwnode)
+{
+	if (WARN_ON(!fwnode || fwnode->type != FWNODE_ACPI_STATIC))
+		return;
+
+	kfree(fwnode);
+}
+
 /**
  * ACPI_DEVICE_CLASS - macro used to describe an ACPI device with
  * the PCI-defined class-code information
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 8516717..8bd28ce 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -17,8 +17,9 @@ enum fwnode_type {
 	FWNODE_OF,
 	FWNODE_ACPI,
 	FWNODE_ACPI_DATA,
+	FWNODE_ACPI_STATIC,
 	FWNODE_PDATA,
-	FWNODE_IRQCHIP,
+	FWNODE_IRQCHIP
 };
 
 struct fwnode_handle {
-- 
2.10.0
