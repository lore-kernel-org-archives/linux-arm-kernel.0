From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 26 Jan 2016 13:12:45 +0000
Subject: [PATCH 07/10] vfio: pci: cache the vfio_group in vfio_pci_device
In-Reply-To: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
References: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1453813968-2024-8-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new set_group operation which allows to cache the vfio_group
handle within the vfio_pci_device struct. This is useful to do
iommu operations from the vfio_pci device.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/pci/vfio_pci.c         | 8 ++++++++
 drivers/vfio/pci/vfio_pci_private.h | 1 +
 drivers/vfio/vfio.c                 | 3 +++
 include/linux/vfio.h                | 3 +++
 4 files changed, 15 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 2760a7b..2a32856 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -920,6 +920,13 @@ static void vfio_pci_request(void *device_data, unsigned int count)
 	mutex_unlock(&vdev->igate);
 }
 
+static void vfio_pci_set_group(void *device_data, struct vfio_group *group)
+{
+	struct vfio_pci_device *vdev = device_data;
+
+	vdev->vfio_group = group;
+}
+
 static const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
 	.open		= vfio_pci_open,
@@ -929,6 +936,7 @@ static const struct vfio_device_ops vfio_pci_ops = {
 	.write		= vfio_pci_write,
 	.mmap		= vfio_pci_mmap,
 	.request	= vfio_pci_request,
+	.set_group	= vfio_pci_set_group,
 };
 
 static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 0e7394f..2893b10 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -35,6 +35,7 @@ struct vfio_pci_irq_ctx {
 
 struct vfio_pci_device {
 	struct pci_dev		*pdev;
+	struct vfio_group	*vfio_group;
 	void __iomem		*barmap[PCI_STD_RESOURCE_END + 1];
 	u8			*pci_config_map;
 	u8			*vconfig;
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 3d9de00..2760d4c 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -548,6 +548,9 @@ struct vfio_device *vfio_group_create_device(struct vfio_group *group,
 	/* No need to get group_lock, caller has group reference */
 	vfio_group_get(group);
 
+	if (device->ops->set_group)
+		device->ops->set_group(device_data, group);
+
 	mutex_lock(&group->device_lock);
 	list_add(&device->group_next, &group->device_list);
 	mutex_unlock(&group->device_lock);
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 0020f81..f7eaf30 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -18,6 +18,8 @@
 #include <linux/poll.h>
 #include <uapi/linux/vfio.h>
 
+struct vfio_group;
+
 /**
  * struct vfio_device_ops - VFIO bus driver device callbacks
  *
@@ -42,6 +44,7 @@ struct vfio_device_ops {
 			 unsigned long arg);
 	int	(*mmap)(void *device_data, struct vm_area_struct *vma);
 	void	(*request)(void *device_data, unsigned int count);
+	void	(*set_group)(void *device_data, struct vfio_group *group);
 };
 
 extern struct iommu_group *vfio_iommu_group_get(struct device *dev);
-- 
1.9.1
