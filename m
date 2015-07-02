From: eric.auger@linaro.org (Eric Auger)
Date: Thu,  2 Jul 2015 15:17:15 +0200
Subject: [RFC 05/17] VFIO: platform: implement vfio_device_external_ops
 callbacks
In-Reply-To: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1435843047-6327-6-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the implementation for the 3 external callbacks of
vfio_device_external_ops struct, namely active, is_active,
set_automasked. Also vfio_device_ops and vfio_device_external_ops are
set accordingly.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v6: creation
---
 drivers/vfio/platform/vfio_platform_common.c  |  7 ++++
 drivers/vfio/platform/vfio_platform_irq.c     | 49 +++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_private.h | 11 ++++++
 3 files changed, 67 insertions(+)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index e43efb5..9acfca6 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -520,6 +520,12 @@ static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
 	return -EINVAL;
 }
 
+static struct vfio_device_external_ops vfio_platform_external_ops = {
+	.mask		= vfio_platform_external_mask,
+	.is_active	= vfio_platform_external_is_active,
+	.set_automasked	= vfio_platform_external_set_automasked,
+};
+
 static const struct vfio_device_ops vfio_platform_ops = {
 	.name		= "vfio-platform",
 	.open		= vfio_platform_open,
@@ -528,6 +534,7 @@ static const struct vfio_device_ops vfio_platform_ops = {
 	.read		= vfio_platform_read,
 	.write		= vfio_platform_write,
 	.mmap		= vfio_platform_mmap,
+	.external_ops	= &vfio_platform_external_ops
 };
 
 int vfio_platform_probe_common(struct vfio_platform_device *vdev,
diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 8eb65c1..f6d83ed 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -231,6 +231,55 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
 	return 0;
 }
 
+int vfio_platform_external_mask(void *device_data, unsigned index,
+				 unsigned start, unsigned count)
+{
+	struct vfio_platform_device *vdev = device_data;
+
+	vfio_platform_mask(&vdev->irqs[index]);
+	return 0;
+}
+
+int vfio_platform_external_is_active(void *device_data, unsigned index,
+				      unsigned start, unsigned count)
+{
+	unsigned long flags;
+	struct vfio_platform_device *vdev = device_data;
+	struct vfio_platform_irq *irq = &vdev->irqs[index];
+	bool active, masked, outstanding;
+	int ret;
+
+	spin_lock_irqsave(&irq->lock, flags);
+
+	ret = irq_get_irqchip_state(irq->hwirq, IRQCHIP_STATE_ACTIVE, &active);
+	BUG_ON(ret);
+	masked = irq->masked;
+	outstanding = active || masked;
+
+	spin_unlock_irqrestore(&irq->lock, flags);
+	return outstanding;
+}
+
+int vfio_platform_external_set_automasked(void *device_data, unsigned index,
+					   unsigned start, unsigned count,
+					   bool automasked)
+{
+	unsigned long flags;
+	struct vfio_platform_device *vdev = device_data;
+	struct vfio_platform_irq *irq = &vdev->irqs[index];
+
+	spin_lock_irqsave(&irq->lock, flags);
+	if (automasked) {
+		irq->flags |= VFIO_IRQ_INFO_AUTOMASKED;
+		irq->handler = vfio_automasked_irq_handler;
+	} else {
+		irq->flags &= ~VFIO_IRQ_INFO_AUTOMASKED;
+		irq->handler = vfio_irq_handler;
+	}
+	spin_unlock_irqrestore(&irq->lock, flags);
+	return 0;
+}
+
 static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 					 unsigned index, unsigned start,
 					 unsigned count, uint32_t flags,
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 413f575..5f46c68 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -90,4 +90,15 @@ extern int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
 					unsigned start, unsigned count,
 					void *data);
 
+extern int vfio_platform_external_mask(void *device_data, unsigned index,
+				       unsigned start, unsigned count);
+extern int vfio_platform_external_is_active(void *device_data,
+					    unsigned index, unsigned start,
+					    unsigned count);
+extern int vfio_platform_external_set_automasked(void *device_data,
+						 unsigned index,
+						 unsigned start,
+						 unsigned count,
+						 bool automasked);
+
 #endif /* VFIO_PLATFORM_PRIVATE_H */
-- 
1.9.1
