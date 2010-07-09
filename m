From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri,  9 Jul 2010 17:37:25 +0200
Subject: [PATCH] ARM: print TCM whereabouts in init message
Message-ID: <1278689845-32526-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If TCM is in use, we should display it in the virtual memory
layout along with everything else.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mm/init.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index cfe4c5e..b7ec94b 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -504,6 +504,14 @@ void __init mem_init(void)
 
 	printk(KERN_NOTICE "Virtual kernel memory layout:\n"
 			"    vector  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+#ifdef CONFIG_HAVE_TCM
+#ifdef DTCM_OFFSET
+			"    DTCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+#endif
+#ifdef ITCM_OFFSET
+			"    ITCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+#endif
+#endif
 			"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
 #ifdef CONFIG_MMU
 			"    DMA     : 0x%08lx - 0x%08lx   (%4ld MB)\n"
@@ -520,6 +528,14 @@ void __init mem_init(void)
 
 			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
 				(PAGE_SIZE)),
+#ifdef CONFIG_HAVE_TCM
+#ifdef DTCM_OFFSET
+			MLK(UL(DTCM_OFFSET), UL(DTCM_END + 1)),
+#endif
+#ifdef ITCM_OFFSET
+			MLK(UL(ITCM_OFFSET), UL(ITCM_END + 1)),
+#endif
+#endif
 			MLK(FIXADDR_START, FIXADDR_TOP),
 #ifdef CONFIG_MMU
 			MLM(CONSISTENT_BASE, CONSISTENT_END),
-- 
1.7.1
