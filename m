From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Apr 2013 09:32:02 +0200
Subject: [Suggestion] ARM64: kernel: compiling issue,
 need implement cmpxchg64 with assembler language.
In-Reply-To: <5171FD67.2080104@asianux.com>
References: <51712E5E.2020809@asianux.com> <201304191412.54601.arnd@arndb.de>
 <5171FD67.2080104@asianux.com>
Message-ID: <2182812.ymprEm6XBb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 April 2013 10:28:55 Chen Gang wrote:
> 
> -------------------------------patch begin--------------------------------------
> 
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index 968b5cb..b572d2b 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -170,4 +170,6 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
>                                        (unsigned long)(n),              \
>                                        sizeof(*(ptr))))
>  
> +#define cmpxchg64(ptr,o,n)     cmpxchg((ptr),(o),(n))
> +
>  #endif /* __ASM_CMPXCHG_H */

Yes, this looks good. Please provide the same for cmpxchg64_local.

> -------------------------------patch end----------------------------------------
> 
> 
> 
>   I think, we can also reference the implementation of s390:
>     it is in arch/s390/include/asm/cmpxchg.h.
>     since we are ARM64, excluding ARM(32,16...), we can only consider 64-bit.
>     if in the future, ARM64 and ARM are merged together:
>       we can use CONFIG_64BIT to switch the cmpxchg64 definition.
>       if define CONFIG_64BIT, use cmpxchg instead of cmpxchg64.
>       else, use the definition of ARM (arch/arm/include/asm/cmpxchg.h already defines cmpxchg64)

I would not worry aobut merging the two at the moment.

> -------------------------------reference begin----------------------------------
> 
> #ifdef CONFIG_64BIT
> #define cmpxchg64(ptr, o, n)                                            \
> ({                                                                      \
>         cmpxchg((ptr), (o), (n));                                       \
> })
> #else /* CONFIG_64BIT */
> ...
> -------------------------------reference end------------------------------------

This implementation in unnecessarily verbose, I think the one you have
above is nicer.

	Arnd
