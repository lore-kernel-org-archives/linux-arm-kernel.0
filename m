From: a.motakis@virtualopensystems.com (Antonios Motakis)
Date: Mon,  5 Aug 2013 15:17:10 +0200
Subject: [PATCH 1/3] VFIO_IOMMU_TYPE1 workaround to build for platform devices
In-Reply-To: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
References: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <1375708632-26356-2-git-send-email-a.motakis@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a workaround to make the VFIO_IOMMU_TYPE1 driver usable with
platform devices instead of PCI. A future permanent fix should support
both. This is required in order to use the Exynos SMMU, or the ARM SMMU
driver with VFIO.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/vfio/Kconfig            |  2 +-
 drivers/vfio/vfio_iommu_type1.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index 7cd5dec..1f84eda 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -6,7 +6,7 @@ config VFIO_IOMMU_TYPE1
 menuconfig VFIO
 	tristate "VFIO Non-Privileged userspace driver framework"
 	depends on IOMMU_API
-	select VFIO_IOMMU_TYPE1 if X86
+	select VFIO_IOMMU_TYPE1 if X86 || ARM
 	help
 	  VFIO provides a framework for secure userspace device drivers.
 	  See Documentation/vfio.txt for more details.
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 6f3fbc4..4339603 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -30,7 +30,8 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/mm.h>
-#include <linux/pci.h>		/* pci_bus_type */
+#include <linux/pci.h>			/* pci_bus_type */
+#include <linux/platform_device.h>	/* platform_bus_type */
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -610,9 +611,17 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 	mutex_init(&iommu->lock);
 
 	/*
+	 * ARM SMMU compatibility workaround
+	 */
+	iommu->domain = iommu_domain_alloc(&platform_bus_type);
+	if (iommu->domain)
+		return iommu;
+
+	/*
 	 * Wish we didn't have to know about bus_type here.
 	 */
-	iommu->domain = iommu_domain_alloc(&pci_bus_type);
+	//iommu->domain = iommu_domain_alloc(&pci_bus_type);
+
 	if (!iommu->domain) {
 		kfree(iommu);
 		return ERR_PTR(-EIO);
@@ -733,7 +742,7 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 
 static int __init vfio_iommu_type1_init(void)
 {
-	if (!iommu_present(&pci_bus_type))
+	if (!iommu_present(&platform_bus_type))
 		return -ENODEV;
 
 	return vfio_register_iommu_driver(&vfio_iommu_driver_ops_type1);
-- 
1.8.1.2
