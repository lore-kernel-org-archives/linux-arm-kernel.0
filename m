From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  6 Nov 2014 15:13:26 +0100
Subject: [PATCH v2 10/10] arm64/efi: improve /dev/mem mmap() handling under
 UEFI
In-Reply-To: <1415283206-14713-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1415283206-14713-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1415283206-14713-11-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting via UEFI, we need to ensure that mappings of arbitrary
physical ranges through /dev/mem do not violate architectural rules
regarding conflicting cacheability attributes of overlapping regions.
Also, when CONFIG_STRICT_DEVMEM is in effect, memory regions with
special significance to UEFI should be protected sufficiently.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3e8b3732ca87..9ae3904f386c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -19,6 +19,7 @@
 
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/efi.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/mman.h>
@@ -28,6 +29,7 @@
 #include <linux/io.h>
 
 #include <asm/cputype.h>
+#include <asm/efi.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/sizes.h>
@@ -121,6 +123,8 @@ early_param("cachepolicy", early_cachepolicy);
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
+	if (efi_enabled(EFI_MEMMAP) && efi_mem_access_prot(pfn, &vma_prot))
+		return vma_prot;
 	if (!pfn_valid(pfn))
 		return pgprot_noncached(vma_prot);
 	else if (file->f_flags & O_SYNC)
@@ -129,6 +133,19 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
 
+/*
+ * This definition of phys_mem_access_prot_allowed() overrides
+ * the __weak definition in drivers/char/mem.c
+ */
+int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
+				 unsigned long size, pgprot_t *prot)
+{
+	if (efi_enabled(EFI_MEMMAP))
+		return efi_mem_access_allowed(pfn, size,
+					      pgprot_val(*prot) & PTE_WRITE);
+	return 1;
+}
+
 static void __init *early_alloc(unsigned long sz)
 {
 	void *ptr = __va(memblock_alloc(sz, sz));
-- 
1.8.3.2
