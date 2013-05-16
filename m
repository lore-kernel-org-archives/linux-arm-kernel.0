From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 May 2013 16:50:38 +0100
Subject: [PATCH 3/3] ARM: kernel: fix __cpu_logical_map default
 initialization
In-Reply-To: <1368718447-19209-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368718447-19209-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1368718447-19209-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130516155038.GK11706@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 04:34:07PM +0100, Lorenzo Pieralisi wrote:
> For legacy reasons, the __cpu_logical_map array is initialized to 0.
> On old pre-DT ARM platforms, smp_setup_processor_id() generates
> __cpu_logical_map entries at boot before the number of possible CPUs is
> set-up, with values that can be considered valid MPIDRs even if they are
> not present in the system booting; this implies that the __cpu_logical_map[]
> might end up containing MPIDR values that can be considered valid at logical
> indexes corresponding to CPUs that are not marked as possible.
> 
> To prevent issues with the current implementation, this patch defines an
> MPIDR_INVALID value, statically initializes the __cpu_logical_map[] array to it
> and allows DT parsing code to overwrite values in the __cpu_logical_map array
> that were erroneously set-up in smp_setup_processor_id().

What issues have you actually hit with this?

> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/cputype.h  |  2 ++
>  arch/arm/include/asm/smp_plat.h |  2 +-
>  arch/arm/kernel/devtree.c       | 10 ++++++----
>  arch/arm/kernel/setup.c         |  2 +-
>  4 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index 7652712..dba62cb 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -32,6 +32,8 @@
>  
>  #define MPIDR_HWID_BITMASK 0xFFFFFF
>  
> +#define MPIDR_INVALID (~MPIDR_HWID_BITMASK)
> +
>  #define MPIDR_LEVEL_BITS 8
>  #define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
>  
> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index aaa61b6..e789832 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -49,7 +49,7 @@ static inline int cache_ops_need_broadcast(void)
>  /*
>   * Logical CPU mapping.
>   */
> -extern int __cpu_logical_map[];
> +extern u32 __cpu_logical_map[];
>  #define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
>  /*
>   * Retrieve logical cpu index corresponding to a given MPIDR[23:0]
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index d2293c0..08f012e 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -79,12 +79,12 @@ void __init arm_dt_init_cpu_maps(void)
>  	 * read as 0.
>  	 */
>  	static u32 tmp_map[NR_CPUS] __initdata = {
> -				[0 ... NR_CPUS-1] = UINT_MAX };
> +				[0 ... NR_CPUS-1] = MPIDR_INVALID };
>  	struct device_node *cpu, *cpus;
>  	u32 i, j, cpuidx = 1;
>  	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
> -
>  	bool bootcpu_valid = false;
> +

Random whitespace change.

Will
