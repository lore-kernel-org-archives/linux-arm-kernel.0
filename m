From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 24 May 2017 10:30:43 +0200
Subject: [PATCH 1/5] random,stackprotect: introduce get_random_canary
 function
In-Reply-To: <20170519212636.30440-2-riel@redhat.com>
References: <20170519212636.30440-1-riel@redhat.com>
 <20170519212636.30440-2-riel@redhat.com>
Message-ID: <20170524083043.hpbpuracjqj2bbv2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* riel at redhat.com <riel@redhat.com> wrote:

> From: Rik van Riel <riel@redhat.com>
> 
> Introduce the get_random_canary function, which provides a random
> unsigned long canary value with the first byte zeroed out on 64
> bit architectures, in order to mitigate non-terminated C string
> overflows.
> 
> Inspired by the "ascii armor" code in the old execshield patches,
> and the current PaX/grsecurity code base.
> 
> Signed-off-by: Rik van Riel <riel@redhat.com>
> ---
>  include/linux/random.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/random.h b/include/linux/random.h
> index ed5c3838780d..765a992c6774 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -57,6 +57,26 @@ static inline unsigned long get_random_long(void)
>  #endif
>  }
>  
> +/*
> + * On 64 bit architectures, protect against non-terminated C string overflows

s/64 bit/64-bit

> + * by zeroing out the first byte of the canary; this leaves 56 bits of entropy.
> + */
> +#ifdef CONFIG_64BIT
> +#ifdef __LITTLE_ENDIAN
> +#define CANARY_MASK 0xffffffffffffff00UL
> +#else /* big endian 64 bits */
> +#define CANARY_MASK 0x00ffffffffffffffUL
> +#endif
> +#else /* 32 bits */
> +#define CANARY_MASK 0xffffffffUL
> +#endif
> +static inline unsigned long get_random_canary(void)
> +{
> +	unsigned long val = get_random_long();
> +
> +	return val & CANARY_MASK;
> +}

Please separate function definitions from macros by a separate empty line.

Also, a bit of structure and organization would make the macro easier to read:

#ifdef CONFIG_64BIT
# ifdef __LITTLE_ENDIAN
#  define CANARY_MASK 0xffffffffffffff00UL
# else /* big endian, 64 bits: */
#  define CANARY_MASK 0x00ffffffffffffffUL
# endif
#else /* 32 bits: */
# define  CANARY_MASK 0x00000000ffffffffUL
#endif

Thanks,

	Ingo
