From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 20 Dec 2013 17:39:25 -0500
Subject: [PATCH] mm/ARM: fix ARMs __ffs() to conform to avoid warning
 with NO_BOOTMEM
In-Reply-To: <1386981486-3173-1-git-send-email-santosh.shilimkar@ti.com>
References: <1386981486-3173-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <52B4C71D.9030904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Friday 13 December 2013 07:38 PM, Santosh Shilimkar wrote:
> Building ARM with NO_BOOTMEM generates below warning.
> 
> mm/nobootmem.c: In function _____free_pages_memory___:
> mm/nobootmem.c:88:11: warning: comparison of distinct pointer types lacks a cast
> 
> 	order = min(MAX_ORDER - 1UL, __ffs(start));
> 
> ARM's __ffs() differs from other architectures in that it ends up being
> an int, whereas almost everyone else is unsigned long.
> 
> So fix ARMs __ffs() to conform to other architectures. Suggested by
> Russell King <linux@arm.linux.org.uk>
> 
> Some more details in below thread -
> 	https://lkml.org/lkml/2013/12/9/807
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
Is this patch inline with what we discussed off-list ?
If you ack it, it can go into the Andrews tree to kill that one last
warning with the memblock series. Thanks


>  arch/arm/include/asm/bitops.h |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
> index e691ec9..5f41d81 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -270,10 +270,25 @@ static inline int fls(int x)
>  	return ret;
>  }
>  
> -#define __fls(x) (fls(x) - 1)
> -#define ffs(x) ({ unsigned long __t = (x); fls(__t & -__t); })
> -#define __ffs(x) (ffs(x) - 1)
> -#define ffz(x) __ffs( ~(x) )
> +static inline unsigned long __fls(unsigned long x)
> +{
> +	return fls(x) - 1;
> +}
> +
> +static inline int ffs(int x)
> +{
> +	return fls(x & -x);
> +}
> +
> +static inline unsigned long __ffs(unsigned long x)
> +{
> +	return ffs(x) - 1;
> +}
> +
> +static inline unsigned long ffz(unsigned long x)
> +{
> +	return __ffs(~x);
> +}
>  
>  #endif
>  
> 
