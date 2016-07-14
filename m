From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 13 Jul 2016 22:06:33 -0400
Subject: [PATCH V9 7/9] vfio,
 platform: make reset driver a requirement by default
In-Reply-To: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
References: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1468461995-32676-8-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code was allowing platform devices to be used without a supporting
VFIO reset driver. The hardware can be left in some inconsistent state
after a guest machine abort.

The reset driver will put the hardware back to safe state and disable
interrupts before returning the control back to the host machine.

Adding a new reset_required kernel module option to platform VFIO drivers.
The default value is true for the DT and ACPI based drivers.
The reset requirement value for AMBA drivers is set to false and is
unchangeable to maintain the existing functionality.

New requirements are:
1. A reset function needs to be implemented by the corresponding driver
via DT/ACPI.
2. The reset function needs to be discovered via DT/ACPI.

The probe of the driver will fail if any of the above conditions are
not satisfied.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/vfio/platform/vfio_amba.c             |  1 +
 drivers/vfio/platform/vfio_platform.c         |  5 +++++
 drivers/vfio/platform/vfio_platform_common.c  | 15 +++++++++++----
 drivers/vfio/platform/vfio_platform_private.h |  1 +
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
index a66479b..31372fb 100644
--- a/drivers/vfio/platform/vfio_amba.c
+++ b/drivers/vfio/platform/vfio_amba.c
@@ -68,6 +68,7 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
 	vdev->get_resource = get_amba_resource;
 	vdev->get_irq = get_amba_irq;
 	vdev->parent_module = THIS_MODULE;
+	vdev->reset_required = false;
 
 	ret = vfio_platform_probe_common(vdev, &adev->dev);
 	if (ret) {
diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index b1cc3a7..6561751 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -23,6 +23,10 @@
 #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis@virtualopensystems.com>"
 #define DRIVER_DESC     "VFIO for platform devices - User Level meta-driver"
 
+static bool reset_required = true;
+module_param(reset_required, bool, 0444);
+MODULE_PARM_DESC(reset_required, "override reset requirement (default: 1)");
+
 /* probing devices from the linux platform bus */
 
 static struct resource *get_platform_resource(struct vfio_platform_device *vdev,
@@ -66,6 +70,7 @@ static int vfio_platform_probe(struct platform_device *pdev)
 	vdev->get_resource = get_platform_resource;
 	vdev->get_irq = get_platform_irq;
 	vdev->parent_module = THIS_MODULE;
+	vdev->reset_required = reset_required;
 
 	ret = vfio_platform_probe_common(vdev, &pdev->dev);
 	if (ret)
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 2d9c905..71248a9 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -123,10 +123,10 @@ static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
 	return vdev->of_reset ? true : false;
 }
 
-static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
+static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
 {
 	if (VFIO_PLATFORM_IS_ACPI(vdev))
-		return;
+		return vfio_platform_acpi_has_reset(vdev) ? 0 : -ENOENT;
 
 	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
 						    &vdev->reset_module);
@@ -135,6 +135,8 @@ static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
 		vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
 							&vdev->reset_module);
 	}
+
+	return vdev->of_reset ? 0 : -ENOENT;
 }
 
 static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
@@ -675,6 +677,13 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 
 	vdev->device = dev;
 
+	ret = vfio_platform_get_reset(vdev);
+	if (ret && vdev->reset_required) {
+		pr_err("vfio: no reset function found for device %s\n",
+		       vdev->name);
+		return ret;
+	}
+
 	group = iommu_group_get(dev);
 	if (!group) {
 		pr_err("VFIO: No IOMMU group for device %s\n", vdev->name);
@@ -687,8 +696,6 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 		return ret;
 	}
 
-	vfio_platform_get_reset(vdev);
-
 	mutex_init(&vdev->igate);
 
 	return 0;
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index ba9e4f8..68fbc00 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -50,6 +50,7 @@ struct vfio_platform_region {
 };
 
 struct vfio_platform_device {
+	bool				reset_required;
 	struct vfio_platform_region	*regions;
 	u32				num_regions;
 	struct vfio_platform_irq	*irqs;
-- 
1.8.2.1
