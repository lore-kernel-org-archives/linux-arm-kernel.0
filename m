From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Dec 2017 12:26:44 +0000
Subject: [PATCH v2 18/19] crypto: arm64/crct10dif-ce - yield NEON every 8
 blocks of input
In-Reply-To: <20171204122645.31535-1-ard.biesheuvel@linaro.org>
References: <20171204122645.31535-1-ard.biesheuvel@linaro.org>
Message-ID: <20171204122645.31535-19-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid excessive scheduling delays under a preemptible kernel by
yielding the NEON every 8 blocks of input.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/crct10dif-ce-core.S | 39 ++++++++++++++++++--
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/crypto/crct10dif-ce-core.S b/arch/arm64/crypto/crct10dif-ce-core.S
index d5b5a8c038c8..d57067e80bae 100644
--- a/arch/arm64/crypto/crct10dif-ce-core.S
+++ b/arch/arm64/crypto/crct10dif-ce-core.S
@@ -74,13 +74,22 @@
 	.text
 	.cpu		generic+crypto
 
-	arg1_low32	.req	w0
-	arg2		.req	x1
-	arg3		.req	x2
+	arg1_low32	.req	w19
+	arg2		.req	x20
+	arg3		.req	x21
 
 	vzr		.req	v13
 
 ENTRY(crc_t10dif_pmull)
+	stp		x29, x30, [sp, #-176]!
+	mov		x29, sp
+	stp		x19, x20, [sp, #16]
+	stp		x21, x22, [sp, #32]
+
+	mov		arg1_low32, w0
+	mov		arg2, x1
+	mov		arg3, x2
+
 	movi		vzr.16b, #0		// init zero register
 
 	// adjust the 16-bit initial_crc value, scale it to 32 bits
@@ -175,8 +184,27 @@ CPU_LE(	ext		v12.16b, v12.16b, v12.16b, #8	)
 	subs		arg3, arg3, #128
 
 	// check if there is another 64B in the buffer to be able to fold
-	b.ge		_fold_64_B_loop
+	b.lt		_fold_64_B_end
+
+	yield_neon_pre	arg3, 3, 128, _fold_64_B_loop	// yield every 8 blocks
+	stp		q0, q1, [sp, #48]
+	stp		q2, q3, [sp, #80]
+	stp		q4, q5, [sp, #112]
+	stp		q6, q7, [sp, #144]
+	yield_neon_post	2f
+	b		_fold_64_B_loop
+
+	.subsection	1
+2:	ldp		q0, q1, [sp, #48]
+	ldp		q2, q3, [sp, #80]
+	ldp		q4, q5, [sp, #112]
+	ldp		q6, q7, [sp, #144]
+	ldr		q10, rk3
+	movi		vzr.16b, #0		// init zero register
+	b		_fold_64_B_loop
+	.previous
 
+_fold_64_B_end:
 	// at this point, the buffer pointer is pointing at the last y Bytes
 	// of the buffer the 64B of folded data is in 4 of the vector
 	// registers: v0, v1, v2, v3
@@ -304,6 +332,9 @@ _barrett:
 _cleanup:
 	// scale the result back to 16 bits
 	lsr		x0, x0, #16
+	ldp		x19, x20, [sp, #16]
+	ldp		x21, x22, [sp, #32]
+	ldp		x29, x30, [sp], #176
 	ret
 
 _less_than_128:
-- 
2.11.0
