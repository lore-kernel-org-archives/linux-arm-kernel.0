From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Thu, 29 Oct 2015 09:05:44 +0100
Subject: [PATCH] arm: fix the return value of find_first{_zero}_bit
In-Reply-To: <1444892115-24784-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1444892115-24784-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20151029080544.GB25880@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 08:54:59AM +0200, LABBE Corentin wrote:
> Building linux with W=1 on arm give me this warning;
> In file included from ../include/linux/nodemask.h:92:0,
>                  from ../include/linux/mmzone.h:16,
>                  from ../include/linux/gfp.h:5,
>                  from ../include/linux/kmod.h:22,
>                  from ../include/linux/module.h:13,
>                  from net/netfilter/xt_nat.mod.c:1:
> ../include/linux/bitmap.h: In function 'bitmap_empty':
> ../include/linux/bitmap.h:287:36: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
>   return find_first_bit(src, nbits) == nbits;
> 
> ../include/linux/bitmap.h: In function 'bitmap_full':
> ../include/linux/bitmap.h:295:41: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
>   return find_first_zero_bit(src, nbits) == nbits;
> 
> The problem is that find_first{_zero}_bit() return type is unsigned long on
> majority of arch.
> 
> Since find_first{_zero}_bit cannot return negative value, unsigned long is
> the best return type.
> 
> After some read, it seems that find_next_bit_[lb]e/_find_next_zero_bit_[lb]e
> are also incorectly set as return int.
> 
> This patch fix the return type of all thoses functions.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/include/asm/bitops.h | 22 +++++++++++-----------
>  arch/arm/lib/findbit.S        |  8 ++++----
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
> index e943e6c..868414b 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -159,18 +159,18 @@ extern int _test_and_change_bit(int nr, volatile unsigned long * p);
>  /*
>   * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
>   */
> -extern int _find_first_zero_bit_le(const void * p, unsigned size);
> -extern int _find_next_zero_bit_le(const void * p, int size, int offset);
> -extern int _find_first_bit_le(const unsigned long *p, unsigned size);
> -extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
> +extern unsigned long _find_first_zero_bit_le(const void *p, unsigned size);
> +extern unsigned long _find_next_zero_bit_le(const void *p, int size, int offset);
> +extern unsigned long _find_first_bit_le(const unsigned long *p, unsigned size);
> +extern unsigned long _find_next_bit_le(const unsigned long *p, int size, int offset);
>  
>  /*
>   * Big endian assembly bitops.  nr = 0 -> byte 3 bit 0.
>   */
> -extern int _find_first_zero_bit_be(const void * p, unsigned size);
> -extern int _find_next_zero_bit_be(const void * p, int size, int offset);
> -extern int _find_first_bit_be(const unsigned long *p, unsigned size);
> -extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
> +extern unsigned long _find_first_zero_bit_be(const void *p, unsigned size);
> +extern unsigned long _find_next_zero_bit_be(const void *p, int size, int offset);
> +extern unsigned long _find_first_bit_be(const unsigned long *p, unsigned size);
> +extern unsigned long _find_next_bit_be(const unsigned long *p, int size, int offset);
>  
>  #ifndef CONFIG_SMP
>  /*
> @@ -317,19 +317,19 @@ static inline unsigned long __ffs(unsigned long x)
>  
>  #ifdef __ARMEB__
>  
> -static inline int find_first_zero_bit_le(const void *p, unsigned size)
> +static inline unsigned long find_first_zero_bit_le(const void *p, unsigned size)
>  {
>  	return _find_first_zero_bit_le(p, size);
>  }
>  #define find_first_zero_bit_le find_first_zero_bit_le
>  
> -static inline int find_next_zero_bit_le(const void *p, int size, int offset)
> +static inline unsigned long find_next_zero_bit_le(const void *p, int size, int offset)
>  {
>  	return _find_next_zero_bit_le(p, size, offset);
>  }
>  #define find_next_zero_bit_le find_next_zero_bit_le
>  
> -static inline int find_next_bit_le(const void *p, int size, int offset)
> +static inline unsigned long find_next_bit_le(const void *p, int size, int offset)
>  {
>  	return _find_next_bit_le(p, size, offset);
>  }
> diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
> index 7848780..b4f6aec 100644
> --- a/arch/arm/lib/findbit.S
> +++ b/arch/arm/lib/findbit.S
> @@ -19,7 +19,7 @@
>  
>  /*
>   * Purpose  : Find a 'zero' bit
> - * Prototype: int find_first_zero_bit(void *addr, unsigned int maxbit);
> + * Prototype: unsigned long find_first_zero_bit(void *addr, unsigned int maxbit);
>   */
>  ENTRY(_find_first_zero_bit_le)
>  		teq	r1, #0	
> @@ -40,7 +40,7 @@ ENDPROC(_find_first_zero_bit_le)
>  
>  /*
>   * Purpose  : Find next 'zero' bit
> - * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
> + * Prototype: unsigned long find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
>   */
>  ENTRY(_find_next_zero_bit_le)
>  		teq	r1, #0
> @@ -60,7 +60,7 @@ ENDPROC(_find_next_zero_bit_le)
>  
>  /*
>   * Purpose  : Find a 'one' bit
> - * Prototype: int find_first_bit(const unsigned long *addr, unsigned int maxbit);
> + * Prototype: unsigned long find_first_bit(const unsigned long *addr, unsigned int maxbit);
>   */
>  ENTRY(_find_first_bit_le)
>  		teq	r1, #0	
> @@ -81,7 +81,7 @@ ENDPROC(_find_first_bit_le)
>  
>  /*
>   * Purpose  : Find next 'one' bit
> - * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
> + * Prototype: unsigned long find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
>   */
>  ENTRY(_find_next_bit_le)
>  		teq	r1, #0
> -- 
> 2.4.9
> 

Hello

Nobody actually made any comment on this.

Best regards
