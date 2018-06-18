From: ebiggers@google.com (Eric Biggers)
Date: Mon, 18 Jun 2018 15:33:23 -0700
Subject: [PATCH] crypto: arm/speck - fix building in Thumb2 mode
Message-ID: <20180618223323.130072-1-ebiggers@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building the kernel with CONFIG_THUMB2_KERNEL=y and
CONFIG_CRYPTO_SPECK_NEON set fails with the following errors:

    arch/arm/crypto/speck-neon-core.S: Assembler messages:

    arch/arm/crypto/speck-neon-core.S:419: Error: r13 not allowed here -- `bic sp,#0xf'
    arch/arm/crypto/speck-neon-core.S:423: Error: r13 not allowed here -- `bic sp,#0xf'
    arch/arm/crypto/speck-neon-core.S:427: Error: r13 not allowed here -- `bic sp,#0xf'
    arch/arm/crypto/speck-neon-core.S:431: Error: r13 not allowed here -- `bic sp,#0xf'

The problem is that the 'bic' instruction can't operate on the 'sp'
register in Thumb2 mode.  Fix it by using a temporary register.  This
isn't in the main loop, so the performance difference is negligible.
This also matches what aes-neonbs-core.S does.

Reported-by: Stefan Agner <stefan@agner.ch>
Fixes: ede9622162fa ("crypto: arm/speck - add NEON-accelerated implementation of Speck-XTS")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/crypto/speck-neon-core.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/crypto/speck-neon-core.S b/arch/arm/crypto/speck-neon-core.S
index 3c1e203e53b9..57caa742016e 100644
--- a/arch/arm/crypto/speck-neon-core.S
+++ b/arch/arm/crypto/speck-neon-core.S
@@ -272,9 +272,11 @@
 	 * Allocate stack space to store 128 bytes worth of tweaks.  For
 	 * performance, this space is aligned to a 16-byte boundary so that we
 	 * can use the load/store instructions that declare 16-byte alignment.
+	 * For Thumb2 compatibility, don't do the 'bic' directly on 'sp'.
 	 */
-	sub		sp, #128
-	bic		sp, #0xf
+	sub		r12, sp, #128
+	bic		r12, #0xf
+	mov		sp, r12
 
 .if \n == 64
 	// Load first tweak
-- 
2.18.0.rc1.244.gcf134e6275-goog
