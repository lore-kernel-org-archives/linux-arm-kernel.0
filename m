From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 2 Mar 2016 15:08:42 +0100
Subject: [PATCH v3 05/12] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
In-Reply-To: <1453541967-3744-6-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-6-git-send-email-guohanjun@huawei.com>
Message-ID: <56D6F3EA.4050904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/01/16 10:39, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> Introduce a new file to hold ACPI based NUMA information
> parsing from SRAT and SLIT.
>
> SRAT includes the CPU ACPI ID to Proximity Domain mappings
> and memory ranges to Proximity Domain mapping.
> SLIT has the information of inter node
> distances(relative number for access latency).
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> ---
>   arch/arm64/include/asm/acpi.h |   8 ++
>   arch/arm64/include/asm/numa.h |   3 +
>   arch/arm64/kernel/Makefile    |   1 +
>   arch/arm64/kernel/acpi_numa.c | 235 ++++++++++++++++++++++++++++++++++++++++++
>   arch/arm64/kernel/smp.c       |   3 +
>   arch/arm64/mm/numa.c          |   5 +-
>   6 files changed, 252 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm64/kernel/acpi_numa.c
>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index caafd63..6db9c6f 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -96,4 +96,12 @@ static inline const char *acpi_get_enable_method(int cpu)
>   pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
>   #endif
>
> +#ifdef CONFIG_ACPI_NUMA
> +int arm64_acpi_numa_init(void);
> +void acpi_numa_set_node_info(unsigned int cpu, u64 hwid);
> +#else
> +static inline int arm64_acpi_numa_init(void) { return -ENODEV; }
> +static inline void acpi_numa_set_node_info(unsigned int cpu, u64 hwid) { }
> +#endif /* CONFIG_ACPI_NUMA */
> +
>   #endif /*_ASM_ACPI_H*/
> diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> index 54deb38..1beb194 100644
> --- a/arch/arm64/include/asm/numa.h
> +++ b/arch/arm64/include/asm/numa.h
> @@ -6,6 +6,8 @@
>
>   #ifdef CONFIG_NUMA
>
> +#define NR_NODE_MEMBLKS		(MAX_NUMNODES * 2)
> +
>   /* currently, arm64 implements flat NUMA topology */
>   #define parent_node(node)	(node)
>
> @@ -43,6 +45,7 @@ struct device_node;
>   int __init arm64_of_numa_init(void);
>   void __init of_numa_set_node_info(unsigned int cpu, struct device_node *dn);
>   #else
> +static inline int arm64_of_numa_init(void) { return -ENODEV; }
>   static inline void of_numa_set_node_info(unsigned int cpu,
>   		struct device_node *dn) { }
>   #endif
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 7987763..555c4a5 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -42,6 +42,7 @@ arm64-obj-$(CONFIG_PCI)			+= pci.o
>   arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
>   arm64-obj-$(CONFIG_ACPI)		+= acpi.o
>   arm64-obj-$(CONFIG_OF_NUMA)		+= of_numa.o
> +arm64-obj-$(CONFIG_ACPI_NUMA)		+= acpi_numa.o
>
>   obj-y					+= $(arm64-obj-y) vdso/
>   obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> new file mode 100644
> index 0000000..f7f7533
> --- /dev/null
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -0,0 +1,235 @@
> +/*
> + * ACPI 5.1 based NUMA setup for ARM64
> + * Lots of code was borrowed from arch/x86/mm/srat.c
> + *
> + * Copyright 2004 Andi Kleen, SuSE Labs.
> + * Copyright (C) 2013-2016, Linaro Ltd.
> + *		Author: Hanjun Guo <hanjun.guo@linaro.org>
> + *
> + * Reads the ACPI SRAT table to figure out what memory belongs to which CPUs.
> + *
> + * Called from acpi_numa_init while reading the SRAT and SLIT tables.
> + * Assumes all memory regions belonging to a single proximity domain
> + * are in one chunk. Holes between them will be included in the node.
> + */
> +
> +#define pr_fmt(fmt) "ACPI: NUMA: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/bitmap.h>
> +#include <linux/bootmem.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/memblock.h>
> +#include <linux/mmzone.h>
> +#include <linux/module.h>
> +#include <linux/topology.h>
> +
> +#include <acpi/processor.h>
> +#include <asm/numa.h>
> +
> +int acpi_numa __initdata;
> +static int cpus_in_srat;
> +
> +struct __node_cpu_hwid {
> +	u32 node_id;    /* logical node containing this CPU */
> +	u64 cpu_hwid;   /* MPIDR for this CPU */
> +};
> +
> +static struct __node_cpu_hwid early_node_cpu_hwid[NR_CPUS] = {
> +[0 ... NR_CPUS - 1] = {NUMA_NO_NODE, PHYS_CPUID_INVALID} };
> +
> +static __init void bad_srat(void)
> +{
> +	pr_err("SRAT not used.\n");
> +	acpi_numa = -1;
> +}
> +
> +static __init inline int srat_disabled(void)
> +{
> +	return acpi_numa < 0;
> +}
> +
> +void __init acpi_numa_set_node_info(unsigned int cpu, u64 hwid)
> +{
> +	int nid = 0, i;
> +
> +	for (i = 0; i < cpus_in_srat; i++) {
> +		if (hwid == early_node_cpu_hwid[i].cpu_hwid) {
> +			nid = early_node_cpu_hwid[i].node_id;
> +			break;
> +		}
> +	}
> +
> +	cpu_to_node_map[cpu] = nid;
> +}
> +
> +/*
> + * Callback for SLIT parsing.
> + * It will get the distance information presented by SLIT
> + * and init the distance matrix of numa nodes
> + */
> +void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < slit->locality_count; i++) {
> +		const int from_node = pxm_to_node(i);
> +
> +		if (from_node == NUMA_NO_NODE)
> +			continue;
> +
> +		for (j = 0; j < slit->locality_count; j++) {
> +			const int to_node = pxm_to_node(j);
> +
> +			if (to_node == NUMA_NO_NODE)
> +				continue;
> +
> +			pr_debug("SLIT: Distance[%d][%d] = %d\n",
> +					from_node, to_node,
> +					slit->entry[
> +					slit->locality_count * i + j]);
> +			numa_set_distance(from_node, to_node,
> +				slit->entry[slit->locality_count * i + j]);
> +		}
> +	}
> +}
> +
> +static int __init get_mpidr_in_madt(int acpi_id, u64 *mpidr)
> +{
> +	unsigned long madt_end, entry;
> +	struct acpi_table_madt *madt;
> +	acpi_size tbl_size;
> +
> +	if (ACPI_FAILURE(acpi_get_table_with_size(ACPI_SIG_MADT, 0,
> +			(struct acpi_table_header **)&madt, &tbl_size)))
> +		return -ENODEV;
> +
> +	entry = (unsigned long)madt;
> +	madt_end = entry + madt->header.length;
> +
> +	/* Parse all entries looking for a match. */
> +	entry += sizeof(struct acpi_table_madt);
> +	while (entry + sizeof(struct acpi_subtable_header) < madt_end) {
> +		struct acpi_subtable_header *header =
> +			(struct acpi_subtable_header *)entry;
> +
> +		if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
> +			struct acpi_madt_generic_interrupt *gicc =
> +				container_of(header,
> +				struct acpi_madt_generic_interrupt, header);
> +
> +			if ((gicc->flags & ACPI_MADT_ENABLED) &&
> +			    (gicc->uid == acpi_id)) {
> +				*mpidr = gicc->arm_mpidr;
> +				early_acpi_os_unmap_memory(madt, tbl_size);
> +				return 0;
> +			}
> +		}
> +		entry += header->length;
> +	}
> +
> +	early_acpi_os_unmap_memory(madt, tbl_size);
> +	return -ENODEV;
> +}
> +
> +/* Callback for Proximity Domain -> ACPI processor UID mapping */
> +void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
> +{
> +	int pxm, node;
> +	u64 mpidr;
> +
> +	if (srat_disabled())
> +		return;
> +
> +	if (pa->header.length < sizeof(struct acpi_srat_gicc_affinity)) {
> +		bad_srat();
> +		return;
> +	}
> +
> +	if (!(pa->flags & ACPI_SRAT_GICC_ENABLED))
> +		return;
> +
> +	if (cpus_in_srat >= NR_CPUS) {
> +		pr_warn_once("SRAT: cpu_to_node_map[%d] is too small, may not be able to use all cpus\n",
> +			     NR_CPUS);
> +		return;
> +	}
> +
> +	pxm = pa->proximity_domain;
> +	node = acpi_map_pxm_to_node(pxm);
> +
> +	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
> +		pr_err("SRAT: Too many proximity domains %d\n", pxm);
> +		bad_srat();
> +		return;
> +	}
> +
> +	if (get_mpidr_in_madt(pa->acpi_processor_uid, &mpidr)) {
> +		pr_warn("SRAT: PXM %d with ACPI ID %d has no valid MPIDR in MADT\n",
> +			pxm, pa->acpi_processor_uid);
> +		bad_srat();
> +		return;
> +	}
> +
> +	early_node_cpu_hwid[cpus_in_srat].node_id = node;
> +	early_node_cpu_hwid[cpus_in_srat].cpu_hwid =  mpidr;
> +	node_set(node, numa_nodes_parsed);
> +	acpi_numa = 1;
> +	cpus_in_srat++;
> +	pr_info("SRAT: PXM %d -> MPIDR 0x%Lx -> Node %d cpu %d\n",
> +		pxm, mpidr, node, cpus_in_srat);
> +}
> +
> +/* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
> +int __init acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> +{
> +	u64 start, end;
> +	int node, pxm;
> +
> +	if (srat_disabled())
> +		return -EINVAL;
> +
> +	if (ma->header.length != sizeof(struct acpi_srat_mem_affinity)) {
> +		bad_srat();
> +		return -EINVAL;
> +	}
> +
> +	/* Ignore disabled entries */
> +	if (!(ma->flags & ACPI_SRAT_MEM_ENABLED))
> +		return -EINVAL;
> +
> +	start = ma->base_address;
> +	end = start + ma->length;
> +	pxm = ma->proximity_domain;
> +
> +	node = acpi_map_pxm_to_node(pxm);
> +
> +	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
> +		pr_err("SRAT: Too many proximity domains.\n");
> +		bad_srat();
> +		return -EINVAL;
> +	}
> +
> +	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
> +		node, pxm,
> +		(unsigned long long) start, (unsigned long long) end - 1);
> +
> +	if (numa_add_memblk(node, start, (end - start)) < 0) {
> +		bad_srat();
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int __init arm64_acpi_numa_init(void)
> +{
> +	int ret;
> +
> +	ret = acpi_numa_init();
> +	if (ret)
> +		return ret;
> +
> +	return srat_disabled() ? -EINVAL : 0;
> +}
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index a2a8c2d..112a892 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -447,6 +447,9 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>   	/* map the logical cpu id to cpu MPIDR */
>   	cpu_logical_map(cpu_count) = hwid;
>
> +	/* map logical cpu to node */
> +	acpi_numa_set_node_info(cpu_count, hwid);
> +
>   	cpu_count++;
>   }
>
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 9e8704b..e974995 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -17,6 +17,7 @@
>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>
> +#include <linux/acpi.h>
>   #include <linux/bootmem.h>
>   #include <linux/ctype.h>
>   #include <linux/init.h>
> @@ -385,10 +386,8 @@ void __init arm64_numa_init(void)
>   {
>   	int ret = -ENODEV;
>
> -#ifdef CONFIG_OF_NUMA
>   	if (!numa_off)
> -		ret = numa_init(arm64_of_numa_init);
> -#endif
> +		ret = numa_init(acpi_disabled ? arm64_of_numa_init : arm64_acpi_numa_init);

Header asm/acpi.h is included in linux/acpi.h but only if CONFIG_ACPI=y
arm64_acpi_numa_init is declared in asm/acpi.h, so if we don't use the 
ifdef CONFIG_* approach from Robert, we will need to include as/acpi.h 
implicitly here. Otherwise we get a compilation error if CONFIG_ACPI is 
not set.

Regards,
Matthias
