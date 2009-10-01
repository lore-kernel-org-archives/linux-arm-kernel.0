From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu,  1 Oct 2009 23:34:15 +0200
Subject: [PATCH] FCSE: Make the shared mappings uncacheable.
In-Reply-To: <1254432860-11511-5-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-3-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-4-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-5-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <1254432860-11511-6-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/mm/fault-armv.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index bc0099d..40bccb9 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -94,6 +94,7 @@ no_pmd:
 static void
 make_coherent(struct address_space *mapping, struct vm_area_struct *vma, unsigned long addr, unsigned long pfn)
 {
+#ifndef CONFIG_ARM_FCSE_GUARANTEED
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *mpnt;
 	struct prio_tree_iter iter;
@@ -127,6 +128,10 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma, unsigne
 		adjust_pte(vma, addr);
 	else
 		flush_cache_page(vma, addr, pfn);
+#else /* CONFIG_ARM_FCSE_GUARANTEED */
+	if (vma->vm_flags & VM_MAYSHARE)
+		adjust_pte(vma, addr);
+#endif /* CONFIG_ARM_FCSE_GUARANTEED */
 }
 
 /*
-- 
1.5.6.5
