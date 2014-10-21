From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Tue, 21 Oct 2014 11:26:46 +0530
Subject: [PATCH v3 2/6] uio: Add new UIO_MEM_PHYS_CACHE type for mem regions
In-Reply-To: <1413871011-4101-1-git-send-email-ankit.jindal@linaro.org>
References: <1413871011-4101-1-git-send-email-ankit.jindal@linaro.org>
Message-ID: <1413871011-4101-3-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, three types of mem regions are supported: UIO_MEM_PHYS,
UIO_MEM_LOGICAL and UIO_MEM_VIRTUAL. Among these UIO_MEM_PHYS helps
UIO driver export physcial memory to user space as non-cacheable
user memory. Typcially memory-mapped registers of a device are exported
to user space as UIO_MEM_PHYS type mem region. The UIO_MEM_PHYS type
is not efficient if dma-capable devices are capable of maintaining coherency
with CPU caches.

This patch adds new type UIO_MEM_PHYS_CACHE for mem regions to enable
cacheable access to physical memory from user space.

Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
---
 drivers/uio/uio.c          |   11 ++++++++---
 include/linux/uio_driver.h |    1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 97e6444..120a84b 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -644,7 +644,7 @@ static const struct vm_operations_struct uio_physical_vm_ops = {
 #endif
 };
 
-static int uio_mmap_physical(struct vm_area_struct *vma)
+static int uio_mmap_physical(struct vm_area_struct *vma, bool cacheable)
 {
 	struct uio_device *idev = vma->vm_private_data;
 	int mi = uio_find_mem_index(vma);
@@ -659,7 +659,9 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
 		return -EINVAL;
 
 	vma->vm_ops = &uio_physical_vm_ops;
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	if (!cacheable)
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	/*
 	 * We cannot use the vm_iomap_memory() helper here,
@@ -707,10 +709,13 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 
 	switch (idev->info->mem[mi].memtype) {
 	case UIO_MEM_PHYS:
-		return uio_mmap_physical(vma);
+		return uio_mmap_physical(vma, false);
 	case UIO_MEM_LOGICAL:
 	case UIO_MEM_VIRTUAL:
 		return uio_mmap_logical(vma);
+	case UIO_MEM_PHYS_CACHE:
+		return uio_mmap_physical(vma, true);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 1ad4724..40ca3f3 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -118,6 +118,7 @@ extern void uio_event_notify(struct uio_info *info);
 #define UIO_MEM_PHYS	1
 #define UIO_MEM_LOGICAL	2
 #define UIO_MEM_VIRTUAL 3
+#define UIO_MEM_PHYS_CACHE	4
 
 /* defines for uio_port->porttype */
 #define UIO_PORT_NONE	0
-- 
1.7.9.5
