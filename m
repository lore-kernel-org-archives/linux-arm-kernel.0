From: steve.capper@arm.com (Steve Capper)
Date: Wed, 29 Aug 2018 13:45:41 +0100
Subject: [PATCH 3/5] arm64: mm: Copy over arch_get_unmapped_area
In-Reply-To: <20180829124543.25314-1-steve.capper@arm.com>
References: <20180829124543.25314-1-steve.capper@arm.com>
Message-ID: <20180829124543.25314-4-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support 52-bit VAs for userspace we need to alter the mmap
area choosing logic to give 52-bit VAs where "high" addresses are
requested.

This patch copies over the arch_get_unmapped_area and
arch_get_unmapped_area_topdown routines from common code such that we
can make modifications to the logic in a future patch.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/include/asm/pgtable.h |  7 ++++
 arch/arm64/mm/mmap.c             | 84 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 8449e266cd46..8d4175cde295 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -785,6 +785,13 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 #define phys_to_ttbr(addr)	(addr)
 #endif
 
+/*
+ * On arm64 we can have larger VA spaces for userspace, we define our own
+ * arch_get_unmapped_area_ routines to allow for hinting from userspace.
+ */
+#define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 842c8a5fcd53..b516e0bfdb71 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -79,6 +79,90 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 	return PAGE_ALIGN(STACK_TOP - gap - rnd);
 }
 
+extern unsigned long mmap_min_addr;
+
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+	struct vm_unmapped_area_info info;
+
+	if (len > TASK_SIZE - mmap_min_addr)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED)
+		return addr;
+
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma_prev(mm, addr, &prev);
+		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		    (!vma || addr + len <= vm_start_gap(vma)) &&
+		    (!prev || addr >= vm_end_gap(prev)))
+			return addr;
+	}
+
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = mm->mmap_base;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = 0;
+	return vm_unmapped_area(&info);
+}
+
+unsigned long
+arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
+			  const unsigned long len, const unsigned long pgoff,
+			  const unsigned long flags)
+{
+	struct vm_area_struct *vma, *prev;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr = addr0;
+	struct vm_unmapped_area_info info;
+
+	/* requested length too big for entire address space */
+	if (len > TASK_SIZE - mmap_min_addr)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED)
+		return addr;
+
+	/* requesting a specific address */
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma_prev(mm, addr, &prev);
+		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+				(!vma || addr + len <= vm_start_gap(vma)) &&
+				(!prev || addr >= vm_end_gap(prev)))
+			return addr;
+	}
+
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.high_limit = mm->mmap_base;
+	info.align_mask = 0;
+	addr = vm_unmapped_area(&info);
+
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	if (offset_in_page(addr)) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = 0;
+		info.low_limit = TASK_UNMAPPED_BASE;
+		info.high_limit = TASK_SIZE;
+		addr = vm_unmapped_area(&info);
+	}
+
+	return addr;
+}
+
 /*
  * This function, called very early during the creation of a new process VM
  * image, sets up which VM layout function to use:
-- 
2.11.0
