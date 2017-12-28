From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 28 Dec 2017 16:38:57 +0100
Subject: [PATCH 2/2] tee: optee: check type of registered shared memory
In-Reply-To: <20171228153857.30086-1-jens.wiklander@linaro.org>
References: <20171228153857.30086-1-jens.wiklander@linaro.org>
Message-ID: <20171228153857.30086-3-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checks the memory type of the pages to be registered as shared memory.
Only normal cached memory is allowed.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index d61c14b788f2..47b12b7fd02d 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/types.h>
@@ -535,6 +536,41 @@ void optee_free_pages_list(void *list, size_t num_entries)
 	free_pages_exact(list, get_pages_list_size(num_entries));
 }
 
+static bool is_normal_memory(pgprot_t p)
+{
+#if defined(CONFIG_ARM)
+	return (pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC;
+#elif defined(CONFIG_ARM64)
+	return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
+#else
+#error "Unuspported architecture"
+#endif
+}
+
+static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
+{
+	while (vma && is_normal_memory(vma->vm_page_prot)) {
+		if (vma->vm_end >= end)
+			return 0;
+		vma = vma->vm_next;
+	}
+
+	return -EINVAL;
+}
+
+static int check_mem_type(unsigned long start, size_t num_pages)
+{
+	struct mm_struct *mm = current->mm;
+	int rc;
+
+	down_read(&mm->mmap_sem);
+	rc = __check_mem_type(find_vma(mm, start),
+			      start + num_pages * PAGE_SIZE);
+	up_read(&mm->mmap_sem);
+
+	return rc;
+}
+
 int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 		       struct page **pages, size_t num_pages,
 		       unsigned long start)
@@ -543,11 +579,15 @@ int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 	struct optee_msg_arg *msg_arg;
 	u64 *pages_list;
 	phys_addr_t msg_parg;
-	int rc = 0;
+	int rc;
 
 	if (!num_pages)
 		return -EINVAL;
 
+	rc = check_mem_type(start, num_pages);
+	if (rc)
+		return rc;
+
 	pages_list = optee_allocate_pages_list(num_pages);
 	if (!pages_list)
 		return -ENOMEM;
@@ -614,7 +654,7 @@ int optee_shm_register_supp(struct tee_context *ctx, struct tee_shm *shm,
 	 * We don't want to register supplicant memory in OP-TEE.
 	 * Instead information about it will be passed in RPC code.
 	 */
-	return 0;
+	return check_mem_type(start, num_pages);
 }
 
 int optee_shm_unregister_supp(struct tee_context *ctx, struct tee_shm *shm)
-- 
2.14.1
