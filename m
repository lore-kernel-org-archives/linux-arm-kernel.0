From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 10 Mar 2018 15:22:06 +0000
Subject: [PATCH v5 21/23] crypto: arm64/sha512-ce - yield NEON after every
 block of input
In-Reply-To: <20180310152208.10369-1-ard.biesheuvel@linaro.org>
References: <20180310152208.10369-1-ard.biesheuvel@linaro.org>
Message-ID: <20180310152208.10369-22-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid excessive scheduling delays under a preemptible kernel by
conditionally yielding the NEON after every block of input.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/sha512-ce-core.S | 27 +++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/crypto/sha512-ce-core.S b/arch/arm64/crypto/sha512-ce-core.S
index 7f3bca5c59a2..ce65e3abe4f2 100644
--- a/arch/arm64/crypto/sha512-ce-core.S
+++ b/arch/arm64/crypto/sha512-ce-core.S
@@ -107,17 +107,23 @@
 	 */
 	.text
 ENTRY(sha512_ce_transform)
+	frame_push	3
+
+	mov		x19, x0
+	mov		x20, x1
+	mov		x21, x2
+
 	/* load state */
-	ld1		{v8.2d-v11.2d}, [x0]
+0:	ld1		{v8.2d-v11.2d}, [x19]
 
 	/* load first 4 round constants */
 	adr_l		x3, .Lsha512_rcon
 	ld1		{v20.2d-v23.2d}, [x3], #64
 
 	/* load input */
-0:	ld1		{v12.2d-v15.2d}, [x1], #64
-	ld1		{v16.2d-v19.2d}, [x1], #64
-	sub		w2, w2, #1
+1:	ld1		{v12.2d-v15.2d}, [x20], #64
+	ld1		{v16.2d-v19.2d}, [x20], #64
+	sub		w21, w21, #1
 
 CPU_LE(	rev64		v12.16b, v12.16b	)
 CPU_LE(	rev64		v13.16b, v13.16b	)
@@ -196,9 +202,18 @@ CPU_LE(	rev64		v19.16b, v19.16b	)
 	add		v11.2d, v11.2d, v3.2d
 
 	/* handled all input blocks? */
-	cbnz		w2, 0b
+	cbz		w21, 3f
+
+	if_will_cond_yield_neon
+	st1		{v8.2d-v11.2d}, [x19]
+	do_cond_yield_neon
+	b		0b
+	endif_yield_neon
+
+	b		1b
 
 	/* store new state */
-3:	st1		{v8.2d-v11.2d}, [x0]
+3:	st1		{v8.2d-v11.2d}, [x19]
+	frame_pop
 	ret
 ENDPROC(sha512_ce_transform)
-- 
2.15.1
