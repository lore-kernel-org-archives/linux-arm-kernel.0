From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 11 Feb 2017 20:23:03 +0000
Subject: [PATCH v2 2/5] arm64: mmu: move TLB maintenance from callers to
 create_mapping_late()
In-Reply-To: <1486844586-26135-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1486844586-26135-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1486844586-26135-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of changing the way we invoke create_mapping_late() (which
is currently invoked twice from the same function), move the TLB flushing
it performs from the caller into create_mapping_late() itself, and change
it to a TLB maintenance by VA rather than a full flush, which is more
appropriate here.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2131521ddc24..9e0ec1a8cd3b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -356,6 +356,9 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 
 	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
 			     NULL, debug_pagealloc_enabled());
+
+	/* flush the TLBs after updating live kernel mappings */
+	flush_tlb_kernel_range(virt, virt + size);
 }
 
 static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
@@ -438,9 +441,6 @@ void mark_rodata_ro(void)
 	create_mapping_late(__pa_symbol(__start_rodata), (unsigned long)__start_rodata,
 			    section_size, PAGE_KERNEL_RO);
 
-	/* flush the TLBs after updating live kernel mappings */
-	flush_tlb_all();
-
 	debug_checkwx();
 }
 
-- 
2.7.4
