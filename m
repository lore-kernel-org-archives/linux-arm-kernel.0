From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 23 Nov 2014 19:35:57 +0100
Subject: [PATCH v3 5/8] VFIO: External user API device helpers
In-Reply-To: <1416767760-14487-1-git-send-email-eric.auger@linaro.org>
References: <1416767760-14487-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1416767760-14487-6-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VFIO external user API is enriched with 3 new functions that
allows a kernel user external to VFIO to retrieve some information
from a VFIO device.

- vfio_device_get_external_user enables to get a vfio device from
  its fd and increments its reference counter
- vfio_device_put_external_user decrements the reference counter
- vfio_external_base_device returns a handle to the struct device

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v2 -> v3:
- reword the commit message

v1 -> v2:

- vfio_external_get_base_device renamed into vfio_external_base_device
- vfio_external_get_type removed
---
 drivers/vfio/vfio.c  | 24 ++++++++++++++++++++++++
 include/linux/vfio.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 8e84471..282814e 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1401,6 +1401,30 @@ void vfio_group_put_external_user(struct vfio_group *group)
 }
 EXPORT_SYMBOL_GPL(vfio_group_put_external_user);
 
+struct vfio_device *vfio_device_get_external_user(struct file *filep)
+{
+	struct vfio_device *vdev = filep->private_data;
+
+	if (filep->f_op != &vfio_device_fops)
+		return ERR_PTR(-EINVAL);
+
+	vfio_device_get(vdev);
+	return vdev;
+}
+EXPORT_SYMBOL_GPL(vfio_device_get_external_user);
+
+void vfio_device_put_external_user(struct vfio_device *vdev)
+{
+	vfio_device_put(vdev);
+}
+EXPORT_SYMBOL_GPL(vfio_device_put_external_user);
+
+struct device *vfio_external_base_device(struct vfio_device *vdev)
+{
+	return vdev->dev;
+}
+EXPORT_SYMBOL_GPL(vfio_external_base_device);
+
 int vfio_external_user_iommu_id(struct vfio_group *group)
 {
 	return iommu_group_id(group->iommu_group);
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 2fb2e30..08e33ec 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -99,6 +99,9 @@ extern void vfio_group_put_external_user(struct vfio_group *group);
 extern int vfio_external_user_iommu_id(struct vfio_group *group);
 extern long vfio_external_check_extension(struct vfio_group *group,
 					  unsigned long arg);
+extern struct vfio_device *vfio_device_get_external_user(struct file *filep);
+extern void vfio_device_put_external_user(struct vfio_device *vdev);
+extern struct device *vfio_external_base_device(struct vfio_device *vdev);
 
 struct pci_dev;
 #ifdef CONFIG_EEH
-- 
1.9.1
