From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Tue,  6 Dec 2016 16:03:46 +0000
Subject: [RFC PATCH v3 04/11] arm64: Refactor vDSO init/setup
In-Reply-To: <20161206160353.14581-1-kevin.brodsky@arm.com>
References: <20161206160353.14581-1-kevin.brodsky@arm.com>
Message-ID: <20161206160353.14581-5-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the logic for setting up mappings and pages for the vDSO into
static functions. This makes the vDSO setup code more consistent with
the compat side and will allow to reuse it for the future compat vDSO.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: Christopher Covington <cov@codeaurora.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/kernel/vdso.c | 170 +++++++++++++++++++++++++++--------------------
 1 file changed, 99 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index d189e5be5039..4d3048619be8 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -39,8 +39,10 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
-extern char vdso_start, vdso_end;
-static unsigned long vdso_pages __ro_after_init;
+struct vdso_mappings {
+	unsigned long num_code_pages;
+	struct vm_special_mapping data_mapping, code_mapping;
+};
 
 /*
  * The vDSO data page.
@@ -51,6 +53,93 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = &vdso_data_store.data;
 
+static int __init vdso_mappings_init(const char *name,
+				      const char *code_start,
+				      const char *code_end,
+				      struct vdso_mappings *mappings)
+{
+	unsigned long i, num_code_pages;
+	struct page **pages;
+
+	if (memcmp(code_start, "\177ELF", 4)) {
+		pr_err("%s is not a valid ELF object!\n", name);
+		return -EINVAL;
+	}
+
+	num_code_pages = (code_end - code_start) >> PAGE_SHIFT;
+	pr_info("%s: %ld pages (%ld code @ %p, %ld data @ %p)\n",
+		name, num_code_pages + 1, num_code_pages, code_start, 1L,
+		vdso_data);
+
+	/*
+	 * Allocate space for storing pointers to the vDSO code pages + the
+	 * data page. The pointers must have the same lifetime as the mappings,
+	 * which are static, so there is no need to keep track of the pointer
+	 * array to free it.
+	 */
+	pages = kmalloc_array(num_code_pages + 1, sizeof(struct page *),
+			      GFP_KERNEL);
+	if (pages == NULL)
+		return -ENOMEM;
+
+	/* Grab the vDSO data page */
+	pages[0] = pfn_to_page(PHYS_PFN(__pa(vdso_data)));
+
+	/* Grab the vDSO code pages */
+	for (i = 0; i < num_code_pages; i++)
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
+	mappings->num_code_pages = num_code_pages;
+	return 0;
+}
+
+static int vdso_setup(struct mm_struct *mm,
+		      const struct vdso_mappings *mappings)
+{
+	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
+	void *ret;
+
+	vdso_text_len = mappings->num_code_pages << PAGE_SHIFT;
+	/* Be sure to map the data page */
+	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+
+	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
+	if (IS_ERR_VALUE(vdso_base)) {
+		ret = ERR_PTR(vdso_base);
+		goto out;
+	}
+
+	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
+				       VM_READ|VM_MAYREAD,
+				       &mappings->data_mapping);
+	if (IS_ERR(ret))
+		goto out;
+
+	vdso_base += PAGE_SIZE;
+	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
+				       VM_READ|VM_EXEC|
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       &mappings->code_mapping);
+	if (IS_ERR(ret))
+		goto out;
+
+	mm->context.vdso = (void *)vdso_base;
+
+out:
+	return PTR_ERR_OR_ZERO(ret);
+}
+
 #ifdef CONFIG_COMPAT
 
 /* sigreturn trampolines page */
@@ -175,90 +264,29 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 #endif /* CONFIG_COMPAT */
 
-static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
-	{
-		.name	= "[vvar]",
-	},
-	{
-		.name	= "[vdso]",
-	},
-};
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
+	extern char vdso_start, vdso_end;
 
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
+	return vdso_mappings_init("vdso", &vdso_start, &vdso_end,
+				   &vdso_mappings);
 }
 arch_initcall(vdso_init);
 
-int arch_setup_additional_pages(struct linux_binprm *bprm,
-				int uses_interp)
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
-	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
-	void *ret;
-
-	vdso_text_len = vdso_pages << PAGE_SHIFT;
-	/* Be sure to map the data page */
-	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+	int ret;
 
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
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
 
+	ret = vdso_setup(mm, &vdso_mappings);
 
 	up_write(&mm->mmap_sem);
-	return 0;
-
-up_fail:
-	mm->context.vdso = NULL;
-	up_write(&mm->mmap_sem);
-	return PTR_ERR(ret);
+	return ret;
 }
 
 /*
-- 
2.10.2
