From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Sun, 29 Oct 2017 21:39:30 +0100
Subject: [PATCH] crypto: AF_ALG - remove locking in async callback
In-Reply-To: <CAGkQfmNKbSwue13zPh2K1F_kLkpm1_AhsAHK4spRFA0xMvU5PA@mail.gmail.com>
References: <CAGkQfmNKbSwue13zPh2K1F_kLkpm1_AhsAHK4spRFA0xMvU5PA@mail.gmail.com>
Message-ID: <5260911.ZuXsrgFD2R@positron.chronox.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 25. Oktober 2017, 17:26:31 CET schrieb Romain Izard:

Hi Romain,

the patch below should cover the issue you see. Would you mind testing it?

Thanks
Stephan

---8<---

The code paths protected by the socket-lock do not use or modify the
socket in a non-atomic fashion. The actions pertaining the socket do not
even need to be handled as an atomic operation. Thus, the socket-lock
can be safely ignored.

This fixes a bug regarding scheduling in atomic as the callback function
may be invoked in interrupt context.

Fixes: 2d97591ef43d0 ("crypto: af_alg - consolidation of duplicate code")
Reported-by: Romain Izard <romain.izard.pro@gmail.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/af_alg.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 337cf382718e..a41f08642eee 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1063,8 +1063,6 @@ void af_alg_async_cb(struct crypto_async_request *_req, int err)
 	struct kiocb *iocb = areq->iocb;
 	unsigned int resultlen;
 
-	lock_sock(sk);
-
 	/* Buffer size written by crypto operation. */
 	resultlen = areq->outlen;
 
@@ -1073,8 +1071,6 @@ void af_alg_async_cb(struct crypto_async_request *_req, int err)
 	__sock_put(sk);
 
 	iocb->ki_complete(iocb, err ? err : resultlen, 0);
-
-	release_sock(sk);
 }
 EXPORT_SYMBOL_GPL(af_alg_async_cb);
 
-- 
2.13.6
