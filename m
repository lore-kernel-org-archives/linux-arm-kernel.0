From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 21:54:23 +0100
Subject: [RFC PATCH 01/10] arm64: mm: move assignment of 'high_memory' before
 its first use
In-Reply-To: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456174472-30028-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable 'high_memory' ends up being referenced in the call to
dma_contiguous_reserve(). So move the assignment before that call.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e1f425fe5a81..017201982da3 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -235,6 +235,9 @@ void __init arm64_memblock_init(void)
 		arm64_dma_phys_limit = max_zone_dma_phys();
 	else
 		arm64_dma_phys_limit = PHYS_MASK + 1;
+
+	high_memory = __va((memblock_end_of_DRAM() & PAGE_MASK) - 1) + 1;
+
 	dma_contiguous_reserve(arm64_dma_phys_limit);
 
 	memblock_allow_resize();
@@ -259,7 +262,6 @@ void __init bootmem_init(void)
 	sparse_init();
 	zone_sizes_init(min, max);
 
-	high_memory = __va((max << PAGE_SHIFT) - 1) + 1;
 	max_pfn = max_low_pfn = max;
 }
 
-- 
2.5.0
