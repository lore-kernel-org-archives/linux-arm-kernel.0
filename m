From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 29 Nov 2016 13:05:32 +0000
Subject: [PATCH 3/4] crypto: arm64/aes-ce-ccm - fix decrypt path with new
 skcipher interface
In-Reply-To: <1480424733-10797-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1480424733-10797-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1480424733-10797-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new skcipher walk interface does not take into account whether we
are encrypting or decrypting. In the latter case, the walk should
disregard the MAC. Fix this in the arm64 CE driver.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/aes-ce-ccm-glue.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/crypto/aes-ce-ccm-glue.c b/arch/arm64/crypto/aes-ce-ccm-glue.c
index d4f35685363b..1a011d658387 100644
--- a/arch/arm64/crypto/aes-ce-ccm-glue.c
+++ b/arch/arm64/crypto/aes-ce-ccm-glue.c
@@ -204,10 +204,10 @@ static int ccm_decrypt(struct aead_request *req)
 	struct skcipher_walk walk;
 	u8 __aligned(8) mac[AES_BLOCK_SIZE];
 	u8 buf[AES_BLOCK_SIZE];
-	u32 len = req->cryptlen - authsize;
 	int err;
 
-	err = ccm_init_mac(req, mac, len);
+	req->cryptlen -= authsize;
+	err = ccm_init_mac(req, mac, req->cryptlen);
 	if (err)
 		return err;
 
@@ -242,8 +242,7 @@ static int ccm_decrypt(struct aead_request *req)
 		return err;
 
 	/* compare calculated auth tag with the stored one */
-	scatterwalk_map_and_copy(buf, req->src,
-				 req->assoclen + req->cryptlen - authsize,
+	scatterwalk_map_and_copy(buf, req->src, req->assoclen + req->cryptlen,
 				 authsize, 0);
 
 	if (crypto_memneq(mac, buf, authsize))
-- 
2.7.4
