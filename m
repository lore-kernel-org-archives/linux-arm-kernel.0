From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 13 Apr 2015 14:29:21 +0200
Subject: [RFC v6 06/16] VFIO: Introduce vfio_device_external_ops
In-Reply-To: <1428928171-18884-1-git-send-email-eric.auger@linaro.org>
References: <1428928171-18884-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1428928171-18884-7-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New bus callbacks are introduced. They correspond to external
functions. To avoid messing up the main vfio_device_ops
struct, a new vfio_device_external_ops struct is introduced.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v6: creation
---
 include/linux/vfio.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index b18c38f..b0ec474 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -19,6 +19,23 @@
 #include <uapi/linux/vfio.h>
 
 /**
+ * struct vfio_device_external_ops - VFIO bus driver device callbacks
+ * used as external API
+ * @mask: mask any IRQ defined by triplet
+ * @is_active: returns whether any IRQ defined by triplet is active
+ * @set_automasked: sets the automasked flag of triplet's IRQ
+ */
+struct vfio_device_external_ops  {
+	int (*mask)(void *device_data, unsigned index, unsigned start,
+		    unsigned count);
+	int (*is_active)(void *device_data, unsigned index, unsigned start,
+			 unsigned count);
+	int (*set_automasked)(void *device_data, unsigned index,
+			      unsigned start, unsigned count,
+			       bool automasked);
+};
+
+/**
  * struct vfio_device_ops - VFIO bus driver device callbacks
  *
  * @open: Called when userspace creates new file descriptor for device
@@ -42,6 +59,7 @@ struct vfio_device_ops {
 			 unsigned long arg);
 	int	(*mmap)(void *device_data, struct vm_area_struct *vma);
 	void	(*request)(void *device_data, unsigned int count);
+	struct vfio_device_external_ops *external_ops;
 };
 
 extern int vfio_add_group_dev(struct device *dev,
-- 
1.9.1
