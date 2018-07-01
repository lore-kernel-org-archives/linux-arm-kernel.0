From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 1 Jul 2018 21:18:39 +0800
Subject: [PATCH] crypto: arm/speck - fix building in Thumb2 mode
In-Reply-To: <20180618223323.130072-1-ebiggers@google.com>
References: <20180618223323.130072-1-ebiggers@google.com>
Message-ID: <20180701131839.kpbwifrfgdf36p4p@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 03:33:23PM -0700, Eric Biggers wrote:
> Building the kernel with CONFIG_THUMB2_KERNEL=y and
> CONFIG_CRYPTO_SPECK_NEON set fails with the following errors:
> 
>     arch/arm/crypto/speck-neon-core.S: Assembler messages:
> 
>     arch/arm/crypto/speck-neon-core.S:419: Error: r13 not allowed here -- `bic sp,#0xf'
>     arch/arm/crypto/speck-neon-core.S:423: Error: r13 not allowed here -- `bic sp,#0xf'
>     arch/arm/crypto/speck-neon-core.S:427: Error: r13 not allowed here -- `bic sp,#0xf'
>     arch/arm/crypto/speck-neon-core.S:431: Error: r13 not allowed here -- `bic sp,#0xf'
> 
> The problem is that the 'bic' instruction can't operate on the 'sp'
> register in Thumb2 mode.  Fix it by using a temporary register.  This
> isn't in the main loop, so the performance difference is negligible.
> This also matches what aes-neonbs-core.S does.
> 
> Reported-by: Stefan Agner <stefan@agner.ch>
> Fixes: ede9622162fa ("crypto: arm/speck - add NEON-accelerated implementation of Speck-XTS")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
