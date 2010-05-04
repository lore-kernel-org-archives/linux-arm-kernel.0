From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 04 May 2010 17:44:48 +0100
Subject: [PATCH 6/8] ARM: Implement copy_to_user_page() for noMMU
In-Reply-To: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100504164448.26355.54748.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7959722 introduced calls to copy_(to|from)_user_page() from
access_process_vm() in mm/nommu.c. The copy_to_user_page() was not
implemented on noMMU ARM.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/nommu.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index f8791ee..33b3273 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -65,6 +65,15 @@ void flush_dcache_page(struct page *page)
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
+void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
+		       unsigned long uaddr, void *dst, const void *src,
+		       unsigned long len)
+{
+	memcpy(dst, src, len);
+	if (vma->vm_flags & VM_EXEC)
+		__cpuc_coherent_user_range(uaddr, uaddr + len);
+}
+
 void __iomem *__arm_ioremap_pfn(unsigned long pfn, unsigned long offset,
 				size_t size, unsigned int mtype)
 {
