From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 11 Sep 2018 13:52:30 +0800
Subject: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack
 requests
In-Reply-To: <CAKv+Gu9kHpBTKjQKA3W4Q424FeY+Zq4srq2-r0MxjfCNKHT_5A@mail.gmail.com>
References: <20180906225854.40989-1-keescook@chromium.org>
 <20180906225854.40989-3-keescook@chromium.org>
 <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
 <CAKv+Gu9kHpBTKjQKA3W4Q424FeY+Zq4srq2-r0MxjfCNKHT_5A@mail.gmail.com>
Message-ID: <20180911055230.iiiq2uu5gczlwjon@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 08:56:23AM +0200, Ard Biesheuvel wrote:
>
> OK, so given that all SKCIPHER_REQUEST_ON_STACK occurrences are
> updated in this series anyway, perhaps we should add
> skcipher_[en|de]crypt_onstack() flavors that encapsulate the
> additional check? Only question is how to enforce at compile time that
> those are used instead of the ordinary ones when using a stack
> allocated request. Would you mind using some macro foo here involving
> __builtin_types_compatible_p() ?

Something like a completely new type which in reality is just a
wrapper around skcipher:

	struct crypto_sync_skcipher {
		struct crypto_skcipher base;
	} tfm;

	tfm = crypto_alloc_sync_skcipher(...);

	crypto_sync_skcipher_encrypt(...)
	crypto_sync_skcipher_decrypt(...)

These functions would just be trivial inline functions around their
crypto_skcipher counterparts.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
