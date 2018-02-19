From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Feb 2018 11:13:26 +0100
Subject: [4.9-stable 7/9] arm64: fix warning about swapper_pg_dir overflow
In-Reply-To: <20180219101343.2922561-1-arnd@arndb.de>
References: <20180219101343.2922561-1-arnd@arndb.de>
Message-ID: <20180219101343.2922561-8-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 12f043ff2b28fa64c9123b454cbe30a8a9e1967e upstream.

With 4 levels of 16KB pages, we get this warning about the fact that we are
copying a whole page into an array that is declared as having only two pointers
for the top level of the page table:

arch/arm64/mm/mmu.c: In function 'paging_init':
arch/arm64/mm/mmu.c:528:2: error: 'memcpy' writing 16384 bytes into a region of size 16 overflows the destination [-Werror=stringop-overflow=]

This is harmless since we actually reserve a whole page in the definition of the
array that comes from, and just the extern declaration is short. The pgdir
is initialized to zero either way, so copying the actual entries here seems
like the best solution.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
[slightly adapted to apply on 4.9]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 05615a3fdc6f..d5cc6d73c2c4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -479,7 +479,7 @@ void __init paging_init(void)
 	 * To do this we need to go via a temporary pgd.
 	 */
 	cpu_replace_ttbr1(__va(pgd_phys));
-	memcpy(swapper_pg_dir, pgd, PAGE_SIZE);
+	memcpy(swapper_pg_dir, pgd, PGD_SIZE);
 	cpu_replace_ttbr1(swapper_pg_dir);
 
 	pgd_clear_fixmap();
-- 
2.9.0
