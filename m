From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 17 Sep 2013 22:33:58 -0500
Subject: [PATCH 18/28] of: create default early_init_dt_add_memory_arch
In-Reply-To: <1379372965-22359-19-git-send-email-robherring2@gmail.com>
References: <1379372965-22359-1-git-send-email-robherring2@gmail.com>
 <1379372965-22359-19-git-send-email-robherring2@gmail.com>
Message-ID: <20130918033358.51CA1C42C9E@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Sep 2013 18:09:14 -0500, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Create a weak version of early_init_dt_add_memory_arch which uses
> memblock or is an empty function when memblock is not enabled. This
> will unify all architectures except ones with custom memory bank
> structs.

Two comments below, but otherwise:

Acked-by: Grant Likely <grant.likely@linaro.org>

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 0714dd4..a9dce7a 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -688,6 +688,17 @@ u64 __init dt_mem_next_cell(int s, __be32 **cellp)
>  	return of_read_number(p, s);
>  }
>  
> +void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> +{
> +#ifdef CONFIG_HAVE_MEMBLOCK
> +	base &= PAGE_MASK;
> +	size &= PAGE_MASK;
> +	memblock_add(base, size);
> +#else
> +	pr_err("%s: ignoring memory (%llx, %llx)\n", __func__, base, size);
> +#endif
> +}
> +

Can you do it this way instead:

#ifdef CONFIG_HAVE_MEMBLOCK
void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
{
	base &= PAGE_MASK;
	size &= PAGE_MASK;
	memblock_add(base, size);
}
#endif

If the platform doesn't provide an early_init_dt_add_memory_arch()
function and it doesn't have a memblock implementation, then the build
should outright fail. I don't see a scenario where we would want to
successfully build the kernel without a working add memory function.

Also, can you group this function with the common __weak
early_init_dt_alloc_memory_arch() implementation? It would be good to
group all the memblock specific functions together.

g.
