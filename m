From: steve.capper@linaro.org (Steve Capper)
Date: Fri,  2 May 2014 16:17:09 +0100
Subject: [PATCH V2] arm64: mm: Create gigabyte kernel logical mappings where
 possible
Message-ID: <1399043829-9036-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have the capability to map 1GB level 1 blocks when using a 4K
granule.

This patch adjusts the create_mapping logic s.t. when mapping physical
memory on boot, we attempt to use a 1GB block if both the VA and PA
start and end are 1GB aligned. This both reduces the levels of lookup
required to resolve a kernel logical address, as well as reduces TLB
pressure on cores that support 1GB TLB entries.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
Changed in V2: free the original pmd table from swapper_pg_dir if we
replace it with a block pud entry.

Catalin,
pud_pfn would give us the pud pointed to by a huge pud. (so will
resolve to a gigabyte aligned address when << PAGE_SHIFTed).

What we want is the pointer to the pmd table. I've opted to go for
pmd_offset as it's easier to gauge intent.
(I know we convert from PA->VA->PA, but this will probably compile
out, and is done once on boot...).

I've tested this with 3 and 4 levels on the Model (and a load of debug
printing that I've removed from the patch).

Cheers,
-- 
Steve
---
 arch/arm64/mm/mmu.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4d29332..2ced5f6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -234,7 +234,30 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		alloc_init_pmd(pud, addr, next, phys);
+
+		/*
+		 * For 4K granule only, attempt to put down a 1GB block
+		 */
+		if ((PAGE_SHIFT == 12) &&
+			((addr | next | phys) & ~PUD_MASK) == 0) {
+			pud_t old_pud = *pud;
+			set_pud(pud, __pud(phys | prot_sect_kernel));
+
+			/*
+			 * If we have an old value for a pud, it will
+			 * be pointing to a pmd table that we no longer
+			 * need (from swapper_pg_dir).
+			 *
+			 * Look up the old pmd table and free it.
+			 */
+			if (!pud_none(old_pud)) {
+				phys_addr_t table = __pa(pmd_offset(&old_pud, 0));
+				memblock_free(table, PAGE_SIZE);
+				flush_tlb_all();
+			}
+		} else {
+			alloc_init_pmd(pud, addr, next, phys);
+		}
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
 }
-- 
1.8.1.4
