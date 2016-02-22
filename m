From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Feb 2016 22:08:37 +0100
Subject: [PATCH 3/8] drm: msm: split out fence and iotrace modules
In-Reply-To: <1456175331-714117-1-git-send-email-arnd@arndb.de>
References: <1456175331-714117-1-git-send-email-arnd@arndb.de>
Message-ID: <1456175331-714117-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a preparation for having edp, dsi and hdmi in separate
modules. Those three drivers depend on the iotrace code and,
and edp depends on gem, which in turn depends on the fence.

With this change, those two pieces of the main driver can be
loaded first, to resolve circular dependencies.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/Kconfig       |   2 +-
 drivers/gpu/drm/msm/Makefile      |   4 +-
 drivers/gpu/drm/msm/msm_drv.c     | 165 --------------------------------------
 drivers/gpu/drm/msm/msm_drv.h     |  12 +++
 drivers/gpu/drm/msm/msm_fence.c   | 115 ++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_iotrace.c |  65 +++++++++++++++
 6 files changed, 196 insertions(+), 167 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/msm_fence.c
 create mode 100644 drivers/gpu/drm/msm/msm_iotrace.c

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index b8beb9bccd91..d987c584d817 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -21,7 +21,7 @@ config DRM_MSM_REGISTER_LOGGING
 	help
 	  Compile in support for logging register reads/writes in a format
 	  that can be parsed by envytools demsm tool.  If enabled, register
-	  logging can be switched on via msm.reglog=y module param.
+	  logging can be switched on via msm_iotrace.reglog=y module param.
 
 source "drivers/gpu/drm/msm/dsi/Kconfig"
 source "drivers/gpu/drm/msm/hdmi/Kconfig"
diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 24f6fd2b9651..acc02aef1b42 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -44,4 +44,6 @@ obj-$(CONFIG_DRM_MSM_DSI) += dsi/
 obj-$(CONFIG_DRM_MSM_HDMI) += hdmi/
 obj-$(CONFIG_DRM_MSM_EDP) += edp/
 
-obj-$(CONFIG_DRM_MSM)	+= drm-msm.o
+obj-$(CONFIG_DRM_MSM)	+= drm-msm.o drm_msm_helper.o
+
+drm_msm_helper-y	+= msm_iotrace.o msm_fence.o
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index d52910e2c26c..5430ea7d2375 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -46,14 +46,6 @@ int msm_register_mmu(struct drm_device *dev, struct msm_mmu *mmu)
 	return idx;
 }
 
-#ifdef CONFIG_DRM_MSM_REGISTER_LOGGING
-static bool reglog = false;
-MODULE_PARM_DESC(reglog, "Enable register read/write logging");
-module_param(reglog, bool, 0600);
-#else
-#define reglog 0
-#endif
-
 #ifdef CONFIG_DRM_FBDEV_EMULATION
 static bool fbdev = true;
 MODULE_PARM_DESC(fbdev, "Enable fbdev compat layer");
@@ -64,56 +56,6 @@ static char *vram = "16m";
 MODULE_PARM_DESC(vram, "Configure VRAM size (for devices without IOMMU/GPUMMU)");
 module_param(vram, charp, 0);
 
