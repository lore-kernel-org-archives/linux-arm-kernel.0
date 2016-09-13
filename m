From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Sep 2016 09:48:53 +0100
Subject: [PATCH 2/2] crypto: arm64/aes-ctr: fix NULL dereference in tail
 processing
In-Reply-To: <1473756533-21078-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1473756533-21078-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1473756533-21078-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AES-CTR glue code avoids calling into the blkcipher API for the
tail portion of the walk, by comparing the remainder of walk.nbytes
modulo AES_BLOCK_SIZE with the residual nbytes, and jumping straight
into the tail processing block if they are equal. This tail processing
block checks whether nbytes != 0, and does nothing otherwise.

However, in case of an allocation failure in the blkcipher layer, we
may enter this code with walk.nbytes == 0, while nbytes > 0. In this
case, we should not dereference the source and destination pointers,
since they may be NULL. So instead of checking for nbytes != 0, check
for (walk.nbytes % AES_BLOCK_SIZE) != 0, which implies the former in
non-error conditions.

Fixes: 49788fe2a128 ("arm64/crypto: AES-ECB/CBC/CTR/XTS using ARMv8 NEON and Crypto Extensions")
Reported-by: xiakaixu <xiakaixu@huawei.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/aes-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index 5c888049d061..6b2aa0fd6cd0 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -216,7 +216,7 @@ static int ctr_encrypt(struct blkcipher_desc *desc, struct scatterlist *dst,
 		err = blkcipher_walk_done(desc, &walk,
 					  walk.nbytes % AES_BLOCK_SIZE);
 	}
-	if (nbytes) {
+	if (walk.nbytes % AES_BLOCK_SIZE) {
 		u8 *tdst = walk.dst.virt.addr + blocks * AES_BLOCK_SIZE;
 		u8 *tsrc = walk.src.virt.addr + blocks * AES_BLOCK_SIZE;
 		u8 __aligned(8) tail[AES_BLOCK_SIZE];
-- 
2.7.4
