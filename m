From: shile.zhang@nokia-sbell.com (Zhang, Shile (NSB - CN/Hangzhou))
Date: Mon, 13 Nov 2017 05:32:26 +0000
Subject: [PATCH] mm/hugetlb: Implement ASLR and topdown for hugetlb
 mappings
In-Reply-To: <1509700757-34420-1-git-send-email-shile.zhang@nokia-sbell.com>
References: <1509700757-34420-1-git-send-email-shile.zhang@nokia-sbell.com>
Message-ID: <VI1PR0701MB2846C892037A515D0B3F4EF8A12B0@VI1PR0701MB2846.eurprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell,

Have you any time to check this patch?
I found this issue/missing in my works, the application cannot mmap big hugepage (about 360MB) due to no more contiguous vm from the default "TASK_UNMMAPPED_AREA" by legacy bottom-up.
We need this patch to fix this issue.

Could you please help check this patch?

Thanks!

BR, Shile

-----Original Message-----
From: Shile Zhang [mailto:shile.zhang at nokia-sbell.com] 
Sent: Friday, November 03, 2017 5:19 PM
To: Russell King <linux@armlinux.org.uk>
Cc: linux-kernel at vger.kernel.org; Zhang, Shile (NSB - CN/Hangzhou) <shile.zhang@nokia-sbell.com>
Subject: [PATCH] mm/hugetlb: Implement ASLR and topdown for hugetlb mappings

merge from arch/x86

Signed-off-by: Shile Zhang <shile.zhang@nokia-sbell.com>
---
 arch/arm/include/asm/page.h |  1 +
 arch/arm/mm/hugetlbpage.c   | 85 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 4355f0e..994630f 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -144,6 +144,7 @@ extern void copy_page(void *to, const void *from);
 
 #ifdef CONFIG_KUSER_HELPERS
 #define __HAVE_ARCH_GATE_AREA 1
+#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #endif
 
 #ifdef CONFIG_ARM_LPAE
diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
index fcafb52..46ed0c8 100644
--- a/arch/arm/mm/hugetlbpage.c
+++ b/arch/arm/mm/hugetlbpage.c
@@ -45,3 +45,88 @@ int pmd_huge(pmd_t pmd)
 {
 	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
 }
+
+#ifdef CONFIG_HUGETLB_PAGE
+static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
+		unsigned long addr, unsigned long len,
+		unsigned long pgoff, unsigned long flags)
+{
+	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
+
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = current->mm->mmap_legacy_base;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
+}
+
+static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
+		unsigned long addr0, unsigned long len,
+		unsigned long pgoff, unsigned long flags)
+{
+	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
+	unsigned long addr;
+
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = current->mm->mmap_base;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	addr = vm_unmapped_area(&info);
+
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	if (addr & ~PAGE_MASK) {
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
+unsigned long
+hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct hstate *h = hstate_file(file);
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED) {
+		if (prepare_hugepage_range(file, addr, len))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (addr) {
+		addr = ALIGN(addr, huge_page_size(h));
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+	if (mm->get_unmapped_area == arch_get_unmapped_area)
+		return hugetlb_get_unmapped_area_bottomup(file, addr, len,
+				pgoff, flags);
+	else
+		return hugetlb_get_unmapped_area_topdown(file, addr, len,
+				pgoff, flags);
+}
+#endif /* CONFIG_HUGETLB_PAGE */
-- 
2.6.2
