From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Wed,  9 Sep 2015 14:27:07 +0200
Subject: [PATCH] crypto: sun4i-ss Fix a possible driver hang with ciphers
Message-ID: <1441801627-31820-1-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i_ss_opti_poll function cipher data until the output miter have
a length of 0.
If the crypto API client, give more SGs than necessary this could result
in an infinite loop.
Fix it by checking for remaining bytes, just like sun4i_ss_cipher_poll().

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
index e070c31..a19ee12 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
@@ -104,7 +104,7 @@ static int sun4i_ss_opti_poll(struct ablkcipher_request *areq)
 			sg_miter_next(&mo);
 			oo = 0;
 		}
-	} while (mo.length > 0);
+	} while (oleft > 0);
 
 	if (areq->info) {
 		for (i = 0; i < 4 && i < ivsize / 4; i++) {
-- 
2.4.6
