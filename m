From: ebiggers@kernel.org (Eric Biggers)
Date: Mon,  5 Nov 2018 15:25:17 -0800
Subject: [RFC PATCH v3 06/15] crypto: arm/chacha20 - limit the
 preemption-disabled section
In-Reply-To: <20181105232526.173947-1-ebiggers@kernel.org>
References: <20181105232526.173947-1-ebiggers@kernel.org>
Message-ID: <20181105232526.173947-7-ebiggers@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Biggers <ebiggers@google.com>

To improve responsivesess, disable preemption for each step of the walk
(which is at most PAGE_SIZE) rather than for the entire
encryption/decryption operation.

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/crypto/chacha20-neon-glue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/crypto/chacha20-neon-glue.c b/arch/arm/crypto/chacha20-neon-glue.c
index 7386eb1c1889..2bc035cb8f23 100644
--- a/arch/arm/crypto/chacha20-neon-glue.c
+++ b/arch/arm/crypto/chacha20-neon-glue.c
@@ -68,22 +68,22 @@ static int chacha20_neon(struct skcipher_request *req)
 	if (req->cryptlen <= CHACHA_BLOCK_SIZE || !may_use_simd())
 		return crypto_chacha_crypt(req);
 
-	err = skcipher_walk_virt(&walk, req, true);
+	err = skcipher_walk_virt(&walk, req, false);
 
 	crypto_chacha_init(state, ctx, walk.iv);
 
-	kernel_neon_begin();
 	while (walk.nbytes > 0) {
 		unsigned int nbytes = walk.nbytes;
 
 		if (nbytes < walk.total)
 			nbytes = round_down(nbytes, walk.stride);
 
+		kernel_neon_begin();
 		chacha20_doneon(state, walk.dst.virt.addr, walk.src.virt.addr,
 				nbytes);
+		kernel_neon_end();
 		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
-	kernel_neon_end();
 
 	return err;
 }
-- 
2.19.1.930.g4563a0d9d0-goog
