From: dave.kleikamp@oracle.com (Dave Kleikamp)
Date: Tue, 19 Jun 2018 08:37:17 -0500
Subject: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via
 /proc/iomem
In-Reply-To: <20180619064424.6642-2-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-2-takahiro.akashi@linaro.org>
Message-ID: <72307608-90e0-4842-edc1-d3b284782940@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2018 01:44 AM, AKASHI Takahiro wrote:

> +static int __init reserve_memblock_reserved_regions(void)
> +{
> +	phys_addr_t start, end, roundup_end = 0;
> +	struct resource *mem, *res;
> +	u64 i;
> +
> +	for_each_reserved_mem_region(i, &start, &end) {
> +		if (end <= roundup_end)
> +			continue; /* done already */
> +
> +		start = __pfn_to_phys(PFN_DOWN(start));
> +		end = __pfn_to_phys(PFN_UP(end)) - 1;
> +		roundup_end = end;
> +
> +		res = kzalloc(sizeof(*res), GFP_ATOMIC);
> +		if (WARN_ON(!res))
> +			return -ENOMEM;
> +		res->start = start;
> +		res->end = end;
> +		res->name  = "reserved";
> +		res->flags = IORESOURCE_MEM;
> +
> +		mem = request_resource_conflict(&iomem_resource, res);
> +		/*
> +		 * We expected memblock_reserve() regions to conflict with
> +		 * memory created by request_standard_resources().
> +		 */
> +		if (WARN_ON_ONCE(!mem))
> +			continue;
> +		kfree(res);

Why is kfree() after the conditional continue? This is a memory leak.

> +
> +		reserve_region_with_split(mem, start, end, "reserved");
> +	}
> +
> +	return 0;
> +}
> +arch_initcall(reserve_memblock_reserved_regions);
> +
>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>  
>  void __init setup_arch(char **cmdline_p)
> 
