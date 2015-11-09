From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  9 Nov 2015 09:55:46 +0100
Subject: [PATCH 2/2] arm64: fix R/O permissions of FDT mapping
In-Reply-To: <1447059346-12050-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1447059346-12050-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1447059346-12050-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mapping permissions of the FDT are set to 'PAGE_KERNEL | PTE_RDONLY'
in an attempt to map the FDT as read-only. However, not only does this
break at build time under STRICT_MM_TYPECHECKS (since the two terms are
of different types in that case), it also results in both the PTE_WRITE
and PTE_RDONLY attributes to be set, which means the region is still
writable under ARMv8.1 DBM (and an attempted write will simply clear the
PT_RDONLY bit).

So instead, define PAGE_KERNEL_RO (which already has an established
meaning across architectures) and use that instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/pgtable.h | 1 +
 arch/arm64/mm/mmu.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f3acf421ded4..9819a9426b69 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -80,6 +80,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 #define _PAGE_DEFAULT		(PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
 
 #define PAGE_KERNEL		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE)
+#define PAGE_KERNEL_RO		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
 #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
 #define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 46a2b8805c97..7471f08b1d98 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -755,7 +755,7 @@ void __set_fixmap(enum fixed_addresses idx,
 void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
 {
 	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
-	pgprot_t prot = PAGE_KERNEL | PTE_RDONLY;
+	pgprot_t prot = PAGE_KERNEL_RO;
 	int size, offset;
 	void *dt_virt;
 
-- 
1.9.1
