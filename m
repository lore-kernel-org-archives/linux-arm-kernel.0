From: keescook@chromium.org (Kees Cook)
Date: Thu, 13 Sep 2018 09:46:17 -0700
Subject: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack
 requests
In-Reply-To: <20180911055230.iiiq2uu5gczlwjon@gondor.apana.org.au>
References: <20180906225854.40989-1-keescook@chromium.org>
 <20180906225854.40989-3-keescook@chromium.org>
 <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
 <CAKv+Gu9kHpBTKjQKA3W4Q424FeY+Zq4srq2-r0MxjfCNKHT_5A@mail.gmail.com>
 <20180911055230.iiiq2uu5gczlwjon@gondor.apana.org.au>
Message-ID: <CAGXu5j+ti_nzxeu64e-X+igNEsnXiW1rjkn7R63DMBCxBOeTNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 10:52 PM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> On Fri, Sep 07, 2018 at 08:56:23AM +0200, Ard Biesheuvel wrote:
>>
>> OK, so given that all SKCIPHER_REQUEST_ON_STACK occurrences are
>> updated in this series anyway, perhaps we should add
>> skcipher_[en|de]crypt_onstack() flavors that encapsulate the
>> additional check? Only question is how to enforce at compile time that
>> those are used instead of the ordinary ones when using a stack
>> allocated request. Would you mind using some macro foo here involving
>> __builtin_types_compatible_p() ?
>
> Something like a completely new type which in reality is just a
> wrapper around skcipher:
>
>         struct crypto_sync_skcipher {
>                 struct crypto_skcipher base;
>         } tfm;
>
>         tfm = crypto_alloc_sync_skcipher(...);
>
>         crypto_sync_skcipher_encrypt(...)
>         crypto_sync_skcipher_decrypt(...)
>
> These functions would just be trivial inline functions around their
> crypto_skcipher counterparts.

This means new wrappers for the other helpers too, yes? For example:

        SKCIPHER_REQUEST_ON_STACK(nreq, ctx->null);

        skcipher_request_set_tfm(nreq, ctx->null);
        skcipher_request_set_callback(nreq, req->base.flags, NULL, NULL);
        skcipher_request_set_crypt(nreq, req->src, req->dst, nbytes, NULL);

        return crypto_skcipher_encrypt(nreq);

For the above, we'd also need:

sync_skcipher_request_set_tfm()
sync_skcipher_request_set_callback()
sync_skcipher_request_set_crypt()

-Kees

-- 
Kees Cook
Pixel Security
