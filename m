From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 23:03:49 +0100
Subject: [PATCH] ARM: turn init_new_context into an inline function
Message-ID: <16176240.edsgIdRrJJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Almost all architectures define init_new_context() as a function,
but on ARM, it's a macro and that causes a compiler warning when
its return code is not used:

drivers/firmware/efi/arm-runtime.c: In function 'efi_virtmap_init':
arch/arm/include/asm/mmu_context.h:88:34: warning: statement with no effect [-Wunused-value]
 #define init_new_context(tsk,mm) 0
drivers/firmware/efi/arm-runtime.c:47:2: note: in expansion of macro 'init_new_context'
  init_new_context(NULL, &efi_mm);

This changes the definition into an inline function, which gcc does
not warn about.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: f7d924894265 ("arm64/efi: refactor EFI init and runtime code for reuse by 32-bit ARM")
---

This has newly showed up in ARM randconfig builds

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index 432ce8176498..fa5b42d44985 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -26,7 +26,12 @@ void __check_vmalloc_seq(struct mm_struct *mm);
 #ifdef CONFIG_CPU_HAS_ASID
 
 void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk);
-#define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
+static inline int
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	atomic64_set(&mm->context.id, 0);
+	return 0;
+}
 
 #ifdef CONFIG_ARM_ERRATA_798181
 void a15_erratum_get_cpumask(int this_cpu, struct mm_struct *mm,
@@ -85,7 +90,12 @@ static inline void finish_arch_post_lock_switch(void)
 
 #endif	/* CONFIG_MMU */
 
-#define init_new_context(tsk,mm)	0
+static inline int
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	return 0;
+}
+
 
 #endif	/* CONFIG_CPU_HAS_ASID */
 
