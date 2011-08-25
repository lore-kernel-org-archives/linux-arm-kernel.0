From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 25 Aug 2011 13:32:42 +0100
Subject: [PATCH] ARM: mm: keep significant bits in pfn_valid
Message-ID: <1314275562-31797-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When ARCH_HAS_HOLES_MEMORYMODEL is selected, pfn_valid calls
memblock_is_memory to test validity of a pfn:

> memblock_is_memory(pfn << PAGE_SHIFT);

On LPAE systems this cuts off the top bits, as the shift occurs before
the value is promoted to a phys_addr_t.

This patch replaces the shift with a call to __pfn_to_phys (which casts
pfn to phys_addr_t before shifting), preventing the loss of significant
bits.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 91bca35..cc7e2d8 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -298,7 +298,7 @@ static void __init arm_bootmem_free(unsigned long min, unsigned long max_low,
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
-	return memblock_is_memory(pfn << PAGE_SHIFT);
+	return memblock_is_memory(__pfn_to_phys(pfn));
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif
-- 
1.7.0.4
