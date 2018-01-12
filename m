From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 12 Jan 2018 18:14:44 +1100
Subject: [PATCH 2/6] crypto: engine - Permit to enqueue all async requests
In-Reply-To: <20180103201109.16077-3-clabbe.montjoie@gmail.com>
References: <20180103201109.16077-1-clabbe.montjoie@gmail.com>
 <20180103201109.16077-3-clabbe.montjoie@gmail.com>
Message-ID: <20180112071444.GA18698@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 03, 2018 at 09:11:05PM +0100, Corentin Labbe wrote:
> The crypto engine could actually only enqueue hash and ablkcipher request.
> This patch permit it to enqueue any type of crypto_async_request.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  crypto/crypto_engine.c  | 230 ++++++++++++++++++++++++------------------------
>  include/crypto/engine.h |  59 +++++++------
>  2 files changed, 148 insertions(+), 141 deletions(-)
> 
> diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
> index 61e7c4e02fd2..036270b61648 100644
> --- a/crypto/crypto_engine.c
> +++ b/crypto/crypto_engine.c
> @@ -15,7 +15,6 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <crypto/engine.h>
> -#include <crypto/internal/hash.h>
>  #include <uapi/linux/sched/types.h>
>  #include "internal.h"
>  
> @@ -34,11 +33,10 @@ static void crypto_pump_requests(struct crypto_engine *engine,
>  				 bool in_kthread)
>  {
>  	struct crypto_async_request *async_req, *backlog;
> -	struct ahash_request *hreq;
> -	struct ablkcipher_request *breq;
>  	unsigned long flags;
>  	bool was_busy = false;
> -	int ret, rtype;
> +	int ret;
> +	struct crypto_engine_reqctx *enginectx;

This all looks very good.  Just one minor nit, since you're storing
this in the tfm ctx as opposed to the request ctx (which is indeed
an improvement), you should remove the "req" from its name.

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
