From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Nov 2015 15:24:36 +0000
Subject: [PATCH] arm64: early_alloc: Fix check for allocation failure
In-Reply-To: <1448041540-26229-1-git-send-email-suzuki.poulose@arm.com>
References: <1448041540-26229-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151123152436.GF4236@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 05:45:40PM +0000, Suzuki K. Poulose wrote:
> In early_alloc we check if the memblock_alloc failed by checking
> the virtual address of the result, which will never fail. This patch
> fixes it to check the actual result for failure.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/mm/mmu.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e3f563c..e94c32b 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -64,8 +64,12 @@ EXPORT_SYMBOL(phys_mem_access_prot);
>  
>  static void __init *early_alloc(unsigned long sz)
>  {
> -	void *ptr = __va(memblock_alloc(sz, sz));
> -	BUG_ON(!ptr);
> +	phys_addr_t phys;
> +	void *ptr;
> +
> +	phys = memblock_alloc(sz, sz);
> +	BUG_ON(!phys);
> +	ptr = __va(phys);
>  	memset(ptr, 0, sz);
>  	return ptr;

Haha, oops! I guess we don't tend to see failures that early on, but the
fix is correct:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
