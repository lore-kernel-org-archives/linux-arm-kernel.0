From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 13 Apr 2015 14:29:24 +0200
Subject: [RFC v6 09/16] VFIO: add vfio_external_{mask|is_active|set_automasked}
In-Reply-To: <1428928171-18884-1-git-send-email-eric.auger@linaro.org>
References: <1428928171-18884-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1428928171-18884-10-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduces 3 new external functions aimed at doing actions
on VFIO devices:
- mask VFIO IRQ
- get the active status of VFIO IRQ (active at interrupt
  controller level or masked by the level-sensitive automasking).
- change the automasked property and switch the IRQ handler
  (between automasked/ non automasked)

Their implementation is based on bus specific callbacks.

Note there is no way to discriminate between user-space
masking and automasked handler masking. As a consequence, is_active
will return true in case the IRQ was masked by the user-space.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v5 -> v6:
- implementation now uses external ops
- prototype changed (index, start, count) and returns int

V4: creation
---
 drivers/vfio/vfio.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/vfio.h | 16 ++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 33ae8c5..a36188e 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1526,6 +1526,45 @@ long vfio_external_check_extension(struct vfio_group *group, unsigned long arg)
 }
 EXPORT_SYMBOL_GPL(vfio_external_check_extension);
 
+int vfio_external_mask(struct vfio_device *vdev, unsigned index,
+			unsigned start, unsigned count)
+{
+	if (vdev->ops->external_ops &&
+		vdev->ops->external_ops->mask)
+		return vdev->ops->external_ops->mask(vdev->device_data,
+						     index, start, count);
+	else
+		return -ENXIO;
+}
+EXPORT_SYMBOL_GPL(vfio_external_mask);
+
+int vfio_external_is_active(struct vfio_device *vdev, unsigned index,
+			     unsigned start, unsigned count)
+{
+	if (vdev->ops->external_ops &&
+		vdev->ops->external_ops->is_active)
+		return vdev->ops->external_ops->is_active(vdev->device_data,
+							  index, start, count);
+	else
+		return -ENXIO;
+}
+EXPORT_SYMBOL_GPL(vfio_external_is_active);
+
+int vfio_external_set_automasked(struct vfio_device *vdev,
+				  unsigned index, unsigned start,
+				  unsigned count, bool automasked)
+{
+	if (vdev->ops->external_ops &&
+		vdev->ops->external_ops->set_automasked)
+		return vdev->ops->external_ops->set_automasked(
+							vdev->device_data,
+							index, start,
+							count, automasked);
+	else
+		return -ENXIO;
+}
+EXPORT_SYMBOL_GPL(vfio_external_set_automasked);
+
 /**
  * Module/class support
  */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index b0ec474..a740392 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -123,6 +123,22 @@ extern struct vfio_device *vfio_device_get_external_user(struct file *filep);
 extern void vfio_device_put_external_user(struct vfio_device *vdev);
 extern struct device *vfio_external_base_device(struct vfio_device *vdev);
 
+extern int vfio_external_mask(struct vfio_device *vdev, unsigned index,
+			       unsigned start, unsigned count);
+/*
+ * returns whether the VFIO IRQ is active:
+ * true if not yet deactivated at interrupt controller level or if
+ * automasked (level sensitive IRQ). Unfortunately there is no way to
+ * discriminate between handler auto-masking and user-space masking
+ */
+extern int vfio_external_is_active(struct vfio_device *vdev,
+				    unsigned index, unsigned start,
+				    unsigned count);
+
+extern int vfio_external_set_automasked(struct vfio_device *vdev,
+					 unsigned index, unsigned start,
+					 unsigned count, bool automasked);
+
 struct pci_dev;
 #ifdef CONFIG_EEH
 extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
-- 
1.9.1
