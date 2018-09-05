From: keescook@chromium.org (Kees Cook)
Date: Wed, 5 Sep 2018 14:05:19 -0700
Subject: [PATCH 2/2] crypto: skcipher: Remove VLA usage for
 SKCIPHER_REQUEST_ON_STACK
In-Reply-To: <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
References: <20180904181629.20712-1-keescook@chromium.org>
 <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
Message-ID: <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2018 at 2:18 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 4 September 2018 at 20:16, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> caps the skcipher request size similar to other limits and adds a sanity
>> check at registration. Looking at instrumented tcrypt output, the largest
>> is for lrw:
>>
>>         crypt: testing lrw(aes)
>>         crypto_skcipher_set_reqsize: 8
>>         crypto_skcipher_set_reqsize: 88
>>         crypto_skcipher_set_reqsize: 472
>>
>
> Are you sure this is a representative sampling? I haven't double
> checked myself, but we have plenty of drivers for peripherals in
> drivers/crypto that implement block ciphers, and they would not turn
> up in tcrypt unless you are running on a platform that provides the
> hardware in question.

Hrm, excellent point. Looking at this again:

The core part of the VLA is using this in the ON_STACK macro:

static inline unsigned int crypto_skcipher_reqsize(struct crypto_skcipher *tfm)
{
        return tfm->reqsize;
}

I don't find any struct crypto_skcipher .reqsize static initializers,
and the initial reqsize is here:

static int crypto_init_skcipher_ops_ablkcipher(struct crypto_tfm *tfm)
{
...
        skcipher->reqsize = crypto_ablkcipher_reqsize(ablkcipher) +
                            sizeof(struct ablkcipher_request);

with updates via crypto_skcipher_set_reqsize().

So I have to examine ablkcipher reqsize too:

static inline unsigned int crypto_ablkcipher_reqsize(
        struct crypto_ablkcipher *tfm)
{
        return crypto_ablkcipher_crt(tfm)->reqsize;
}

And of the crt_ablkcipher.reqsize assignments/initializers, I found:

ablkcipher reqsize:
1       struct dcp_aes_req_ctx
8       struct atmel_tdes_reqctx
8       struct cryptd_blkcipher_request_ctx
8       struct mtk_aes_reqctx
8       struct omap_des_reqctx
8       struct s5p_aes_reqctx
8       struct sahara_aes_reqctx
8       struct stm32_cryp_reqctx
8       struct stm32_cryp_reqctx
16      struct ablk_ctx
24      struct atmel_aes_reqctx
48      struct omap_aes_reqctx
48      struct omap_aes_reqctx
48      struct qat_crypto_request
56      struct artpec6_crypto_request_context
64      struct chcr_blkcipher_req_ctx
80      struct spacc_req
80      struct virtio_crypto_sym_request
136     struct qce_cipher_reqctx
168     struct n2_request_context
328     struct ccp_des3_req_ctx
400     struct ccp_aes_req_ctx
536     struct hifn_request_context
992     struct cvm_req_ctx
2456    struct iproc_reqctx_s

The base ablkcipher wrapper is:
80      struct ablkcipher_request

And in my earlier skcipher wrapper analysis, lrw was the largest
skcipher wrapper:
384     struct rctx

iproc_reqctx_s is an extreme outlier, with cvm_req_ctx at a bit less than half.

Making this a 2920 byte fixed array doesn't seem sensible at all
(though that's what's already possible to use with existing
SKCIPHER_REQUEST_ON_STACK users).

What's the right path forward here?

-Kees

-- 
Kees Cook
Pixel Security
