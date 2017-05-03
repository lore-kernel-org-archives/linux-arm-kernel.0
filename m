From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 May 2017 12:18:16 +0100
Subject: [PATCH v3 3/3] arm64: Silence first allocation with
 CONFIG_ARM64_MODULE_PLTS=y
In-Reply-To: <20170427181902.28829-4-f.fainelli@gmail.com>
References: <20170427181902.28829-1-f.fainelli@gmail.com>
 <20170427181902.28829-4-f.fainelli@gmail.com>
Message-ID: <20170503111814.GF8233@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 11:19:02AM -0700, Florian Fainelli wrote:
> When CONFIG_ARM64_MODULE_PLTS is enabled, the first allocation using the
> module space fails, because the module is too big, and then the module
> allocation is attempted from vmalloc space. Silence the first allocation
> failure in that case by setting __GFP_NOWARN.
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/kernel/module.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

I'm not sure what the merge plan is for these, but the arm64 bit here
looks fine to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index 7f316982ce00..093c13541efb 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -32,11 +32,16 @@
>  
>  void *module_alloc(unsigned long size)
>  {
> +	gfp_t gfp_mask = GFP_KERNEL;
>  	void *p;
>  
> +	/* Silence the initial allocation */
> +	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
> +		gfp_mask |= __GFP_NOWARN;
> +
>  	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>  				module_alloc_base + MODULES_VSIZE,
> -				GFP_KERNEL, PAGE_KERNEL_EXEC, 0,
> +				gfp_mask, PAGE_KERNEL_EXEC, 0,
>  				NUMA_NO_NODE, __builtin_return_address(0));
>  
>  	if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> -- 
> 2.9.3
> 
