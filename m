From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 14 Sep 2015 17:55:28 +0200
Subject: [PATCH 2/3] arm64: only consider memblocks with NOMAP cleared for
 linear mapping
In-Reply-To: <1442246129-13930-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442246129-13930-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1442246129-13930-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take the new memblock attribute MEMBLOCK_NOMAP into account when
deciding whether a certain region is or should covered by the
kernel direct mapping.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 2 +-
 arch/arm64/mm/mmu.c  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f5c0680d17d9..48133235d9f5 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -119,7 +119,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
-	return memblock_is_memory(pfn << PAGE_SHIFT);
+	return memblock_is_map_memory(pfn << PAGE_SHIFT);
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9211b8527f25..7067ae232bed 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -370,6 +370,8 @@ static void __init map_mem(void)
 
 		if (start >= end)
 			break;
+		if (memblock_is_nomap(reg))
+			continue;
 
 #ifndef CONFIG_ARM64_64K_PAGES
 		/*
-- 
1.9.1
