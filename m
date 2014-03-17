From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 17 Mar 2014 16:55:51 +0100
Subject: [PATCH] arm64/lib: add optimized implementation of sha_transform
Message-ID: <1395071751-17474-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implementation keeps the 64 bytes of workspace in registers rather than
on the stack, eliminating most of the loads and stores, and reducing the
instruction count by about 25%.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

@Catalin: I assumed x18 has no special significance in the kernel, so I am
using it as a temp register without preserving it. Is this correct?

Changes since v1:
- as suggested in feedback I received off list, it makes sense to schedule
  more carefully for an in-order pipeline (A53?), so the rounds are now
  2-way interleaved and combined with the schedule updates
- use named constants rather than bare numbers
- use ldnp for loading the input (non-temporal hint)

 arch/arm64/kernel/arm64ksyms.c |   3 +
 arch/arm64/lib/Makefile        |   2 +-
 arch/arm64/lib/sha1.S          | 277 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 281 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/lib/sha1.S

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 338b568cd8ae..1f5693fb5d93 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -56,3 +56,6 @@ EXPORT_SYMBOL(clear_bit);
 EXPORT_SYMBOL(test_and_clear_bit);
 EXPORT_SYMBOL(change_bit);
 EXPORT_SYMBOL(test_and_change_bit);
