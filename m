From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 7 Sep 2018 11:42:42 +0800
Subject: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack
 requests
In-Reply-To: <20180906225854.40989-3-keescook@chromium.org>
References: <20180906225854.40989-1-keescook@chromium.org>
 <20180906225854.40989-3-keescook@chromium.org>
Message-ID: <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 03:58:52PM -0700, Kees Cook wrote:
>
> @@ -437,6 +442,12 @@ static inline struct crypto_skcipher *crypto_skcipher_reqtfm_check(
>  {
>  	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
>  
> +	if (req->__onstack) {
> +		if (WARN_ON(crypto_skcipher_alg(tfm)->base.cra_flags &
> +				CRYPTO_ALG_ASYNC))
> +			return ERR_PTR(-EINVAL);
> +	}

Sorry but I don't like imposing a run-time check on everybody when
stack-based requests are the odd ones out.  If we're going to make
this a run-time check (I'd much prefer a compile-time check, but I
understand that this may involve too much churn), then please do it
for stack-based request users only.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
