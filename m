From: a.motakis@virtualopensystems.com (Antonios Motakis)
Date: Mon,  5 Aug 2013 15:17:12 +0200
Subject: [PATCH 3/3] Return info for device and its memory regions and
 interrupts
In-Reply-To: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
References: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <1375708632-26356-4-git-send-email-a.motakis@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A VFIO userspace driver will start by opening the VFIO device
that corresponds to an IOMMU group, and will use the ioctl interface
to get the basic device info, such as number of memory regions and
interrupts, and their properties.

This patch implements the IOCTLs:
 - VFIO_DEVICE_GET_INFO
 - VFIO_DEVICE_GET_REGION_INFO
 - VFIO_DEVICE_GET_IRQ_INFO

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/vfio/vfio_dt.c | 60 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_dt.c b/drivers/vfio/vfio_dt.c
index ad4d31d..817c552 100644
--- a/drivers/vfio/vfio_dt.c
+++ b/drivers/vfio/vfio_dt.c
@@ -28,6 +28,10 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
 
 #define DRIVER_VERSION  "0.1"
 #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis@virtualopensystems.com>"
@@ -54,10 +58,13 @@ static long vfio_dt_ioctl(void *device_data,
 			   unsigned int cmd, unsigned long arg)
 {
 	struct vfio_dt_device *vdev = device_data;
+	struct device_node *of_node = vdev->pdev->dev.of_node;
 	unsigned long minsz;
 
 	if (cmd == VFIO_DEVICE_GET_INFO) {
 		struct vfio_device_info info;
+		struct resource res;
+		int cnt = 0;
 
 		minsz = offsetofend(struct vfio_device_info, num_irqs);
 
@@ -68,18 +75,57 @@ static long vfio_dt_ioctl(void *device_data,
 			return -EINVAL;
 
 		info.flags = VFIO_DEVICE_FLAGS_DT;
-		info.num_regions = 0;
-		info.num_irqs = 0;
+
+		while (!of_address_to_resource(of_node, cnt, &res))
+			cnt++;
+
+		info.num_regions = cnt;
+
+		info.num_irqs = of_irq_count(of_node);
 
 		return copy_to_user((void __user *)arg, &info, minsz);
 
-	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
-		return -EINVAL;
+	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
+		struct vfio_region_info info;
+		struct resource res;
 
-	else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
-		return -EINVAL;
+		minsz = offsetofend(struct vfio_region_info, offset);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		if(of_address_to_resource(of_node, info.index, &res))
+			return -EINVAL;
+
+		info.offset = res.start;	/* map phys addr with offset */
+		info.size = resource_size(&res);
+		info.flags = 0;
+
+		return copy_to_user((void __user *)arg, &info, minsz);	
+
+	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
+		struct vfio_irq_info info;
+		struct resource res;
+
+		minsz = offsetofend(struct vfio_irq_info, count);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		of_irq_to_resource(of_node, info.index, &res);
+
+		info.flags = 0;
+		info.count = 1;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
 
-	else if (cmd == VFIO_DEVICE_SET_IRQS)
+	} else if (cmd == VFIO_DEVICE_SET_IRQS)
 		return -EINVAL;
 
 	else if (cmd == VFIO_DEVICE_RESET)
-- 
1.8.1.2
