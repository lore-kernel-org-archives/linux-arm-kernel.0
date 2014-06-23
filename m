From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Sun, 22 Jun 2014 22:11:54 -0500
Subject: [PATCH v7 5/9] ARM: place sigpage at a random offset above stack
In-Reply-To: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1403493118-7597-6-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sigpage is currently placed alongside shared libraries etc in the
address space.  Similar to what x86_64 does for its VDSO, place the
sigpage at a randomized offset above the stack so that learning the
base address of the sigpage doesn't help expose where shared libraries
are loaded in the address space (and vice versa).

This code will be used for placing the vdso as well, hence the
vdso_addr function name and npages argument.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/kernel/process.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 81ef686a91ca..219a0d1d10fc 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -477,6 +477,35 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 		 "[sigpage]" : NULL;
 }
 
+static unsigned long vdso_addr(const struct mm_struct *mm, unsigned int npages)
+{
+	unsigned long offset;
+	unsigned long first;
+	unsigned long last;
+	unsigned long addr;
+	unsigned int slots;
+
+	first = PAGE_ALIGN(mm->start_stack);
+
+	last = TASK_SIZE - (npages << PAGE_SHIFT);
+
+	/* No room after stack? */
+	if (first > last)
+		return 0;
+
+	/* Just enough room? */
+	if (first == last)
+		return first;
+
+	slots = ((last - first) >> PAGE_SHIFT) + 1;
+
+	offset = get_random_int() % slots;
+
+	addr = first + (offset << PAGE_SHIFT);
+
+	return addr;
+}
+
 static struct page *signal_page;
 extern struct page *get_signal_page(void);
 
@@ -484,6 +513,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
+	unsigned long hint;
 	int ret;
 
 	if (!signal_page)
@@ -492,7 +522,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return -ENOMEM;
 
 	down_write(&mm->mmap_sem);
-	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
+	hint = vdso_addr(mm, 1);
+	addr = get_unmapped_area(NULL, hint, PAGE_SIZE, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
 		ret = addr;
 		goto up_fail;
-- 
1.9.3
