From: james.morse@arm.com (James Morse)
Date: Mon,  6 Nov 2017 18:44:26 +0000
Subject: [PATCH 3/4] arm64: mm: Remove arch_apei_flush_tlb_one()
In-Reply-To: <20171106184427.31905-1-james.morse@arm.com>
References: <20171106184427.31905-1-james.morse@arm.com>
Message-ID: <20171106184427.31905-4-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing calls arch_apei_flush_tlb_one() anymore, instead relying on
__set_fixmap() to do the invalidation. Remove it.

Move the IPI-considered-harmful comment to __set_fixmap().

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 arch/arm64/include/asm/acpi.h | 12 ------------
 arch/arm64/mm/mmu.c           |  4 ++++
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 59cca1d6ec54..32f465a80e4e 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -126,18 +126,6 @@ static inline const char *acpi_get_enable_method(int cpu)
  */
 #define acpi_disable_cmcff 1
 pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
-
-/*
- * Despite its name, this function must still broadcast the TLB
- * invalidation in order to ensure other CPUs don't end up with junk
- * entries as a result of speculation. Unusually, its also called in
- * IRQ context (ghes_iounmap_irq) so if we ever need to use IPIs for
- * TLB broadcasting, then we're in trouble here.
- */
-static inline void arch_apei_flush_tlb_one(unsigned long addr)
-{
-	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-}
 #endif /* CONFIG_ACPI_APEI */
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f1eb15e0e864..267d2b79d52d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -778,6 +778,10 @@ void __init early_fixmap_init(void)
 	}
 }
 
+/*
+ * Unusually, this is also called in IRQ context (ghes_iounmap_irq) so if we
+ * ever need to use IPIs for TLB broadcasting, then we're in trouble here.
+ */
 void __set_fixmap(enum fixed_addresses idx,
 			       phys_addr_t phys, pgprot_t flags)
 {
-- 
2.15.0.rc2
