From: fkan@apm.com (Feng Kan)
Date: Fri, 21 Aug 2015 15:01:33 -0700
Subject: [PATCH V4 1/2] arm64: copy_to-from-in_user optimization using copy
 template
Message-ID: <1440194493-4907-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch optimize copy_to-from-in_user for arm 64bit architecture.
The copy template is using the memcpy.S as a base. This allows the
sharing of the copy template with all of the copy*.S files.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Balamurugan Shanmugam <bshanmugam@apm.com>
---
 arch/arm64/lib/copy_from_user.S |  78 +++++++++-------
 arch/arm64/lib/copy_in_user.S   |  66 ++++++++------
 arch/arm64/lib/copy_template.S  | 196 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/lib/copy_to_user.S   |  66 ++++++++------
 4 files changed, 314 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm64/lib/copy_template.S

diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 1be9ef2..cb085cf 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -18,6 +18,7 @@
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cache.h>
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
 
@@ -31,49 +32,58 @@
  * Returns:
  *	x0 - bytes not copied
  */
+
+	.macro ldrb1 label, ptr, regB, val
+	USER(\label, ldrb  \ptr, [\regB], \val)
+	.endm
+
+	.macro strb1 label, ptr, regB, val
+	strb \ptr, [\regB], \val
+	.endm
+
+	.macro ldrh1 label, ptr, regB, val
+	USER(\label, ldrh  \ptr, [\regB], \val)
+	.endm
+
+	.macro strh1 label, ptr, regB, val
+	strh \ptr, [\regB], \val
+	.endm
+
+	.macro ldr1 label, ptr, regB, val
+	USER(\label, ldr \ptr, [\regB], \val)
+	.endm
+
+	.macro str1 label, ptr, regB, val
+	str \ptr, [\regB], \val
+	.endm
+
+	.macro ldp1 label, ptr, regB, regC, val
+	USER(\label, ldp \ptr, \regB, [\regC], \val)
+	.endm
+
+	.macro stp1 label, ptr, regB, regC, val
+	stp \ptr, \regB, [\regC], \val
+	.endm
+
 ENTRY(__copy_from_user)
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
-	add	x5, x1, x2			// upper user buffer boundary
-	subs	x2, x2, #16
-	b.mi	1f
-0:
-USER(9f, ldp	x3, x4, [x1], #16)
-	subs	x2, x2, #16
-	stp	x3, x4, [x0], #16
-	b.pl	0b
-1:	adds	x2, x2, #8
-	b.mi	2f
-USER(9f, ldr	x3, [x1], #8	)
-	sub	x2, x2, #8
-	str	x3, [x0], #8
-2:	adds	x2, x2, #4
-	b.mi	3f
-USER(9f, ldr	w3, [x1], #4	)
-	sub	x2, x2, #4
-	str	w3, [x0], #4
-3:	adds	x2, x2, #2
-	b.mi	4f
-USER(9f, ldrh	w3, [x1], #2	)
-	sub	x2, x2, #2
-	strh	w3, [x0], #2
-4:	adds	x2, x2, #1
-	b.mi	5f
-USER(9f, ldrb	w3, [x1]	)
-	strb	w3, [x0]
-5:	mov	x0, #0
+#include "copy_template.S"
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
+	mov	x0, #0				// Nothing to copy
 	ret
 ENDPROC(__copy_from_user)
 
 	.section .fixup,"ax"
 	.align	2
-9:	sub	x2, x5, x1
-	mov	x3, x2
-10:	strb	wzr, [x0], #1			// zero remaining buffer space
-	subs	x3, x3, #1
-	b.ne	10b
-	mov	x0, x2				// bytes not copied
+11:
+	sub	x4, tmp3, dst
+	mov	x0, x4
+	sub	dst, tmp3, x4
+
+20:	strb	wzr, [dst], #1			// zero remaining buffer space
+	subs	x4, x4, #1
+	b.ne	20b
 	ret
 	.previous
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 1b94661e..b54d44e 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -20,6 +20,7 @@
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cache.h>
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
 
@@ -33,44 +34,51 @@
  * Returns:
  *	x0 - bytes not copied
  */
+	.macro ldrb1 label, ptr, regB, val
+	USER(\label, ldrb  \ptr, [\regB], \val)
+	.endm
+
+	.macro strb1 label, ptr, regB, val
+	USER(\label, strb \ptr, [\regB], \val)
+	.endm
+
+	.macro ldrh1 label, ptr, regB, val
+	USER(\label, ldrh  \ptr, [\regB], \val)
+	.endm
+
+	.macro strh1 label, ptr, regB, val
+	USER(\label, strh \ptr, [\regB], \val)
+	.endm
+
+	.macro ldr1 label, ptr, regB, val
+	USER(\label, ldr \ptr, [\regB], \val)
+	.endm
+
+	.macro str1 label, ptr, regB, val
+	USER(\label, str \ptr, [\regB], \val)
+	.endm
+
+	.macro ldp1 label, ptr, regB, regC, val
+	USER(\label, ldp \ptr, \regB, [\regC], \val)
+	.endm
+
+	.macro stp1 label, ptr, regB, regC, val
+	USER(\label, stp \ptr, \regB, [\regC], \val)
+	.endm
+
 ENTRY(__copy_in_user)
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
-	add	x5, x0, x2			// upper user buffer boundary
-	subs	x2, x2, #16
-	b.mi	1f
-0:
-USER(9f, ldp	x3, x4, [x1], #16)
-	subs	x2, x2, #16
-USER(9f, stp	x3, x4, [x0], #16)
-	b.pl	0b
-1:	adds	x2, x2, #8
-	b.mi	2f
-USER(9f, ldr	x3, [x1], #8	)
-	sub	x2, x2, #8
-USER(9f, str	x3, [x0], #8	)
-2:	adds	x2, x2, #4
-	b.mi	3f
-USER(9f, ldr	w3, [x1], #4	)
-	sub	x2, x2, #4
-USER(9f, str	w3, [x0], #4	)
-3:	adds	x2, x2, #2
-	b.mi	4f
-USER(9f, ldrh	w3, [x1], #2	)
-	sub	x2, x2, #2
-USER(9f, strh	w3, [x0], #2	)
-4:	adds	x2, x2, #1
-	b.mi	5f
-USER(9f, ldrb	w3, [x1]	)
-USER(9f, strb	w3, [x0]	)
-5:	mov	x0, #0
+#include "copy_template.S"
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
+	mov	x0, #0
 	ret
 ENDPROC(__copy_in_user)
 
 	.section .fixup,"ax"
 	.align	2
-9:	sub	x0, x5, x0			// bytes not copied
+11:	sub	tmp3, tmp3, dst			// bytes not copied
+	mov	x0, tmp3
 	ret
 	.previous
diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
new file mode 100644
index 0000000..c9ece2f
--- /dev/null
+++ b/arch/arm64/lib/copy_template.S
@@ -0,0 +1,196 @@
+/*
+ * Copyright (C) 2013 ARM Ltd.
+ * Copyright (C) 2013 Linaro.
+ *
+ * This code is based on glibc cortex strings work originally authored by Linaro
+ * and re-licensed under GPLv2 for the Linux kernel. The original code can
+ * be found @
+ *
+ * http://bazaar.launchpad.net/~linaro-toolchain-dev/cortex-strings/trunk/
+ * files/head:/src/aarch64/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+
+/*
+ * Copy a buffer from src to dest (alignment handled by the hardware)
+ *
+ * Parameters:
+ *	x0 - dest
+ *	x1 - src
+ *	x2 - n
+ * Returns:
+ *	x0 - dest
+ */
+dstin	.req	x0
+src	.req	x1
+count	.req	x2
+tmp1	.req	x3
+tmp1w	.req	w3
+tmp2	.req	x4
+tmp2w	.req	w4
+tmp3	.req	x5
+tmp3w	.req	w5
+dst	.req	x6
+
+A_l	.req	x7
+A_h	.req	x8
+B_l	.req	x9
+B_h	.req	x10
+C_l	.req	x11
+C_h	.req	x12
+D_l	.req	x13
+D_h	.req	x14
+
+	mov	dst, dstin
+	add	tmp3, dst, count
+	cmp	count, #16
+	/*When memory length is less than 16, the accessed are not aligned.*/
+	b.lo	.Ltiny15
+
+	neg	tmp2, src
+	ands	tmp2, tmp2, #15/* Bytes to reach alignment. */
+	b.eq	.LSrcAligned
+	sub	count, count, tmp2
+	/*
+	* Copy the leading memory data from src to dst in an increasing
+	* address order.By this way,the risk of overwritting the source
+	* memory data is eliminated when the distance between src and
+	* dst is less than 16. The memory accesses here are alignment.
+	*/
+	tbz	tmp2, #0, 1f
+	ldrb1	11f, tmp1w, src, #1
+	strb1	11f, tmp1w, dst, #1
+1:
+	tbz	tmp2, #1, 2f
+	ldrh1	11f, tmp1w, src, #2
+	strh1	11f, tmp1w, dst, #2
+2:
+	tbz	tmp2, #2, 3f
+	ldr1	11f, tmp1w, src, #4
+	str1	11f, tmp1w, dst, #4
+3:
+	tbz	tmp2, #3, .LSrcAligned
+	ldr1	11f, tmp1, src, #8
+	str1	11f, tmp1, dst, #8
+
+.LSrcAligned:
+	cmp	count, #64
+	b.ge	.Lcpy_over64
+	/*
+	* Deal with small copies quickly by dropping straight into the
+	* exit block.
+	*/
+.Ltail63:
+	/*
+	* Copy up to 48 bytes of data. At this point we only need the
+	* bottom 6 bits of count to be accurate.
+	*/
+	ands	tmp1, count, #0x30
+	b.eq	.Ltiny15
+	cmp	tmp1w, #0x20
+	b.eq	1f
+	b.lt	2f
+	ldp1	11f, A_l, A_h, src, #16
+	stp1	11f, A_l, A_h, dst, #16
+1:
+	ldp1	11f, A_l, A_h, src, #16
+	stp1	11f, A_l, A_h, dst, #16
+2:
+	ldp1	11f, A_l, A_h, src, #16
+	stp1	11f, A_l, A_h, dst, #16
+.Ltiny15:
+	/*
+	* Prefer to break one ldp/stp into several load/store to access
+	* memory in an increasing address order,rather than to load/store 16
+	* bytes from (src-16) to (dst-16) and to backward the src to aligned
+	* address,which way is used in original cortex memcpy. If keeping
+	* the original memcpy process here, memmove need to satisfy the
+	* precondition that src address is at least 16 bytes bigger than dst
+	* address,otherwise some source data will be overwritten when memove
+	* call memcpy directly. To make memmove simpler and decouple the
+	* memcpy's dependency on memmove, withdrew the original process.
+	*/
+	tbz	count, #3, 1f
+	ldr1	11f, tmp1, src, #8
+	str1	11f, tmp1, dst, #8
+1:
+	tbz	count, #2, 2f
+	ldr1	11f, tmp1w, src, #4
+	str1	11f, tmp1w, dst, #4
+2:
+	tbz	count, #1, 3f
+	ldrh1	11f, tmp1w, src, #2
+	strh1	11f, tmp1w, dst, #2
+3:
+	tbz	count, #0, .Lexitfunc
+	ldrb1	11f, tmp1w, src, #1
+	strb1	11f, tmp1w, dst, #1
+
+	b	.Lexitfunc
+
+.Lcpy_over64:
+	subs	count, count, #128
+	b.ge	.Lcpy_body_large
+	/*
+	* Less than 128 bytes to copy, so handle 64 here and then jump
+	* to the tail.
+	*/
+	ldp1	11f, A_l, A_h, src, #16
+	stp1	11f, A_l, A_h, dst, #16
+	ldp1	11f, B_l, B_h, src, #16
+	ldp1	11f, C_l, C_h, src, #16
+	stp1	11f, B_l, B_h, dst, #16
+	stp1	11f, C_l, C_h, dst, #16
+	ldp1	11f, D_l, D_h, src, #16
+	stp1	11f, D_l, D_h, dst, #16
+
+	tst	count, #0x3f
+	b.ne	.Ltail63
+	b	.Lexitfunc
+
+	/*
+	* Critical loop.  Start at a new cache line boundary.  Assuming
+	* 64 bytes per line this ensures the entire loop is in one line.
+	*/
+	.p2align	L1_CACHE_SHIFT
+.Lcpy_body_large:
+	/* pre-get 64 bytes data. */
+	ldp1	11f, A_l, A_h, src, #16
+	ldp1	11f, B_l, B_h, src, #16
+	ldp1	11f, C_l, C_h, src, #16
+	ldp1	11f, D_l, D_h, src, #16
+1:
+	/*
+	* interlace the load of next 64 bytes data block with store of the last
+	* loaded 64 bytes data.
+	*/
+	stp1	11f, A_l, A_h, dst, #16
+	ldp1	11f, A_l, A_h, src, #16
+	stp1	11f, B_l, B_h, dst, #16
+	ldp1	11f, B_l, B_h, src, #16
+	stp1	11f, C_l, C_h, dst, #16
+	ldp1	11f, C_l, C_h, src, #16
+	stp1	11f, D_l, D_h, dst, #16
+	ldp1	11f, D_l, D_h, src, #16
+	subs	count, count, #64
+	b.ge	1b
+	stp1	11f, A_l, A_h, dst, #16
+	stp1	11f, B_l, B_h, dst, #16
+	stp1	11f, C_l, C_h, dst, #16
+	stp1	11f, D_l, D_h, dst, #16
+
+	tst	count, #0x3f
+	b.ne	.Ltail63
+.Lexitfunc:
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index a257b47..0ef3eb2 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -18,6 +18,7 @@
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cache.h>
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
 
@@ -31,44 +32,51 @@
  * Returns:
  *	x0 - bytes not copied
  */
+	.macro ldrb1 label, ptr, regB, val
+	ldrb  \ptr, [\regB], \val
+	.endm
+
+	.macro strb1 label, ptr, regB, val
+	USER(\label, strb \ptr, [\regB], \val)
+	.endm
+
+	.macro ldrh1 label, ptr, regB, val
+	ldrh  \ptr, [\regB], \val
+	.endm
+
+	.macro strh1 label, ptr, regB, val
+	USER(\label, strh \ptr, [\regB], \val)
+	.endm
+
+	.macro ldr1 label, ptr, regB, val
+	ldr \ptr, [\regB], \val
+	.endm
+
+	.macro str1 label, ptr, regB, val
+	USER(\label, str \ptr, [\regB], \val)
+	.endm
+
+	.macro ldp1 label, ptr, regB, regC, val
+	ldp \ptr, \regB, [\regC], \val
+	.endm
+
+	.macro stp1 label, ptr, regB, regC, val
+	USER(\label, stp \ptr, \regB, [\regC], \val)
+	.endm
+
 ENTRY(__copy_to_user)
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
-	add	x5, x0, x2			// upper user buffer boundary
-	subs	x2, x2, #16
-	b.mi	1f
-0:
-	ldp	x3, x4, [x1], #16
-	subs	x2, x2, #16
-USER(9f, stp	x3, x4, [x0], #16)
-	b.pl	0b
-1:	adds	x2, x2, #8
-	b.mi	2f
-	ldr	x3, [x1], #8
-	sub	x2, x2, #8
-USER(9f, str	x3, [x0], #8	)
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
+#include "copy_template.S"
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
+	mov	x0, #0
 	ret
 ENDPROC(__copy_to_user)
 
 	.section .fixup,"ax"
 	.align	2
-9:	sub	x0, x5, x0			// bytes not copied
+11:	sub	tmp3, tmp3, dst			// bytes not copied
+	mov	x0, tmp3
 	ret
 	.previous
-- 
1.9.1