-/*
- * Util/helpers:
- */
-
-void __iomem *msm_ioremap(struct platform_device *pdev, const char *name,
-		const char *dbgname)
-{
-	struct resource *res;
-	unsigned long size;
-	void __iomem *ptr;
-
-	if (name)
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
-	else
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get memory resource: %s\n", name);
-		return ERR_PTR(-EINVAL);
-	}
-
-	size = resource_size(res);
-
-	ptr = devm_ioremap_nocache(&pdev->dev, res->start, size);
-	if (!ptr) {
-		dev_err(&pdev->dev, "failed to ioremap: %s\n", name);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	if (reglog)
-		printk(KERN_DEBUG "IO:region %s %p %08lx\n", dbgname, ptr, size);
-
-	return ptr;
-}
-
-void msm_writel(u32 data, void __iomem *addr)
-{
-	if (reglog)
-		printk(KERN_DEBUG "IO:W %p %08x\n", addr, data);
-	writel(data, addr);
-}
-
-u32 msm_readl(const void __iomem *addr)
-{
-	u32 val = readl(addr);
-	if (reglog)
-		printk(KERN_ERR "IO:R %p %08x\n", addr, val);
-	return val;
-}
-
 struct vblank_event {
 	struct list_head node;
 	int crtc_id;
@@ -691,113 +633,6 @@ static void msm_debugfs_cleanup(struct drm_minor *minor)
 #endif
 
 /*
- * Fences:
- */
-
-int msm_wait_fence(struct drm_device *dev, uint32_t fence,
-		ktime_t *timeout , bool interruptible)
-{
-	struct msm_drm_private *priv = dev->dev_private;
-	int ret;
-
-	if (!priv->gpu)
-		return 0;
-
-	if (fence > priv->gpu->submitted_fence) {
-		DRM_ERROR("waiting on invalid fence: %u (of %u)\n",
-				fence, priv->gpu->submitted_fence);
-		return -EINVAL;
-	}
-
-	if (!timeout) {
-		/* no-wait: */
-		ret = fence_completed(dev, fence) ? 0 : -EBUSY;
-	} else {
-		ktime_t now = ktime_get();
-		unsigned long remaining_jiffies;
-
-		if (ktime_compare(*timeout, now) < 0) {
-			remaining_jiffies = 0;
-		} else {
-			ktime_t rem = ktime_sub(*timeout, now);
-			struct timespec ts = ktime_to_timespec(rem);
-			remaining_jiffies = timespec_to_jiffies(&ts);
-		}
-
-		if (interruptible)
-			ret = wait_event_interruptible_timeout(priv->fence_event,
-				fence_completed(dev, fence),
-				remaining_jiffies);
-		else
-			ret = wait_event_timeout(priv->fence_event,
-				fence_completed(dev, fence),
-				remaining_jiffies);
-
-		if (ret == 0) {
-			DBG("timeout waiting for fence: %u (completed: %u)",
-					fence, priv->completed_fence);
-			ret = -ETIMEDOUT;
-		} else if (ret != -ERESTARTSYS) {
-			ret = 0;
-		}
-	}
-
-	return ret;
-}
-
-int msm_queue_fence_cb(struct drm_device *dev,
-		struct msm_fence_cb *cb, uint32_t fence)
-{
-	struct msm_drm_private *priv = dev->dev_private;
-	int ret = 0;
-
-	mutex_lock(&dev->struct_mutex);
-	if (!list_empty(&cb->work.entry)) {
-		ret = -EINVAL;
-	} else if (fence > priv->completed_fence) {
-		cb->fence = fence;
-		list_add_tail(&cb->work.entry, &priv->fence_cbs);
-	} else {
-		queue_work(priv->wq, &cb->work);
-	}
-	mutex_unlock(&dev->struct_mutex);
-
-	return ret;
-}
-
-/* called from workqueue */
-void msm_update_fence(struct drm_device *dev, uint32_t fence)
-{
-	struct msm_drm_private *priv = dev->dev_private;
-
-	mutex_lock(&dev->struct_mutex);
-	priv->completed_fence = max(fence, priv->completed_fence);
-
-	while (!list_empty(&priv->fence_cbs)) {
-		struct msm_fence_cb *cb;
-
-		cb = list_first_entry(&priv->fence_cbs,
-				struct msm_fence_cb, work.entry);
-
-		if (cb->fence > priv->completed_fence)
-			break;
-
-		list_del_init(&cb->work.entry);
-		queue_work(priv->wq, &cb->work);
-	}
-
-	mutex_unlock(&dev->struct_mutex);
-
-	wake_up_all(&priv->fence_event);
-}
-
-void __msm_fence_worker(struct work_struct *work)
-{
-	struct msm_fence_cb *cb = container_of(work, struct msm_fence_cb, work);
-	cb->func(cb);
-}
-
-/*
  * DRM ioctls:
  */
 
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index a2755b4a0d86..b8bd88b66c9c 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/list.h>
+#include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/types.h>
 #include <linux/of_graph.h>
@@ -330,8 +331,19 @@ static inline void msm_rd_dump_submit(struct msm_gem_submit *submit) {}
 
 void __iomem *msm_ioremap(struct platform_device *pdev, const char *name,
 		const char *dbgname);
+#ifdef CONFIG_DRM_MSM_REGISTER_LOGGING
 void msm_writel(u32 data, void __iomem *addr);
 u32 msm_readl(const void __iomem *addr);
+#else
+static inline void msm_writel(u32 data, void __iomem *addr)
+{
+	writel(data, addr);
+}
+static inline u32 msm_readl(const void __iomem *addr)
+{
+	return readl(addr);
+}
+#endif
 
 #define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
 #define VERB(fmt, ...) if (0) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
new file mode 100644
index 000000000000..df66e04e01d8
--- /dev/null
+++ b/drivers/gpu/drm/msm/msm_fence.c
@@ -0,0 +1,115 @@
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include <drm/drmP.h>
+
+#include "msm_drv.h"
+#include "msm_gpu.h"
+
+int msm_wait_fence(struct drm_device *dev, uint32_t fence,
+		ktime_t *timeout , bool interruptible)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+	int ret;
+
+	if (!priv->gpu)
+		return 0;
+
+	if (fence > priv->gpu->submitted_fence) {
+		DRM_ERROR("waiting on invalid fence: %u (of %u)\n",
+				fence, priv->gpu->submitted_fence);
+		return -EINVAL;
+	}
+
+	if (!timeout) {
+		/* no-wait: */
+		ret = fence_completed(dev, fence) ? 0 : -EBUSY;
+	} else {
+		ktime_t now = ktime_get();
+		unsigned long remaining_jiffies;
+
+		if (ktime_compare(*timeout, now) < 0) {
+			remaining_jiffies = 0;
+		} else {
+			ktime_t rem = ktime_sub(*timeout, now);
+			struct timespec ts = ktime_to_timespec(rem);
+			remaining_jiffies = timespec_to_jiffies(&ts);
+		}
+
+		if (interruptible)
+			ret = wait_event_interruptible_timeout(priv->fence_event,
+				fence_completed(dev, fence),
+				remaining_jiffies);
+		else
+			ret = wait_event_timeout(priv->fence_event,
+				fence_completed(dev, fence),
+				remaining_jiffies);
+
+		if (ret == 0) {
+			DBG("timeout waiting for fence: %u (completed: %u)",
+					fence, priv->completed_fence);
+			ret = -ETIMEDOUT;
+		} else if (ret != -ERESTARTSYS) {
+			ret = 0;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(msm_wait_fence);
+
+int msm_queue_fence_cb(struct drm_device *dev,
+		struct msm_fence_cb *cb, uint32_t fence)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+	int ret = 0;
+
+	mutex_lock(&dev->struct_mutex);
+	if (!list_empty(&cb->work.entry)) {
+		ret = -EINVAL;
+	} else if (fence > priv->completed_fence) {
+		cb->fence = fence;
+		list_add_tail(&cb->work.entry, &priv->fence_cbs);
+	} else {
+		queue_work(priv->wq, &cb->work);
+	}
+	mutex_unlock(&dev->struct_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(msm_queue_fence_cb);
+
+/* called from workqueue */
+void msm_update_fence(struct drm_device *dev, uint32_t fence)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+
+	mutex_lock(&dev->struct_mutex);
+	priv->completed_fence = max(fence, priv->completed_fence);
+
+	while (!list_empty(&priv->fence_cbs)) {
+		struct msm_fence_cb *cb;
+
+		cb = list_first_entry(&priv->fence_cbs,
+				struct msm_fence_cb, work.entry);
+
+		if (cb->fence > priv->completed_fence)
+			break;
+
+		list_del_init(&cb->work.entry);
+		queue_work(priv->wq, &cb->work);
+	}
+
+	mutex_unlock(&dev->struct_mutex);
+
+	wake_up_all(&priv->fence_event);
+}
+EXPORT_SYMBOL_GPL(msm_update_fence);
+
+void __msm_fence_worker(struct work_struct *work)
+{
+	struct msm_fence_cb *cb = container_of(work, struct msm_fence_cb, work);
+	cb->func(cb);
+}
+EXPORT_SYMBOL_GPL(__msm_fence_worker);
diff --git a/drivers/gpu/drm/msm/msm_iotrace.c b/drivers/gpu/drm/msm/msm_iotrace.c
new file mode 100644
index 000000000000..7761470eee26
--- /dev/null
+++ b/drivers/gpu/drm/msm/msm_iotrace.c
@@ -0,0 +1,65 @@
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/module.h>
+
+static bool reglog = false;
+
+#ifdef CONFIG_DRM_MSM_REGISTER_LOGGING
+MODULE_PARM_DESC(reglog, "Enable register read/write logging");
+module_param(reglog, bool, 0600);
+
+void msm_writel(u32 data, void __iomem *addr)
+{
+	if (reglog)
+		printk(KERN_DEBUG "IO:W %p %08x\n", addr, data);
+	writel(data, addr);
+}
+EXPORT_SYMBOL_GPL(msm_writel);
+
+u32 msm_readl(const void __iomem *addr)
+{
+	u32 val = readl(addr);
+	if (reglog)
+		printk(KERN_ERR "IO:R %p %08x\n", addr, val);
+	return val;
+}
+EXPORT_SYMBOL_GPL(msm_readl);
+#endif
+
+void __iomem *msm_ioremap(struct platform_device *pdev, const char *name,
+		const char *dbgname)
+{
+	struct resource *res;
+	unsigned long size;
+	void __iomem *ptr;
+
+	if (name)
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	else
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get memory resource: %s\n", name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	size = resource_size(res);
+
+	ptr = devm_ioremap_nocache(&pdev->dev, res->start, size);
+	if (!ptr) {
+		dev_err(&pdev->dev, "failed to ioremap: %s\n", name);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (reglog)
+		printk(KERN_DEBUG "IO:region %s %p %08lx\n", dbgname, ptr, size);
+
+	return ptr;
+}
+EXPORT_SYMBOL_GPL(msm_ioremap);
+
+MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
+MODULE_DESCRIPTION("MSM DRM Driver support code");
+MODULE_LICENSE("GPL");
-- 
2.7.0
