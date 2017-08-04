From: salyzyn@android.com (Mark Salyzyn)
Date: Fri,  4 Aug 2017 11:30:42 -0700
Subject: [PATCH 1/2] arm64: compat: Split the sigreturn trampolines and kuser
 helpers
Message-ID: <20170804183117.77996-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

AArch32 processes are currently installed a special [vectors] page that
contains the sigreturn trampolines and the kuser helpers, at the fixed
address mandated by the kuser helpers ABI.

Having both functionalities in the same page has become problematic,
because:

* It makes it impossible to disable the kuser helpers (the sigreturn
  trampolines cannot be removed), which is possible on arm.

* A future 32-bit vDSO would provide the sigreturn trampolines itself,
  making those in [vectors] redundant.

This patch addresses the problem by moving the sigreturn trampolines to
a separate [sigpage] page, mirroring [sigpage] on arm.

Even though [vectors] has always been a misnomer on arm64/compat, as
there is no AArch32 vector there (and now only the kuser helpers),
its name has been left unchanged, for compatibility with arm (there
are reports of software relying on [vectors] being there as the last
mapping in /proc/maps).

mm->context.vdso used to point to the [vectors] page, which is
unnecessary (as its address is fixed). It now points to the [sigpage]
page (whose address is randomized like a vDSO).

Finally aarch32_setup_vectors_page() has been renamed to the more
generic aarch32_setup_additional_pages().

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 arch/arm64/include/asm/elf.h       |   6 +-
 arch/arm64/include/asm/processor.h |   4 +-
 arch/arm64/include/asm/signal32.h  |   2 -
 arch/arm64/kernel/signal32.c       |   5 +-
 arch/arm64/kernel/vdso.c           | 138 +++++++++++++++++++++++++++----------
 5 files changed, 107 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index acae781f7359..4f57c23d8a83 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -199,10 +199,10 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 	set_thread_flag(TIF_32BIT);					\
  })
 #define COMPAT_ARCH_DLINFO
-extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
-				      int uses_interp);
+extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
+					  int uses_interp);
 #define compat_arch_setup_additional_pages \
-					aarch32_setup_vectors_page
+					aarch32_setup_additional_pages
 
 #endif /* CONFIG_COMPAT */
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 64c9e78f9882..70ac0ceef306 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -39,9 +39,9 @@
 
 #define STACK_TOP_MAX		TASK_SIZE_64
 #ifdef CONFIG_COMPAT
-#define AARCH32_VECTORS_BASE	0xffff0000
+#define AARCH32_KUSER_HELPERS_BASE 0xffff0000
 #define STACK_TOP		(test_thread_flag(TIF_32BIT) ? \
-				AARCH32_VECTORS_BASE : STACK_TOP_MAX)
+				AARCH32_KUSER_HELPERS_BASE : STACK_TOP_MAX)
 #else
 #define STACK_TOP		STACK_TOP_MAX
 #endif /* CONFIG_COMPAT */
diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index eeaa97559bab..49896b9c161e 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -20,8 +20,6 @@
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
-#define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
-
 extern const compat_ulong_t aarch32_sigret_code[6];
 
 int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index c747a0fc5d7d..3f4c5adb244e 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -484,14 +484,13 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+		void *sigreturn_base = current->mm->context.vdso;
 		unsigned int idx = thumb << 1;
 
 		if (ka->sa.sa_flags & SA_SIGINFO)
 			idx += 3;
 
-		retcode = AARCH32_VECTORS_BASE +
-			  AARCH32_KERN_SIGRET_CODE_OFFSET +
-			  (idx << 2) + thumb;
+		retcode = ptr_to_compat(sigreturn_base) + (idx << 2) + thumb;
 	}
 
 	regs->regs[0]	= usig;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e8f759f764f2..456420b1f3f1 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -1,5 +1,7 @@
 /*
- * VDSO implementation for AArch64 and vector page setup for AArch32.
+ * Additional userspace pages setup for AArch64 and AArch32.
+ * - AArch64: vDSO pages setup, vDSO data page update.
+ * - AArch32: sigreturn and kuser helpers pages setup.
  *
  * Copyright (C) 2012 ARM Limited
  *
@@ -50,64 +52,124 @@ static union {
 struct vdso_data *vdso_data = &vdso_data_store.data;
 
 #ifdef CONFIG_COMPAT
-/*
- * Create and map the vectors page for AArch32 tasks.
- */
-static struct page *vectors_page[1] __ro_after_init;
 
