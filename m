From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 13 Sep 2016 20:43:54 +0800
Subject: [PATCH 1/2] crypto: arm/aes-ctr: fix NULL dereference in tail
 processing
In-Reply-To: <1473756533-21078-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1473756533-21078-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160913124354.GI31835@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 09:48:52AM +0100, Ard Biesheuvel wrote:
> The AES-CTR glue code avoids calling into the blkcipher API for the
> tail portion of the walk, by comparing the remainder of walk.nbytes
> modulo AES_BLOCK_SIZE with the residual nbytes, and jumping straight
> into the tail processing block if they are equal. This tail processing
> block checks whether nbytes != 0, and does nothing otherwise.
> 
> However, in case of an allocation failure in the blkcipher layer, we
> may enter this code with walk.nbytes == 0, while nbytes > 0. In this
> case, we should not dereference the source and destination pointers,
> since they may be NULL. So instead of checking for nbytes != 0, check
> for (walk.nbytes % AES_BLOCK_SIZE) != 0, which implies the former in
> non-error conditions.
> 
> Fixes: 86464859cc77 ("crypto: arm - AES in ECB/CBC/CTR/XTS modes using ARMv8 Crypto Extensions")
> Reported-by: xiakaixu <xiakaixu@huawei.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

Both patches applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
