From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 14 Sep 2010 01:24:04 -0400 (EDT)
Subject: [PATCH/RFC] ARM: add a vma entry for the user accessible vector page
Message-ID: <alpine.LFD.2.00.1009140118510.19366@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    
The kernel makes the high vector page visible to user space. This page
contains (amongst others) small code segments that can be executed in
user space.  Make this page visible through ptrace and /proc/<pid>/mem
in order to let gdb perform code parsing needed for proper unwinding.

For example, the ERESTART_RESTARTBLOCK handler actually has a stack
frame -- it returns to a PC value stored on the user's stack.   To
unwind after a "sleep" system call was interrupted twice, GDB would
have to recognize this situation and understand that stack frame
layout -- which it currently cannot do.

We could fix this by hard-coding addresses in the vector page range into
GDB, but that isn't really portable as not all of those addresses are
guaranteed to remain stable across kernel releases.  And having the gdb
process make an exception for this page and get  content from its own
view of it looks strange, and it is not future proof either.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index 5747a8b..8bb66bc 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -127,4 +127,8 @@ struct mm_struct;
 extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 #define arch_randomize_brk arch_randomize_brk
 
+extern int vectors_user_mapping(void);
+#define arch_setup_additional_pages(bprm, uses_interp) vectors_user_mapping()
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
+
 #endif
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index a0b3cac..71605d9 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -18,7 +18,6 @@
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
 #include <asm/proc-fns.h>
-#include <asm-generic/mm_hooks.h>
 
 void __check_kvm_seq(struct mm_struct *mm);
 
@@ -134,4 +133,32 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #define deactivate_mm(tsk,mm)	do { } while (0)
 #define activate_mm(prev,next)	switch_mm(prev, next, NULL)
 
+/*
+ * We are inserting a "fake" vma for the user-accessible vector page so
+ * gdb and friends can get to it through ptrace and /proc/<pid>/mem.
+ * But we also want to remove it before the generic code gets to see it
+ * during process exit or the unmapping of it would  cause total havoc.
+ * (the macro is used as remove_vma() is static to mm/mmap.c)
+ */
+#define arch_exit_mmap(mm) \
+do { \
+	struct vm_area_struct *high_vma = find_vma(mm, 0xffff0000); \
+	if (high_vma) { \
+		BUG_ON(high_vma->vm_next);  /* it should be last */ \
+		if (high_vma->vm_prev) \
+			high_vma->vm_prev->vm_next = NULL; \
+		else \
+			mm->mmap = NULL; \
+		rb_erase(&high_vma->vm_rb, &mm->mm_rb); \
+		mm->mmap_cache = NULL; \
+		mm->map_count--; \
+		remove_vma(high_vma); \
+	} \
+} while (0)
+
+static inline void arch_dup_mmap(struct mm_struct *oldmm,
+				 struct mm_struct *mm)
+{
+}
+
 #endif
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 401e38b..150ce77 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -458,3 +458,24 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	unsigned long range_end = mm->brk + 0x02000000;
 	return randomize_range(mm->brk, range_end, 0) ? : mm->brk;
 }
+
+/*
+ * The vectors page is always readable from user space for the
+ * atomic helpers and the signal restart code.  Let's declare a mapping
+ * for it so it is visible through ptrace and /proc/<pid>/mem.
+ */
+
+int vectors_user_mapping(void)
+{
+	struct mm_struct *mm = current->mm;
+	return install_special_mapping(mm, 0xffff0000, PAGE_SIZE,
+				       VM_READ | VM_EXEC |
+				       VM_MAYREAD | VM_MAYEXEC |
+				       VM_ALWAYSDUMP | VM_RESERVED,
+				       NULL);
+}
+
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	return (vma->vm_start == 0xffff0000) ? "[vectors]" : NULL;
+}
