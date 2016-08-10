From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 10 Aug 2016 15:19:18 +0800
Subject: [PATCH 2/3] arm64: vdso: put read only/mostly objects into proper
 sections
In-Reply-To: <1470813559-2917-1-git-send-email-jszhang@marvell.com>
References: <1470813559-2917-1-git-send-email-jszhang@marvell.com>
Message-ID: <1470813559-2917-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vdso_pages and vdso_spec are initialized by vdso_init(), thereafter are
mostly read during vdso special mapping handling.

vectors_page is initialized by alloc_vectors_page(), thereafter is
mostly read during aarch32 vectors special mapping handling.

The fact that they are mostly read and not written to makes them
candidates for __read_mostly declarations.

The vm_special_mapping spec is never modified, so mark it as const.

This patch also removes global vdso_pagelist.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/vdso.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e320e8f..e62da76 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -37,8 +37,7 @@
 #include <asm/vdso_datapage.h>
 
 extern char vdso_start, vdso_end;
-static unsigned long vdso_pages;
-static struct page **vdso_pagelist;
+static unsigned long vdso_pages __read_mostly;
 
 /*
  * The vDSO data page.
@@ -53,7 +52,7 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
-static struct page *vectors_page[1];
+static struct page *vectors_page[1] __read_mostly;
 
 static int __init alloc_vectors_page(void)
 {
@@ -88,7 +87,7 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = AARCH32_VECTORS_BASE;
-	static struct vm_special_mapping spec = {
+	static const struct vm_special_mapping spec = {
 		.name	= "[vectors]",
 		.pages	= vectors_page,
 
@@ -110,11 +109,19 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 }
 #endif /* CONFIG_COMPAT */
 
-static struct vm_special_mapping vdso_spec[2];
+static struct vm_special_mapping vdso_spec[2] __read_mostly = {
+	{
+		.name	= "[vvar]",
+	},
+	{
+		.name	= "[vdso]",
+	},
+};
 
 static int __init vdso_init(void)
 {
 	int i;
+	struct page **vdso_pagelist;
 
 	if (memcmp(&vdso_start, "\177ELF", 4)) {
 		pr_err("vDSO is not a valid ELF object!\n");
@@ -138,16 +145,8 @@ static int __init vdso_init(void)
 	for (i = 0; i < vdso_pages; i++)
 		vdso_pagelist[i + 1] = pfn_to_page(PHYS_PFN(__pa(&vdso_start)) + i);
 
-	/* Populate the special mapping structures */
-	vdso_spec[0] = (struct vm_special_mapping) {
-		.name	= "[vvar]",
-		.pages	= vdso_pagelist,
-	};
-
-	vdso_spec[1] = (struct vm_special_mapping) {
-		.name	= "[vdso]",
-		.pages	= &vdso_pagelist[1],
-	};
+	vdso_spec[0].pages = vdso_pagelist;
+	vdso_spec[1].pages = &vdso_pagelist[1];
 
 	return 0;
 }
-- 
2.8.1
