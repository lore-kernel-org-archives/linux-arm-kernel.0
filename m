From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Aug 2017 16:23:51 +0200
Subject: [PATCH v2] ARM: vdso: Define vdso_{start,end} as array
Message-ID: <20170823142419.1811665-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-8 correctly points out that reading four bytes from a pointer to a
'char' variable is wrong

arch/arm/kernel/vdso.c: In function 'vdso_init':
arch/arm/kernel/vdso.c:200:6: error: '__builtin_memcmp_eq' reading 4 bytes from a region of size 1 [-Werror=stringop-overflow=]

However, in this case the variable just stands for the beginning of the
vdso and is not actually a 'char', so the code is doing what it is meant
to do.

This uses the same approach as arm64 and x86, declaring the addresses
as char arrays.

See also: dbbb08f500d6 ("arm64, vdso: Define vdso_{start,end} as array")

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/vdso.h |  2 +-
 arch/arm/kernel/vdso.c      | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
index d0295f1dd1a3..95b7a4dcd6d2 100644
--- a/arch/arm/include/asm/vdso.h
+++ b/arch/arm/include/asm/vdso.h
@@ -11,7 +11,7 @@ struct mm_struct;
 
 void arm_install_vdso(struct mm_struct *mm, unsigned long addr);
 
-extern char vdso_start, vdso_end;
+extern char vdso_start[], vdso_end[];
 
 extern unsigned int vdso_total_pages;
 
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index a4d6dc0f2427..f401b51d06ea 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -197,13 +197,13 @@ static int __init vdso_init(void)
 	unsigned int text_pages;
 	int i;
 
-	if (memcmp(&vdso_start, "\177ELF", 4)) {
+	if (memcmp(vdso_start, "\177ELF", 4)) {
 		pr_err("VDSO is not a valid ELF object!\n");
 		return -ENOEXEC;
 	}
 
-	text_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
-	pr_debug("vdso: %i text pages at base %p\n", text_pages, &vdso_start);
+	text_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
+	pr_debug("vdso: %i text pages at base %p\n", text_pages, vdso_start);
 
 	/* Allocate the VDSO text pagelist */
 	vdso_text_pagelist = kcalloc(text_pages, sizeof(struct page *),
@@ -218,7 +218,7 @@ static int __init vdso_init(void)
 	for (i = 0; i < text_pages; i++) {
 		struct page *page;
 
-		page = virt_to_page(&vdso_start + i * PAGE_SIZE);
+		page = virt_to_page(vdso_start + i * PAGE_SIZE);
 		vdso_text_pagelist[i] = page;
 	}
 
@@ -229,7 +229,7 @@ static int __init vdso_init(void)
 
 	cntvct_ok = cntvct_functional();
 
-	patch_vdso(&vdso_start);
+	patch_vdso(vdso_start);
 
 	return 0;
 }
-- 
2.9.0
