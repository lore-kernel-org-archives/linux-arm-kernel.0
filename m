From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 13 Jun 2016 00:26:39 -0400
Subject: [PATCH V7 7/9] vfio,
 platform: make reset driver a requirement by default
In-Reply-To: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
References: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1465792001-27960-8-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code was allowing platform devices to be used without a supporting
VFIO reset driver. The hardware can be left in some inconsistent state
after a guest machine abort.

The reset driver will put the hardware back to safe state and disable
interrupts before returning the control back to the host machine.

Adding a new reset_required kernel module option to AMBA and platform
VFIO drivers with a default value of true.

New requirements are:
1. A reset function needs to be implemented by the corresponding driver
via DT/ACPI.
2. The reset function needs to be discovered via DT/ACPI.

The probe of the driver will fail if any of the above conditions are
not satisfied.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/platform/vfio_amba.c             |  5 +++++
 drivers/vfio/platform/vfio_platform.c         |  5 +++++
 drivers/vfio/platform/vfio_platform_common.c  | 22 +++++++++++++++-------
 drivers/vfio/platform/vfio_platform_private.h |  1 +
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
index a66479b..7585902 100644
--- a/drivers/vfio/platform/vfio_amba.c
+++ b/drivers/vfio/platform/vfio_amba.c
@@ -23,6 +23,10 @@
 #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis@virtualopensystems.com>"
 #define DRIVER_DESC     "VFIO for AMBA devices - User Level meta-driver"
 
+static bool reset_required = true;
+module_param(reset_required, bool, 0644);
+MODULE_PARM_DESC(reset_required, "override reset requirement (default: 1)");
+
 /* probing devices from the AMBA bus */
 
 static struct resource *get_amba_resource(struct vfio_platform_device *vdev,
@@ -68,6 +72,7 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
 	vdev->get_resource = get_amba_resource;
 	vdev->get_irq = get_amba_irq;
 	vdev->parent_module = THIS_MODULE;
+	vdev->reset_required = reset_required;
 
 	ret = vfio_platform_probe_common(vdev, &adev->dev);
 	if (ret) {
diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index b1cc3a7..ef89146 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -23,6 +23,10 @@
 #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis@virtualopensystems.com>"
 #define DRIVER_DESC     "VFIO for platform devices - User Level meta-driver"
 
+static bool reset_required = true;
+module_param(reset_required, bool, 0644);
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
index 0ea8c26..d84c399 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -128,10 +128,10 @@ static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
 	return vdev->of_reset ? true : false;
 }
 
-static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
+static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
 {
 	if (vdev->acpihid)
-		return;
+		return vfio_platform_acpi_has_reset(vdev) ? 0 : -ENOENT;
 
 	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
 						    &vdev->reset_module);
@@ -140,6 +140,8 @@ static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
 		vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
 							&vdev->reset_module);
 	}
+
+	return vdev->of_reset ? 0 : -ENOENT;
 }
 
 static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
@@ -670,16 +672,22 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 	}
 
 	ret = vfio_add_group_dev(dev, &vfio_platform_ops, vdev);
-	if (ret) {
-		iommu_group_put(group);
-		return ret;
-	}
+	if (ret)
+		goto out;
 
-	vfio_platform_get_reset(vdev);
+	ret = vfio_platform_get_reset(vdev);
+	if (ret && vdev->reset_required) {
+		pr_err("vfio: no reset function found for device %s\n",
+		       vdev->name);
+		goto out;
+	}
 
 	mutex_init(&vdev->igate);
 
 	return 0;
+out:
+	iommu_group_put(group);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(vfio_platform_probe_common);
 
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
