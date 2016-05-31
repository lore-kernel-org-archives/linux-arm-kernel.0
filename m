From: mbrugger@suse.com (Matthias Brugger)
Date: Tue, 31 May 2016 11:07:06 +0200
Subject: [PATCH v2 5/5] arm64/numa: avoid inconsistent information to be
 printed
In-Reply-To: <1464427377-12712-6-git-send-email-thunder.leizhen@huawei.com>
References: <1464427377-12712-1-git-send-email-thunder.leizhen@huawei.com>
 <1464427377-12712-6-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <574D543A.2090406@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/05/16 11:22, Zhen Lei wrote:
> numa_init(of_numa_init) may returned error because of numa configuration
> error. So "No NUMA configuration found" is inaccurate. In fact, specific
> configuration error information should be immediately printed by the
> testing branch.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

Which kernel version is this patch based on?

Regards,
Matthias

>   arch/arm64/mm/numa.c | 6 +++---
>   drivers/of/of_numa.c | 7 +++----
>   2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 2601660..1b9622c 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -338,8 +338,10 @@ static int __init numa_init(int (*init_func)(void))
>   	if (ret < 0)
>   		return ret;
>
> -	if (nodes_empty(numa_nodes_parsed))
> +	if (nodes_empty(numa_nodes_parsed)) {
> +		pr_info("No NUMA configuration found\n");
>   		return -EINVAL;
> +	}
>
>   	ret = numa_register_nodes();
>   	if (ret < 0)
> @@ -370,8 +372,6 @@ static int __init dummy_numa_init(void)
>
>   	if (numa_off)
>   		pr_info("NUMA disabled\n"); /* Forced off on command line. */
> -	else
> -		pr_info("No NUMA configuration found\n");
>   	pr_info("NUMA: Faking a node at [mem %#018Lx-%#018Lx]\n",
>   	       0LLU, PFN_PHYS(max_pfn) - 1);
>
> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> index fb62307..3157130 100644
> --- a/drivers/of/of_numa.c
> +++ b/drivers/of/of_numa.c
> @@ -63,7 +63,7 @@ static int __init of_numa_parse_memory_nodes(void)
>   	struct device_node *np = NULL;
>   	struct resource rsrc;
>   	u32 nid;
> -	int i, r = 0;
> +	int i, r;
>
>   	for_each_node_by_type(np, "memory") {
>   		r = of_property_read_u32(np, "numa-node-id", &nid);
> @@ -81,12 +81,11 @@ static int __init of_numa_parse_memory_nodes(void)
>   		if (!i || r) {
>   			of_node_put(np);
>   			pr_err("NUMA: bad property in memory node\n");
> -			r = r ? : -EINVAL;
> -			break;
> +			return r ? : -EINVAL;
>   		}
>   	}
>
> -	return r;
> +	return 0;
>   }
>

Well this is fixing changes you introduced in this patch-set. Any reason 
this is not part of patch 2?

>   static int __init of_numa_parse_distance_map_v1(struct device_node *map)
> --
> 2.5.0
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
