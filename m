From: steve.capper@arm.com (Steve Capper)
Date: Wed, 29 Aug 2018 13:45:42 +0100
Subject: [PATCH 4/5] arm64: mmap: Allow for "high" 52-bit VA allocations
In-Reply-To: <20180829124543.25314-1-steve.capper@arm.com>
References: <20180829124543.25314-1-steve.capper@arm.com>
Message-ID: <20180829124543.25314-5-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch alters arch_get_unmapped_area and
arch_get_unmapped_area_topdown such that mmap calls with an addr
parameter that lie above 48-bit VAs will receive a VA that lies within
the 52-bit VA space on systems that support it.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/mm/mmap.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index b516e0bfdb71..827414b69866 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -81,6 +81,15 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 
 extern unsigned long mmap_min_addr;
 
+static unsigned long get_end_address(unsigned long addr)
+{
+	if (IS_ENABLED(CONFIG_ARM64_TRY_52BIT_VA) &&
+			(addr > DEFAULT_MAP_WINDOW))
+		return TASK_SIZE;
+	else
+		return DEFAULT_MAP_WINDOW;
+}
+
 unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
@@ -88,8 +97,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
 	struct vm_unmapped_area_info info;
+	unsigned long end = get_end_address(addr);
 
-	if (len > TASK_SIZE - mmap_min_addr)
+	if (len > end - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -98,7 +108,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma_prev(mm, addr, &prev);
-		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		if (end - len >= addr && addr >= mmap_min_addr &&
 		    (!vma || addr + len <= vm_start_gap(vma)) &&
 		    (!prev || addr >= vm_end_gap(prev)))
 			return addr;
@@ -107,7 +117,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
-	info.high_limit = TASK_SIZE;
+	info.high_limit = end;
 	info.align_mask = 0;
 	return vm_unmapped_area(&info);
 }
@@ -121,9 +131,10 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info;
+	unsigned long end = get_end_address(addr);
 
 	/* requested length too big for entire address space */
-	if (len > TASK_SIZE - mmap_min_addr)
+	if (len > end - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -133,7 +144,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma_prev(mm, addr, &prev);
-		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		if (end - len >= addr && addr >= mmap_min_addr &&
 				(!vma || addr + len <= vm_start_gap(vma)) &&
 				(!prev || addr >= vm_end_gap(prev)))
 			return addr;
@@ -143,6 +154,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.length = len;
 	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
 	info.high_limit = mm->mmap_base;
+	if (IS_ENABLED(CONFIG_ARM64_TRY_52BIT_VA) && (addr > DEFAULT_MAP_WINDOW))
+		info.high_limit += TASK_SIZE - DEFAULT_MAP_WINDOW;
+
 	info.align_mask = 0;
 	addr = vm_unmapped_area(&info);
 
@@ -156,7 +170,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
 		info.low_limit = TASK_UNMAPPED_BASE;
-		info.high_limit = TASK_SIZE;
+		info.high_limit = end;
 		addr = vm_unmapped_area(&info);
 	}
 
-- 
2.11.0
