From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Tue, 11 Feb 2014 16:28:42 -0600
Subject: [PATCH] arm64: vdso: clean up vdso_pagelist initialization
Message-ID: <1392157722-6372-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove some unnecessary bits that were apparently carried over from
another architecture's implementation:

- No need to get_page() the vdso text/data - these are part of the
  kernel image.
- No need for ClearPageReserved on the vdso text.
- No need to vmap the first text page to check the ELF header - this
  can be done through &vdso_start.

Also some minor cleanup:
- Use kcalloc for vdso_pagelist array allocation.
- Don't print on allocation failure, slab/slub will do that for us.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm64/kernel/vdso.c | 42 ++++++++++++------------------------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a7149cae1615..50384fec56c4 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -106,49 +106,31 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 
 static int __init vdso_init(void)
 {
-	struct page *pg;
-	char *vbase;
-	int i, ret = 0;
+	int i;
+
+	if (memcmp(&vdso_start, "\177ELF", 4)) {
+		pr_err("vDSO is not a valid ELF object!\n");
+		return -EINVAL;
+	}
 
 	vdso_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
 	pr_info("vdso: %ld pages (%ld code, %ld data) at base %p\n",
 		vdso_pages + 1, vdso_pages, 1L, &vdso_start);
 
 	/* Allocate the vDSO pagelist, plus a page for the data. */
-	vdso_pagelist = kzalloc(sizeof(struct page *) * (vdso_pages + 1),
+	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
 				GFP_KERNEL);
-	if (vdso_pagelist == NULL) {
-		pr_err("Failed to allocate vDSO pagelist!\n");
+	if (vdso_pagelist == NULL)
 		return -ENOMEM;
-	}
 
 	/* Grab the vDSO code pages. */
-	for (i = 0; i < vdso_pages; i++) {
-		pg = virt_to_page(&vdso_start + i*PAGE_SIZE);
-		ClearPageReserved(pg);
-		get_page(pg);
-		vdso_pagelist[i] = pg;
-	}
-
-	/* Sanity check the shared object header. */
-	vbase = vmap(vdso_pagelist, 1, 0, PAGE_KERNEL);
-	if (vbase == NULL) {
-		pr_err("Failed to map vDSO pagelist!\n");
-		return -ENOMEM;
-	} else if (memcmp(vbase, "\177ELF", 4)) {
-		pr_err("vDSO is not a valid ELF object!\n");
-		ret = -EINVAL;
-		goto unmap;
-	}
+	for (i = 0; i < vdso_pages; i++)
+		vdso_pagelist[i] = virt_to_page(&vdso_start + i * PAGE_SIZE);
 
 	/* Grab the vDSO data page. */
-	pg = virt_to_page(vdso_data);
-	get_page(pg);
-	vdso_pagelist[i] = pg;
+	vdso_pagelist[i] = virt_to_page(vdso_data);
 
-unmap:
-	vunmap(vbase);
-	return ret;
+	return 0;
 }
 arch_initcall(vdso_init);
 
-- 
1.8.3.1
