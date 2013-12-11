From: zhichang.yuan@linaro.org (zhichang.yuan at linaro.org)
Date: Wed, 11 Dec 2013 14:24:38 +0800
Subject: [PATCH 2/6] arm64: lib: Implement optimized memmove routine
In-Reply-To: <1386743082-5231-1-git-send-email-zhichang.yuan@linaro.org>
References: <1386743082-5231-1-git-send-email-zhichang.yuan@linaro.org>
Message-ID: <1386743082-5231-3-git-send-email-zhichang.yuan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "zhichang.yuan" <zhichang.yuan@linaro.org>

This patch, based on Linaro's Cortex Strings library, improves
the performance of the assembly optimized memmove() function.

Signed-off-by: Zhichang Yuan <zhichang.yuan@linaro.org>
Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm64/lib/memmove.S |  195 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 166 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/lib/memmove.S b/arch/arm64/lib/memmove.S
index b79fdfa..61ee8d9 100644
--- a/arch/arm64/lib/memmove.S
+++ b/arch/arm64/lib/memmove.S
@@ -1,13 +1,21 @@
 /*
  * Copyright (C) 2013 ARM Ltd.
+ * Copyright (C) 2013 Linaro.
+ *
+ * This code is based on glibc cortex strings work originally authored by Linaro
+ * and re-licensed under GPLv2 for the Linux kernel. The original code can
+ * be found @
+ *
+ * http://bazaar.launchpad.net/~linaro-toolchain-dev/cortex-strings/trunk/
+ * files/head:/src/aarch64/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
@@ -18,7 +26,8 @@
 #include <asm/assembler.h>
 
 /*
- * Move a buffer from src to test (alignment handled by the hardware).
+ * Move a buffer from src to test
+ * (alignment handled by the hardware for part cases).
  * If dest <= src, call memcpy, otherwise copy in reverse order.
  *
  * Parameters:
@@ -28,30 +37,158 @@
  * Returns:
  *	x0 - dest
  */
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
 ENTRY(memmove)
