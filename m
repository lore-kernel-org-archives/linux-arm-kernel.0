From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Jan 2013 09:28:01 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129083522.GA14302@pd.tnic>
 <1359478014.3529.157.camel@shinybook.infradead.org>
 <20130129174249.GB25415@pd.tnic>
 <1359482147.3529.161.camel@shinybook.infradead.org>
 <20130129181046.GC25415@pd.tnic>
 <1359541333.3529.186.camel@shinybook.infradead.org>
 <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
Message-ID: <20130131092801.GV23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 08:09:00PM -0600, Kim Phillips wrote:
> The savings come mostly from device-tree related code, and some
> from drivers.

You forget that IP networking is all big endian, so these will be using
the byte swapping too (search it for htons/ntohs/htonl/ntohl).

> v2:
> - at91 and lpd270 builds fixed by limiting to ARMv6 and above
>   (i.e., ARM cores that have support for the 'rev' instruction).
>   Otherwise, the compiler emits calls to libgcc's __bswapsi2 on
>   these ARMv4/v5 builds (and arch ARM doesn't link with libgcc).

Which compiler version?  gcc 4.5.4 doesn't do this, except for the 16-bit
swap, so I doubt that any later compiler does.

> --- a/arch/arm/include/uapi/asm/swab.h
> +++ b/arch/arm/include/uapi/asm/swab.h
> @@ -50,4 +50,14 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
>  
>  #endif
>  
> +#if defined(__KERNEL__) && __LINUX_ARM_ARCH__ >= 6
> +#if GCC_VERSION >= 40600
> +#define __HAVE_BUILTIN_BSWAP32__
> +#define __HAVE_BUILTIN_BSWAP64__
> +#endif
> +#if GCC_VERSION >= 40800
> +#define __HAVE_BUILTIN_BSWAP16__
> +#endif
> +#endif

If this is __KERNEL__ only, it should not be in a uapi header.  UAPI
headers get exported to userland, this is not userland interface code.
IT should be in arch/arm/include/asm/swab.h
