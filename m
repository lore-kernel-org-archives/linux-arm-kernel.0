From: fkan@apm.com (Feng Kan)
Date: Thu, 15 Aug 2013 11:29:57 -0700
Subject: [PATCH 1/4] arm64: optimized copy_to_user assembly code
Message-ID: <1376591397-1776-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the optimized copy_to_user code, iperf performance improved 20%.

---
 arch/arm64/lib/copy_to_user.S |  249 +++++++++++++++++++++++++++++++++--------
 1 files changed, 204 insertions(+), 45 deletions(-)

diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index a0aeeb9..2a07b13 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -1,61 +1,220 @@
 /*
- * Copyright (C) 2012 ARM Ltd.
+ * Copyright (c) 2013, Applied Micro Circuits Corporation
+ * Copyright (c) 2012-2013, Linaro Limited
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Author: Feng Kan <fkan@apm.com>
+ * Author: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * The code is adopted from the memcpy routine by Linaro Limited.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * This file is dual licensed: you can use it either under the terms of
+ * the GPL, or the BSD license, at your option.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
+ *
+ * Alternatively,
+ *
+ *  b) Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *     1. Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *     2. Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
+ *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+ *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
-/*
- * Copy to user space from a kernel buffer (alignment handled by the hardware)
- *
- * Parameters:
- *	x0 - to
- *	x1 - from
- *	x2 - n
- * Returns:
- *	x0 - bytes not copied
- */
-ENTRY(__copy_to_user)
-	add	x4, x0, x2			// upper user buffer boundary
-	subs	x2, x2, #8
-	b.mi	2f
+#define dstin	x0
+#define src	x1
+#define count	x2
+#define tmp1	x3
+#define tmp1w	w3
+#define tmp2	x4
+#define tmp2w	w4
+#define tmp3	x5
+#define tmp3w	w5
+#define dst	x6
+
+#define A_l	x7
+#define A_h	x8
+#define B_l	x9
+#define B_h	x10
+#define C_l	x11
+#define C_h	x12
+#define D_l	x13
+#define D_h	x14
+
+	/*
+	 * Prototype: size_t copy_to_user (void *dst, const void *src, size_t nb)
+	 */
+	.text
+	.align	2
+	.p2align 6,,63
+ENTRY(__copy_to_user)	
+	mov	dst, dstin
+	cmp	count, #64
+	b.ge	.Lcpy_not_short
+	cmp	count, #15
+	b.le	.Ltail15tiny
+
+	/* Deal with small copies quickly by dropping straight into the
+	 * exit block.  */
+.Ltail63:
+	/* Copy up to 48 bytes of data.  At this point we only need the
+	 * bottom 6 bits of count to be accurate.  */
+	ands	tmp1, count, #0x30
+	b.eq	.Ltail15
+	add	dst, dst, tmp1
+	add	src, src, tmp1
+	cmp	tmp1w, #0x20
+	b.eq	1f
+	b.lt	2f
+	ldp	A_l, A_h, [src, #-48]
+USER (9f, stp A_l, A_h, [dst, #-48])
+1:
+	ldp	A_l, A_h, [src, #-32]
+USER (9f, stp A_l, A_h, [dst, #-32])
+2:
+	ldp	A_l, A_h, [src, #-16]
+USER (9f, stp A_l, A_h, [dst, #-16])
+
+.Ltail15:
+	ands	count, count, #15
+	beq	1f
+	add	src, src, count
+	ldp	A_l, A_h, [src, #-16]
+	add	dst, dst, count
+USER (9f, stp A_l, A_h, [dst, #-16])
+1:
+	b	.Lsuccess
+
+.Ltail15tiny:
+	/* Copy up to 15 bytes of data.  Does not assume additional data
+	   being copied.  */
+	tbz	count, #3, 1f
+	ldr	tmp1, [src], #8
+USER (9f, str tmp1, [dst], #8)
+1:
+	tbz	count, #2, 1f
+	ldr	tmp1w, [src], #4
+USER (9f, str tmp1w, [dst], #4)
 1:
-	ldr	x3, [x1], #8
-	subs	x2, x2, #8
-USER(9f, str	x3, [x0], #8	)
-	b.pl	1b
-2:	adds	x2, x2, #4
-	b.mi	3f
-	ldr	w3, [x1], #4
-	sub	x2, x2, #4
-USER(9f, str	w3, [x0], #4	)
-3:	adds	x2, x2, #2
-	b.mi	4f
-	ldrh	w3, [x1], #2
-	sub	x2, x2, #2
-USER(9f, strh	w3, [x0], #2	)
-4:	adds	x2, x2, #1
-	b.mi	5f
-	ldrb	w3, [x1]
-USER(9f, strb	w3, [x0]	)
-5:	mov	x0, #0
+	tbz	count, #1, 1f
+	ldrh	tmp1w, [src], #2
+USER (9f, strh tmp1w, [dst], #2)
+1:
+	tbz	count, #0, 1f
+	ldrb	tmp1w, [src]
+USER (9f, strb tmp1w, [dst])
+1:
+	b	.Lsuccess
+
+.Lcpy_not_short:
+	/* We don't much care about the alignment of DST, but we want SRC
+	 * to be 128-bit (16 byte) aligned so that we don't cross cache line
+	 * boundaries on both loads and stores.  */
+	neg	tmp2, src
+	ands	tmp2, tmp2, #15		/* Bytes to reach alignment.  */
+	b.eq	2f
+	sub	count, count, tmp2
+	/* Copy more data than needed; it's faster than jumping
+	 * around copying sub-Quadword quantities.  We know that
+	 * it can't overrun.  */
+	ldp	A_l, A_h, [src]
+	add	src, src, tmp2
+USER (9f, stp A_l, A_h, [dst])
+	add	dst, dst, tmp2
+	/* There may be less than 63 bytes to go now.  */
+	cmp	count, #63
+	b.le	.Ltail63
+2:
+	subs	count, count, #128
+	b.ge	.Lcpy_body_large
+	/* Less than 128 bytes to copy, so handle 64 here and then jump
+	 * to the tail.  */
+	ldp	A_l, A_h, [src]
+	ldp	B_l, B_h, [src, #16]
+	ldp	C_l, C_h, [src, #32]
+	ldp	D_l, D_h, [src, #48]
+USER (9f, stp A_l, A_h, [dst])
+USER (9f, stp B_l, B_h, [dst, #16])
+USER (9f, stp C_l, C_h, [dst, #32])
+USER (9f, stp D_l, D_h, [dst, #48])
+	tst	count, #0x3f
+	add	src, src, #64
+	add	dst, dst, #64
+	b.ne	.Ltail63
+	b	.Lsuccess
+
+	/* Critical loop.  Start at a new cache line boundary.  Assuming
+	 * 64 bytes per line this ensures the entire loop is in one line.  */
+	.p2align 6
+.Lcpy_body_large:
+	/* There are at least 128 bytes to copy.  */
+	ldp	A_l, A_h, [src, #0]
+	sub	dst, dst, #16		/* Pre-bias.  */
+	ldp	B_l, B_h, [src, #16]
+	ldp	C_l, C_h, [src, #32]
+	ldp	D_l, D_h, [src, #48]!	/* src += 64 - Pre-bias.  */
+1:
+USER (9f, stp A_l, A_h, [dst, #16])
+	ldp	A_l, A_h, [src, #16]
+USER (9f, stp B_l, B_h, [dst, #32])
+	ldp	B_l, B_h, [src, #32]
+USER (9f, stp C_l, C_h, [dst, #48])
+	ldp	C_l, C_h, [src, #48]
+USER (9f, stp D_l, D_h, [dst, #64]!)
+	ldp	D_l, D_h, [src, #64]!
+	subs	count, count, #64
+	b.ge	1b
+USER (9f, stp A_l, A_h, [dst, #16])
+USER (9f, stp B_l, B_h, [dst, #32])
+USER (9f, stp C_l, C_h, [dst, #48])
+USER (9f, stp D_l, D_h, [dst, #64])
+	add	src, src, #16
+	add	dst, dst, #64 + 16
+	tst	count, #0x3f
+	b.ne	.Ltail63
+.Lsuccess:
+	mov	x0, #0		    // nothing left to copy
 	ret
 ENDPROC(__copy_to_user)
 
 	.section .fixup,"ax"
-	.align	2
-9:	sub	x0, x4, x0			// bytes not copied
+	.align    2
+9:	mov    x0, count            // approximate the number of bytes not copied
 	ret
 	.previous
-- 
1.7.6.1
