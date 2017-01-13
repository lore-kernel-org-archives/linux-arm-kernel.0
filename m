From: tanxiaojun@huawei.com (Tan Xiaojun)
Date: Fri, 13 Jan 2017 17:06:33 +0800
Subject: [PATCH v2 2/2] arm64: cacheinfo: add support to override cache
 levels via device tree
In-Reply-To: <1484245772-31511-2-git-send-email-sudeep.holla@arm.com>
References: <1484245772-31511-1-git-send-email-sudeep.holla@arm.com>
 <1484245772-31511-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <58789899.3080909@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/1/13 2:29, Sudeep Holla wrote:
> The cache hierarchy can be identified through Cache Level ID(CLIDR)
> architected system register. However in some cases it will provide
> only the number of cache levels that are integrated into the processor
> itself. In other words, it can't provide any information about the
> caches that are external and/or transparent.
> 
> Some platforms require to export the information about all such external
> caches to the userspace applications via the sysfs interface.
> 
> This patch adds support to override the cache levels using device tree
> to take such external non-architected caches into account.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Tested-by: Tan Xiaojun <tanxiaojun@huawei.com>

> ---
>  arch/arm64/kernel/cacheinfo.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
> index 9617301f76b5..3f2250fc391b 100644
> --- a/arch/arm64/kernel/cacheinfo.c
> +++ b/arch/arm64/kernel/cacheinfo.c
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
> +	of_level = of_find_last_cache_level(cpu);
> +	if (level < of_level) {
> +		/*
> +		 * some external caches not specified in CLIDR_EL1
> +		 * the information may be available in the device tree
> +		 * only unified external caches are considered here
> +		 */
> +		leaves += (of_level - level);
> +		level = of_level;
> +	}
> +
>  	this_cpu_ci->num_levels = level;
>  	this_cpu_ci->num_leaves = leaves;
>  	return 0;
> --
> 2.7.4
> 
> 
> .
> 
