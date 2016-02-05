From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Fri, 5 Feb 2016 12:04:02 +0000
Subject: [QUESTION ]ARM64 external L3 cache support in topology info
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8172E13A4@lhreml504-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a query to get the external L3 cache included in the cache
topology info. ARM64 kernel now has the cache topology info added
based on the patch here [1].

1. http://permalink.gmane.org/gmane.linux.ports.arm.kernel/383628

> 
> This patch adds support for cacheinfo on ARM64.
> 
> On ARMv8, the cache hierarchy can be identified through Cache Level ID
> (CLIDR) register while the cache geometry is provided by Cache Size ID
> (CCSIDR) register.
> 
> Since the architecture doesn't provide any way of detecting the cpus 
> sharing particular cache, device tree is used for the same purpose.

We have a ARM64 board(Hisilicon D02) and it has got an external L3 cache.
As per my understanding after talking to our SoC guys, this cache is not
integrated into the processor and is not visible in (CLIDR) register. 
But this looks to be fine as per the Programmer's Guide for ARMv8-A.

"The CLIDR register is only aware of how many levels of cache are 
integrated into the processor itself. It cannot provide information
about any caches in the external memory system. For example, if 
only L1 and L2 are integrated, CLIDR/CLIDR_EL1 identifies two levels
of cache and the processor is unaware of any external L3 cache. 
It might be necessary to take into account non-integrated caches
when performing cache maintenance, or code that is maintaining
coherency with integrated caches."

> Signed-off-by: Sudeep Holla <sudeep.holla <at> arm.com>
> Cc: Catalin Marinas <catalin.marinas <at> arm.com>
> Cc: Will Deacon <will.deacon <at> arm.com>
> Cc: Mark Rutland <mark.rutland <at> arm.com>
> Cc: linux-arm-kernel <at> lists.infradead.org
> ---
>  arch/arm64/include/asm/cachetype.h |  29 +++++++--
>  arch/arm64/kernel/Makefile         |   2 +-
>  arch/arm64/kernel/cacheinfo.c      | 128 
[....]

> +static int __populate_cache_leaves(unsigned int cpu)
> +{
> +    unsigned int level, idx;
> +    enum cache_type type;
> +    struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +    struct cacheinfo *this_leaf = this_cpu_ci->info_list;
> +
> +    for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
> +         idx < this_cpu_ci->num_leaves; idx++, level++) {
> +        type = get_cache_type(level);
> +        if (type == CACHE_TYPE_SEPARATE) {
> +            ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> +            ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> +        } else {
> +            ci_leaf_init(this_leaf++, type, level);
> +        }
> +    }
> +    return 0;
> +}
Here the cache leaves are populated on what CLIDR is reporting, and dts
entry is only used to find out the sharing info. Not sure purpose of
this patch is only to report the cache that is integrated to the processor.

In our case, the L3 cache seems to be intelligent enough and doesn't
require any additional maintenance ops. So there is no cache-controller
code for this. I am just wondering what's the best way to add this L3
cache info to the topology. Overriding the CLIDR register, if there is
a next-level-cache entry in the dts and then retrieve the cache geometry
either from dts or from cache specific registers( but this will be
implementation specific) ? Or am I missing something here? 

Thanks,
Shameer
