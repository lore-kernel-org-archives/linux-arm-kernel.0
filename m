From: spang@chromium.org (Michael Spang)
Date: Mon, 22 Oct 2012 15:51:54 -0400
Subject: [PATCH] ARM: Only initialize max_mapnr when using flatmem
Message-ID: <1350935514-27422-1-git-send-email-spang@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The expression used to initialize max_mapnr is not appropriate for
sparsemem, since mem_map is NULL and pfn_to_page() only works on valid
pages. This patch leaves max_mapnr uninitialized for sparsemem.

For flatmem, the expression simplifies to copying max_pfn.

Signed-off-by: Michael Spang <spang@chromium.org>
---
 arch/arm/mm/init.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

I'm not sure we need this variable it all - it looks like there are no
users.

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c21d06c..9b72e6f 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -600,7 +600,9 @@ void __init mem_init(void)
 	extern u32 itcm_end;
 #endif
 
-	max_mapnr   = pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;
+#ifdef CONFIG_FLATMEM
+	max_mapnr = max_pfn;
+#endif
 
 	/* this will put all unused low memory onto the freelists */
 	free_unused_memmap(&meminfo);
-- 
1.7.7.3
