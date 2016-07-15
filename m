From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 15 Jul 2016 14:33:58 +0530
Subject: [PATCH 3/8] uio: Add new UIO_MEM_DEVICE type for mem regions
In-Reply-To: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
References: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1468573443-4670-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM64, the MMU supports special memory attributes for device
memory/registers. Due to this we have pgprot_device() provided
by asm/pgtable.h of arch/arm64.

On architectures that do not have special MMU attribute for device
memory/registers, the asm-generic/pgtable.h maps pgprot_device()
to pgprot_noncached().

This patch introduces a new UIO mem region type UIO_MEM_DEVICE to
represent device registers/memory. The UIO device drivers should
prefer this new UIO mem region type for memory mapped device registers.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/uio/uio.c          | 4 ++++
 include/linux/uio_driver.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 0e53076..a00990c 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -663,6 +663,9 @@ static int uio_mmap_physical(struct vm_area_struct *vma, int memtype)
 	case UIO_MEM_PHYS_CACHE:
 		/* Do nothing. */
 		break;
+	case UIO_MEM_DEVICE:
+		vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -714,6 +717,7 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 	switch (idev->info->mem[mi].memtype) {
 	case UIO_MEM_PHYS:
 	case UIO_MEM_PHYS_CACHE:
+	case UIO_MEM_DEVICE:
 		return uio_mmap_physical(vma, idev->info->mem[mi].memtype);
 	case UIO_MEM_LOGICAL:
 	case UIO_MEM_VIRTUAL:
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 31359aee..7349f95 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -129,6 +129,7 @@ extern void uio_event_notify(struct uio_info *info);
 #define UIO_MEM_LOGICAL		2
 #define UIO_MEM_VIRTUAL		3
 #define UIO_MEM_PHYS_CACHE	4
+#define UIO_MEM_DEVICE		5
 
 /* defines for uio_port->porttype */
 #define UIO_PORT_NONE	0
-- 
1.9.1
