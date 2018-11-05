From: ebiggers@kernel.org (Eric Biggers)
Date: Mon,  5 Nov 2018 15:25:13 -0800
Subject: [RFC PATCH v3 02/15] crypto: chacha20-generic - don't unnecessarily
 use atomic walk
In-Reply-To: <20181105232526.173947-1-ebiggers@kernel.org>
References: <20181105232526.173947-1-ebiggers@kernel.org>
Message-ID: <20181105232526.173947-3-ebiggers@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Biggers <ebiggers@google.com>

chacha20-generic doesn't use SIMD instructions or otherwise disable
preemption, so passing atomic=true to skcipher_walk_virt() is
unnecessary.

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/chacha20_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/chacha20_generic.c b/crypto/chacha20_generic.c
index 3ae96587caf9..3529521d72a4 100644
--- a/crypto/chacha20_generic.c
+++ b/crypto/chacha20_generic.c
@@ -81,7 +81,7 @@ int crypto_chacha20_crypt(struct skcipher_request *req)
 	u32 state[16];
 	int err;
 
-	err = skcipher_walk_virt(&walk, req, true);
+	err = skcipher_walk_virt(&walk, req, false);
 
 	crypto_chacha20_init(state, ctx, walk.iv);
 
-- 
2.19.1.930.g4563a0d9d0-goog
