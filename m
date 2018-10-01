From: salyzyn@android.com (Mark Salyzyn)
Date: Mon,  1 Oct 2018 10:58:42 -0700
Subject: RESEND [PATCH 5/6] arm64: compat: 32-bit vDSO setup
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
Message-ID: <20181001175845.168430-23-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

If the compat vDSO is enabled, install it in compat processes. In this
case, the compat vDSO replaces the sigreturn page (it provides its own
sigreturn trampolines).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel at android.com
---
 arch/arm64/kernel/vdso.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 8529e85a521f..9fb1e0d380ab 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -58,6 +58,7 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
+#if !defined(CONFIG_VDSO32) || defined(CONFIG_KUSER_HELPERS)
 static struct page *vectors_page[] __ro_after_init;
 static const struct vm_special_mapping compat_vdso_spec[] = {
 	{
@@ -73,6 +74,7 @@ static const struct vm_special_mapping compat_vdso_spec[] = {
 #endif
 };
 static struct page *vectors_page[ARRAY_SIZE(compat_vdso_spec)] __ro_after_init;
+#endif
 
 static int __init alloc_vectors_page(void)
 {
@@ -82,6 +84,7 @@ static int __init alloc_vectors_page(void)
 	unsigned long kuser_vpage;
 #endif
 
+#ifndef CONFIG_VDSO32
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
 	size_t sigret_sz =
 		__aarch32_sigret_code_end - __aarch32_sigret_code_start;
@@ -90,19 +93,24 @@ static int __init alloc_vectors_page(void)
 	sigret_vpage = get_zeroed_page(GFP_ATOMIC);
 	if (!sigret_vpage)
 		return -ENOMEM;
+#endif
 
 #ifdef CONFIG_KUSER_HELPERS
 	kuser_vpage = get_zeroed_page(GFP_ATOMIC);
 	if (!kuser_vpage) {
+#ifndef CONFIG_VDSO32
 		free_page(sigret_vpage);
+#endif
 		return -ENOMEM;
 	}
 #endif
 
+#ifndef CONFIG_VDSO32
 	/* sigreturn code */
 	memcpy((void *)sigret_vpage, __aarch32_sigret_code_start, sigret_sz);
 	flush_icache_range(sigret_vpage, sigret_vpage + PAGE_SIZE);
 	vectors_page[0] = virt_to_page(sigret_vpage);
+#endif
 
 #ifdef CONFIG_KUSER_HELPERS
 	/* kuser helpers */
@@ -116,6 +124,7 @@ static int __init alloc_vectors_page(void)
 }
 arch_initcall(alloc_vectors_page);
 
+#ifndef CONFIG_VDSO32
 int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
@@ -151,6 +160,7 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 
 	return PTR_ERR_OR_ZERO(ret);
 }
+#endif /* !CONFIG_VDSO32 */
 #endif /* CONFIG_COMPAT */
 
 static int vdso_mremap(const struct vm_special_mapping *sm,
@@ -221,6 +231,23 @@ static int __init vdso_mappings_init(const char *name,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+#ifdef CONFIG_VDSO32
+
+static struct vdso_mappings vdso32_mappings __ro_after_init;
+
+static int __init vdso32_init(void)
+{
+	extern char vdso32_start[], vdso32_end[];
+
+	return vdso_mappings_init("vdso32", vdso32_start, vdso32_end,
+				  &vdso32_mappings);
+}
+arch_initcall(vdso32_init);
+
+#endif /* CONFIG_VDSO32 */
+#endif /* CONFIG_COMPAT */
+
 static struct vdso_mappings vdso_mappings __ro_after_init;
 
 static int __init vdso_init(void)
@@ -263,6 +290,34 @@ static int vdso_setup(struct mm_struct *mm,
 	return PTR_ERR_OR_ZERO(ret);
 }
 
+#ifdef CONFIG_COMPAT
+#ifdef CONFIG_VDSO32
+int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
+{
+	struct mm_struct *mm = current->mm;
+	void *ret;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	ret = ERR_PTR(vdso_setup(mm, &vdso32_mappings));
+#ifdef CONFIG_KUSER_HELPERS
+	if (!IS_ERR(ret))
+		/* Map the kuser helpers at the ABI-defined high address. */
+		ret = _install_special_mapping(mm, AARCH32_KUSER_HELPERS_BASE,
+					       PAGE_SIZE,
+					       VM_READ|VM_EXEC|
+					       VM_MAYREAD|VM_MAYEXEC,
+					       &compat_vdso_spec[1]);
+#endif
+
+	up_write(&mm->mmap_sem);
+
+	return PTR_ERR_OR_ZERO(ret);
+}
+#endif /* CONFIG_VDSO32 */
+#endif /* CONFIG_COMPAT */
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
-- 
2.19.0.605.g01d371f741-goog
