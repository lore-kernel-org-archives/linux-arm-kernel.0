From: salyzyn@android.com (Mark Salyzyn)
Date: Mon,  1 Oct 2018 10:58:40 -0700
Subject: RESEND [PATCH 3/6] arm64: Refactor vDSO init/setup
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
Message-ID: <20181001175845.168430-21-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

Move the logic for setting up mappings and pages for the vDSO into
static functions. This makes the vDSO setup code more consistent with
the compat side and will allow to reuse it for the future compat vDSO.

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
 arch/arm64/kernel/vdso.c | 118 +++++++++++++++++++++++----------------
 1 file changed, 70 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 76a94bed4bd5..8529e85a521f 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -39,8 +39,11 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
-extern char vdso_start[], vdso_end[];
-static unsigned long vdso_pages __ro_after_init;
+struct vdso_mappings {
+	unsigned long num_code_pages;
+	struct vm_special_mapping data_mapping;
+	struct vm_special_mapping code_mapping;
+};
 
 /*
  * The vDSO data page.
@@ -164,95 +167,114 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
-static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
-	{
-		.name	= "[vvar]",
-	},
-	{
-		.name	= "[vdso]",
-		.mremap = vdso_mremap,
-	},
-};
-
-static int __init vdso_init(void)
+static int __init vdso_mappings_init(const char *name,
+				     const char *code_start,
+				     const char *code_end,
+				     struct vdso_mappings *mappings)
 {
-	int i;
+	unsigned long i, vdso_page;
 	struct page **vdso_pagelist;
 	unsigned long pfn;
 
-	if (memcmp(vdso_start, "\177ELF", 4)) {
-		pr_err("vDSO is not a valid ELF object!\n");
+	if (memcmp(code_start, "\177ELF", 4)) {
+		pr_err("%s is not a valid ELF object!\n", name);
 		return -EINVAL;
 	}
 
-	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
-	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
-		vdso_pages + 1, vdso_pages, vdso_start, 1L, vdso_data);
-
-	/* Allocate the vDSO pagelist, plus a page for the data. */
-	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
-				GFP_KERNEL);
+	vdso_pages = (code_end - code_start) >> PAGE_SHIFT;
+	pr_info("%s: %ld pages (%ld code @ %p, %ld data @ %p)\n",
+		name, vdso_pages + 1, vdso_pages, code_start, 1L,
+		vdso_data);
+
+	/*
+	 * Allocate space for storing pointers to the vDSO code pages + the
+	 * data page. The pointers must have the same lifetime as the mappings,
+	 * which are static, so there is no need to keep track of the pointer
+	 * array to free it.
+	 */
+	vdso_pagelist = kmalloc_array(vdso_pages + 1, sizeof(struct page *),
+				      GFP_KERNEL);
 	if (vdso_pagelist == NULL)
 		return -ENOMEM;
 
 	/* Grab the vDSO data page. */
 	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
 
-
 	/* Grab the vDSO code pages. */
-	pfn = sym_to_pfn(vdso_start);
+	pfn = sym_to_pfn(code_start);
 
 	for (i = 0; i < vdso_pages; i++)
 		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
 
-	vdso_spec[0].pages = &vdso_pagelist[0];
-	vdso_spec[1].pages = &vdso_pagelist[1];
+	/* Populate the special mapping structures */
+	mappings->data_mapping = (struct vm_special_mapping) {
+		.name	= "[vvar]",
+		.pages	= &vdso_pagelist[0],
+	};
+
+	mappings->code_mapping = (struct vm_special_mapping) {
+		.name	= "[vdso]",
+		.pages	= &vdso_pagelist[1],
+	};
 
+	mappings->num_code_pages = vdso_pages;
 	return 0;
 }
+
+static struct vdso_mappings vdso_mappings __ro_after_init;
+
+static int __init vdso_init(void)
+{
+	extern char vdso_start[], vdso_end[];
+
+	return vdso_mappings_init("vdso", vdso_start, vdso_end,
+				  &vdso_mappings);
+}
 arch_initcall(vdso_init);
 
-int arch_setup_additional_pages(struct linux_binprm *bprm,
-				int uses_interp)
+static int vdso_setup(struct mm_struct *mm,
+		      const struct vdso_mappings *mappings)
 {
-	struct mm_struct *mm = current->mm;
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	void *ret;
 
-	vdso_text_len = vdso_pages << PAGE_SHIFT;
+	vdso_text_len = mappings->num_code_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
 	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
 
-	if (down_write_killable(&mm->mmap_sem))
-		return -EINTR;
 	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
-	if (IS_ERR_VALUE(vdso_base)) {
-		ret = ERR_PTR(vdso_base);
-		goto up_fail;
-	}
+	if (IS_ERR_VALUE(vdso_base))
+		ret = PTR_ERR_OR_ZERO(ERR_PTR(vdso_base));
+
 	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
 				       VM_READ|VM_MAYREAD,
-				       &vdso_spec[0]);
+				       &mappings->data_mapping);
 	if (IS_ERR(ret))
-		goto up_fail;
+		return PTR_ERR_OR_ZERO(ret);
 
 	vdso_base += PAGE_SIZE;
-	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|
 				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
-				       &vdso_spec[1]);
-	if (IS_ERR(ret))
-		goto up_fail;
+				       &mappings->code_mapping);
+	if (!IS_ERR(ret))
+		mm->context.vdso = (void *)vdso_base;
+
+	return PTR_ERR_OR_ZERO(ret);
+}
 
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	struct mm_struct *mm = current->mm;
+	int ret;
 
-	up_write(&mm->mmap_sem);
-	return 0;
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	ret = vdso_setup(mm, &vdso_mappings);
 
-up_fail:
-	mm->context.vdso = NULL;
 	up_write(&mm->mmap_sem);
-	return PTR_ERR(ret);
+	return ret;
 }
 
 /*
-- 
2.19.0.605.g01d371f741-goog
