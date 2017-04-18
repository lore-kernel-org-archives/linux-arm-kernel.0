From: slash.tmp@free.fr (Mason)
Date: Tue, 18 Apr 2017 11:36:12 +0200
Subject: [PATCH] arm: bitops: Align prototypes to generic API
In-Reply-To: <b6610c43-75fe-64ee-8b22-867f970e3fe7@free.fr>
References: <87371ad9-012b-358d-f186-f8caa79feb0f@free.fr>
 <b6610c43-75fe-64ee-8b22-867f970e3fe7@free.fr>
Message-ID: <5afb9255-886c-be8d-fb7d-4ce46d995a98@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2017 14:21, Mason wrote:

> include/asm-generic/bitops/find.h declares:
> 
> extern unsigned long
> find_first_zero_bit(const unsigned long *addr, unsigned long size);
> 
> while arch/arm/include/asm/bitops.h declares:
> 
> #define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
> extern int _find_first_zero_bit_le(const void * p, unsigned size);
> 
> Align the arm prototypes to the generic API, to have gcc report
> inadequate arguments, such as pointer to u32.
> 
> Signed-off-by: Mason <slash.tmp@free.fr>
> ---
>  arch/arm/include/asm/bitops.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
> index e943e6cee254..f308c8c40cb9 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -159,16 +159,16 @@ extern int _test_and_change_bit(int nr, volatile unsigned long * p);
>  /*
>   * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
>   */
> -extern int _find_first_zero_bit_le(const void * p, unsigned size);
> -extern int _find_next_zero_bit_le(const void * p, int size, int offset);
> +extern int _find_first_zero_bit_le(const unsigned long *p, unsigned size);
> +extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
>  extern int _find_first_bit_le(const unsigned long *p, unsigned size);
>  extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
>  
>  /*
>   * Big endian assembly bitops.  nr = 0 -> byte 3 bit 0.
>   */
> -extern int _find_first_zero_bit_be(const void * p, unsigned size);
> -extern int _find_next_zero_bit_be(const void * p, int size, int offset);
> +extern int _find_first_zero_bit_be(const unsigned long *p, unsigned size);
> +extern int _find_next_zero_bit_be(const unsigned long *p, int size, int offset);
>  extern int _find_first_bit_be(const unsigned long *p, unsigned size);
>  extern int _find_next_bit_be(const unsigned long *p, int size, int offset);

Marc, it was you who pointed out that it is not valid to pass
the address of a u32 to find_first_zero_bit()

What are your thoughts on this trivial patch?

Russell, same question.

If no one thinks this patch is useful, I'll drop it and move on.

Regards.
