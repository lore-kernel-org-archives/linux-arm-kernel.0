From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 28 Mar 2016 09:35:23 -0400
Subject: [PATCH V3 2/3] vfio,
 platform: make reset driver a requirement by default
In-Reply-To: <1459172124-6730-1-git-send-email-okaya@codeaurora.org>
References: <1459172124-6730-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1459172124-6730-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code was allowing platform devices to be used without a supporting VFIO
reset driver. The hardware can be left in some inconsistent state after a
guest machine abort.

The reset driver will put the hardware back to safe state and disable
interrupts before returning the control back to the host machine.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/vfio/platform/vfio_amba.c             | 5 +++++
 drivers/vfio/platform/vfio_platform.c         | 5 +++++
 drivers/vfio/platform/vfio_platform_common.c  | 8 +++++++-
 drivers/vfio/platform/vfio_platform_private.h | 1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

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
index c28883a..67a3163 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -637,7 +637,13 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 		return ret;
 	}
 
-	vfio_platform_get_reset(vdev);
+	ret = vfio_platform_get_reset(vdev);
+	if (ret && vdev->reset_required) {
+		pr_err("vfio: no reset function found for device %s\n",
+		       vdev->name);
+		iommu_group_put(group);
+		return ret;
+	}
 	mutex_init(&vdev->igate);
 
 	return 0;
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 1b95adf..b5a699a 100644
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
