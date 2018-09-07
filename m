From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 7 Sep 2018 08:56:23 +0200
Subject: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack
 requests
In-Reply-To: <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
References: <20180906225854.40989-1-keescook@chromium.org>
 <20180906225854.40989-3-keescook@chromium.org>
 <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
Message-ID: <CAKv+Gu9kHpBTKjQKA3W4Q424FeY+Zq4srq2-r0MxjfCNKHT_5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 September 2018 at 05:42, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Sep 06, 2018 at 03:58:52PM -0700, Kees Cook wrote:
>>
>> @@ -437,6 +442,12 @@ static inline struct crypto_skcipher *crypto_skcipher_reqtfm_check(
>>  {
>>       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
>>
>> +     if (req->__onstack) {
>> +             if (WARN_ON(crypto_skcipher_alg(tfm)->base.cra_flags &
>> +                             CRYPTO_ALG_ASYNC))
>> +                     return ERR_PTR(-EINVAL);
>> +     }
>
> Sorry but I don't like imposing a run-time check on everybody when
> stack-based requests are the odd ones out.  If we're going to make
> this a run-time check (I'd much prefer a compile-time check, but I
> understand that this may involve too much churn), then please do it
> for stack-based request users only.
>

OK, so given that all SKCIPHER_REQUEST_ON_STACK occurrences are
updated in this series anyway, perhaps we should add
skcipher_[en|de]crypt_onstack() flavors that encapsulate the
additional check? Only question is how to enforce at compile time that
those are used instead of the ordinary ones when using a stack
allocated request. Would you mind using some macro foo here involving
__builtin_types_compatible_p() ?
