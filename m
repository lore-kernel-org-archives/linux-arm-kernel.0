From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu, 27 Oct 2016 17:30:51 +0100
Subject: [RFC PATCH v2 1/8] arm64: Refactor vDSO setup
In-Reply-To: <20161027163058.12156-1-kevin.brodsky@arm.com>
References: <20161027163058.12156-1-kevin.brodsky@arm.com>
Message-ID: <20161027163058.12156-2-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the logic for setting up mappings and pages for the vDSO into
static functions with a clear interface. This will allow to reuse the
setup code for the future compat vDSO.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/kernel/vdso.c | 177 ++++++++++++++++++++++++++---------------------
 1 file changed, 98 insertions(+), 79 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a2c2478e7d78..c239b1c15eb3 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -37,8 +37,10 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
-extern char vdso_start, vdso_end;
-static unsigned long vdso_pages __ro_after_init;
+struct vdso_mappings {
+	unsigned long num_pages;
+	struct vm_special_mapping data_mapping, code_mapping;
+};
 
 /*
  * The vDSO data page.
@@ -49,6 +51,92 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = &vdso_data_store.data;
 
+static int __init setup_vdso_mappings(const char *name,
+				      const char *code_start,
+				      const char *code_end,
+				      struct vdso_mappings *mappings)
+{
+	unsigned long i, num_pages;
+	struct page **pages;
+
+	if (memcmp(code_start, "\177ELF", 4)) {
+		pr_err("%s is not a valid ELF object!\n", name);
+		return -EINVAL;
+	}
+
+	num_pages = (code_end - code_start) >> PAGE_SHIFT;
+	pr_info("%s: %ld pages (%ld code @ %p, %ld data @ %p)\n",
+		name, num_pages + 1, num_pages, code_start, 1L, vdso_data);
+
+	/* Allocate the vDSO code pages, plus a page for the data. */
+	pages = kcalloc(num_pages + 1, sizeof(struct page *), GFP_KERNEL);
+	if (pages == NULL)
+		return -ENOMEM;
+
+	/* Grab the vDSO data page. */
+	pages[0] = pfn_to_page(PHYS_PFN(__pa(vdso_data)));
+
+	/* Grab the vDSO code pages. */
+	for (i = 0; i < num_pages; i++)
+		pages[i + 1] = pfn_to_page(PHYS_PFN(__pa(code_start)) + i);
+
+	/* Populate the special mapping structures */
+	mappings->data_mapping = (struct vm_special_mapping) {
+		.name	= "[vvar]",
+		.pages	= &pages[0],
+	};
+
+	mappings->code_mapping = (struct vm_special_mapping) {
+		.name	= "[vdso]",
+		.pages	= &pages[1],
+	};
+
+	mappings->num_pages = num_pages;
+	return 0;
+}
+
+static int setup_vdso_pages(const struct vdso_mappings *mappings)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
+	void *ret;
+
+	vdso_text_len = mappings->num_pages << PAGE_SHIFT;
+	/* Be sure to map the data page */
+	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
+	if (IS_ERR_VALUE(vdso_base)) {
+		ret = ERR_PTR(vdso_base);
+		goto up_fail;
+	}
+	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
+				       VM_READ|VM_MAYREAD,
+				       &mappings->data_mapping);
+	if (IS_ERR(ret))
+		goto up_fail;
+
+	vdso_base += PAGE_SIZE;
+	mm->context.vdso = (void *)vdso_base;
+	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
+				       VM_READ|VM_EXEC|
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       &mappings->code_mapping);
+	if (IS_ERR(ret))
+		goto up_fail;
+
+
+	up_write(&mm->mmap_sem);
+	return 0;
+
+up_fail:
+	mm->context.vdso = NULL;
+	up_write(&mm->mmap_sem);
+	return PTR_ERR(ret);
+}
+
 #ifdef CONFIG_COMPAT
 /*
  * Create and map the vectors page for AArch32 tasks.
@@ -71,11 +159,11 @@ static int __init alloc_vectors_page(void)
 
 	/* kuser helpers */
 	memcpy((void *)vpage + 0x1000 - kuser_sz, __kuser_helper_start,
-		kuser_sz);
+	       kuser_sz);
 
 	/* sigreturn code */
 	memcpy((void *)vpage + AARCH32_KERN_SIGRET_CODE_OFFSET,
-               __aarch32_sigret_code_start, sigret_sz);
+	       __aarch32_sigret_code_start, sigret_sz);
 
 	flush_icache_range(vpage, vpage + PAGE_SIZE);
 	vectors_page[0] = virt_to_page(vpage);
@@ -110,90 +198,21 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 }
 #endif /* CONFIG_COMPAT */
 
-static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
-	{
-		.name	= "[vvar]",
-	},
-	{
-		.name	= "[vdso]",
-	},
-};
+extern char vdso_start, vdso_end;
+
+static struct vdso_mappings vdso_mappings __ro_after_init;
 
 static int __init vdso_init(void)
 {
-	int i;
-	struct page **vdso_pagelist;
-
-	if (memcmp(&vdso_start, "\177ELF", 4)) {
-		pr_err("vDSO is not a valid ELF object!\n");
-		return -EINVAL;
-	}
-
-	vdso_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
-	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
-		vdso_pages + 1, vdso_pages, &vdso_start, 1L, vdso_data);
-
-	/* Allocate the vDSO pagelist, plus a page for the data. */
-	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
-				GFP_KERNEL);
-	if (vdso_pagelist == NULL)
-		return -ENOMEM;
-
-	/* Grab the vDSO data page. */
-	vdso_pagelist[0] = pfn_to_page(PHYS_PFN(__pa(vdso_data)));
-
-	/* Grab the vDSO code pages. */
-	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i + 1] = pfn_to_page(PHYS_PFN(__pa(&vdso_start)) + i);
-
-	vdso_spec[0].pages = &vdso_pagelist[0];
-	vdso_spec[1].pages = &vdso_pagelist[1];
-
-	return 0;
+	return setup_vdso_mappings("vdso", &vdso_start, &vdso_end,
+				   &vdso_mappings);
 }
 arch_initcall(vdso_init);
 
 int arch_setup_additional_pages(struct linux_binprm *bprm,
 				int uses_interp)
 {
-	struct mm_struct *mm = current->mm;
-	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
-	void *ret;
-
-	vdso_text_len = vdso_pages << PAGE_SHIFT;
-	/* Be sure to map the data page */
-	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
-
-	if (down_write_killable(&mm->mmap_sem))
-		return -EINTR;
-	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
-	if (IS_ERR_VALUE(vdso_base)) {
-		ret = ERR_PTR(vdso_base);
-		goto up_fail;
-	}
-	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
-				       VM_READ|VM_MAYREAD,
-				       &vdso_spec[0]);
-	if (IS_ERR(ret))
-		goto up_fail;
-
-	vdso_base += PAGE_SIZE;
-	mm->context.vdso = (void *)vdso_base;
-	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
-				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
-				       &vdso_spec[1]);
-	if (IS_ERR(ret))
-		goto up_fail;
-
-
-	up_write(&mm->mmap_sem);
-	return 0;
-
-up_fail:
-	mm->context.vdso = NULL;
-	up_write(&mm->mmap_sem);
-	return PTR_ERR(ret);
+	return setup_vdso_pages(&vdso_mappings);
 }
 
 /*
-- 
2.10.0
