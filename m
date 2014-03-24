From: marex@denx.de (Marek Vasut)
Date: Mon, 24 Mar 2014 21:36:20 +0100
Subject: [PATCH] arm64: SHA-224/SHA-256 using ARMv8 Crypto Extensions
In-Reply-To: <1395326886-5866-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1395326886-5866-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <201403242136.20547.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 20, 2014 at 03:48:06 PM, Ard Biesheuvel wrote:
> This patch adds support for the SHA-224 and SHA-256 hash algorithms using
> the NEON based SHA-256 instructions that were introduced in ARM v8.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

[...]

> + * Copyright (c) Alan Smithee.

Email contact is missing here.

[...]

> +static int sha224_init(struct shash_desc *desc)
> +{
> +	struct sha256_state *sctx = shash_desc_ctx(desc);
> +
> +	*sctx = (struct sha256_state){

This cast is interesting, I don't quite understand it. Can you please explain 
that to me ?

> +		.state = {
> +			SHA224_H0, SHA224_H1, SHA224_H2, SHA224_H3,
> +			SHA224_H4, SHA224_H5, SHA224_H6, SHA224_H7,
> +		}
> +	};
> +	return 0;
> +}

[...]

> +static int sha224_final(struct shash_desc *desc, u8 *out)
> +{
> +	struct sha256_state *sctx = shash_desc_ctx(desc);
> +	__be32 *dst = (__be32 *)out;
> +	int i;
> +
> +	sha2_final(desc);
> +
> +	for (i = 0; i < SHA224_DIGEST_SIZE / sizeof(*dst); i++)
> +		dst[i] = cpu_to_be32(sctx->state[i]);

Won't this cause unaligned access if *dst is not aligned to 32 bytes ?

Try the crypto tests with this patch to see if this explodes please.

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 7795550..b9b7144 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -191,7 +191,8 @@ static int __test_hash(struct crypto_ahash *tfm, struct 
hash_testvec *template,
        const char *algo = crypto_tfm_alg_driver_name(crypto_ahash_tfm(tfm));
        unsigned int i, j, k, temp;
        struct scatterlist sg[8];
-       char result[64];
+       char _result[68];
+       char *result = _result + 1;
        struct ahash_request *req;
        struct tcrypt_result tresult;
        void *hash_buff;

[...]
