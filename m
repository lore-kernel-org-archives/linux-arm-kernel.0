From: ebiggers3@gmail.com (Eric Biggers)
Date: Tue, 24 Jul 2018 18:29:07 -0700
Subject: [PATCH] crypto: arm/chacha20 - always use vrev for 16-bit rotates
Message-ID: <20180725012907.1614-1-ebiggers3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Biggers <ebiggers@google.com>

The 4-way ChaCha20 NEON code implements 16-bit rotates with vrev32.16,
but the one-way code (used on remainder blocks) implements it with
vshl + vsri, which is slower.  Switch the one-way code to vrev32.16 too.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/crypto/chacha20-neon-core.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/crypto/chacha20-neon-core.S b/arch/arm/crypto/chacha20-neon-core.S
index 3fecb2124c35..451a849ad518 100644
--- a/arch/arm/crypto/chacha20-neon-core.S
+++ b/arch/arm/crypto/chacha20-neon-core.S
@@ -51,9 +51,8 @@ ENTRY(chacha20_block_xor_neon)
 .Ldoubleround:
 	// x0 += x1, x3 = rotl32(x3 ^ x0, 16)
 	vadd.i32	q0, q0, q1
-	veor		q4, q3, q0
-	vshl.u32	q3, q4, #16
-	vsri.u32	q3, q4, #16
+	veor		q3, q3, q0
+	vrev32.16	q3, q3
 
 	// x2 += x3, x1 = rotl32(x1 ^ x2, 12)
 	vadd.i32	q2, q2, q3
@@ -82,9 +81,8 @@ ENTRY(chacha20_block_xor_neon)
 
 	// x0 += x1, x3 = rotl32(x3 ^ x0, 16)
 	vadd.i32	q0, q0, q1
-	veor		q4, q3, q0
-	vshl.u32	q3, q4, #16
-	vsri.u32	q3, q4, #16
+	veor		q3, q3, q0
+	vrev32.16	q3, q3
 
 	// x2 += x3, x1 = rotl32(x1 ^ x2, 12)
 	vadd.i32	q2, q2, q3
-- 
2.18.0
