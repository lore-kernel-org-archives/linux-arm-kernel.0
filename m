From: zhichang.yuan@linaro.org (zhichang.yuan at linaro.org)
Date: Wed, 11 Dec 2013 14:24:41 +0800
Subject: [PATCH 5/6] arm64: lib: Implement optimized string compare routines
In-Reply-To: <1386743082-5231-1-git-send-email-zhichang.yuan@linaro.org>
References: <1386743082-5231-1-git-send-email-zhichang.yuan@linaro.org>
Message-ID: <1386743082-5231-6-git-send-email-zhichang.yuan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "zhichang.yuan" <zhichang.yuan@linaro.org>

This patch, based on Linaro's Cortex Strings library, adds
an assembly optimized strcmp() and strncmp() functions.

Signed-off-by: Zhichang Yuan <zhichang.yuan@linaro.org>
Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm64/include/asm/string.h |    6 +
 arch/arm64/kernel/arm64ksyms.c  |    2 +
 arch/arm64/lib/Makefile         |    2 +-
 arch/arm64/lib/strcmp.S         |  256 +++++++++++++++++++++++++++++
 arch/arm64/lib/strncmp.S        |  340 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 605 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/lib/strcmp.S
 create mode 100644 arch/arm64/lib/strncmp.S

diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
index 3a43305..6133f49 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -22,6 +22,12 @@ extern char *strrchr(const char *, int c);
 #define __HAVE_ARCH_STRCHR
 extern char *strchr(const char *, int c);
 
+#define __HAVE_ARCH_STRCMP
+extern int strcmp(const char *, const char *);
+
+#define __HAVE_ARCH_STRNCMP
+extern int strncmp(const char *, const char *, __kernel_size_t);
+
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, __kernel_size_t);
 
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index af02a25..d61fa39 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -47,6 +47,8 @@ EXPORT_SYMBOL(memstart_addr);
 	/* string / mem functions */
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
+EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index a6a8d3d..5ded21f 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -3,4 +3,4 @@ lib-y		:= bitops.o delay.o					\
 		   copy_from_user.o copy_to_user.o copy_in_user.o	\
 		   copy_page.o clear_page.o				\
 		   memchr.o memcpy.o memmove.o memset.o memcmp.o	\
