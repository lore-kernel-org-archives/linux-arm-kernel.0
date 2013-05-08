From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 May 2013 19:45:55 +0100
Subject: [PATCH v5, part3 01/15] mm: fix build warnings caused by
 free_reserved_area()
In-Reply-To: <1368026235-5976-2-git-send-email-jiang.liu@huawei.com>
References: <1368026235-5976-1-git-send-email-jiang.liu@huawei.com>
 <1368026235-5976-2-git-send-email-jiang.liu@huawei.com>
Message-ID: <20130508184555.GR18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 11:17:00PM +0800, Jiang Liu wrote:
> Fix following build warnings cuased by free_reserved_area():
> 
> arch/arm/mm/init.c: In function 'mem_init':
> arch/arm/mm/init.c:603:2: warning: passing argument 1 of 'free_reserved_area' makes integer from pointer without a cast [enabled by default]
>   free_reserved_area(__va(PHYS_PFN_OFFSET), swapper_pg_dir, 0, NULL);
>   ^
> In file included from include/linux/mman.h:4:0,
>                  from arch/arm/mm/init.c:15:
> include/linux/mm.h:1301:22: note: expected 'long unsigned int' but argument is of type 'void *'
>  extern unsigned long free_reserved_area(unsigned long start, unsigned long end,
> 
>    mm/page_alloc.c: In function 'free_reserved_area':
> >> mm/page_alloc.c:5134:3: warning: passing argument 1 of 'virt_to_phys' makes pointer from integer without a cast [enabled by default]
>    In file included from arch/mips/include/asm/page.h:49:0,
>                     from include/linux/mmzone.h:20,
>                     from include/linux/gfp.h:4,
>                     from include/linux/mm.h:8,
>                     from mm/page_alloc.c:18:
>    arch/mips/include/asm/io.h:119:29: note: expected 'const volatile void *' but argument is of type 'long unsigned int'
>    mm/page_alloc.c: In function 'free_area_init_nodes':
>    mm/page_alloc.c:5030:34: warning: array subscript is below array bounds [-Warray-bounds]
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-mm at kvack.org
> ---
>  arch/arm/mm/init.c |    6 ++++--
>  mm/page_alloc.c    |    2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 9a5cdc0..7a82fcd 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -600,7 +600,8 @@ void __init mem_init(void)
>  
>  #ifdef CONFIG_SA1111
>  	/* now that our DMA memory is actually so designated, we can free it */
> -	free_reserved_area(__va(PHYS_PFN_OFFSET), swapper_pg_dir, 0, NULL);
> +	free_reserved_area((unsigned long)__va(PHYS_PFN_OFFSET),
> +			   (unsigned long)swapper_pg_dir, 0, NULL);

*YUCK*.

As I've said before, fixing the arguments on free_reserved_area() would
be much better than throwing these horrid casts all over the code.

You're casting pointers to integers, and then immediately casting them
back to pointers in free_reserved_area().  Please fix the function
argument types to be sane.