-	cmp	x0, x1
-	b.ls	memcpy
-	add	x4, x0, x2
-	add	x1, x1, x2
-	subs	x2, x2, #8
-	b.mi	2f
-1:	ldr	x3, [x1, #-8]!
-	subs	x2, x2, #8
-	str	x3, [x4, #-8]!
-	b.pl	1b
-2:	adds	x2, x2, #4
-	b.mi	3f
-	ldr	w3, [x1, #-4]!
-	sub	x2, x2, #4
-	str	w3, [x4, #-4]!
-3:	adds	x2, x2, #2
-	b.mi	4f
-	ldrh	w3, [x1, #-2]!
-	sub	x2, x2, #2
-	strh	w3, [x4, #-2]!
-4:	adds	x2, x2, #1
-	b.mi	5f
-	ldrb	w3, [x1, #-1]
-	strb	w3, [x4, #-1]
-5:	ret
+	cmp	dstin, src
+	/*b.eq	.Lexitfunc*/
+	b.lo	memcpy
+	add	tmp1, src, count
+	cmp	dstin, tmp1
+	b.hs	memcpy		/* No overlap.  */
+
+	add	dst, dstin, count
+	add	src, src, count
+	cmp	count, #16
+	b.lo	.Ltail15
+
+.Lover16:
+	ands	tmp2, src, #15     /* Bytes to reach alignment.  */
+	b.eq	.LSrcAligned
+	sub	count, count, tmp2
+	/*
+	* process the aligned offset length to make the src aligned firstly.
+	* those extra instructions' cost is acceptable. It also make the
+	* coming accesses are based on aligned address.
+	*/
+	tbz	tmp2, #0, 1f
+	ldrb	tmp1w, [src, #-1]!
+	strb	tmp1w, [dst, #-1]!
+1:
+	tbz	tmp2, #1, 1f
+	ldrh	tmp1w, [src, #-2]!
+	strh	tmp1w, [dst, #-2]!
+1:
+	tbz	tmp2, #2, 1f
+	ldr	tmp1w, [src, #-4]!
+	str	tmp1w, [dst, #-4]!
+1:
+	tbz	tmp2, #3, .LSrcAligned
+	ldr	tmp1, [src, #-8]!
+	str	tmp1, [dst, #-8]!
+
+.LSrcAligned:
+	cmp	count, #64
+	b.ge	.Lcpy_over64
+
+	/*
+	* Deal with small copies quickly by dropping straight into the
+	* exit block.*/
+.Ltail63:
+	/*
+	* Copy up to 48 bytes of data. At this point we only need the
+	* bottom 6 bits of count to be accurate.
+	*/
+	ands	tmp1, count, #0x30
+	b.eq	.Ltail15
+	cmp	tmp1w, #0x20
+	b.eq	1f
+	b.lt	2f
+	ldp	A_l, A_h, [src, #-16]!
+	stp	A_l, A_h, [dst, #-16]!
+1:
+	ldp	A_l, A_h, [src, #-16]!
+	stp	A_l, A_h, [dst, #-16]!
+2:
+	ldp	A_l, A_h, [src, #-16]!
+	stp	A_l, A_h, [dst, #-16]!
+
+.Ltail15:
+	tbz	count, #3, 1f
+	ldr	tmp1, [src, #-8]!
+	str	tmp1, [dst, #-8]!
+1:
+	tbz	count, #2, 1f
+	ldr	tmp1w, [src, #-4]!
+	str	tmp1w, [dst, #-4]!
+1:
+	tbz	count, #1, 1f
+	ldrh	tmp1w, [src, #-2]!
+	strh	tmp1w, [dst, #-2]!
+1:
+	tbz	count, #0, .Lexitfunc
+	ldrb	tmp1w, [src, #-1]
+	strb	tmp1w, [dst, #-1]
+
+.Lexitfunc:
+	ret
+
+.Lcpy_over64:
+	subs	count, count, #128
+	b.ge	.Lcpy_body_large
+	/*
+	* Less than 128 bytes to copy, so handle 64 here and then jump
+	* to the tail.
+	*/
+	ldp	A_l, A_h, [src, #-16]
+	stp	A_l, A_h, [dst, #-16]
+	ldp	B_l, B_h, [src, #-32]
+	ldp	C_l, C_h, [src, #-48]
+	stp	B_l, B_h, [dst, #-32]
+	stp	C_l, C_h, [dst, #-48]
+	ldp	D_l, D_h, [src, #-64]!
+	stp	D_l, D_h, [dst, #-64]!
+
+	tst	count, #0x3f
+	b.ne	.Ltail63
+	ret
+
+	/*
+	* Critical loop. Start at a new cache line boundary. Assuming
+	* 64 bytes per line this ensures the entire loop is in one line.
+	*/
+	.p2align	6
+.Lcpy_body_large:
+	/* There are@least 128 bytes to copy.  */
+	ldp	A_l, A_h, [src, #-16]
+	ldp	B_l, B_h, [src, #-32]
+	ldp	C_l, C_h, [src, #-48]
+	ldp	D_l, D_h, [src, #-64]!
+1:
+	stp	A_l, A_h, [dst, #-16]
+	ldp	A_l, A_h, [src, #-16]
+	stp	B_l, B_h, [dst, #-32]
+	ldp	B_l, B_h, [src, #-32]
+	stp	C_l, C_h, [dst, #-48]
+	ldp	C_l, C_h, [src, #-48]
+	stp	D_l, D_h, [dst, #-64]!
+	ldp	D_l, D_h, [src, #-64]!
+	subs	count, count, #64
+	b.ge	1b
+	stp	A_l, A_h, [dst, #-16]
+	stp	B_l, B_h, [dst, #-32]
+	stp	C_l, C_h, [dst, #-48]
+	stp	D_l, D_h, [dst, #-64]!
+
+	tst	count, #0x3f
+	b.ne	.Ltail63
+	ret
 ENDPROC(memmove)
-- 
1.7.9.5