-		   strchr.o strrchr.o
+		   strchr.o strrchr.o strcmp.o strncmp.o
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
new file mode 100644
index 0000000..e07ea0d
--- /dev/null
+++ b/arch/arm64/lib/strcmp.S
@@ -0,0 +1,256 @@
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
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+/*
+ * compare two strings
+ *
+ * Parameters:
+ *	x0 - const string 1 pointer
+ *    x1 - const string 2 pointer
+ * Returns:
+ * x0 - an integer less than, equal to, or greater than zero
+ * if  s1  is  found, respectively, to be less than, to match,
+ * or be greater than s2.
+ */
+
+#define REP8_01 0x0101010101010101
+#define REP8_7f 0x7f7f7f7f7f7f7f7f
+#define REP8_80 0x8080808080808080
+
+/* Parameters and result.  */
+#define src1		x0
+#define src2		x1
+#define result		x0
+
+/* Internal variables.  */
+#define data1		x2
+#define data1w		w2
+#define data2		x3
+#define data2w		w3
+#define has_nul		x4
+#define diff		x5
+#define syndrome	x6
+#define tmp1		x7
+#define tmp2		x8
+#define tmp3		x9
+#define zeroones	x10
+#define pos		x11
+
+ENTRY(strcmp)
+	eor	tmp1, src1, src2
+	mov	zeroones, #REP8_01
+	tst	tmp1, #7
+	b.ne	.Lmisaligned8
+	ands	tmp1, src1, #7
+	b.ne	.Lmutual_align
+
+	/*
+	* NUL detection works on the principle that (X - 1) & (~X) & 0x80
+	* (=> (X - 1) & ~(X | 0x7f)) is non-zero iff a byte is zero, and
+	* can be done in parallel across the entire word.
+	*/
+.Lloop_aligned:
+	ldr	data1, [src1], #8
+	ldr	data2, [src2], #8
+.Lstart_realigned:
+	sub	tmp1, data1, zeroones
+	orr	tmp2, data1, #REP8_7f
+	eor	diff, data1, data2	/* Non-zero if differences found.  */
+	bic	has_nul, tmp1, tmp2	/* Non-zero if NUL terminator.  */
+	orr	syndrome, diff, has_nul
+	cbz	syndrome, .Lloop_aligned
+	b	.Lcal_cmpresult
+
+.Lmutual_align:
+	/*
+	* Sources are mutually aligned, but are not currently at an
+	* alignment boundary.  Round down the addresses and then mask off
+	* the bytes that preceed the start point.
+	*/
+	bic	src1, src1, #7
+	bic	src2, src2, #7
+	lsl	tmp1, tmp1, #3		/* Bytes beyond alignment -> bits.  */
+	ldr	data1, [src1], #8
+	neg	tmp1, tmp1		/* Bits to alignment -64.  */
+	ldr	data2, [src2], #8
+	mov	tmp2, #~0
+#ifdef __ARM64EB__
+	/* Big-endian.  Early bytes are at MSB.  */
+	lsl	tmp2, tmp2, tmp1	/* Shift (tmp1 & 63).  */
+#else
+	/* Little-endian.  Early bytes are at LSB.  */
+	lsr	tmp2, tmp2, tmp1	/* Shift (tmp1 & 63).  */
+#endif
+	orr	data1, data1, tmp2
+	orr	data2, data2, tmp2
+	b	.Lstart_realigned
+
+.Lmisaligned8:
+	/*
+	* Get the align offset length to compare per byte first.
+	* After this process, one string's address will be aligned.
+	*/
+	and	tmp1, src1, #7
+	neg	tmp1, tmp1
+	add	tmp1, tmp1, #8
+	and	tmp2, src2, #7
+	neg	tmp2, tmp2
+	add	tmp2, tmp2, #8
+	subs	tmp3, tmp1, tmp2
+	csel	pos, tmp1, tmp2, hi /*Choose the maximum. */
+.Ltinycmp:
+	ldrb	data1w, [src1], #1
+	ldrb	data2w, [src2], #1
+	subs	pos, pos, #1
+	ccmp	data1w, #1, #0, ne  /* NZCV = 0b0000.  */
+	ccmp	data1w, data2w, #0, cs  /* NZCV = 0b0000.  */
+	b.eq	.Ltinycmp
+	cbnz	pos, 1f /*find the null or unequal...*/
+	cmp	data1w, #1
+	ccmp	data1w, data2w, #0, cs
+	b.eq	.Lstart_align /*the last bytes are equal....*/
+1:
+	sub	result, data1, data2
+	ret
+
+.Lstart_align:
+	ands	xzr, src1, #7
+	/*
+	* eq means tmp1 src1 is aligned now;
+	* tmp3 is positive for this branch.
+	*/
+	b.eq	.Lrecal_offset
+	add	src1, src1, tmp3
+	add	src2, src2, tmp3
+	ldr	data1, [src1], #8
+	ldr	data2, [src2], #8
+
+	sub	tmp1, data1, zeroones
+	orr	tmp2, data1, #REP8_7f
+	bic	has_nul, tmp1, tmp2
+	eor	diff, data1, data2 /* Non-zero if differences found.  */
+	orr	syndrome, diff, has_nul
+	cbnz	syndrome, .Lcal_cmpresult
+	and	tmp3, tmp3, #7  /*tmp3 = 8 + tmp3 ( old tmp3 is negative)*/
+	/*
+	* src1 is aligned and src1 is in the right of src2.
+	* start to compare the next 8 bytes of two strings.
+	*/
+.Lrecal_offset:
+	neg	pos, tmp3
+.Lloopcmp_proc:
+	/*
+	* Fall back pos bytes, get the first bytes segment of one Dword of src1.
+	* pos is negative here. We also can  use :
+	* ldr	data1, [src1]
+	* ldr	data2, [src2, pos]
+	* These two instructions will read data with aligned address.
+	* But if we adapt this method, have to add some shift and mask out
+	* some bits from these two Dwords to construct two new Dwords.
+	* Some more instructions will be added,and most important,
+	* it will need more time cost.
+	*/
+	ldr	data1, [src1,pos]
+	ldr	data2, [src2,pos]
+	sub	tmp1, data1, zeroones
+	orr	tmp2, data1, #REP8_7f
+	bic	has_nul, tmp1, tmp2
+	eor	diff, data1, data2  /* Non-zero if differences found.  */
+	orr	syndrome, diff, has_nul
+	cbnz	syndrome, .Lcal_cmpresult
+
+	/*The second part process*/
+	ldr	data1, [src1], #8
+	ldr	data2, [src2], #8
+	sub	tmp1, data1, zeroones
+	orr	tmp2, data1, #REP8_7f
+	bic	has_nul, tmp1, tmp2
+	eor	diff, data1, data2  /* Non-zero if differences found.  */
+	orr	syndrome, diff, has_nul
+	cbz	syndrome, .Lloopcmp_proc
+
+.Lcal_cmpresult:
+#ifndef	__ARM64EB__
+	rev	syndrome, syndrome
+	rev	data1, data1
+	/*
+	* The MS-non-zero bit of the syndrome marks either the first bit
+	* that is different, or the top bit of the first zero byte.
+	* Shifting left now will bring the critical information into the
+	* top bits.
+	*/
+	clz	pos, syndrome
+	rev	data2, data2
+	lsl	data1, data1, pos
+	lsl	data2, data2, pos
+	/*
+	* But we need to zero-extend (char is unsigned) the value and then
+	* perform a signed 32-bit subtraction.
+	*/
+	lsr	data1, data1, #56
+	sub	result, data1, data2, lsr #56
+	ret
+#else
+	/*
+	* For big-endian we cannot use the trick with the syndrome value
+	* as carry-propagation can corrupt the upper bits if the trailing
+	* bytes in the string contain 0x01.
+	* However, if there is no NUL byte in the dword, we can generate
+	* the result directly.  We can't just subtract the bytes as the
+	* MSB might be significant.
+	*/
+	cbnz	has_nul, 1f
+	cmp	data1, data2
+	cset	result, ne
+	cneg	result, result, lo
+	ret
+1:
+	/*Re-compute the NUL-byte detection, using a byte-reversed value. */
+	rev	tmp3, data1
+	sub	tmp1, tmp3, zeroones
+	orr	tmp2, tmp3, #REP8_7f
+	bic	has_nul, tmp1, tmp2
+	rev	has_nul, has_nul
+	orr	syndrome, diff, has_nul
+	clz	pos, syndrome
+	/*
+	* The MS-non-zero bit of the syndrome marks either the first bit
+	* that is different, or the top bit of the first zero byte.
+	* Shifting left now will bring the critical information into the
+	* top bits.
+	*/
+	lsl	data1, data1, pos
+	lsl	data2, data2, pos
+	/*
+	* But we need to zero-extend (char is unsigned) the value and then
+	* perform a signed 32-bit subtraction.
+	*/
+	lsr	data1, data1, #56
+	sub	result, data1, data2, lsr #56
+	ret
+#endif
+ENDPROC(strcmp)
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
new file mode 100644
index 0000000..e883fd3
--- /dev/null
+++ b/arch/arm64/lib/strncmp.S
@@ -0,0 +1,340 @@
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
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+/*
+ * compare two strings
+ *
+ * Parameters:
+ *  x0 - const string 1 pointer
+ *  x1 - const string 2 pointer
+ *  x2 - the maximal length to be compared
+ * Returns:
+ *  x0 - an integer less than, equal to, or greater than zero if s1 is found,
+ *     respectively, to be less than, to match, or be greater than s2.
+ */
+
+#define REP8_01 0x0101010101010101
+#define REP8_7f 0x7f7f7f7f7f7f7f7f
+#define REP8_80 0x8080808080808080
+
+/* Parameters and result.  */
+#define src1		x0
+#define src2		x1
+#define limit		x2
+#define result		x0
+
+/* Internal variables.  */
+#define data1		x3
+#define data1w		w3
+#define data2		x4
+#define data2w		w4
+#define has_nul		x5
+#define diff		x6
+#define syndrome	x7
+#define tmp1		x8
+#define tmp2		x9
+#define tmp3		x10
+#define zeroones	x11
+#define pos		x12
+#define limit_wd	x13
+#define mask		x14
+#define endloop		x15
+
+ENTRY(strncmp)
+	cbz	limit, .Lret0
+	eor	tmp1, src1, src2
+	mov	zeroones, #REP8_01
+	tst	tmp1, #7
+	b.ne	.Lmisaligned8
+	ands	tmp1, src1, #7
+	b.ne	.Lmutual_align
+	/* Calculate the number of full and partial words -1.  */
+	/*
+	* when limit is mulitply of 8, if not sub 1,
+	* the judgement of last dword will wrong.
+	*/
+	sub	limit_wd, limit, #1 /* limit != 0, so no underflow.  */
+	lsr	limit_wd, limit_wd, #3  /* Convert to Dwords.  */
+
+	/*
+	* NUL detection works on the principle that (X - 1) & (~X) & 0x80
+	* (=> (X - 1) & ~(X | 0x7f)) is non-zero iff a byte is zero, and
+	* can be done in parallel across the entire word.
+	*/
+.Lloop_aligned:
+	ldr	data1, [src1], #8
+	ldr	data2, [src2], #8
+.Lstart_realigned:
+	subs	limit_wd, limit_wd, #1
+	sub	tmp1, data1, zeroones
+	orr	tmp2, data1, #REP8_7f
+	eor	diff, data1, data2  /* Non-zero if differences found.  */
+	csinv	endloop, diff, xzr, pl  /* Last Dword or differences.*/
+	bics	has_nul, tmp1, tmp2 /* Non-zero if NUL terminator.  */
+	ccmp	endloop, #0, #0, eq
+	b.eq	.Lloop_aligned
+
+	/*Not reached the limit, must have found the end or a diff.  */
+	tbz	limit_wd, #63, .Lnot_limit
+
+	/* Limit % 8 == 0 => all bytes significant.  */
+	ands	limit, limit, #7
+	b.eq	.Lnot_limit
+
+	lsl	limit, limit, #3    /* Bits -> bytes.  */
+	mov	mask, #~0
+#ifdef __ARM64EB__
+	lsr	mask, mask, limit
+#else
+	lsl	mask, mask, limit
+#endif
+	bic	data1, data1, mask
+	bic	data2, data2, mask
+
+	/* Make sure that the NUL byte is marked in the syndrome.  */
+	orr	has_nul, has_nul, mask
+
+.Lnot_limit:
+	orr	syndrome, diff, has_nul
+	b	.Lcal_cmpresult
+
+.Lmutual_align:
+	/*
+	* Sources are mutually aligned, but are not currently at an
+	* alignment boundary.  Round down the addresses and then mask off
+	* the bytes that precede the start point.
+	* We also need to adjust the limit calculations, but without
+	* overflowing if the limit is near ULONG_MAX.
+	*/
+	bic	src1, src1, #7
+	bic	src2, src2, #7
+	ldr	data1, [src1], #8
+	neg	tmp3, tmp1, lsl #3  /* 64 - bits(bytes beyond align). */
+	ldr	data2, [src2], #8
+	mov	tmp2, #~0
+	sub	limit_wd, limit, #1 /* limit != 0, so no underflow.  */
+#ifdef __ARM64EB__
+	/* Big-endian.  Early bytes are at MSB.  */
+	lsl	tmp2, tmp2, tmp3    /* Shift (tmp1 & 63).  */
+#else
+	/* Little-endian.  Early bytes are at LSB.  */
+	lsr	tmp2, tmp2, tmp3    /* Shift (tmp1 & 63).  */
+#endif
+	and	tmp3, limit_wd, #7
+	lsr	limit_wd, limit_wd, #3
+	/* Adjust the limit. Only low 3 bits used, so overflow irrelevant.*/
+	add	limit, limit, tmp1
+	add	tmp3, tmp3, tmp1
+	orr	data1, data1, tmp2
+	orr	data2, data2, tmp2
+	add	limit_wd, limit_wd, tmp3, lsr #3
+	b	.Lstart_realigned
+
+/*when src1 offset is not equal to src2 offset...*/
+.Lmisaligned8:
+	cmp	limit, #8
+	b.lo	.Ltiny8proc /*limit < 8... */
+	/*
+	* Get the align offset length to compare per byte first.
+	* After this process, one string's address will be aligned.*/
+	and	tmp1, src1, #7
+	neg	tmp1, tmp1
+	add	tmp1, tmp1, #8
+	and	tmp2, src2, #7
+	neg	tmp2, tmp2
+	add	tmp2, tmp2, #8
+	subs	tmp3, tmp1, tmp2
+	csel	pos, tmp1, tmp2, hi /*Choose the maximum. */
+	/*
+	* Here, limit is not less than 8, so directly run .Ltinycmp
+	* without checking the limit.*/
+	sub	limit, limit, pos
+.Ltinycmp:
+	ldrb	data1w, [src1], #1
+	ldrb	data2w, [src2], #1
+	subs	pos, pos, #1
+	ccmp	data1w, #1, #0, ne  /* NZCV = 0b0000.  */
+	ccmp	data1w, data2w, #0, cs  /* NZCV = 0b0000.  */
+	b.eq	.Ltinycmp
+	cbnz	pos, 1f /*find the null or unequal...*/
+	cmp	data1w, #1
+	ccmp	data1w, data2w, #0, cs
+	b.eq	.Lstart_align /*the last bytes are equal....*/
+1:
+	sub	result, data1, data2
+	ret
+
+.Lstart_align:
+	lsr	limit_wd, limit, #3
+	cbz	limit_wd, .Lremain8
+	ands	xzr, src1, #7
+	/*eq means src1 is aligned now,tmp3 is positive in this branch.*/
+	b.eq	.Lrecal_offset
+	add	src1, src1, tmp3
+	add	src2, src2, tmp3
+	ldr	data1, [src1], #8
+	ldr	data2, [src2], #8
+	/*
+	* since tmp3 is negative and limit is not less than 8,so cbz is not
+	* needed..
+	*/
+	sub	limit, limit, tmp3
+	lsr	limit_wd, limit, #3
+	subs	limit_wd, limit_wd, #1
+
+	sub	tmp1, data1, zeroones
+	orr	tmp2, data1, #REP8_7f
+	eor	diff, data1, data2  /* Non-zero if differences found.  */
+	csinv	endloop, diff, xzr, ne/*if limit_wd is 0,will finish the cmp*/
+	bics	has_nul, tmp1, tmp2
+	ccmp	endloop, #0, #0, eq /*has_null is ZERO: no null byte*/
+	b.ne	.Lunequal_proc
+	and	tmp3, tmp3, #7  /*tmp3 = 8 + tmp3 ( old tmp3 is negative)*/
+	/*
+	* src1 is aligned and src1 is in the right of src2.
+	* start the next 8 bytes compare..
+	*/
+.Lrecal_offset:
+	neg	pos, tmp3
+.Lloopcmp_proc:
+	/*
+	* Fall back pos bytes, get the first bytes segment of one Dword of src1.
+	* pos is negative here. We also can  use :
+	* ldr	data1, [src1]
+	* ldr	data2, [src2, pos]
+	* These two instructions will read data with aligned address.
+	* But if we adapt this method, have to  add some shift and mask out
+	* some bits from these two Dword to construct two new Dwords.
+	* Some more instructions will be added,
+	* and most important, it will need more time cost.
+	*/
+	ldr	data1, [src1,pos]
+	ldr	data2, [src2,pos]
+	sub	tmp1, data1, zeroones
+	orr	tmp2, data1, #REP8_7f
+	bics	has_nul, tmp1, tmp2 /* Non-zero if NUL terminator.  */
+	eor	diff, data1, data2  /* Non-zero if differences found.  */
+	csinv	endloop, diff, xzr, eq
+	cbnz	endloop, .Lunequal_proc
+
+	/*The second part process*/
+	ldr	data1, [src1], #8
+	ldr	data2, [src2], #8
+	subs	limit_wd, limit_wd, #1
+	sub	tmp1, data1, zeroones
+	orr	tmp2, data1, #REP8_7f
+	eor	diff, data1, data2  /* Non-zero if differences found.  */
+	csinv	endloop, diff, xzr, ne/*if limit_wd is 0,will finish the cmp*/
+	bics	has_nul, tmp1, tmp2
+	ccmp	endloop, #0, #0, eq /*has_null is ZERO: no null byte*/
+	b.eq	.Lloopcmp_proc
+
+.Lunequal_proc:
+	orr	syndrome, diff, has_nul
+	cbz	syndrome, .Lremain8
+.Lcal_cmpresult:
+#ifndef	__ARM64EB__
+	rev	syndrome, syndrome
+	rev	data1, data1
+	/*
+	* The MS-non-zero bit of the syndrome marks either the first bit
+	* that is different, or the top bit of the first zero byte.
+	* Shifting left now will bring the critical information into the
+	* top bits.
+	*/
+	clz	pos, syndrome
+	rev	data2, data2
+	lsl	data1, data1, pos
+	lsl	data2, data2, pos
+	/* But we need to zero-extend (char is unsigned) the value and then
+	perform a signed 32-bit subtraction.  */
+	lsr	data1, data1, #56
+	sub	result, data1, data2, lsr #56
+	ret
+#else
+	/*
+	* For big-endian we cannot use the trick with the syndrome value
+	* as carry-propagation can corrupt the upper bits if the trailing
+	* bytes in the string contain 0x01.
+	* However, if there is no NUL byte in the dword, we can generate
+	* the result directly.  We can't just subtract the bytes as the
+	* MSB might be significant.
+	*/
+	cbnz	has_nul, 1f
+	cmp	data1, data2
+	cset	result, ne
+	cneg	result, result, lo
+	ret
+1:
+	/* Re-compute the NUL-byte detection, using a byte-reversed value.*/
+	rev	tmp3, data1
+	sub	tmp1, tmp3, zeroones
+	orr	tmp2, tmp3, #REP8_7f
+	bic	has_nul, tmp1, tmp2
+	rev	has_nul, has_nul
+	orr	syndrome, diff, has_nul
+	clz	pos, syndrome
+	/*
+	* The MS-non-zero bit of the syndrome marks either the first bit
+	* that is different, or the top bit of the first zero byte.
+	* Shifting left now will bring the critical information into the
+	* top bits.
+	*/
+	lsl	data1, data1, pos
+	lsl	data2, data2, pos
+	/*
+	* But we need to zero-extend (char is unsigned) the value and then
+	* perform a signed 32-bit subtraction.
+	*/
+	lsr	data1, data1, #56
+	sub	result, data1, data2, lsr #56
+	ret
+#endif
+
+.Lremain8:
+	/* Limit % 8 == 0 => all bytes significant.  */
+	ands	limit, limit, #7
+	b.eq	.Lret0
+.Ltiny8proc:
+	/* Perhaps we can do better than this.  */
+	ldrb	data1w, [src1], #1
+	ldrb	data2w, [src2], #1
+	subs	limit, limit, #1
+	/*
+	* nz satisfied means current limit > 0.
+	* Z=1 will make cs =0, lead to next ccmp use ZERO to set flags
+	*/
+	ccmp	data1w, #1, #0, ne  /* NZCV = 0b0000.  */
+	ccmp	data1w, data2w, #0, cs  /* NZCV = 0b0000.  */
+	b.eq	.Ltiny8proc
+	sub	result, data1, data2
+	ret
+
+.Lret0:
+	mov	result, #0
+	ret
+ENDPROC(strncmp)
-- 
1.7.9.5
