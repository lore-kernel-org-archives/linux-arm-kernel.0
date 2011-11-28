From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Nov 2011 18:28:53 +0000
Subject: [PATCH v2 2/6] ARM: suspend: use idmap_pgd instead of suspend_pgd
In-Reply-To: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
References: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
Message-ID: <1322504937-24718-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM CPU suspend code requires cpu_resume_mmu to be identity mapped
in order to re-enable the MMU when coming out of suspend. Currently,
this is accomplished by maintaining a suspend_pgd with the relevant
mapping put in place at init time.

This patch replaces the use of suspend_pgd with the new idmap_pgd.
cpu_resume_mmu is placed in the .idmap.text section so that it is
included in the identity map.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Dave Martin <dave.martin@linaro.org>
Tested-by: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/sleep.S   |    2 ++
 arch/arm/kernel/suspend.c |   18 +++---------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 020e99c..9e64231 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -54,6 +54,7 @@ ENDPROC(cpu_suspend_abort)
  * r0 = control register value
  */
 	.align	5
+	.pushsection	.idmap.text,"ax"
 ENTRY(cpu_resume_mmu)
 	ldr	r3, =cpu_resume_after_mmu
 	mcr	p15, 0, r0, c1, c0, 0	@ turn on MMU, I-cache, etc
@@ -62,6 +63,7 @@ ENTRY(cpu_resume_mmu)
 	mov	r0, r0
 	mov	pc, r3			@ jump to virtual address
 ENDPROC(cpu_resume_mmu)
+	.popsection
 cpu_resume_after_mmu:
 	bl	cpu_init		@ restore the und/abt/irq banked regs
 	mov	r0, #0			@ return zero on success
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 93a22d2..1794cc3 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -1,13 +1,12 @@
 #include <linux/init.h>
 
+#include <asm/idmap.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/memory.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
 
-static pgd_t *suspend_pgd;
-
 extern int __cpu_suspend(unsigned long, int (*)(unsigned long));
 extern void cpu_resume_mmu(void);
 
@@ -21,7 +20,7 @@ void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
 	*save_ptr = virt_to_phys(ptr);
 
 	/* This must correspond to the LDM in cpu_resume() assembly */
-	*ptr++ = virt_to_phys(suspend_pgd);
+	*ptr++ = virt_to_phys(idmap_pgd);
 	*ptr++ = sp;
 	*ptr++ = virt_to_phys(cpu_do_resume);
 
@@ -42,7 +41,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	struct mm_struct *mm = current->active_mm;
 	int ret;
 
-	if (!suspend_pgd)
+	if (!idmap_pgd)
 		return -EINVAL;
 
 	/*
@@ -59,14 +58,3 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 
 	return ret;
 }
-
-static int __init cpu_suspend_init(void)
-{
-	suspend_pgd = pgd_alloc(&init_mm);
-	if (suspend_pgd) {
-		unsigned long addr = virt_to_phys(cpu_resume_mmu);
-		identity_mapping_add(suspend_pgd, addr, addr + SECTION_SIZE);
-	}
-	return suspend_pgd ? 0 : -ENOMEM;
-}
-core_initcall(cpu_suspend_init);
-- 
1.7.4.1
