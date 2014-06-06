From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri,  6 Jun 2014 11:29:50 +0100
Subject: [PATCH] arm64: Add flush_cache_vmap call in __early_set_fixmap
Message-ID: <1402050590-23877-1-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__early_set_fixmap does not do any synchronization when called to set a
fixmap entry. Add call to flush_vmap_cache().

Tested on hardware.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/mm/ioremap.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 7ec3283..5b8766c 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -176,9 +176,10 @@ void __init __early_set_fixmap(enum fixed_addresses idx,
 
 	pte = early_ioremap_pte(addr);
 
-	if (pgprot_val(flags))
+	if (pgprot_val(flags)) {
 		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
-	else {
+		flush_cache_vmap(addr, addr + PAGE_SIZE);
+	} else {
 		pte_clear(&init_mm, addr, pte);
 		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
 	}
-- 
1.7.10.4
