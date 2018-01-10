From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 10 Jan 2018 12:11:38 +0000
Subject: [PATCH 3/7] arm64/crypto: aes-neon: move literal data to .rodata
 section
In-Reply-To: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
References: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
Message-ID: <20180110121142.18291-4-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the S-boxes and some other literals to the .rodata section where
it is safe from being exploited by speculative execution.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/aes-neon.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/crypto/aes-neon.S b/arch/arm64/crypto/aes-neon.S
index f1e3aa2732f9..1c7b45b7268e 100644
--- a/arch/arm64/crypto/aes-neon.S
+++ b/arch/arm64/crypto/aes-neon.S
@@ -32,10 +32,10 @@
 
 	/* preload the entire Sbox */
 	.macro		prepare, sbox, shiftrows, temp
-	adr		\temp, \sbox
 	movi		v12.16b, #0x1b
-	ldr		q13, \shiftrows
-	ldr		q14, .Lror32by8
+	ldr_l		q13, \shiftrows, \temp
+	ldr_l		q14, .Lror32by8, \temp
+	adr_l		\temp, \sbox
 	ld1		{v16.16b-v19.16b}, [\temp], #64
 	ld1		{v20.16b-v23.16b}, [\temp], #64
 	ld1		{v24.16b-v27.16b}, [\temp], #64
@@ -272,7 +272,7 @@
 
 #include "aes-modes.S"
 
-	.text
+	.section	".rodata", "a"
 	.align		6
 .LForward_Sbox:
 	.byte		0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5
-- 
2.11.0
