From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 28 Sep 2012 00:17:53 -0400 (EDT)
Subject: [PATCH] ARM: optimize memset_io()/memcpy_fromio()/memcpy_toio()
In-Reply-To: <E1THMAC-0004nL-8B@rmk-PC.arm.linux.org.uk>
References: <E1THMAC-0004nL-8B@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1209280011340.6667@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Sep 2012, Russell King wrote:

> If we are building for a LE platform, and we haven't overriden the
> MMIO ops, then we can optimize the mem*io operations using the
> standard string functions.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

We presume that the IO space is able to cope with a mixture of access 
width other than byte access which should be perfectly reasonable by 
default.  If so then...

Acked-by: Nicolas Pitre <nico@.linaro.org>

> ---
>  arch/arm/include/asm/io.h |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 815c669..ed0577e 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -23,6 +23,7 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <linux/string.h>
>  #include <linux/types.h>
>  #include <asm/byteorder.h>
>  #include <asm/memory.h>
> @@ -249,9 +250,33 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>  #define writesw(p,d,l)		__raw_writesw(p,d,l)
>  #define writesl(p,d,l)		__raw_writesl(p,d,l)
>  
> +#ifndef __ARMBE__
> +static inline void memset_io(volatile void __iomem *dst, unsigned c,
> +	size_t count)
> +{
> +	memset((void __force *)dst, c, count);
> +}
> +#define memset_io(dst,c,count) memset_io(dst,c,count)
> +
> +static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
> +	size_t count)
> +{
> +	memcpy(to, (const void __force *)from, count);
> +}
> +#define memcpy_fromio(to,from,count) memcpy_fromio(to,from,count)
> +
> +static inline void memcpy_toio(volatile void __iomem *to, const void *from,
> +	size_t count)
> +{
> +	memcpy((void __force *)to, from, count);
> +}
> +#define memcpy_toio(to,from,count) memcpy_toio(to,from,count)
> +
> +#else
>  #define memset_io(c,v,l)	_memset_io(c,(v),(l))
>  #define memcpy_fromio(a,c,l)	_memcpy_fromio((a),c,(l))
>  #define memcpy_toio(c,a,l)	_memcpy_toio(c,(a),(l))
> +#endif
>  
>  #endif	/* readl */
>  
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
