From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Jan 2017 08:33:26 +0000
Subject: [PATCH] crypto: arm/aes - avoid reserved 'tt' mnemonic in asm code
Message-ID: <1484296406-13224-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv8-M architecture introduces 'tt' and 'ttt' instructions,
which means we can no longer use 'tt' as a register alias on recent
versions of binutils for ARM. So replace the alias with 'ttab'.

Fixes: 81edb4262975 ("crypto: arm/aes - replace scalar AES cipher")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/aes-cipher-core.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/crypto/aes-cipher-core.S b/arch/arm/crypto/aes-cipher-core.S
index b04261e1e068..c817a86c4ca8 100644
--- a/arch/arm/crypto/aes-cipher-core.S
+++ b/arch/arm/crypto/aes-cipher-core.S
@@ -18,7 +18,7 @@
 	rounds		.req	r1
 	in		.req	r2
 	out		.req	r3
-	tt		.req	ip
+	ttab		.req	ip
 
 	t0		.req	lr
 	t1		.req	r2
@@ -34,9 +34,9 @@
 
 	.macro		__load, out, in, idx
 	.if		__LINUX_ARM_ARCH__ < 7 && \idx > 0
-	ldr		\out, [tt, \in, lsr #(8 * \idx) - 2]
+	ldr		\out, [ttab, \in, lsr #(8 * \idx) - 2]
 	.else
-	ldr		\out, [tt, \in, lsl #2]
+	ldr		\out, [ttab, \in, lsl #2]
 	.endif
 	.endm
 
@@ -136,7 +136,7 @@
 	eor		r6, r6, r10
 	eor		r7, r7, r11
 
-	__adrl		tt, \ttab
+	__adrl		ttab, \ttab
 
 	tst		rounds, #2
 	bne		1f
@@ -146,7 +146,7 @@
 
 1:	subs		rounds, rounds, #4
 	\round		r8, r9, r10, r11, r4, r5, r6, r7
-	__adrl		tt, \ltab, ls
+	__adrl		ttab, \ltab, ls
 	\round		r4, r5, r6, r7, r8, r9, r10, r11
 	bhi		0b
 
-- 
2.7.4
