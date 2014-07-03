From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 3 Jul 2014 21:44:00 +0800
Subject: [PATCH] crypto: ux500: make interrupt mode plausible
In-Reply-To: <13720857.JmA1VNKFj8@wuerfel>
References: <13720857.JmA1VNKFj8@wuerfel>
Message-ID: <20140703134400.GC14291@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 01:43:02PM +0200, Arnd Bergmann wrote:
> The interrupt handler in the ux500 crypto driver has an obviously
> incorrect way to access the data buffer, which for a while has
> caused this build warning:
> 
> ../ux500/cryp/cryp_core.c: In function 'cryp_interrupt_handler':
> ../ux500/cryp/cryp_core.c:234:5: warning: passing argument 1 of '__fswab32' makes integer from pointer without a cast [enabled by default]
>      writel_relaxed(ctx->indata,
>      ^
> In file included from ../include/linux/swab.h:4:0,
>                  from ../include/uapi/linux/byteorder/big_endian.h:12,
>                  from ../include/linux/byteorder/big_endian.h:4,
>                  from ../arch/arm/include/uapi/asm/byteorder.h:19,
>                  from ../include/asm-generic/bitops/le.h:5,
>                  from ../arch/arm/include/asm/bitops.h:340,
>                  from ../include/linux/bitops.h:33,
>                  from ../include/linux/kernel.h:10,
>                  from ../include/linux/clk.h:16,
>                  from ../drivers/crypto/ux500/cryp/cryp_core.c:12:
> ../include/uapi/linux/swab.h:57:119: note: expected '__u32' but argument is of type 'const u8 *'
>  static inline __attribute_const__ __u32 __fswab32(__u32 val)
> 
> There are at least two, possibly three problems here:
> a) when writing into the FIFO, we copy the pointer rather than the
>    actual data we want to give to the hardware
> b) the data pointer is an array of 8-bit values, while the FIFO
>    is 32-bit wide, so both the read and write access fail to do
>    a proper type conversion
> c) This seems incorrect for big-endian kernels, on which we need to
>    byte-swap any register access, but not normally FIFO accesses,
>    at least the DMA case doesn't do it either.
> 
> This converts the bogus loop to use the same readsl/writesl pair
> that we use for the two other modes (DMA and polling). This is
> more efficient and consistent, and probably correct for endianess.
> 
> The bug has existed since the driver was first merged, and was
> probably never detected because nobody tried to use interrupt mode.
> It might make sense to backport this fix to stable kernels, depending
> on how the crypto maintainers feel about that.

Patch applied.  I'm not going to push this to stable though until
I see some more testing.  We can always push this later if needed.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
