From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 10 Mar 2018 15:22:07 +0000
Subject: [PATCH v5 22/23] crypto: arm64/sm3-ce - yield NEON after every block
 of input
In-Reply-To: <20180310152208.10369-1-ard.biesheuvel@linaro.org>
References: <20180310152208.10369-1-ard.biesheuvel@linaro.org>
Message-ID: <20180310152208.10369-23-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid excessive scheduling delays under a preemptible kernel by
conditionally yielding the NEON after every block of input.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/sm3-ce-core.S | 30 +++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/crypto/sm3-ce-core.S b/arch/arm64/crypto/sm3-ce-core.S
index 27169fe07a68..5a116c8d0cee 100644
--- a/arch/arm64/crypto/sm3-ce-core.S
+++ b/arch/arm64/crypto/sm3-ce-core.S
@@ -77,19 +77,25 @@
 	 */
 	.text
 ENTRY(sm3_ce_transform)
+	frame_push	3
+
+	mov		x19, x0
+	mov		x20, x1
+	mov		x21, x2
+
 	/* load state */
-	ld1		{v8.4s-v9.4s}, [x0]
+	ld1		{v8.4s-v9.4s}, [x19]
 	rev64		v8.4s, v8.4s
 	rev64		v9.4s, v9.4s
 	ext		v8.16b, v8.16b, v8.16b, #8
 	ext		v9.16b, v9.16b, v9.16b, #8
 
-	adr_l		x8, .Lt
+0:	adr_l		x8, .Lt
 	ldp		s13, s14, [x8]
 
 	/* load input */
-0:	ld1		{v0.16b-v3.16b}, [x1], #64
-	sub		w2, w2, #1
+1:	ld1		{v0.16b-v3.16b}, [x20], #64
+	sub		w21, w21, #1
 
 	mov		v15.16b, v8.16b
 	mov		v16.16b, v9.16b
@@ -125,14 +131,24 @@ CPU_LE(	rev32		v3.16b, v3.16b		)
 	eor		v9.16b, v9.16b, v16.16b
 
 	/* handled all input blocks? */
-	cbnz		w2, 0b
+	cbz		w21, 2f
+
+	if_will_cond_yield_neon
+	st1		{v8.4s-v9.4s}, [x19]
+	do_cond_yield_neon
+	ld1		{v8.4s-v9.4s}, [x19]
+	b		0b
+	endif_yield_neon
+
+	b		1b
 
 	/* save state */
-	rev64		v8.4s, v8.4s
+2:	rev64		v8.4s, v8.4s
 	rev64		v9.4s, v9.4s
 	ext		v8.16b, v8.16b, v8.16b, #8
 	ext		v9.16b, v9.16b, v9.16b, #8
-	st1		{v8.4s-v9.4s}, [x0]
+	st1		{v8.4s-v9.4s}, [x19]
+	frame_pop
 	ret
 ENDPROC(sm3_ce_transform)
 
-- 
2.15.1
