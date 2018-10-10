From: james.morse@arm.com (James Morse)
Date: Wed, 10 Oct 2018 15:43:22 +0100
Subject: [PATCH] arm64: mm: Use __pa_symbol() for set_swapper_pgd()
Message-ID: <20181010144322.14363-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 2330b7ca78350efcb ("arm64/mm: use fixmap to modify
swapper_pg_dir") modifies the swapper_pg_dir via the fixmap
as the kernel page tables have been moved to a read-only
part of the kernel mapping.

Using __pa() to setup the fixmap causes CONFIG_DEBUG_VIRTUAL
to fire, as this function is used on the kernel-image swapper
address. The in_swapper_pgdir() test before each call of this
function means set_swapper_pgd() will only ever be called when
pgdp points somewhere in the kernel-image mapping of
swapper_pd_dir. Use __pa_symbol().

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: James Morse <james.morse@arm.com>
CC: Jun Yao <yaojun8558363@gmail.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6f0e2edcc114..6deb836a102a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -74,7 +74,7 @@ void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
 	pgd_t *fixmap_pgdp;
 
 	spin_lock(&swapper_pgdir_lock);
-	fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
+	fixmap_pgdp = pgd_set_fixmap(__pa_symbol(pgdp));
 	WRITE_ONCE(*fixmap_pgdp, pgd);
 	/*
 	 * We need dsb(ishst) here to ensure the page-table-walker sees
-- 
2.19.0
