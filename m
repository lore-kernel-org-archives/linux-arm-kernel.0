From: anup.patel@broadcom.com (Anup Patel)
Date: Mon,  8 Aug 2016 11:22:32 +0530
Subject: [PATCH RESEND v2 3/8] uio: Add new UIO_MEM_PHYS_CACHE type for mem
 regions
In-Reply-To: <1470635557-13416-1-git-send-email-anup.patel@broadcom.com>
References: <1470635557-13416-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1470635557-13416-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ankit Jindal <thatsjindal@gmail.com>

Currently, three types of mem regions are supported: UIO_MEM_PHYS,
UIO_MEM_LOGICAL and UIO_MEM_VIRTUAL. Among these UIO_MEM_PHYS helps
UIO driver export physcial memory to user space as non-cacheable
user memory. Typcially memory-mapped registers of a device are exported
to user space as UIO_MEM_PHYS type mem region. The UIO_MEM_PHYS type
is not efficient if dma-capable devices are capable of maintaining
coherency with CPU caches.

This patch adds new type UIO_MEM_PHYS_CACHE for mem regions to enable
cacheable access to physical memory from user space.

Signed-off-by: Ankit Jindal <thatsjindal@gmail.com>
Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/uio/uio.c          | 16 +++++++++++++---
 include/linux/uio_driver.h |  9 +++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index f2729b7..0e53076 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -641,7 +641,7 @@ static const struct vm_operations_struct uio_physical_vm_ops = {
 #endif
 };
 
-static int uio_mmap_physical(struct vm_area_struct *vma)
+static int uio_mmap_physical(struct vm_area_struct *vma, int memtype)
 {
 	struct uio_device *idev = vma->vm_private_data;
 	int mi = uio_find_mem_index(vma);
@@ -656,7 +656,16 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
 		return -EINVAL;
 
 	vma->vm_ops = &uio_physical_vm_ops;
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	switch (memtype) {
+	case UIO_MEM_PHYS:
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		break;
+	case UIO_MEM_PHYS_CACHE:
+		/* Do nothing. */
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	/*
 	 * We cannot use the vm_iomap_memory() helper here,
@@ -704,7 +713,8 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 
 	switch (idev->info->mem[mi].memtype) {
 	case UIO_MEM_PHYS:
-		return uio_mmap_physical(vma);
+	case UIO_MEM_PHYS_CACHE:
+		return uio_mmap_physical(vma, idev->info->mem[mi].memtype);
 	case UIO_MEM_LOGICAL:
 	case UIO_MEM_VIRTUAL:
 		return uio_mmap_logical(vma);
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 32c0e83..31359aee 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -124,10 +124,11 @@ extern void uio_event_notify(struct uio_info *info);
 #define UIO_IRQ_NONE	0
 
 /* defines for uio_mem->memtype */
-#define UIO_MEM_NONE	0
-#define UIO_MEM_PHYS	1
-#define UIO_MEM_LOGICAL	2
-#define UIO_MEM_VIRTUAL 3
+#define UIO_MEM_NONE		0
+#define UIO_MEM_PHYS		1
+#define UIO_MEM_LOGICAL		2
+#define UIO_MEM_VIRTUAL		3
+#define UIO_MEM_PHYS_CACHE	4
 
 /* defines for uio_port->porttype */
 #define UIO_PORT_NONE	0
-- 
1.9.1
