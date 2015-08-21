From: fkan@apm.com (Feng Kan)
Date: Fri, 21 Aug 2015 15:01:41 -0700
Subject: [PATCH V4 2/2] arm64: Change memcpy in kernel to use the copy
 template file
Message-ID: <1440194501-4953-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the memcpy.S to use the copy template file. The copy
template file was based originally on the memcpy.S. Minor changes
was made to it to accommodate the copy to/from/in user files.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/lib/memcpy.S | 179 +++++++-----------------------------------------
 1 file changed, 26 insertions(+), 153 deletions(-)

diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
index 8a9a96d..761acd7 100644
--- a/arch/arm64/lib/memcpy.S
+++ b/arch/arm64/lib/memcpy.S
@@ -36,166 +36,39 @@
  * Returns:
  *	x0 - dest
  */
-dstin	.req	x0
-src	.req	x1
-count	.req	x2
-tmp1	.req	x3
-tmp1w	.req	w3
-tmp2	.req	x4
-tmp2w	.req	w4
-tmp3	.req	x5
-tmp3w	.req	w5
-dst	.req	x6
+        .macro ldrb1 label, ptr, regB, val
+        ldrb  \ptr, [\regB], \val
+        .endm
 
-A_l	.req	x7
-A_h	.req	x8
-B_l	.req	x9
-B_h	.req	x10
-C_l	.req	x11
-C_h	.req	x12
-D_l	.req	x13
-D_h	.req	x14
+        .macro strb1 label, ptr, regB, val
+        strb \ptr, [\regB], \val
+        .endm
 
-ENTRY(memcpy)
-	mov	dst, dstin
-	cmp	count, #16
-	/*When memory length is less than 16, the accessed are not aligned.*/
-	b.lo	.Ltiny15
+        .macro ldrh1 label, ptr, regB, val
+        ldrh  \ptr, [\regB], \val
+        .endm
 
-	neg	tmp2, src
-	ands	tmp2, tmp2, #15/* Bytes to reach alignment. */
-	b.eq	.LSrcAligned
-	sub	count, count, tmp2
-	/*
-	* Copy the leading memory data from src to dst in an increasing
-	* address order.By this way,the risk of overwritting the source
-	* memory data is eliminated when the distance between src and
-	* dst is less than 16. The memory accesses here are alignment.
-	*/
-	tbz	tmp2, #0, 1f
-	ldrb	tmp1w, [src], #1
-	strb	tmp1w, [dst], #1
-1:
-	tbz	tmp2, #1, 2f
-	ldrh	tmp1w, [src], #2
-	strh	tmp1w, [dst], #2
-2:
-	tbz	tmp2, #2, 3f
-	ldr	tmp1w, [src], #4
-	str	tmp1w, [dst], #4
-3:
-	tbz	tmp2, #3, .LSrcAligned
-	ldr	tmp1, [src],#8
-	str	tmp1, [dst],#8
+        .macro strh1 label, ptr, regB, val
+        strh \ptr, [\regB], \val
+        .endm
 
