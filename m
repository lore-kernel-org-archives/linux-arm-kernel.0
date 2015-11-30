From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Nov 2015 13:28:25 +0100
Subject: [PATCH v4 11/13] ARM: only consider memblocks with NOMAP cleared for
 linear mapping
In-Reply-To: <1448886507-3216-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1448886507-3216-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1448886507-3216-12-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take the new memblock attribute MEMBLOCK_NOMAP into account when
deciding whether a certain region is or should be covered by the
kernel direct mapping.

Tested-by: Ryan Harkin <ryan.harkin@linaro.org>
Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/mm/init.c | 5 ++++-
 arch/arm/mm/mmu.c  | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 8a63b4cdc0f2..16104b1e2661 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -191,7 +191,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
-	return memblock_is_memory(__pfn_to_phys(pfn));
+	return memblock_is_map_memory(__pfn_to_phys(pfn));
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif
@@ -432,6 +432,9 @@ static void __init free_highpages(void)
 		if (end <= max_low)
 			continue;
 
+		if (memblock_is_nomap(mem))
+			continue;
+
 		/* Truncate partial highmem entries */
 		if (start < max_low)
 			start = max_low;
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 8c69830e791a..c615d2eb9232 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1435,6 +1435,9 @@ static void __init map_lowmem(void)
 		phys_addr_t end = start + reg->size;
 		struct map_desc map;
 
+		if (memblock_is_nomap(reg))
+			continue;
+
 		if (end > arm_lowmem_limit)
 			end = arm_lowmem_limit;
 		if (start >= end)
-- 
1.9.1
