From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Sat,  7 Jan 2017 22:52:00 +0530
Subject: [PATCH WIP 3/4] ARM: mm: nommu: display dynamic exception base
In-Reply-To: <20170107171339.GA5044@afzalpc>
References: <20170107171339.GA5044@afzalpc>
Message-ID: <20170107172200.6397-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Display dynamically estimated nommu exception base.

TODO: Dynamically update MMU case too.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/mm/init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 370581aeb871..1777ee23a6a2 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -39,6 +39,10 @@
 
 #include "mm.h"
 
+#ifndef CONFIG_MMU
+extern unsigned long vectors_base;
+#endif
+
 #ifdef CONFIG_CPU_CP15_MMU
 unsigned long __init __clear_cr(unsigned long mask)
 {
@@ -521,8 +525,13 @@ void __init mem_init(void)
 			"      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
 			"       .bss : 0x%p" " - 0x%p" "   (%4td kB)\n",
 
+#ifdef CONFIG_MMU
 			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
 				(PAGE_SIZE)),
+#else
+			MLK_ROUNDUP(vectors_base, vectors_base + PAGE_SIZE),
+#endif
+
 #ifdef CONFIG_HAVE_TCM
 			MLK(DTCM_OFFSET, (unsigned long) dtcm_end),
 			MLK(ITCM_OFFSET, (unsigned long) itcm_end),
-- 
2.11.0