-.LSrcAligned:
-	cmp	count, #64
-	b.ge	.Lcpy_over64
-	/*
-	* Deal with small copies quickly by dropping straight into the
-	* exit block.
-	*/
-.Ltail63:
-	/*
-	* Copy up to 48 bytes of data. At this point we only need the
-	* bottom 6 bits of count to be accurate.
-	*/
-	ands	tmp1, count, #0x30
-	b.eq	.Ltiny15
-	cmp	tmp1w, #0x20
-	b.eq	1f
-	b.lt	2f
-	ldp	A_l, A_h, [src], #16
-	stp	A_l, A_h, [dst], #16
-1:
-	ldp	A_l, A_h, [src], #16
-	stp	A_l, A_h, [dst], #16
-2:
-	ldp	A_l, A_h, [src], #16
-	stp	A_l, A_h, [dst], #16
-.Ltiny15:
-	/*
-	* Prefer to break one ldp/stp into several load/store to access
-	* memory in an increasing address order,rather than to load/store 16
-	* bytes from (src-16) to (dst-16) and to backward the src to aligned
-	* address,which way is used in original cortex memcpy. If keeping
-	* the original memcpy process here, memmove need to satisfy the
-	* precondition that src address is at least 16 bytes bigger than dst
-	* address,otherwise some source data will be overwritten when memove
-	* call memcpy directly. To make memmove simpler and decouple the
-	* memcpy's dependency on memmove, withdrew the original process.
-	*/
-	tbz	count, #3, 1f
-	ldr	tmp1, [src], #8
-	str	tmp1, [dst], #8
-1:
-	tbz	count, #2, 2f
-	ldr	tmp1w, [src], #4
-	str	tmp1w, [dst], #4
-2:
-	tbz	count, #1, 3f
-	ldrh	tmp1w, [src], #2
-	strh	tmp1w, [dst], #2
-3:
-	tbz	count, #0, .Lexitfunc
-	ldrb	tmp1w, [src]
-	strb	tmp1w, [dst]
+        .macro ldr1 label, ptr, regB, val
+        ldr \ptr, [\regB], \val
+        .endm
 
-.Lexitfunc:
-	ret
+        .macro str1 label, ptr, regB, val
+        str \ptr, [\regB], \val
+        .endm
 
-.Lcpy_over64:
-	subs	count, count, #128
-	b.ge	.Lcpy_body_large
-	/*
-	* Less than 128 bytes to copy, so handle 64 here and then jump
-	* to the tail.
-	*/
-	ldp	A_l, A_h, [src],#16
-	stp	A_l, A_h, [dst],#16
-	ldp	B_l, B_h, [src],#16
-	ldp	C_l, C_h, [src],#16
-	stp	B_l, B_h, [dst],#16
-	stp	C_l, C_h, [dst],#16
-	ldp	D_l, D_h, [src],#16
-	stp	D_l, D_h, [dst],#16
+        .macro ldp1 label, ptr, regB, regC, val
+        ldp \ptr, \regB, [\regC], \val
+        .endm
 
-	tst	count, #0x3f
-	b.ne	.Ltail63
-	ret
+        .macro stp1 label, ptr, regB, regC, val
+        stp \ptr, \regB, [\regC], \val
+        .endm
 
-	/*
-	* Critical loop.  Start at a new cache line boundary.  Assuming
-	* 64 bytes per line this ensures the entire loop is in one line.
-	*/
-	.p2align	L1_CACHE_SHIFT
-.Lcpy_body_large:
-	/* pre-get 64 bytes data. */
-	ldp	A_l, A_h, [src],#16
-	ldp	B_l, B_h, [src],#16
-	ldp	C_l, C_h, [src],#16
-	ldp	D_l, D_h, [src],#16
-1:
-	/*
-	* interlace the load of next 64 bytes data block with store of the last
-	* loaded 64 bytes data.
-	*/
-	stp	A_l, A_h, [dst],#16
-	ldp	A_l, A_h, [src],#16
-	stp	B_l, B_h, [dst],#16
-	ldp	B_l, B_h, [src],#16
-	stp	C_l, C_h, [dst],#16
-	ldp	C_l, C_h, [src],#16
-	stp	D_l, D_h, [dst],#16
-	ldp	D_l, D_h, [src],#16
-	subs	count, count, #64
-	b.ge	1b
-	stp	A_l, A_h, [dst],#16
-	stp	B_l, B_h, [dst],#16
-	stp	C_l, C_h, [dst],#16
-	stp	D_l, D_h, [dst],#16
-
-	tst	count, #0x3f
-	b.ne	.Ltail63
+ENTRY(memcpy)
+#include "copy_template.S"
 	ret
 ENDPROC(memcpy)
-- 
1.9.1
