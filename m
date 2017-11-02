From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 2 Nov 2017 12:25:47 +0000
Subject: [PATCH] ARM: NOMMU: work around maybe-uninitialized warning
In-Reply-To: <20171102092155.737712-1-arnd@arndb.de>
References: <20171102092155.737712-1-arnd@arndb.de>
Message-ID: <681a1757-ddbe-c9a7-6945-fa72600cf172@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/17 09:21, Arnd Bergmann wrote:
> The reworked MPU code produces a new warning in some configurations,
> presumably starting with the code move after the compiler now makes
> different inlining decisions:
> 
> arch/arm/mm/pmsa-v7.c: In function 'adjust_lowmem_bounds_mpu':
> arch/arm/mm/pmsa-v7.c:310:5: error: 'specified_mem_size' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This appears to be harmless, as we know that there is always at
> least one memblock, and the only way this could get triggered is
> if the for_each_memblock() loop was never entered.
> 
> I could not come up with a better workaround than initializing
> the specified_mem_size to zero, but at least that is the value
> that the variable would have in the hypothetical case of no
> memblocks.
> 
> Fixes: 877ec119dbbf ("ARM: 8706/1: NOMMU: Move out MPU setup in separate module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Vladimir, if this looks good to you, can you forward it to Russell's
> patch tracker, or otherwise suggest a different fix?

Accepted as patch 8719/1. Not sure if Russell will pick it up or not... anyway,
thanks for the patch!

Vladimir

> ---
>  arch/arm/mm/pmsa-v7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
> index 106ae1c435a3..976df60ac426 100644
> --- a/arch/arm/mm/pmsa-v7.c
> +++ b/arch/arm/mm/pmsa-v7.c
> @@ -234,7 +234,7 @@ static int __init allocate_region(phys_addr_t base, phys_addr_t size,
>  /* MPU initialisation functions */
>  void __init adjust_lowmem_bounds_mpu(void)
>  {
> -	phys_addr_t  specified_mem_size, total_mem_size = 0;
> +	phys_addr_t  specified_mem_size = 0, total_mem_size = 0;
>  	struct memblock_region *reg;
>  	bool first = true;
>  	phys_addr_t mem_start;
> 
