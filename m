From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 16 May 2014 17:34:04 +0100
Subject: [PATCH 4/6] arm64: topology: add MPIDR-based detection
In-Reply-To: <1399063112-16917-5-git-send-email-broonie@kernel.org>
References: <1399063112-16917-1-git-send-email-broonie@kernel.org>
 <1399063112-16917-5-git-send-email-broonie@kernel.org>
Message-ID: <53763DFC.8070309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/05/14 21:38, Mark Brown wrote:
> From: Zi Shen Lim <zlim@broadcom.com>
>
> Create cpu topology based on MPIDR. When hardware sets MPIDR to sane
> values, this method will always work. Therefore it should also work well
> as the fallback method. [1]
>
> When we have multiple processing elements in the system, we create
> the cpu topology by mapping each affinity level (from lowest to highest)
> to threads (if they exist), cores, and clusters.
>
> We combine data from all higher affinity levels into cluster_id
> so we don't lose any information from MPIDR. [2]
>
> [1] http://www.spinics.net/lists/arm-kernel/msg317445.html
> [2] https://lkml.org/lkml/2014/4/23/703
>
> [Raise the priority of the error message if we don't discover topology
> now that we can read it from MPIDIR -- broonie]
>
> Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>   arch/arm64/include/asm/cputype.h |  5 +++++
>   arch/arm64/kernel/topology.c     | 46 ++++++++++++++++++++++++++++++++++++----
>   2 files changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index c404fb0..b3b3287 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -18,6 +18,8 @@
>
>   #define INVALID_HWID		ULONG_MAX
>
> +#define MPIDR_UP_BITMASK	(0x1 << 30)
> +#define MPIDR_MT_BITMASK	(0x1 << 24)
>   #define MPIDR_HWID_BITMASK	0xff00ffffff
>
>   #define MPIDR_LEVEL_BITS_SHIFT	3
> @@ -30,6 +32,9 @@
>   #define MPIDR_AFFINITY_LEVEL(mpidr, level) \
>   	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
>
> +#define MPIDR_AFF_MASK(level) \
> +	((u64)MPIDR_LEVEL_MASK << MPIDR_LEVEL_SHIFT(level))
> +
>   #define read_cpuid(reg) ({						\
>   	u64 __val;							\
>   	asm("mrs	%0, " #reg : "=r" (__val));			\
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 43514f9..3b2479c 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -20,6 +20,8 @@
>   #include <linux/of.h>
>   #include <linux/sched.h>
>
> +#include <asm/cputype.h>
> +#include <asm/smp_plat.h>
>   #include <asm/topology.h>
>
>   static int __init get_cpu_for_node(struct device_node *node)
> @@ -220,10 +222,8 @@ static void update_siblings_masks(unsigned int cpuid)
>   	int cpu;
>
>   	if (cpuid_topo->cluster_id == -1) {
> -		/*
> -		 * DT does not contain topology information for this cpu.
> -		 */
> -		pr_debug("CPU%u: No topology information configured\n", cpuid);
> +		/* No topology information for this cpu ?! */
> +		pr_err("CPU%u: No topology information configured\n", cpuid);
>   		return;
>   	}
>
> @@ -249,6 +249,44 @@ static void update_siblings_masks(unsigned int cpuid)
>
>   void store_cpu_topology(unsigned int cpuid)
>   {
> +	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
> +	u64 mpidr;
> +
> +	if (cpuid_topo->cluster_id != -1)
> +		goto topology_populated;
> +
> +	mpidr = read_cpuid_mpidr();
> +
> +	/* Create cpu topology mapping based on MPIDR. */
> +	if (mpidr & MPIDR_UP_BITMASK) {
> +		/* Uniprocessor system */
> +		cpuid_topo->thread_id  = -1;
> +		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +		cpuid_topo->cluster_id = 0;
> +	} else if (mpidr & MPIDR_MT_BITMASK) {
> +		/* Multiprocessor system : Multi-threads per core */
> +		cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +		cpuid_topo->cluster_id =
> +			((mpidr & MPIDR_AFF_MASK(2)) >> mpidr_hash.shift_aff[2] |
> +			 (mpidr & MPIDR_AFF_MASK(3)) >> mpidr_hash.shift_aff[3])
> +			>> mpidr_hash.shift_aff[1] >> mpidr_hash.shift_aff[0];

This is broken, IIRC Lorenzo commented on this in the previous version of the
patch.

> +	} else {
> +		/* Multiprocessor system : Single-thread per core */
> +		cpuid_topo->thread_id  = -1;
> +		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +		cpuid_topo->cluster_id =
> +			((mpidr & MPIDR_AFF_MASK(1)) >> mpidr_hash.shift_aff[1] |
> +			 (mpidr & MPIDR_AFF_MASK(2)) >> mpidr_hash.shift_aff[2] |
> +			 (mpidr & MPIDR_AFF_MASK(3)) >> mpidr_hash.shift_aff[3])
> +			>> mpidr_hash.shift_aff[0];

Ditto here.

Take a simple example of system with 2 Quad core clusters.
The mpidr_hash.shift_aff[1] will be 6 as you need minimum 2 bits to represent
aff[0]. So you will end up with second cluster with id = 4 instead of 1.

I am not sure if we need this serialization, but even if we need it you can't
simply use the hash bits generated for MPIDR.Aff{3..0} serialization directly
as is for serializing parts of it.

Regards,
Sudeep
