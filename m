From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 18 Jan 2016 15:01:05 +0100
Subject: [PATCH] arm64: allow vmalloc regions to be set with set_memory_*
Message-ID: <1453125665-26627-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The range of set_memory_* is currently restricted to the module address
range because of difficulties in breaking down larger block sizes.
vmalloc maps PAGE_SIZE pages so it is safe to use as well. Update the
function ranges and add a comment explaining why the range is restricted
the way it is.

Suggested-by: Laura Abbott <labbott@fedoraproject.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/pageattr.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 3571c7309c5e..1360a02d88b7 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/vmalloc.h>
 #include <linux/sched.h>
 
 #include <asm/pgtable.h>
@@ -44,6 +45,7 @@ static int change_memory_common(unsigned long addr, int numpages,
 	unsigned long end = start + size;
 	int ret;
 	struct page_change_data data;
+	struct vm_struct *area;
 
 	if (!PAGE_ALIGNED(addr)) {
 		start &= PAGE_MASK;
@@ -51,10 +53,23 @@ static int change_memory_common(unsigned long addr, int numpages,
 		WARN_ON_ONCE(1);
 	}
 
-	if (start < MODULES_VADDR || start >= MODULES_END)
-		return -EINVAL;
-
-	if (end < MODULES_VADDR || end >= MODULES_END)
+	/*
+	 * Kernel VA mappings are always live, and splitting live section
+	 * mappings into page mappings may cause TLB conflicts. This means
+	 * we have to ensure that changing the permission bits of the range
+	 * we are operating on does not result in such splitting.
+	 *
+	 * Let's restrict ourselves to mappings created by vmalloc (or vmap).
+	 * Those are guaranteed to consist entirely of page mappings, and
+	 * splitting is never needed.
+	 *
+	 * So check whether the [addr, addr + size) interval is entirely
+	 * covered by precisely one VM area that has the VM_ALLOC flag set.
+	 */
+	area = find_vm_area((void *)addr);
+	if (!area ||
+	    end > (unsigned long)area->addr + area->size ||
+	    !(area->flags & VM_ALLOC))
 		return -EINVAL;
 
 	data.set_mask = set_mask;
-- 
2.5.0
