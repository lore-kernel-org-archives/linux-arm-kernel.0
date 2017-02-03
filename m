From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 3 Feb 2017 18:22:44 +0800
Subject: [PATCH 2/2] crypto: arm/aes - don't use IV buffer to return
 final keystream block
In-Reply-To: <1486035536-895-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1486035536-895-1-git-send-email-ard.biesheuvel@linaro.org>
 <1486035536-895-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170203102244.GI2632@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 11:38:56AM +0000, Ard Biesheuvel wrote:
> The ARM bit sliced AES core code uses the IV buffer to pass the final
> keystream block back to the glue code if the input is not a multiple of
> the block size, so that the asm code does not have to deal with anything
> except 16 byte blocks. This is done under the assumption that the outgoing
> IV is meaningless anyway in this case, given that chaining is no longer
> possible under these circumstances.
> 
> However, as it turns out, the CCM driver does expect the IV to retain
> a value that is equal to the original IV except for the counter value,
> and even interprets byte zero as a length indicator, which may result
> in memory corruption if the IV is overwritten with something else.
> 
> So use a separate buffer to return the final keystream block.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
