From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Apr 2011 16:31:39 +0200
Subject: [PATCH 1/3] bitops: add ifdef CONFIG_GENERIC_FIND_BIT_LE guard
In-Reply-To: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com>
References: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <201104201631.40017.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 April 2011, Akinobu Mita wrote:
> index 946a21b..bd2253e 100644
> --- a/include/asm-generic/bitops/le.h
> +++ b/include/asm-generic/bitops/le.h
> @@ -30,6 +30,8 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
>  
>  #define BITOP_LE_SWIZZLE       ((BITS_PER_LONG-1) & ~0x7)
>  
> +#ifdef CONFIG_GENERIC_FIND_BIT_LE
> +
>  extern unsigned long find_next_zero_bit_le(const void *addr,
>                 unsigned long size, unsigned long offset);
>  extern unsigned long find_next_bit_le(const void *addr,
> @@ -38,6 +40,8 @@ extern unsigned long find_next_bit_le(const void *addr,
>  #define find_first_zero_bit_le(addr, size) \
>         find_next_zero_bit_le((addr), (size), 0)
>  
> +#endif /* CONFIG_GENERIC_FIND_BIT_LE */
> +
>  #else
>  #error "Please fix <asm/byteorder.h>"
>  #endif

The style that we normally use in asm-generic is to test the macro itself
for existence, so in asm-generic, do:

#ifndef find_next_zero_bit_le
extern unsigned long find_next_zero_bit_le(const void *addr,
                 unsigned long size, unsigned long offset);
#endif

and in the architectures, write

static inline unsigned long find_next_zero_bit_le(const void *addr,
                 unsigned long size, unsigned long offset)
#define find_next_zero_bit_le find_next_zero_bit_le

I guess we can do the #ifdef separately for each of the three macros,
or choose one of them to use as a key.

	Arnd
