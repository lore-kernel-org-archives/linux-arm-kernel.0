From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 18 Oct 2015 18:00:14 +0200
Subject: [PATCH 3/4] vfio: platform: add compat in vfio_platform_device
In-Reply-To: <1445184015-24414-1-git-send-email-eric.auger@linaro.org>
References: <1445184015-24414-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1445184015-24414-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's retrieve the compatibility string on probe and store it
in the vfio_platform_device struct

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/platform/vfio_platform_common.c  | 15 ++++++++-------
 drivers/vfio/platform/vfio_platform_private.h |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index d36afc9..31a6a8c 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -38,16 +38,11 @@ static const struct vfio_platform_reset_combo reset_lookup_table[] = {
 static void vfio_platform_get_reset(struct vfio_platform_device *vdev,
 				    struct device *dev)
 {
-	const char *compat;
 	int (*reset)(struct vfio_platform_device *);
-	int ret, i;
-
-	ret = device_property_read_string(dev, "compatible", &compat);
-	if (ret)
-		return;
+	int i;
 
 	for (i = 0 ; i < ARRAY_SIZE(reset_lookup_table); i++) {
-		if (!strcmp(reset_lookup_table[i].compat, compat)) {
+		if (!strcmp(reset_lookup_table[i].compat, vdev->compat)) {
 			request_module(reset_lookup_table[i].module_name);
 			reset = __symbol_get(
 				reset_lookup_table[i].reset_function_name);
@@ -538,6 +533,12 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 	struct iommu_group *group;
 	int ret;
 
+	ret = device_property_read_string(dev, "compatible", &vdev->compat);
+	if (ret) {
+		pr_err("VFIO: cannot retrieve compat for %s\n", vdev->name);
+		return -EINVAL;
+	}
+
 	if (!vdev)
 		return -EINVAL;
 
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 17323f0..b274646 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -56,6 +56,7 @@ struct vfio_platform_device {
 	u32				num_irqs;
 	int				refcnt;
 	struct mutex			igate;
+	const char			*compat;
 
 	/*
 	 * These fields should be filled by the bus specific binder
-- 
1.9.1
