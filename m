From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 27 Apr 2017 19:07:25 +0100
Subject: [PATCH v2 3/3] arm64: Silence first allocation with
 CONFIG_ARM64_MODULE_PLTS=y
In-Reply-To: <20170427173900.2538-4-f.fainelli@gmail.com>
References: <20170427173900.2538-1-f.fainelli@gmail.com>
 <20170427173900.2538-4-f.fainelli@gmail.com>
Message-ID: <C103C078-3462-43D9-AEF5-5DEC3A74CA7E@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 27 Apr 2017, at 18:39, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> When CONFIG_ARM64_MODULE_PLTS is enabled, the first allocation using the
> module space fails, because the module is too big, and then the module
> allocation is attempted from vmalloc space. Silence the first allocation
> failure in that case by setting __GFP_NOWARN.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> arch/arm64/kernel/module.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index 7f316982ce00..58bd5cfdd544 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -32,11 +32,16 @@
> 
> void *module_alloc(unsigned long size)
> {
> +    gfp_t gfp_mask = GFP_KERNEL;
>    void *p;
> 
> +#if IS_ENABLED(CONFIG_ARM64_MODULE_PLTS)
> +    /* Silence the initial allocation */
> +    gfp_mask |= __GFP_NOWARN;
> +#endif

Please use IS_ENABLED() instead here

>    p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>                module_alloc_base + MODULES_VSIZE,
> -                GFP_KERNEL, PAGE_KERNEL_EXEC, 0,
> +                gfp_mask, PAGE_KERNEL_EXEC, 0,
>                NUMA_NO_NODE, __builtin_return_address(0));
> 
>    if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> -- 
> 2.9.3
> 

Other than that, and with Michal's nit addressed:

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
