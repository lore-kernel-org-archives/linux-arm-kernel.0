From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Oct 2010 11:48:00 +0100
Subject: [PATCH] ARM: memblock: set allocation limit for
	MEMBLOCK_ALLOC_ANYWHERE
Message-ID: <20101025104800.6961.70715.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

Commit e63075a3 removed the explicit MEMBLOCK_REAL_LIMIT #define
and introduced the requirement that arch code calls
memblock_set_current_limit to ensure that the __va macro can
be used on physical addresses returned from memblock_alloc.

This patch ensures that memblock allocates from lowmem on ARM
by setting the allocation limit to lowmem_end_addr.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/memblock.h |    3 ---
 arch/arm/mm/mmu.c               |    1 +
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/memblock.h b/arch/arm/include/asm/memblock.h
index fdbc43b..655b4c4 100644
--- a/arch/arm/include/asm/memblock.h
+++ b/arch/arm/include/asm/memblock.h
@@ -3,9 +3,6 @@
 
 #ifdef CONFIG_MMU
 extern phys_addr_t lowmem_end_addr;
-#define MEMBLOCK_REAL_LIMIT	lowmem_end_addr
-#else
-#define MEMBLOCK_REAL_LIMIT	0
 #endif
 
 struct meminfo;
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 72cc529..fd7bb1e 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -753,6 +753,7 @@ static void __init sanity_check_meminfo(void)
 	int i, j, highmem = 0;
 
 	lowmem_end_addr = __pa(vmalloc_min - 1) + 1;
+	memblock_set_current_limit(lowmem_end_addr);
 
 	for (i = 0, j = 0; i < meminfo.nr_banks; i++) {
 		struct membank *bank = &meminfo.bank[j];
