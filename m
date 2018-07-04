From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jul 2018 14:52:37 +0100
Subject: [PATCH v2 2/7] arm64: numa: separate out updates to percpu
 nodeid and NUMA node cpumap
In-Reply-To: <1529327923-17911-3-git-send-email-sudeep.holla@arm.com>
References: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
 <1529327923-17911-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180704135237.GA4828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 02:18:38PM +0100, Sudeep Holla wrote:
> Currently numa_clear_node removes both cpu information from the NUMA
> node cpumap as well as the NUMA node id from the cpu. Similarly
> numa_store_cpu_info updates both percpu nodeid and NUMA cpumap.
> 
> However we need to retain the numa node id for the cpu and only remove
> the cpu information from the numa node cpumap during CPU hotplug out.
> The same can be extended for hotplugging in the CPU.
> 
> This patch separates out numa_{add,remove}_cpu from numa_clear_node and
> numa_store_cpu_info.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/include/asm/numa.h |  4 ++++
>  arch/arm64/kernel/smp.c       |  2 ++
>  arch/arm64/mm/numa.c          | 29 +++++++++++++++++++++--------
>  3 files changed, 27 insertions(+), 8 deletions(-)

--->8

> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index dad128ba98bf..43cc669bc7bc 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -70,19 +70,32 @@ EXPORT_SYMBOL(cpumask_of_node);
> 
>  #endif
> 
> -static void map_cpu_to_node(unsigned int cpu, int nid)
> +static void numa_update_cpu(unsigned int cpu, bool remove)
>  {
> -	set_cpu_numa_node(cpu, nid);
> -	if (nid >= 0)
> +	int nid = cpu_to_node(cpu);
> +
> +	if (nid < 0)
> +		return;

This could be a check against NUMA_NO_NODE, right?

Will
