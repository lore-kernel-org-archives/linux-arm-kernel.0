From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Mar 2015 19:05:13 +0100
Subject: [PATCH] arm64/crypto: issue aese/aesmc instructions in pairs
Message-ID: <1426615513-28587-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes the AES core transform implementations to issue aese/aesmc
(and aesd/aesimc) in pairs. This enables a micro-architectural optimization
in recent Cortex-A5x cores that improves performance by 50-90%.

Measured performance in cycles per byte (Cortex-A57):

                CBC enc         CBC dec         CTR
  before        3.64            1.34            1.32
  after         1.95            0.85            0.93

Note that this results in a ~5% performance decrease for older cores.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

Will,

This is the optimization you yourself mentioned to me about a year ago
(or even longer perhaps?) Anyway, we have now been able to confirm it
on a sample 'in the wild', (i.e., a Galaxy S6 phone)

 arch/arm64/crypto/aes-ce-ccm-core.S | 12 ++++++------
 arch/arm64/crypto/aes-ce.S          | 10 +++-------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/crypto/aes-ce-ccm-core.S b/arch/arm64/crypto/aes-ce-ccm-core.S
index 432e4841cd81..a2a7fbcacc14 100644
--- a/arch/arm64/crypto/aes-ce-ccm-core.S
+++ b/arch/arm64/crypto/aes-ce-ccm-core.S
@@ -101,19 +101,19 @@ ENTRY(ce_aes_ccm_final)
 0:	mov	v4.16b, v3.16b
 1:	ld1	{v5.2d}, [x2], #16		/* load next round key */
 	aese	v0.16b, v4.16b
-	aese	v1.16b, v4.16b
 	aesmc	v0.16b, v0.16b
+	aese	v1.16b, v4.16b
 	aesmc	v1.16b, v1.16b
 2:	ld1	{v3.2d}, [x2], #16		/* load next round key */
 	aese	v0.16b, v5.16b
-	aese	v1.16b, v5.16b
 	aesmc	v0.16b, v0.16b
+	aese	v1.16b, v5.16b
 	aesmc	v1.16b, v1.16b
 3:	ld1	{v4.2d}, [x2], #16		/* load next round key */
 	subs	w3, w3, #3
 	aese	v0.16b, v3.16b
-	aese	v1.16b, v3.16b
 	aesmc	v0.16b, v0.16b
+	aese	v1.16b, v3.16b
 	aesmc	v1.16b, v1.16b
 	bpl	1b
 	aese	v0.16b, v4.16b
@@ -146,19 +146,19 @@ ENDPROC(ce_aes_ccm_final)
 	ld1	{v5.2d}, [x10], #16		/* load 2nd round key */
 2:	/* inner loop: 3 rounds, 2x interleaved */
 	aese	v0.16b, v4.16b
-	aese	v1.16b, v4.16b
 	aesmc	v0.16b, v0.16b
+	aese	v1.16b, v4.16b
 	aesmc	v1.16b, v1.16b
 3:	ld1	{v3.2d}, [x10], #16		/* load next round key */
 	aese	v0.16b, v5.16b
-	aese	v1.16b, v5.16b
 	aesmc	v0.16b, v0.16b
+	aese	v1.16b, v5.16b
 	aesmc	v1.16b, v1.16b
 4:	ld1	{v4.2d}, [x10], #16		/* load next round key */
 	subs	w7, w7, #3
 	aese	v0.16b, v3.16b
-	aese	v1.16b, v3.16b
 	aesmc	v0.16b, v0.16b
+	aese	v1.16b, v3.16b
 	aesmc	v1.16b, v1.16b
 	ld1	{v5.2d}, [x10], #16		/* load next round key */
 	bpl	2b
diff --git a/arch/arm64/crypto/aes-ce.S b/arch/arm64/crypto/aes-ce.S
index 685a18f731eb..78f3cfe92c08 100644
--- a/arch/arm64/crypto/aes-ce.S
+++ b/arch/arm64/crypto/aes-ce.S
@@ -45,18 +45,14 @@
 
 	.macro		do_enc_Nx, de, mc, k, i0, i1, i2, i3
 	aes\de		\i0\().16b, \k\().16b
-	.ifnb		\i1
-	aes\de		\i1\().16b, \k\().16b
-	.ifnb		\i3
-	aes\de		\i2\().16b, \k\().16b
-	aes\de		\i3\().16b, \k\().16b
-	.endif
-	.endif
 	aes\mc		\i0\().16b, \i0\().16b
 	.ifnb		\i1
+	aes\de		\i1\().16b, \k\().16b
 	aes\mc		\i1\().16b, \i1\().16b
 	.ifnb		\i3
+	aes\de		\i2\().16b, \k\().16b
 	aes\mc		\i2\().16b, \i2\().16b
+	aes\de		\i3\().16b, \k\().16b
 	aes\mc		\i3\().16b, \i3\().16b
 	.endif
 	.endif
-- 
1.8.3.2
