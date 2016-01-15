From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 15 Jan 2016 15:49:31 +0100
Subject: [PATCH 1/5] crypto: atmel-sha: fix crash when computing digest on
 empty message
In-Reply-To: <cover.1452867917.git.cyrille.pitchen@atmel.com>
References: <cover.1452867917.git.cyrille.pitchen@atmel.com>
Message-ID: <4396c236d6cc6dc89801ef6d179d10b901461654.1452867917.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a crash which occured during the computation of the
digest of an empty message.

Indeed, when processing an empty message, the atmel_sha_handle_queue()
function was never called, hence the dd->req pointer remained
uninitialized.

Later, when the atmel_sha_final_req() function was called, it used
to crash while using this uninitialized dd->req pointer.

Hence this patch adds missing initializations of dd->req before calls of
the atmel_sha_final_req() function.

This bug prevented us from passing the tcrypt test suite on SHA algo.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/crypto/atmel-sha.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 20de861aa0ea..006b2aefba30 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -939,6 +939,7 @@ static int atmel_sha_final(struct ahash_request *req)
 		if (err)
 			goto err1;
 
+		dd->req = req;
 		dd->flags |= SHA_FLAGS_BUSY;
 		err = atmel_sha_final_req(dd);
 	} else {
-- 
1.8.2.2
