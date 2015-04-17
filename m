From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 17 Apr 2015 15:37:12 +0200
Subject: [RFC 2/3] VFIO: platform: export platform callbacks, probe and remove
In-Reply-To: <1429277833-28663-1-git-send-email-eric.auger@linaro.org>
References: <1429277833-28663-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1429277833-28663-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We intend to derive the platform driver into specialized ones, featuring
reset modality. In order to avoid duplication, let's export the functions
that can be reused in all vfio_platform drivers:
- get_platform_resource
- get_platform_irq
- vfio_platform_probe
- vfio_platform_remove

Practically, only the vfio_platform_probe method should need to be
overridden.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/platform/vfio_platform.c         | 14 +++++++++-----
 drivers/vfio/platform/vfio_platform_private.h |  7 +++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index cef645c..81adb03 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -25,8 +25,8 @@
 
 /* probing devices from the linux platform bus */
 
-static struct resource *get_platform_resource(struct vfio_platform_device *vdev,
-					      int num)
+struct resource *get_platform_resource(struct vfio_platform_device *vdev,
+				      int num)
 {
 	struct platform_device *dev = (struct platform_device *) vdev->opaque;
 	int i;
@@ -43,15 +43,17 @@ static struct resource *get_platform_resource(struct vfio_platform_device *vdev,
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(get_platform_resource);
 
-static int get_platform_irq(struct vfio_platform_device *vdev, int i)
+int get_platform_irq(struct vfio_platform_device *vdev, int i)
 {
 	struct platform_device *pdev = (struct platform_device *) vdev->opaque;
 
 	return platform_get_irq(pdev, i);
 }
+EXPORT_SYMBOL_GPL(get_platform_irq);
 
-static int vfio_platform_probe(struct platform_device *pdev)
+int vfio_platform_probe(struct platform_device *pdev)
 {
 	struct vfio_platform_device *vdev;
 	int ret;
@@ -72,8 +74,9 @@ static int vfio_platform_probe(struct platform_device *pdev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(vfio_platform_probe);
 
-static int vfio_platform_remove(struct platform_device *pdev)
+int vfio_platform_remove(struct platform_device *pdev)
 {
 	struct vfio_platform_device *vdev;
 
@@ -85,6 +88,7 @@ static int vfio_platform_remove(struct platform_device *pdev)
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(vfio_platform_remove);
 
 static struct platform_driver vfio_platform_driver = {
 	.probe		= vfio_platform_probe,
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 0a20028..e2b4f0b 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -95,4 +95,11 @@ extern int vfio_platform_external_set_automasked(void *device_data,
 						 unsigned count,
 						 bool automasked);
 
+struct platform_device;
+struct resource *get_platform_resource(struct vfio_platform_device *vdev,
+					int num);
+int get_platform_irq(struct vfio_platform_device *vdev, int i);
+int vfio_platform_probe(struct platform_device *pdev);
+int vfio_platform_remove(struct platform_device *pdev);
+
 #endif /* VFIO_PLATFORM_PRIVATE_H */
-- 
1.9.1
