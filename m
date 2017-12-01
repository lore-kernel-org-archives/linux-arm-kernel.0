From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  1 Dec 2017 21:19:26 +0000
Subject: [PATCH 4/5] crypto: arm64/chacha20 - move kernel mode neon en/disable
 into loop
In-Reply-To: <20171201211927.24653-1-ard.biesheuvel@linaro.org>
References: <20171201211927.24653-1-ard.biesheuvel@linaro.org>
Message-ID: <20171201211927.24653-5-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When kernel mode NEON was first introduced on arm64, the preserve and
restore of the userland NEON state was completely unoptimized, and
involved saving all registers on each call to kernel_neon_begin(),
and restoring them on each call to kernel_neon_end(). For this reason,
the NEON crypto code that was introduced at the time keeps the NEON
enabled throughout the execution of the crypto API methods, which may
include calls back into the crypto API that could result in memory
allocation or other actions that we should avoid when running with
preemption disabled.

Since then, we have optimized the kernel mode NEON handling, which now
restores lazily (upon return to userland), and so the preserve action
is only costly the first time it is called after entering the kernel.

So let's put the kernel_neon_begin() and kernel_neon_end() calls around
the actual invocations of the NEON crypto code, and run the remainder of
the code with kernel mode NEON disabled (and preemption enabled)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/chacha20-neon-glue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/crypto/chacha20-neon-glue.c b/arch/arm64/crypto/chacha20-neon-glue.c
index cbdb75d15cd0..b9ca7bef428a 100644
--- a/arch/arm64/crypto/chacha20-neon-glue.c
+++ b/arch/arm64/crypto/chacha20-neon-glue.c
@@ -36,6 +36,7 @@ static void chacha20_doneon(u32 *state, u8 *dst, const u8 *src,
 {
 	u8 buf[CHACHA20_BLOCK_SIZE];
 
+	kernel_neon_begin();
 	while (bytes >= CHACHA20_BLOCK_SIZE * 4) {
 		chacha20_4block_xor_neon(state, dst, src);
 		bytes -= CHACHA20_BLOCK_SIZE * 4;
@@ -55,6 +56,7 @@ static void chacha20_doneon(u32 *state, u8 *dst, const u8 *src,
 		chacha20_block_xor_neon(state, buf, buf);
 		memcpy(dst, buf, bytes);
 	}
+	kernel_neon_end();
 }
 
 static int chacha20_neon(struct skcipher_request *req)
@@ -72,7 +74,6 @@ static int chacha20_neon(struct skcipher_request *req)
 
 	crypto_chacha20_init(state, ctx, walk.iv);
 
-	kernel_neon_begin();
 	while (walk.nbytes > 0) {
 		unsigned int nbytes = walk.nbytes;
 
@@ -83,7 +84,6 @@ static int chacha20_neon(struct skcipher_request *req)
 				nbytes);
 		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
-	kernel_neon_end();
 
 	return err;
 }
-- 
2.11.0
