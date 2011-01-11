From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Jan 2011 12:02:17 +0000
Subject: [PATCH] ARM: nommu: avoid mapping vectors page when !CONFIG_MMU
Message-ID: <1294747337-18238-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running without an MMU, we do not need to install a mapping for the
vectors page. Attempting to do so causes a compile-time error because
install_special_mapping is not defined.

This patch adds compile-time guards to the vector mapping functions
so that we can build nommu configurations once more.

Cc: Greg Ungerer <gerg@uclinux.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/process.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index e76fcaa..94bbedb 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -483,6 +483,7 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	return randomize_range(mm->brk, range_end, 0) ? : mm->brk;
 }
 
+#ifdef CONFIG_MMU
 /*
  * The vectors page is always readable from user space for the
  * atomic helpers and the signal restart code.  Let's declare a mapping
@@ -503,3 +504,4 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 {
 	return (vma->vm_start == 0xffff0000) ? "[vectors]" : NULL;
 }
+#endif
-- 
1.7.0.4