+
+	/* SHA-1 implementation under lib/ */
+EXPORT_SYMBOL(sha_transform);
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 328ce1a99daa..ea093ebb9a9a 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -1,4 +1,4 @@
 lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
 		   copy_to_user.o copy_in_user.o copy_page.o		\
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
-		   strchr.o strrchr.o
+		   strchr.o strrchr.o sha1.o
diff --git a/arch/arm64/lib/sha1.S b/arch/arm64/lib/sha1.S
new file mode 100644
index 000000000000..5c472f32f917
--- /dev/null
+++ b/arch/arm64/lib/sha1.S
@@ -0,0 +1,277 @@
+/*
+ * linux/arch/arm64/lib/sha1.S
+ *
+ * Copyright (C) 2014 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+	.text
+	.altmacro
+
+	wA		.req	w2
+	wB		.req	w3
+	wC		.req	w4
+	wD		.req	w5
+	wE		.req	w6
+
+	k		.req	w7
+
+	t0		.req	w16
+	t1		.req	w17
+	t2		.req	w18
+	t3		.req	w1
+
+	xt0		.req	x16
+	xt1		.req	x17
+	xt2		.req	x18
+	xt3		.req	x1
+
+	.macro		load_k_hi, reg, rc
+	.ifnb		rc
+	movz		\reg, #:abs_g1:\rc
+	.endif
+	.endm
+
+	.macro		load_k_lo, reg, rc
+	.ifnb		rc
+	movk		\reg, #:abs_g0_nc:\rc
+	.endif
+	.endm
+
+	.macro		inp_2rounds, in, a, b, c, d, e, rc
+	eor		t0, \c, \d
+	.irp		in2, %(in | 1)
+	.ifne		in ^ in2
+	ldnp		x\in, x\in2, [x1, #8 * (\in - 8)]
+	.endif
+	.endr
+	load_k_hi	k, \rc
+	and		t0, t0, \b
+	load_k_lo	k, \rc
+	ror		\b, \b, #2
+	eor		t0, t0, \d
+	eor		t1, \b, \c
+CPU_LE(	rev32		x\in, x\in	)
+	add		t0, t0, \e
+	ror		\e, \a, #(32 - 5)
+	and		t1, t1, \a
+	add		\e, \e, k
+	add		t0, t0, w\in
+	eor		t1, t1, \c
+	add		\e, \e, t0
+	add		t1, t1, \d
+	ror		\d, \e, #(32 - 5)
+	add		xt1, xt1, x\in, lsr #32
+	add		\d, \d, k
+	ror		\a, \a, #2
+	add		\d, \d, t1
+	.endm
+
+	.macro		cho_2rounds, a, b, c, d, e, st0, st1, st4, st6, st7
+	extr		xt2, x\st7, x\st6, #32
+	eor		t0, \c, \d
+	eor		x\st0, x\st0, x\st1
+	and		t0, t0, \b
+	eor		xt2, xt2, x\st4
+	ror		\b, \b, #2
+	eor		xt2, xt2, x\st0
+	eor		t0, t0, \d
+	eor		t1, \b, \c
+	ror		t3, t2, #(32 - 1)
+	add		t0, t0, \e
+	lsr		xt2, xt2, #32
+	and		t1, t1, \a
+	ror		t2, t2, #(32 - 1)
+	ror		\e, \a, #(32 - 5)
+	eor		t1, t1, \c
+	add		\e, \e, k
+	add		t0, t0, t3
+	ror		\a, \a, #2
+	add		\e, \e, t0
+	add		t1, t1, \d
+	ror		\d, \e, #(32 - 5)
+	add		t1, t1, t2
+	add		\d, \d, k
+	orr		x\st0, xt3, xt2, lsl #32
+	add		\d, \d, t1
+	.endm
+
+	.macro		par_2rounds, a, b, c, d, e, st0, st1, st4, st6, st7, rc
+	extr		xt2, x\st7, x\st6, #32
+	load_k_hi	k, \rc
+	eor		x\st0, x\st0, x\st1
+	eor		t0, \b, \c
+	load_k_lo	k, \rc
+	eor		xt2, xt2, x\st4
+	ror		\b, \b, #2
+	eor		xt2, xt2, x\st0
+	eor		t0, t0, \d
+	ror		t3, t2, #(32 - 1)
+	eor		t1, \a, \b
+	lsr		xt2, xt2, #32
+	add		t0, t0, \e
+	ror		t2, t2, #(32 - 1)
+	ror		\e, \a, #(32 - 5)
+	eor		t1, t1, \c
+	add		\e, \e, k
+	add		t0, t0, t3
+	ror		\a, \a, #2
+	add		\e, \e, t0
+	add		t1, t1, \d
+	ror		\d, \e, #(32 - 5)
+	add		t1, t1, t2
+	add		\d, \d, k
+	orr		x\st0, xt3, xt2, lsl #32
+	add		\d, \d, t1
+	.endm
+
+	.macro		maj_2rounds, a, b, c, d, e, st0, st1, st4, st6, st7, rc
+	extr		xt2, x\st7, x\st6, #32
+	load_k_hi	k, \rc
+	eor		t1, \b, \c
+	eor		x\st0, x\st0, x\st1
+	and		t0, \b, \c
+	load_k_lo	k, \rc
+	eor		xt2, xt2, x\st4
+	ror		\b, \b, #2
+	and		t1, t1, \d
+	eor		t3, \a, \b
+	add		t0, t0, t1
+	and		t1, \a, \b
+	and		t3, t3, \c
+	eor		xt2, xt2, x\st0
+	add		t1, t1, t3
+	ror		t3, t2, #(32 - 1)
+	lsr		xt2, xt2, #32
+	add		t0, t0, \e
+	ror		\e, \a, #(32 - 5)
+	ror		t2, t2, #(32 - 1)
+	add		\e, \e, k
+	add		t0, t0, t3
+	ror		\a, \a, #2
+	add		\e, \e, t0
+	add		t1, t1, \d
+	ror		\d, \e, #(32 - 5)
+	add		t1, t1, t2
+	add		\d, \d, k
+	orr		x\st0, xt3, xt2, lsl #32
+	add		\d, \d, t1
+	.endm
+
+	.macro		mix_2rounds, in, a, b, c, d, e, f, rc
+			st1 = (in + 1) % 8 + 8
+			st4 = (in + 4) % 8 + 8
+			st6 = (in + 6) % 8 + 8
+			st7 = (in + 7) % 8 + 8
+	\f\()_2rounds	\a, \b, \c, \d, \e, \in, %st1, %st4, %st6, %st7, \rc
+	.endm
+
+	/*
+	 * The SHA-1 round constants
+	 */
+	.set		sha_rcon1, 0x5a827999
+	.set		sha_rcon2, 0x6ed9eba1
+	.set		sha_rcon3, 0x8f1bbcdc
+	.set		sha_rcon4, 0xca62c1d6
+
+	/*
+	 * void sha_transform(__u32 *digest, const char *data, __u32 *array)
+	 */
+ENTRY(sha_transform)
+	/* load digest input */
+	ldp		wC, wD, [x0, #8]
+	ldp		wA, wB, [x0]
+	ldr		wE, [x0, #16]
+
+	inp_2rounds	 8, wA, wB, wC, wD, wE, sha_rcon1
+	inp_2rounds	 9, wD, wE, wA, wB, wC
+	inp_2rounds	10, wB, wC, wD, wE, wA
+	inp_2rounds	11, wE, wA, wB, wC, wD
+	inp_2rounds	12, wC, wD, wE, wA, wB
+	inp_2rounds	13, wA, wB, wC, wD, wE
+	inp_2rounds	14, wD, wE, wA, wB, wC
+	inp_2rounds	15, wB, wC, wD, wE, wA
+	mix_2rounds	 8, wE, wA, wB, wC, wD, cho
+	mix_2rounds	 9, wC, wD, wE, wA, wB, cho
+
+	mix_2rounds	10, wA, wB, wC, wD, wE, par, sha_rcon2
+	mix_2rounds	11, wD, wE, wA, wB, wC, par
+	mix_2rounds	12, wB, wC, wD, wE, wA, par
+	mix_2rounds	13, wE, wA, wB, wC, wD, par
+	mix_2rounds	14, wC, wD, wE, wA, wB, par
+	mix_2rounds	15, wA, wB, wC, wD, wE, par
+	mix_2rounds	 8, wD, wE, wA, wB, wC, par
+	mix_2rounds	 9, wB, wC, wD, wE, wA, par
+	mix_2rounds	10, wE, wA, wB, wC, wD, par
+	mix_2rounds	11, wC, wD, wE, wA, wB, par
+
+	mix_2rounds	12, wA, wB, wC, wD, wE, maj, sha_rcon3
+	mix_2rounds	13, wD, wE, wA, wB, wC, maj
+	mix_2rounds	14, wB, wC, wD, wE, wA, maj
+	mix_2rounds	15, wE, wA, wB, wC, wD, maj
+	mix_2rounds	 8, wC, wD, wE, wA, wB, maj
+	mix_2rounds	 9, wA, wB, wC, wD, wE, maj
+	mix_2rounds	10, wD, wE, wA, wB, wC, maj
+	mix_2rounds	11, wB, wC, wD, wE, wA, maj
+	mix_2rounds	12, wE, wA, wB, wC, wD, maj
+	mix_2rounds	13, wC, wD, wE, wA, wB, maj
+
+	mix_2rounds	14, wA, wB, wC, wD, wE, par, sha_rcon4
+	mix_2rounds	15, wD, wE, wA, wB, wC, par
+	mix_2rounds	 8, wB, wC, wD, wE, wA, par
+	mix_2rounds	 9, wE, wA, wB, wC, wD, par
+	mix_2rounds	10, wC, wD, wE, wA, wB, par
+	mix_2rounds	11, wA, wB, wC, wD, wE, par
+	mix_2rounds	12, wD, wE, wA, wB, wC, par
+	mix_2rounds	13, wB, wC, wD, wE, wA, par
+	mix_2rounds	14, wE, wA, wB, wC, wD, par
+	mix_2rounds	15, wC, wD, wE, wA, wB, par
+
+	/* reload digest input */
+	ldr		w8, [x0]
+	ldp		w9, w10, [x0, #4]
+	ldp		w11, w12, [x0, #12]
+
+	/* add this block's output to digest */
+	add		wA, wA, w8
+	add		wB, wB, w9
+	add		wC, wC, w10
+	add		wD, wD, w11
+	add		wE, wE, w12
+
+	/* store digest */
+	str		wA, [x0]
+	stp		wB, wC, [x0, #4]
+	stp		wD, wE, [x0, #12]
+	ret
+ENDPROC(sha_transform)
+
+	/*
+	 * The SHA-1 digest initial values
+	 */
+.Lsha_init:
+	.word		0x67452301
+	.word		0xefcdab89
+	.word		0x98badcfe
+	.word		0x10325476
+	.word		0xc3d2e1f0
+
+	/*
+	 * void sha_init(__u32 *buf)
+	 */
+ENTRY(sha_init)
+	adr		xt0, .Lsha_init
+	ldr		wA, [xt0]
+	ldp		wB, wC, [xt0, #4]
+	ldp		wD, wE, [xt0, #12]
+	str		wA, [x0]
+	stp		wB, wC, [x0, #4]
+	stp		wD, wE, [x0, #12]
+	ret
+ENDPROC(sha_init)
-- 
1.8.3.2
