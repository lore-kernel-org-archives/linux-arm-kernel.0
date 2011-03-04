From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 4 Mar 2011 15:24:23 +0100
Subject: [PATCH] ARM: fix compile error in tlb.h
Message-ID: <1299248663-27130-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

It seems some of the new tlb handling code merged for 2.6.38-rc7
use <linux/pagemap.h> while this is only included for the NON-MMU
case. This moves the inclusion out of the clause so the kernel
compiles.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Symptom without this patch:

n file included from /home/elinwal/linux-2.6/arch/arm/mm/init.c:27:
/home/elinwal/linux-2.6/arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
/home/elinwal/linux-2.6/arch/arm/include/asm/tlb.h:104: error: implicit declaration of function 'release_pages'
/home/elinwal/linux-2.6/arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
/home/elinwal/linux-2.6/arch/arm/include/asm/tlb.h:168: error: implicit declaration of function 'page_cache_release'
make[3]: *** [arch/arm/mm/init.o] Error 1
---
 arch/arm/include/asm/tlb.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 82dfe5d..d13af30 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -21,14 +21,13 @@
 
 #ifndef CONFIG_MMU
 
-#include <linux/pagemap.h>
-
 #define tlb_flush(tlb)	((void) tlb)
 
 #include <asm-generic/tlb.h>
 
 #else /* !CONFIG_MMU */
 
+#include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-- 
1.7.3.2
