From: tanxiaojun@huawei.com (Tan Xiaojun)
Date: Thu, 5 Jan 2017 11:43:44 +0800
Subject: [QUESTION] Arm64: Query L3 cache info via DT
In-Reply-To: <81784854-11f8-468a-a280-69be0a714a3b@arm.com>
References: <58633494.9030708@huawei.com>
 <81784854-11f8-468a-a280-69be0a714a3b@arm.com>
Message-ID: <586DC0F0.5030006@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK. Thank you very much. I will try it in my arm64 board.

Xiaojun.

On 2017/1/4 19:47, Sudeep Holla wrote:
> 
> Hi Tan,
> 
> On 28/12/16 03:42, Tan Xiaojun wrote:
>> Hi.
>>
>> I saw you discussed how to achieve querying cache information and
>> tend to implement the external ones(like L3 cache) via DT a few
>> months ago.
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/405399.html
>>
>>  Are these implementations progressing? Forgive me to take the
>> liberty to ask, we care about this thing.
>>
> 
> Yes the support to override the cache properties for DT was added in v4.10
> 
> However, it still depends on the the sysreg to get the total levels of
> caches supported in the system. You may need to tweak a bit around that
> to support what you need.
> 
>> If you've already implemented some codes, we can help with testing
>> (in Hisilicon D02, D03, D05) after you send it to the mail-list.
>>
> 
> Sure, that would help.
> 
>> We can try our best to help if there is any difficulty.
> 
> OK, you can start trying the patch below :). It's not even compile
> tested, so you make have to make some changes necessary. I just wanted
> to put my thoughts here. Make sure all the L3 cacheinfo is present in DT.
> 
> Regards,
> Sudeep
> 
> 
> --
> 
> diff --git i/arch/arm64/kernel/cacheinfo.c w/arch/arm64/kernel/cacheinfo.c
> index 9617301f76b5..88fbcd368104 100644
> --- i/arch/arm64/kernel/cacheinfo.c
> +++ w/arch/arm64/kernel/cacheinfo.c
> @@ -84,7 +84,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
> 
>  static int __init_cache_level(unsigned int cpu)
>  {
> -	unsigned int ctype, level, leaves;
> +	unsigned int ctype, level, leaves, of_level;
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> 
>  	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
> @@ -97,6 +97,17 @@ static int __init_cache_level(unsigned int cpu)
>  		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
>  	}
> 
> +	of_level = of_count_cache_levels(cpu);
> +	if (level < of_level) {
> +		/*
> +		 * some external caches not specified in CLIDR_EL1
> +		 * the information may be available in the device tree
> +		 * only unified external caches are considered here
> +		 */
> +		level = of_level;
> +		leaves += (of_level - level);
> +	}
> +
>  	this_cpu_ci->num_levels = level;
>  	this_cpu_ci->num_leaves = leaves;
>  	return 0;
> diff --git i/drivers/of/base.c w/drivers/of/base.c
> index d4bea3c797d6..8007f3b06cb8 100644
> --- i/drivers/of/base.c
> +++ w/drivers/of/base.c
> @@ -2267,6 +2267,20 @@ struct device_node *of_find_next_cache_node(const
> struct device_node *np)
>  	return NULL;
>  }
> 
> +int of_count_cache_levels(unsigned int cpu)
> +{
> +	int level = 0;
> +	struct device *cpu_dev = get_cpu_device(cpu);
> +	struct device_node *np = cpu_dev->of_node;
> +
> +	while (np) {
> +		level++;
> +		np = of_find_next_cache_node(np);
> +	}
> +
> +	return level;
> +}
> +
>  /**
>   * of_graph_parse_endpoint() - parse common endpoint node properties
>   * @node: pointer to endpoint device_node
> diff --git i/include/linux/of.h w/include/linux/of.h
> index d72f01009297..c8597ae71ff3 100644
> --- i/include/linux/of.h
> +++ w/include/linux/of.h
> @@ -280,6 +280,7 @@ extern struct device_node
> *of_get_child_by_name(const struct device_node *node,
> 
>  /* cache lookup */
>  extern struct device_node *of_find_next_cache_node(const struct
> device_node *);
> +extern int of_count_cache_levels(unsigned int cpu);
>  extern struct device_node *of_find_node_with_property(
>  	struct device_node *from, const char *prop_name);
> 
> 
> .
> 
