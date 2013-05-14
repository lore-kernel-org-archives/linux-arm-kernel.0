From: anup.patel@linaro.org (Anup Patel)
Date: Tue, 14 May 2013 14:56:54 +0530
Subject: [PATCH] arm64: mm: Fix operands of clz in __flush_dcache_all
Message-ID: <1368523614-22484-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sukanto Ghosh <sghosh@apm.com>

The format of the lower 32-bits of the 64-bit operand to 'dc cisw' is
unchanged from ARMv7 architecture and the upper bits are RES0. This
implies that the 'way' field of the operand of 'dc cisw' occupies the
bit-positions [31 .. (32-A)]. Due to the use of 64-bit extended operands
to 'clz', the existing implementation of __flush_dcache_all is incorrectly
placing the 'way' field in the bit-positions [63 .. (64-A)].

Signed-off-by: Sukanto Ghosh <sghosh@apm.com>
Tested-by: Anup Patel <anup.patel@linaro.org>
---
 arch/arm64/mm/cache.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index abe69b8..48a3860 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -52,7 +52,7 @@ loop1:
 	add	x2, x2, #4			// add 4 (line length offset)
 	mov	x4, #0x3ff
 	and	x4, x4, x1, lsr #3		// find maximum number on the way size
-	clz	x5, x4				// find bit position of way size increment
+	clz	w5, w4				// find bit position of way size increment
 	mov	x7, #0x7fff
 	and	x7, x7, x1, lsr #13		// extract max number of the index size
 loop2:
-- 
1.7.9.5
