From: cjk@cs.unc.edu (Christopher Kenna)
Date: Wed, 10 Oct 2012 17:56:43 -0400
Subject: [PATCH] Add forgotten mask in cache way unlock for PL310.
Message-ID: <1349906203-7839-1-git-send-email-cjk@cs.unc.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The part number should be masked out of the cache ID when detecting if
the cache controller is a PL310. Since this is done elsewhere, add a
macro for brevity.

Tested on a PandaBoard ES.

Signed-off-by: Christopher Kenna <cjk@cs.unc.edu>
---
 arch/arm/mm/cache-l2x0.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 8a97e64..bdf2f66 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -27,6 +27,7 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #define CACHE_LINE_SIZE		32
+#define CACHE_ID_PART(id)	((id) & L2X0_CACHE_ID_PART_MASK)
 
 static void __iomem *l2x0_base;
 static DEFINE_RAW_SPINLOCK(l2x0_lock);
@@ -292,7 +293,7 @@ static void l2x0_unlock(u32 cache_id)
 	int lockregs;
 	int i;
 
-	if (cache_id == L2X0_CACHE_ID_PART_L310)
+	if (CACHE_ID_PART(cache_id) == L2X0_CACHE_ID_PART_L310)
 		lockregs = 8;
 	else
 		/* L210 and unknown types */
@@ -323,7 +324,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	aux |= aux_val;
 
 	/* Determine the number of ways */
-	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
+	switch (CACHE_ID_PART(cache_id)) {
 	case L2X0_CACHE_ID_PART_L310:
 		if (aux & (1 << 16))
 			ways = 16;
-- 
1.7.9.5
