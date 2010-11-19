From: jajones@nvidia.com (James Jones)
Date: Fri, 19 Nov 2010 10:13:20 -0800
Subject: [PATCH] ARM: Fix find_next_zero_bit and related assembly
Message-ID: <201011191013.20983.jajones@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The find_next_bit, find_first_bit, find_next_zero_bit
and find_first_zero_bit functions were not properly
clamping to the maxbit argument at the bit level. They
were instead only checking maxbit at the byte level.
To fix this, add a compare and a conditional move
instruction to the end of the common bit-within-the-
byte code used by all the functions and be sure not to
clobber the maxbit argument before it is used.

Signed-off-by: James Jones <jajones@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/lib/findbit.S |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
index 1e4cbd4..64f6bc1 100644
--- a/arch/arm/lib/findbit.S
+++ b/arch/arm/lib/findbit.S
@@ -174,8 +174,8 @@ ENDPROC(_find_next_bit_be)
  */
 .L_found:
 #if __LINUX_ARM_ARCH__ >= 5
-		rsb	r1, r3, #0
-		and	r3, r3, r1
+		rsb	r0, r3, #0
+		and	r3, r3, r0
 		clz	r3, r3
 		rsb	r3, r3, #31
 		add	r0, r2, r3
@@ -190,5 +190,7 @@ ENDPROC(_find_next_bit_be)
 		addeq	r2, r2, #1
 		mov	r0, r2
 #endif
+		cmp	r1, r0			@ Clamp to maxbit
+		movlo	r0, r1
 		mov	pc, lr
 
-- 
1.7.1
