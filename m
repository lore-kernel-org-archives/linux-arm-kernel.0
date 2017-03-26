From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 26 Mar 2017 22:41:53 +0800
Subject: [PATCH 4/5] vfio: platform: Convert to use devm_*()
In-Reply-To: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1490539314-9681-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert driver to use devm_*() APIs so rely on driver model core layer
to manage resources. This eliminates error path boilerplate and makes
code neat.

This patch also renames amba_id structure, the old code used some code
which directly copied from other driver.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/vfio/platform/vfio_amba.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
index 31372fb..433db1f 100644
--- a/drivers/vfio/platform/vfio_amba.c
+++ b/drivers/vfio/platform/vfio_amba.c
@@ -53,15 +53,14 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
 	struct vfio_platform_device *vdev;
 	int ret;
 
-	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+	vdev = devm_kzalloc(&adev->dev, sizeof(*vdev), GFP_KERNEL);
 	if (!vdev)
 		return -ENOMEM;
 
-	vdev->name = kasprintf(GFP_KERNEL, "vfio-amba-%08x", adev->periphid);
-	if (!vdev->name) {
-		kfree(vdev);
+	vdev->name = devm_kasprintf(&adev->dev, GFP_KERNEL,
+				    "vfio-amba-%08x", adev->periphid);
+	if (!vdev->name)
 		return -ENOMEM;
-	}
 
 	vdev->opaque = (void *) adev;
 	vdev->flags = VFIO_DEVICE_FLAGS_AMBA;
@@ -71,11 +70,6 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
 	vdev->reset_required = false;
 
 	ret = vfio_platform_probe_common(vdev, &adev->dev);
-	if (ret) {
-		kfree(vdev->name);
-		kfree(vdev);
-	}
-
 	return ret;
 }
 
@@ -84,25 +78,22 @@ static int vfio_amba_remove(struct amba_device *adev)
 	struct vfio_platform_device *vdev;
 
 	vdev = vfio_platform_remove_common(&adev->dev);
-	if (vdev) {
-		kfree(vdev->name);
-		kfree(vdev);
+	if (vdev)
 		return 0;
-	}
 
 	return -EINVAL;
 }
 
-static struct amba_id pl330_ids[] = {
+static struct amba_id vfio_ids[] = {
 	{ 0, 0 },
 };
 
-MODULE_DEVICE_TABLE(amba, pl330_ids);
+MODULE_DEVICE_TABLE(amba, vfio_ids);
 
 static struct amba_driver vfio_amba_driver = {
 	.probe = vfio_amba_probe,
 	.remove = vfio_amba_remove,
-	.id_table = pl330_ids,
+	.id_table = vfio_ids,
 	.drv = {
 		.name = "vfio-amba",
 		.owner = THIS_MODULE,
-- 
2.7.4
