From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Nov 2015 12:23:17 +0100
Subject: [PATCH v3 6/7] arm64: map linear region as non-executable
In-Reply-To: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1447672998-20981-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we moved the kernel text out of the linear region, there
is no longer a reason to map the linear region as executable. This
also allows us to completely get rid of the __map_mem() variant that
only maps some of it executable if CONFIG_DEBUG_RODATA is selected.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 41 +-------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c7ba171951c8..526eeb7e1e97 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -357,47 +357,10 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 				phys, virt, size, prot, late_alloc);
 }
 
-#ifdef CONFIG_DEBUG_RODATA
 static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
 {
-	/*
-	 * Set up the executable regions using the existing section mappings
-	 * for now. This will get more fine grained later once all memory
-	 * is mapped
-	 */
-	unsigned long kernel_x_start = round_down(__pa(_stext), SWAPPER_BLOCK_SIZE);
-	unsigned long kernel_x_end = round_up(__pa(__init_end), SWAPPER_BLOCK_SIZE);
-
-	if (end < kernel_x_start) {
-		create_mapping(start, __phys_to_virt(start),
-			end - start, PAGE_KERNEL);
-	} else if (start >= kernel_x_end) {
-		create_mapping(start, __phys_to_virt(start),
-			end - start, PAGE_KERNEL);
-	} else {
-		if (start < kernel_x_start)
-			create_mapping(start, __phys_to_virt(start),
-				kernel_x_start - start,
-				PAGE_KERNEL);
-		create_mapping(kernel_x_start,
-				__phys_to_virt(kernel_x_start),
-				kernel_x_end - kernel_x_start,
-				PAGE_KERNEL_EXEC);
-		if (kernel_x_end < end)
-			create_mapping(kernel_x_end,
-				__phys_to_virt(kernel_x_end),
-				end - kernel_x_end,
-				PAGE_KERNEL);
-	}
-
-}
-#else
-static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
-{
-	create_mapping(start, __phys_to_virt(start), end - start,
-			PAGE_KERNEL_EXEC);
+	create_mapping(start, __phys_to_virt(start), end - start, PAGE_KERNEL);
 }
-#endif
 
 struct bootstrap_pgtables {
 	pte_t	pte[PTRS_PER_PTE];
@@ -471,7 +434,7 @@ static unsigned long __init bootstrap_region(struct bootstrap_pgtables *reg,
 				      SWAPPER_BLOCK_SIZE));
 
 		create_mapping(__pa(vstart - va_offset), vstart, vend - vstart,
-			       PAGE_KERNEL_EXEC);
+			       PAGE_KERNEL);
 
 		return vend;
 	}
-- 
1.9.1
