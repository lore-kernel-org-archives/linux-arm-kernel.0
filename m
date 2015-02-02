From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Feb 2015 15:36:49 +0000
Subject: [PATCH 1/2] arm64: adding cpu lookup functionality
In-Reply-To: <1422658466-23984-2-git-send-email-mathieu.poirier@linaro.org>
References: <1422658466-23984-1-git-send-email-mathieu.poirier@linaro.org>
 <1422658466-23984-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20150202153649.GC21175@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 10:54:25PM +0000, mathieu.poirier at linaro.org wrote:
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Adding a lookup function allowing for quick and easy mapping
> between processor HWID (as found, for example) in DT specifications
> and the CPU index known to the kernel.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  arch/arm64/include/asm/smp_plat.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
> index 59e282311b58..8e4b011303b1 100644
> --- a/arch/arm64/include/asm/smp_plat.h
> +++ b/arch/arm64/include/asm/smp_plat.h
> @@ -19,6 +19,7 @@
>  #ifndef __ASM_SMP_PLAT_H
>  #define __ASM_SMP_PLAT_H
>  
> +#include <linux/cpumask.h>
>  #include <asm/types.h>
>  
>  struct mpidr_hash {
> @@ -40,4 +41,15 @@ static inline u32 mpidr_hash_size(void)
>  extern u64 __cpu_logical_map[NR_CPUS];
>  #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
>  
> +static inline int get_logical_index(u64 mpidr)
> +{
> +	int cpu;
> +
> +	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> +		if (cpu_logical_map(cpu) == mpidr)
> +			return cpu;
> +	return -EINVAL;
> +}

Are there some pending updates for of_coresight.c that aren't in
mainline yet? It looks like even with this the parsing would be broken
if /cpus/#address-cells is greater than 1 (as with juno.dts), and it'll
just assume CPU0 in that case.

It would be nicer if we instead had a CPU node to logical ID mapping
function in the core OF code. We already have the inverse with
of_get_cpu_node, so I assume the necessary infrastructure is already
there.

Mark.
