From: stefan@agner.ch (Stefan Agner)
Date: Sat,  3 Sep 2016 22:33:31 -0700
Subject: [PATCH] ARM: LPAE: initialize cachepolicy correctly
Message-ID: <20160904053331.7264-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cachepolicy variable gets initialized using a masked pmd
So far, the pmd has been masked with flags valid for the 2-page
table format. In the LPAE case, this lead to a wrong assumption
of what the initial cachepolicy has been used. Later a check
forces the cache policy to writealloc and prints the following
warning:
Forcing write-allocate cache policy for SMP

This patch uses PMD_SECT_WBWA to mask all cache setting flags.
The define represents the complete mask of the cache relevant
flags for both page table formats.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 724d6be..241e5e2 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -137,7 +137,7 @@ void __init init_default_cache_policy(unsigned long pmd)
 
 	initial_pmd_value = pmd;
 
-	pmd &= PMD_SECT_TEX(1) | PMD_SECT_BUFFERABLE | PMD_SECT_CACHEABLE;
+	pmd &= PMD_SECT_WBWA;
 
 	for (i = 0; i < ARRAY_SIZE(cache_policies); i++)
 		if (cache_policies[i].pmd == pmd) {
-- 
2.9.0
