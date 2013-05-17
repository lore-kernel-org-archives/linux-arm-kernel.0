From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 17 May 2013 12:22:33 -0400 (EDT)
Subject: [RFC PATCH v4 18/18] ARM: DT: kernel: DT cpus/cpu node bindings
 update
In-Reply-To: <1368804061-4421-19-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1368804061-4421-19-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.03.1305171222020.31158@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 May 2013, Lorenzo Pieralisi wrote:

> DT cpu map parsing code must be made compliant with the latest cpus/cpu
> nodes bindings updates, hence this patch updates the arm_dt_init_cpu_maps()
> function with checks and additional parsing rules.
> 
> Uniprocessor systems predating v7 do not parse the cpus node at all
> since the reg property is meaningless on those systems.
> 
> Device trees for 64-bit systems can be taken as device tree input also
> for 64-bit CPUs running in 32-bit mode. The code checks that the reg entries
> are zeroed as required in the respective fields and detects automatically
> the cpus node #address-cells value so that device tree written for
> 64-bit ARM platforms (that can have cpus node #address-cells == 2) can still
> be taken as input. The correct device tree entries are to be set up by the
> boot loader, kernel code just checks that device tree entries in the cpus
> node are as expected for a 32-bit CPU (reg[63:24] == 0).
> 
> cpu node entries with invalid reg property or containing duplicates are
> ignored and the device tree parsing is not stopped anymore when such
> entries are encountered, the device tree cpu node entry is just skipped.
> 
> A device tree with cpu nodes missing the boot CPU MPIDR is considered
> an error and the kernel flags this up as such to trigger firmware updates.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/kernel/devtree.c | 146 ++++++++++++++++++++++++++++------------------
>  1 file changed, 88 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 0905502..80d6cf24 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -23,6 +23,7 @@
>  #include <asm/setup.h>
>  #include <asm/page.h>
>  #include <asm/smp_plat.h>
> +#include <asm/system_info.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
>  
> @@ -72,100 +73,129 @@ void __init arm_dt_memblock_reserve(void)
>   */
>  void __init arm_dt_init_cpu_maps(void)
>  {
> -	/*
> -	 * Temp logical map is initialized with UINT_MAX values that are
> -	 * considered invalid logical map entries since the logical map must
> -	 * contain a list of MPIDR[23:0] values where MPIDR[31:24] must
> -	 * read as 0.
> -	 */
>  	struct device_node *cpu, *cpus;
> -	u32 i, j, cpuidx = 1;
> +	u32 i, ac, cpuidx = 1;
> +	int len;
>  	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
>  
> -	u32 tmp_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
>  	bool bootcpu_valid = false;
>  	cpus = of_find_node_by_path("/cpus");
>  
> -	if (!cpus)
> +	if (!cpus || ((cpu_architecture() < CPU_ARCH_ARMv7) && !is_smp()))
>  		return;
>  
> +	if (of_property_read_u32(cpus, "#address-cells", &ac)) {
> +		pr_warn("%s invalid #address-cells\n", cpus->full_name);
> +		ac = of_n_addr_cells(cpus);
> +	}
> +	/*
> +	 * The boot CPU knows its MPIDR and initialize it
> +	 * to allow DT boot CPU detection.
> +	 */
> +	cpu_logical_map(0) = mpidr;
> +
>  	for_each_child_of_node(cpus, cpu) {
> -		u32 hwid;
> +		u64 hwid64;
> +		u32 hwid32;
> +		const __be32 *prop;
>  
>  		if (of_node_cmp(cpu->type, "cpu"))
>  			continue;
>  
>  		pr_debug(" * %s...\n", cpu->full_name);
>  		/*
> -		 * A device tree containing CPU nodes with missing "reg"
> -		 * properties is considered invalid to build the
> -		 * cpu_logical_map.
> +		 * A CPU node with missing or wrong "reg" property is
> +		 * considered invalid to build a cpu_logical_map entry.
>  		 */
> -		if (of_property_read_u32(cpu, "reg", &hwid)) {
> -			pr_debug(" * %s missing reg property\n",
> -				     cpu->full_name);
> -			return;
> +		prop = of_get_property(cpu, "reg", &len);
> +		if (!prop || len < (ac * sizeof(*prop))) {
> +			pr_warn(" * %s node missing/wrong reg property, skipped\n",
> +				cpu->full_name);
> +				goto next;
>  		}
>  
>  		/*
> -		 * 8 MSBs must be set to 0 in the DT since the reg property
> -		 * defines the MPIDR[23:0].
> +		 * Always read reg as u64 value.
> +		 * For dts with #address-cells == 1 hwid64[63:32]
> +		 * will be set to 0 by of_read_number.
> +		 * Toss away the top 32 bits and store value in hwid32.
>  		 */
> -		if (hwid & ~MPIDR_HWID_BITMASK)
> -			return;
> -
> +		hwid32 = hwid64 = of_read_number(prop, ac);
> +		/*
> +		 * hwid64[63:24] must be always be 0 since the reg
> +		 * property defines the MPIDR[23:0] bits regardless
> +		 * of the cpus node #address-cells value.
> +		 */
> +		if (hwid64 & ~MPIDR_HWID_BITMASK) {
> +			pr_warn(" * %s node reg[63:24] must be 0 on 32-bit dts, got %#016llx, skipped\n",
> +				cpu->full_name, hwid64);
> +			goto next;
> +		}
>  		/*
>  		 * Duplicate MPIDRs are a recipe for disaster.
>  		 * Scan all initialized entries and check for
> -		 * duplicates. If any is found just bail out.
> -		 * temp values were initialized to UINT_MAX
> -		 * to avoid matching valid MPIDR[23:0] values.
> +		 * duplicates. If any is found just ignore the CPU.
> +		 * Boot CPU at logical index 0 is not checked to
> +		 * allow self contained boot CPU detection logic.
>  		 */
> -		for (j = 0; j < cpuidx; j++)
> -			if (WARN(tmp_map[j] == hwid, "Duplicate /cpu reg "
> -						     "properties in the DT\n"))
> -				return;
> +		for (i = 1; i < cpuidx; i++)
> +			if (cpu_logical_map(i) == hwid32) {
> +				pr_warn(" * %s node duplicate cpu reg property, skipped\n",
> +					cpu->full_name);
> +				goto next;
> +			}
>  
>  		/*
> -		 * Build a stashed array of MPIDR values. Numbering scheme
> -		 * requires that if detected the boot CPU must be assigned
> -		 * logical id 0. Other CPUs get sequential indexes starting
> -		 * from 1. If a CPU node with a reg property matching the
> -		 * boot CPU MPIDR is detected, this is recorded so that the
> -		 * logical map built from DT is validated and can be used
> -		 * to override the map created in smp_setup_processor_id().
> +		 * If a CPU node with a reg property matching the
> +		 * cpu_logical_map(0) is detected, this is recorded so
> +		 * that the bootcpu_valid condition can be checked when
> +		 * DT scanning is completed. Duplicate boot cpu entries
> +		 * are flagged up if detected.
>  		 */
> -		if (hwid == mpidr) {
> -			i = 0;
> -			bootcpu_valid = true;
> -		} else {
> -			i = cpuidx++;
> +		if (hwid32 == cpu_logical_map(0)) {
> +			if (bootcpu_valid) {
> +				pr_warn(" * %s node duplicate boot cpu reg property, skipped\n",
> +					cpu->full_name);
> +			} else {
> +				bootcpu_valid = true;
> +			}
> +			goto next;
>  		}
> +		/*
> +		 * Build cpu_logical_map array. Numbering scheme
> +		 * requires that boot CPU is assigned logical id 0.
> +		 * Other CPUs get sequential indexes starting from 1.
> +		 */
> +		i = cpuidx++;
>  
> -		if (WARN(cpuidx > nr_cpu_ids, "DT /cpu %u nodes greater than "
> -					       "max cores %u, capping them\n",
> -					       cpuidx, nr_cpu_ids)) {
> +		if (cpuidx > nr_cpu_ids) {
> +			pr_warn_once("DT cpu %u nodes greater than max cores %u, capping them\n",
> +				cpuidx, nr_cpu_ids);
>  			cpuidx = nr_cpu_ids;
> -			break;
> +			goto next;
>  		}
>  
> -		tmp_map[i] = hwid;
> +		cpu_logical_map(i) = hwid32;
> +		set_cpu_possible(i, true);
> +		pr_debug("cpu_logical_map(%u) 0x%x\n", i, cpu_logical_map(i));
> +next:	;
>  	}
> -
> -	if (WARN(!bootcpu_valid, "DT missing boot CPU MPIDR[23:0], "
> -				 "fall back to default cpu_logical_map\n"))
> -		return;
> +	/*
> +	 * A DT missing the boot CPU MPIDR is a really bad omen
> +	 * Flag it up as such.
> +	 */
> +	if (!bootcpu_valid)
> +		pr_warn("DT missing boot cpu node\n");
>  
>  	/*
> -	 * Since the boot CPU node contains proper data, and all nodes have
> -	 * a reg property, the DT CPU list can be considered valid and the
> -	 * logical map created in smp_setup_processor_id() can be overridden
> +	 * Since the DT might contain fewer entries than NR_CPUS,
> +	 * cpu_logical_map entries initialized in smp_setup_processor_id()
> +	 * but not found in the DT must be overriden with MPIDR_INVALID
> +	 * values to make sure the cpu_logical_map does not contain stale
> +	 * MPIDR values.
>  	 */
> -	for (i = 0; i < cpuidx; i++) {
> -		set_cpu_possible(i, true);
> -		cpu_logical_map(i) = tmp_map[i];
> -		pr_debug("cpu logical map 0x%x\n", cpu_logical_map(i));
> -	}
> +	for (i = cpuidx; i < nr_cpu_ids; i++)
> +		cpu_logical_map(i) = MPIDR_INVALID;
>  }
>  
>  /**
> -- 
> 1.8.2.2
> 
> 
