From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Dec 2016 10:06:15 +0000
Subject: [PATCH v6 2/5] lib: implement __arch_bitrev8x4()
In-Reply-To: <6c1c052d3c1d0c02a791aaaf8e114360ab1cb4e7.1481918884.git.stillcompiling@gmail.com>
References: <cover.1481918884.git.stillcompiling@gmail.com>
 <6c1c052d3c1d0c02a791aaaf8e114360ab1cb4e7.1481918884.git.stillcompiling@gmail.com>
Message-ID: <20161219100614.GC4508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 03:17:51PM -0800, Joshua Clayton wrote:
> Implement faster bitrev8x4() for arm, arm64 and mips, all the platforms
> with CONFIG_HAVE_ARCH_BITREVERSE.
> ARM platforms just need a byteswap added to the existing __arch_bitrev32()
> Amusingly, the mips implementation is exactly the opposite, requiring
> removal of the byteswap from its __arch_bitrev32()
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>  arch/arm/include/asm/bitrev.h   | 6 ++++++
>  arch/arm64/include/asm/bitrev.h | 6 ++++++
>  arch/mips/include/asm/bitrev.h  | 6 ++++++
>  include/linux/bitrev.h          | 1 +
>  4 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm/include/asm/bitrev.h b/arch/arm/include/asm/bitrev.h
> index ec291c3..9482f78 100644
> --- a/arch/arm/include/asm/bitrev.h
> +++ b/arch/arm/include/asm/bitrev.h
> @@ -17,4 +17,10 @@ static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
>  	return __arch_bitrev32((u32)x) >> 24;
>  }
>  
> +static __always_inline __attribute_const__ u32 __arch_bitrev8x4(u32 x)
> +{
> +	__asm__ ("rbit %0, %1; rev %0, %0" : "=r" (x) : "r" (x));
> +	return x;
> +}
> +
>  #endif
> diff --git a/arch/arm64/include/asm/bitrev.h b/arch/arm64/include/asm/bitrev.h
> index a5a0c36..1801078 100644
> --- a/arch/arm64/include/asm/bitrev.h
> +++ b/arch/arm64/include/asm/bitrev.h
> @@ -16,4 +16,10 @@ static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
>  	return __arch_bitrev32((u32)x) >> 24;
>  }
>  
> +static __always_inline __attribute_const__ u32 __arch_bitrev8x4(u32 x)
> +{
> +	__asm__ ("rbit %0, %1; rev %0, %0" : "=r" (x) : "r" (x));

This is broken -- you're operating on 64-bit registers. I only noticed
because if you write:

  swab32(bitrev32(x))

then GCC generates:

  rbit	w0, w0
  rev	w0, w0

so perhaps we should just implement the asm-generic version like that
and not bother with the arch-specific stuff?

Will
