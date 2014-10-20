From: js07.lee@gmail.com (Jungseung Lee)
Date: Mon, 20 Oct 2014 21:54:02 +0900
Subject: [PATCH] arm: fix flush_pfn_alias
Message-ID: <1413809642-12931-1-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

L1_CACHE_BYTES could be larger than real L1 cache line size.
In that case, flush_pfn_alias function would omit to flush last bytes
as much as L1_CACHE_BYTES - real cache line size.

So fix end address to "to + PAGE_SIZE - 1". The bottom bits of the address
is LINELEN. that is ignored by mcrr.

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm/mm/flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 265b836..34b66af 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -33,7 +33,7 @@ static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 	asm(	"mcrr	p15, 0, %1, %0, c14\n"
 	"	mcr	p15, 0, %2, c7, c10, 4"
 	    :
-	    : "r" (to), "r" (to + PAGE_SIZE - L1_CACHE_BYTES), "r" (zero)
+	    : "r" (to), "r" (to + PAGE_SIZE - 1), "r" (zero)
 	    : "cc");
 }
 
-- 
1.9.1
