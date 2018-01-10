From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 10 Jan 2018 12:11:42 +0000
Subject: [PATCH 7/7] arm64/crypto: sha1-ce: get rid of literal pool
In-Reply-To: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
References: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
Message-ID: <20180110121142.18291-8-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Load the four SHA-1 round constants using immediates rather than literal
pool entries, to avoid having executable data that may be exploitable
under speculation attacks.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/sha1-ce-core.S | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/crypto/sha1-ce-core.S b/arch/arm64/crypto/sha1-ce-core.S
index 8550408735a0..46049850727d 100644
--- a/arch/arm64/crypto/sha1-ce-core.S
+++ b/arch/arm64/crypto/sha1-ce-core.S
@@ -58,12 +58,11 @@
 	sha1su1		v\s0\().4s, v\s3\().4s
 	.endm
 
-	/*
-	 * The SHA1 round constants
-	 */
-	.align		4
-.Lsha1_rcon:
-	.word		0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6
+	.macro		loadrc, k, val, tmp
+	movz		\tmp, :abs_g0_nc:\val
+	movk		\tmp, :abs_g1:\val
+	dup		\k, \tmp
+	.endm
 
 	/*
 	 * void sha1_ce_transform(struct sha1_ce_state *sst, u8 const *src,
@@ -71,11 +70,10 @@
 	 */
 ENTRY(sha1_ce_transform)
 	/* load round constants */
-	adr		x6, .Lsha1_rcon
-	ld1r		{k0.4s}, [x6], #4
-	ld1r		{k1.4s}, [x6], #4
-	ld1r		{k2.4s}, [x6], #4
-	ld1r		{k3.4s}, [x6]
+	loadrc		k0.4s, 0x5a827999, w6
+	loadrc		k1.4s, 0x6ed9eba1, w6
+	loadrc		k2.4s, 0x8f1bbcdc, w6
+	loadrc		k3.4s, 0xca62c1d6, w6
 
 	/* load state */
 	ld1		{dgav.4s}, [x0]
-- 
2.11.0
