From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue,  6 Jan 2015 13:41:13 +0000
Subject: [PATCH v2 2/2] arm64: call early_ioremap_reset() in paging_init()
In-Reply-To: <1420551673-31416-1-git-send-email-leif.lindholm@linaro.org>
References: <1420551673-31416-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1420551673-31416-3-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 does not support early_memremap/memunmap/ioremap/iounmap after
paging_init() has been called. The core early_*remap code handles this
via the after_paging_init variable, which is set by a call to
early_ioremap_reset().

However, arm64 currently does not call early_ioremap_reset(), which
has made it possible to poke around in the fixmap region after kmap
is enabled. Add the required call.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Fixes: bf4b558eba92 ("arm64: add early_ioremap support")
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6032f3e..506544f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -348,6 +348,7 @@ void __init paging_init(void)
 {
 	void *zero_page;
 
+	early_ioremap_reset();
 	map_mem();
 
 	/*
-- 
2.1.3
