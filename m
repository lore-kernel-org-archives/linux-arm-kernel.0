From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  1 Aug 2016 13:29:31 +0200
Subject: [PATCH] arm64: mm: avoid fdt_check_header() before the FDT is fully
 mapped
Message-ID: <1470050971-30103-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported by Zijun, the fdt_check_header() call in __fixmap_remap_fdt()
is not safe since it is not guaranteed that the FDT header is mapped
completely. Due to the minimum alignment of 8 bytes, the only fields we
can assume to be mapped are 'magic' and 'totalsize'.

Since the OF layer is in charge of validating the FDT image, and we are
only interested in making reasonably sure that the size field contains
a meaningful value, replace the fdt_check_header() call with an explicit
comparison of the magic field's value against the expected value.

Reported-by: Zijun Hu <zijun_hu@htc.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0f85a46c3e18..3e90a2cad995 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -748,9 +748,9 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	/*
 	 * Check whether the physical FDT address is set and meets the minimum
 	 * alignment requirement. Since we are relying on MIN_FDT_ALIGN to be
-	 * at least 8 bytes so that we can always access the size field of the
-	 * FDT header after mapping the first chunk, double check here if that
-	 * is indeed the case.
+	 * at least 8 bytes so that we can always access the magic and size
+	 * fields of the FDT header after mapping the first chunk, double check
+	 * here if that is indeed the case.
 	 */
 	BUILD_BUG_ON(MIN_FDT_ALIGN < 8);
 	if (!dt_phys || dt_phys % MIN_FDT_ALIGN)
@@ -778,7 +778,7 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	create_mapping_noalloc(round_down(dt_phys, SWAPPER_BLOCK_SIZE),
 			dt_virt_base, SWAPPER_BLOCK_SIZE, prot);
 
-	if (fdt_check_header(dt_virt) != 0)
+	if (fdt_magic(dt_virt) != FDT_MAGIC)
 		return NULL;
 
 	*size = fdt_totalsize(dt_virt);
-- 
2.7.4
