From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 4 Sep 2018 13:22:11 +0800
Subject: [PATCH v2] crypto: arm/chacha20 - faster 8-bit rotations and
 other optimizations
In-Reply-To: <20180901071707.14712-1-ebiggers@kernel.org>
References: <20180901071707.14712-1-ebiggers@kernel.org>
Message-ID: <20180904052211.tlncsdzljwjh5xyg@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 01, 2018 at 12:17:07AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Optimize ChaCha20 NEON performance by:
> 
> - Implementing the 8-bit rotations using the 'vtbl.8' instruction.
> - Streamlining the part that adds the original state and XORs the data.
> - Making some other small tweaks.
> 
> On ARM Cortex-A7, these optimizations improve ChaCha20 performance from
> about 12.08 cycles per byte to about 11.37 -- a 5.9% improvement.
> 
> There is a tradeoff involved with the 'vtbl.8' rotation method since
> there is at least one CPU (Cortex-A53) where it's not fastest.  But it
> seems to be a better default; see the added comment.  Overall, this
> patch reduces Cortex-A53 performance by less than 0.5%.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/arm/crypto/chacha20-neon-core.S | 277 ++++++++++++++-------------
>  1 file changed, 143 insertions(+), 134 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
