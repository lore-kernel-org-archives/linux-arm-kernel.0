From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 15 May 2018 12:15:08 -0500
Subject: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
In-Reply-To: <20180511235807.30834-3-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
Message-ID: <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Have you had a chance to look at the cachinfo parts of this patch?

Comments?

Thanks,




On 05/11/2018 06:57 PM, Jeremy Linton wrote:
> The original intent in cacheinfo was that an architecture
> specific populate_cache_leaves() would probe the hardware
> and then cache_shared_cpu_map_setup() and
> cache_override_properties() would provide firmware help to
> extend/expand upon what was probed. Arm64 was really
> the only architecture that was working this way, and
> with the removal of most of the hardware probing logic it
> became clear that it was possible to simplify the logic a bit.
> 
> This patch combines the walk of the DT nodes with the
> code updating the cache size/line_size and nr_sets.
> cache_override_properties() (which was DT specific) is
> then removed. The result is that cacheinfo.of_node is
> no longer used as a temporary place to hold DT references
> for future calls that update cache properties. That change
> helps to clarify its one remaining use (matching
> cacheinfo nodes that represent shared caches) which
> will be used by the ACPI/PPTT code in the following patches.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>   arch/riscv/kernel/cacheinfo.c |  1 -
>   drivers/base/cacheinfo.c      | 65 +++++++++++++++++++------------------------
>   2 files changed, 29 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 10ed2749e246..0bc86e5f8f3f 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -20,7 +20,6 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>   			 struct device_node *node,
>   			 enum cache_type type, unsigned int level)
>   {
> -	this_leaf->of_node = node;
>   	this_leaf->level = level;
>   	this_leaf->type = type;
>   	/* not a sector cache */
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 09ccef7ddc99..a872523e8951 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -71,7 +71,7 @@ static inline int get_cacheinfo_idx(enum cache_type type)
>   	return type;
>   }
>   
> -static void cache_size(struct cacheinfo *this_leaf)
> +static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
>   {
>   	const char *propname;
>   	const __be32 *cache_size;
> @@ -80,13 +80,14 @@ static void cache_size(struct cacheinfo *this_leaf)
>   	ct_idx = get_cacheinfo_idx(this_leaf->type);
>   	propname = cache_type_info[ct_idx].size_prop;
>   
> -	cache_size = of_get_property(this_leaf->of_node, propname, NULL);
> +	cache_size = of_get_property(np, propname, NULL);
>   	if (cache_size)
>   		this_leaf->size = of_read_number(cache_size, 1);
>   }
>   
>   /* not cache_line_size() because that's a macro in include/linux/cache.h */
> -static void cache_get_line_size(struct cacheinfo *this_leaf)
> +static void cache_get_line_size(struct cacheinfo *this_leaf,
> +				struct device_node *np)
>   {
>   	const __be32 *line_size;
>   	int i, lim, ct_idx;
> @@ -98,7 +99,7 @@ static void cache_get_line_size(struct cacheinfo *this_leaf)
>   		const char *propname;
>   
>   		propname = cache_type_info[ct_idx].line_size_props[i];
> -		line_size = of_get_property(this_leaf->of_node, propname, NULL);
> +		line_size = of_get_property(np, propname, NULL);
>   		if (line_size)
>   			break;
>   	}
> @@ -107,7 +108,7 @@ static void cache_get_line_size(struct cacheinfo *this_leaf)
>   		this_leaf->coherency_line_size = of_read_number(line_size, 1);
>   }
>   
> -static void cache_nr_sets(struct cacheinfo *this_leaf)
> +static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
>   {
>   	const char *propname;
>   	const __be32 *nr_sets;
> @@ -116,7 +117,7 @@ static void cache_nr_sets(struct cacheinfo *this_leaf)
>   	ct_idx = get_cacheinfo_idx(this_leaf->type);
>   	propname = cache_type_info[ct_idx].nr_sets_prop;
>   
> -	nr_sets = of_get_property(this_leaf->of_node, propname, NULL);
> +	nr_sets = of_get_property(np, propname, NULL);
>   	if (nr_sets)
>   		this_leaf->number_of_sets = of_read_number(nr_sets, 1);
>   }
> @@ -135,32 +136,27 @@ static void cache_associativity(struct cacheinfo *this_leaf)
>   		this_leaf->ways_of_associativity = (size / nr_sets) / line_size;
>   }
>   
> -static bool cache_node_is_unified(struct cacheinfo *this_leaf)
> +static bool cache_node_is_unified(struct cacheinfo *this_leaf,
> +				  struct device_node *np)
>   {
> -	return of_property_read_bool(this_leaf->of_node, "cache-unified");
> +	return of_property_read_bool(np, "cache-unified");
>   }
>   
> -static void cache_of_override_properties(unsigned int cpu)
> +static void cache_of_set_props(struct cacheinfo *this_leaf,
> +			       struct device_node *np)
>   {
> -	int index;
> -	struct cacheinfo *this_leaf;
> -	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> -
> -	for (index = 0; index < cache_leaves(cpu); index++) {
> -		this_leaf = this_cpu_ci->info_list + index;
> -		/*
> -		 * init_cache_level must setup the cache level correctly
> -		 * overriding the architecturally specified levels, so
> -		 * if type is NONE at this stage, it should be unified
> -		 */
> -		if (this_leaf->type == CACHE_TYPE_NOCACHE &&
> -		    cache_node_is_unified(this_leaf))
> -			this_leaf->type = CACHE_TYPE_UNIFIED;
> -		cache_size(this_leaf);
> -		cache_get_line_size(this_leaf);
> -		cache_nr_sets(this_leaf);
> -		cache_associativity(this_leaf);
> -	}
> +	/*
> +	 * init_cache_level must setup the cache level correctly
> +	 * overriding the architecturally specified levels, so
> +	 * if type is NONE at this stage, it should be unified
> +	 */
> +	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
> +	    cache_node_is_unified(this_leaf, np))
> +		this_leaf->type = CACHE_TYPE_UNIFIED;
> +	cache_size(this_leaf, np);
> +	cache_get_line_size(this_leaf, np);
> +	cache_nr_sets(this_leaf, np);
> +	cache_associativity(this_leaf);
>   }
>   
>   static int cache_setup_of_node(unsigned int cpu)
> @@ -193,6 +189,7 @@ static int cache_setup_of_node(unsigned int cpu)
>   			np = of_node_get(np);/* cpu node itself */
>   		if (!np)
>   			break;
> +		cache_of_set_props(this_leaf, np);
>   		this_leaf->of_node = np;
>   		index++;
>   	}
> @@ -203,7 +200,6 @@ static int cache_setup_of_node(unsigned int cpu)
>   	return 0;
>   }
>   #else
> -static void cache_of_override_properties(unsigned int cpu) { }
>   static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
>   static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
>   					   struct cacheinfo *sib_leaf)
> @@ -286,12 +282,6 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
>   	}
>   }
>   
> -static void cache_override_properties(unsigned int cpu)
> -{
> -	if (of_have_populated_dt())
> -		return cache_of_override_properties(cpu);
> -}
> -
>   static void free_cache_attributes(unsigned int cpu)
>   {
>   	if (!per_cpu_cacheinfo(cpu))
> @@ -325,6 +315,10 @@ static int detect_cache_attributes(unsigned int cpu)
>   	if (per_cpu_cacheinfo(cpu) == NULL)
>   		return -ENOMEM;
>   
> +	/*
> +	 * populate_cache_leaves() may completely setup the cache leaves and
> +	 * shared_cpu_map or it may leave it partially setup.
> +	 */
>   	ret = populate_cache_leaves(cpu);
>   	if (ret)
>   		goto free_ci;
> @@ -338,7 +332,6 @@ static int detect_cache_attributes(unsigned int cpu)
>   		goto free_ci;
>   	}
>   
> -	cache_override_properties(cpu);
>   	return 0;
>   
>   free_ci:
> 
