From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Fri, 01 Aug 2014 21:37:19 +0900
Subject: [PATCH] ARM: mm: fix size rounding-down of arm_add_memory()
In-Reply-To: <1402025567-18021-1-git-send-email-yamada.m@jp.panasonic.com>
References: <1402025567-18021-1-git-send-email-yamada.m@jp.panasonic.com>
Message-ID: <20140801213719.D537.AA925319@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

Any comments for this patch?


Thanks

Best Regards
Masahiro Yamada



On Fri,  6 Jun 2014 12:32:47 +0900
Masahiro Yamada <yamada.m@jp.panasonic.com> wrote:

> The current rounding of "size" is wrong.
> 
>     size -= start & ~PAGE_MASK;
> 
> should be
> 
>     size -= PAGE_SIZE - (start & ~PAGE_MASK);
> 
> Or more simply
> 
>     size -= aligned_start - start;
> 
> Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
> ---
>  arch/arm/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 50e198c..84508c0 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -641,8 +641,8 @@ int __init arm_add_memory(u64 start, u64 size)
>  	 * Ensure that start/size are aligned to a page boundary.
>  	 * Size is appropriately rounded down, start is rounded up.
>  	 */
> -	size -= start & ~PAGE_MASK;
>  	aligned_start = PAGE_ALIGN(start);
> +	size -= aligned_start - start;
>  
>  #ifndef CONFIG_ARCH_PHYS_ADDR_T_64BIT
>  	if (aligned_start > ULONG_MAX) {
> -- 
> 1.9.1
