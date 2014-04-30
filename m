From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 30 Apr 2014 12:36:22 +0100
Subject: [PATCH] arm64: mm: Create gigabyte kernel logical mappings where
 possible
Message-ID: <1398857782-1525-1-git-send-email-steve.capper@linaro.org>
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
Hello,
This patch has been tested on the FastModel for 4K and 64K pages.
Also, this has been tested with Jungseok's 4 level patch.

I put in the explicit check for PAGE_SHIFT, as I am anticipating a
three level 64KB configuration at some point.

With two level 64K, a PUD is equivalent to a PMD which is equivalent to
a PGD, and these are all level 2 descriptors.

Under three level 64K, a PUD would be equivalent to a PGD which would
be a level 1 descriptor thus may not be a block.

Comments/critique/testers welcome.

Cheers,
-- 
Steve
---
 arch/arm64/mm/mmu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4d29332..867e979 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -234,7 +234,20 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
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
+			if (!pud_none(old_pud))
+				flush_tlb_all();
+		} else {
+			alloc_init_pmd(pud, addr, next, phys);
+		}
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
 }
-- 
1.8.1.4
