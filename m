From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 29 Apr 2015 08:44:09 -0500
Subject: [PATCH 2/2] ACPI / scan: Parse _CCA and setup device coherency
In-Reply-To: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1430315049-4663-3-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements support for ACPI _CCA object, which is introduced in
ACPIv5.1, can be used for specifying device DMA coherency attribute.

The parsing logic traverses device namespace to parse coherency
information, and stores it in acpi_device_flags. Then uses it to call
arch_setup_dma_ops() when creating each device enumerated in DSDT
during ACPI scan.

This patch also introduces acpi_dma_is_coherent(), which provides
an interface for device drivers to check the coherency information
similarly to the of_dma_is_coherent().

Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/acpi/acpi_platform.c |  5 ++++-
 drivers/acpi/scan.c          | 45 ++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h      |  9 ++++++++-
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 4bf7559..a4db208 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -108,9 +108,12 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 	if (IS_ERR(pdev))
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
 			PTR_ERR(pdev));
-	else
+	else {
+		arch_setup_dma_ops(&pdev->dev, 0, 0, NULL,
+				   adev->flags.is_coherent);
 		dev_dbg(&adev->dev, "created platform device %s\n",
 			dev_name(&pdev->dev));
+	}
 
 	kfree(resources);
 	return pdev;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 849b699..509d0157 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,6 +11,7 @@
 #include <linux/kthread.h>
 #include <linux/dmi.h>
 #include <linux/nls.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/pgtable.h>
 
@@ -2137,6 +2138,49 @@ void acpi_free_pnp_ids(struct acpi_device_pnp *pnp)
 	kfree(pnp->unique_id);
 }
 
+static void acpi_init_coherency(struct acpi_device *device)
+{
+	unsigned long long cca;
+	acpi_status status;
+	struct acpi_device *parent = device->parent;
+
+	if (parent && parent->flags.cca_seen) {
+		/*
+		 * From ACPIv5.1, OSPM will ignore _CCA if an ancestor
+		 * already saw one.
+		 */
+		device->flags.cca_seen = 1;
+		cca = acpi_dma_is_coherent(parent);
+	} else {
+		status = acpi_evaluate_integer(device->handle, "_CCA",
+					       NULL, &cca);
+		if (ACPI_SUCCESS(status)) {
+			device->flags.cca_seen = 1;
+		} else if (IS_ENABLED(CONFIG_ACPI_MUST_HAVE_CCA)) {
+			/*
+			 * Architecture has specified that if the device
+			 * can do DMA, it must have ACPI _CCA object.
+			 * Here, there could be two cases:
+			 *   1. Not DMA-able device.
+			 *   2. DMA-able device, but missing _CCA object.
+			 *
+			 * In both cases, we will default to dma non-coherent.
+			 */
+			cca = 0;
+		} else {
+			/*
+			 * If architecture does not specify that device must
+			 * specify ACPI _CCA (e.g. x86), we default to use
+			 * dma coherent.
+			 */
+			cca = 1;
+		}
+	}
+
+	device->flags.is_coherent = cca;
+	arch_setup_dma_ops(&device->dev, 0, 0, NULL, cca);
+}
+
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 			     int type, unsigned long long sta)
 {
@@ -2155,6 +2199,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	device->flags.visited = false;
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
+	acpi_init_coherency(device);
 }
 
 void acpi_device_add_finalize(struct acpi_device *device)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 8de4fa9..7e8cd4c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -208,7 +208,9 @@ struct acpi_device_flags {
 	u32 visited:1;
 	u32 hotplug_notify:1;
 	u32 is_dock_station:1;
-	u32 reserved:23;
+	u32 is_coherent:1;
+	u32 cca_seen:1;
+	u32 reserved:21;
 };
 
 /* File System */
@@ -380,6 +382,11 @@ struct acpi_device {
 	void (*remove)(struct acpi_device *);
 };
 
+static inline bool acpi_dma_is_coherent(struct acpi_device *adev)
+{
+	return adev && adev->flags.is_coherent;
+}
+
 static inline bool is_acpi_node(struct fwnode_handle *fwnode)
 {
 	return fwnode && fwnode->type == FWNODE_ACPI;
-- 
2.1.0