-static int __init alloc_vectors_page(void)
-{
-	extern char __kuser_helper_start[], __kuser_helper_end[];
-	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
+/* sigreturn trampolines page */
+static struct page *sigreturn_page __ro_after_init;
+static const struct vm_special_mapping sigreturn_spec = {
+	/* Must be named [sigpage] for compatibility with arm. */
+	.name	= "[sigpage]",
+	.pages	= &sigreturn_page,
+};
 
-	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
-	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
-	unsigned long vpage;
+static int __init aarch32_sigreturn_init(void)
+{
+	extern char __aarch32_sigret_code_start, __aarch32_sigret_code_end;
 
-	vpage = get_zeroed_page(GFP_ATOMIC);
+	size_t sigret_sz =
+		&__aarch32_sigret_code_end - &__aarch32_sigret_code_start;
+	struct page *page;
+	unsigned long page_addr;
 
-	if (!vpage)
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
 		return -ENOMEM;
+	page_addr = (unsigned long)page_address(page);
 
-	/* kuser helpers */
-	memcpy((void *)vpage + 0x1000 - kuser_sz, __kuser_helper_start,
-		kuser_sz);
-
-	/* sigreturn code */
-	memcpy((void *)vpage + AARCH32_KERN_SIGRET_CODE_OFFSET,
-               __aarch32_sigret_code_start, sigret_sz);
+	memcpy((void *)page_addr, &__aarch32_sigret_code_start, sigret_sz);
 
-	flush_icache_range(vpage, vpage + PAGE_SIZE);
-	vectors_page[0] = virt_to_page(vpage);
+	flush_icache_range(page_addr, page_addr + PAGE_SIZE);
 
+	sigreturn_page = page;
 	return 0;
 }
-arch_initcall(alloc_vectors_page);
+arch_initcall(aarch32_sigreturn_init);
 
-int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
+static int sigreturn_setup(struct mm_struct *mm)
 {
-	struct mm_struct *mm = current->mm;
-	unsigned long addr = AARCH32_VECTORS_BASE;
-	static const struct vm_special_mapping spec = {
-		.name	= "[vectors]",
-		.pages	= vectors_page,
+	unsigned long addr;
+	void *ret;
+
+	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
+	if (IS_ERR_VALUE(addr)) {
+		ret = ERR_PTR(addr);
+		goto out;
+	}
+
+	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
+				       VM_READ|VM_EXEC|
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       &sigreturn_spec);
+	if (IS_ERR(ret))
+		goto out;
+
+	mm->context.vdso = (void *)addr;
+
+out:
+	return PTR_ERR_OR_ZERO(ret);
+}
+
+/* kuser helpers page */
+static struct page *kuser_helpers_page __ro_after_init;
+static const struct vm_special_mapping kuser_helpers_spec = {
+	/* Must be named [vectors] for compatibility with arm. */
+	.name	= "[vectors]",
+	.pages	= &kuser_helpers_page,
+};
+
+static int __init aarch32_kuser_helpers_init(void)
+{
+	extern char __kuser_helper_start, __kuser_helper_end;
 
-	};
+	size_t kuser_sz = &__kuser_helper_end - &__kuser_helper_start;
+	struct page *page;
+	unsigned long page_addr;
+
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+	page_addr = (unsigned long)page_address(page);
+
+	memcpy((void *)(page_addr + 0x1000 - kuser_sz), &__kuser_helper_start,
+	       kuser_sz);
+
+	flush_icache_range(page_addr, page_addr + PAGE_SIZE);
+
+	kuser_helpers_page = page;
+	return 0;
+}
+arch_initcall(aarch32_kuser_helpers_init);
+
+static int kuser_helpers_setup(struct mm_struct *mm)
+{
 	void *ret;
 
+	/* Map the kuser helpers at the ABI-defined high address */
+	ret = _install_special_mapping(mm, AARCH32_KUSER_HELPERS_BASE,
+				       PAGE_SIZE,
+				       VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
+				       &kuser_helpers_spec);
+	return PTR_ERR_OR_ZERO(ret);
+}
+
+int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	struct mm_struct *mm = current->mm;
+	int ret;
+
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
-	current->mm->context.vdso = (void *)addr;
 
-	/* Map vectors page at the high address. */
-	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
-				       VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
-				       &spec);
+	ret = sigreturn_setup(mm);
+	if (ret)
+		goto out;
 
-	up_write(&mm->mmap_sem);
+	ret = kuser_helpers_setup(mm);
 
-	return PTR_ERR_OR_ZERO(ret);
+out:
+	up_write(&mm->mmap_sem);
+	return ret;
 }
+
 #endif /* CONFIG_COMPAT */
 
 static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
