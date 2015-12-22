From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 22 Dec 2015 20:34:42 +0800
Subject: [PATCH v2 3/4] arm64, acpi, numa: NUMA support based on SRAT and
 SLIT
In-Reply-To: <20151218162336.GA25024@red-moon>
References: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1447784733-10419-4-git-send-email-gkulkarni@caviumnetworks.com>
 <20151218162336.GA25024@red-moon>
Message-ID: <56794362.80303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

Sorry for the late reply, just busy with other work, please
see my comments below.

On 2015/12/19 0:23, Lorenzo Pieralisi wrote:
> On Tue, Nov 17, 2015 at 11:55:32PM +0530, Ganapatrao Kulkarni wrote:
>
> [...]
>
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index 7987763..555c4a5 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -42,6 +42,7 @@ arm64-obj-$(CONFIG_PCI)			+= pci.o
>>   arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
>>   arm64-obj-$(CONFIG_ACPI)		+= acpi.o
>>   arm64-obj-$(CONFIG_OF_NUMA)		+= of_numa.o
>> +arm64-obj-$(CONFIG_ACPI_NUMA)		+= acpi_numa.o
>
> Isn't it better to merge ACPI and DT support in one file (a bit like
> what we did for smp.c) to remove some of this iffdeffery ?

It's definitely a good idea, but I'm not sure what's the blockers
ahead, I will try to do that in next version.

>
>>
>>   obj-y					+= $(arm64-obj-y) vdso/
>>   obj-m					+= $(arm64-obj-m)
>> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
>> new file mode 100644
>> index 0000000..8aee205
>> --- /dev/null
>> +++ b/arch/arm64/kernel/acpi_numa.c
>> @@ -0,0 +1,215 @@
>> +/*
>> + * ACPI 5.1 based NUMA setup for ARM64
>> + * Lots of code was borrowed from arch/x86/mm/srat.c
>> + *
>> + * Copyright 2004 Andi Kleen, SuSE Labs.
>> + * Copyright (C) 2013-2014, Linaro Ltd.
>> + *		Author: Hanjun Guo <hanjun.guo@linaro.org>
>> + *
>> + * Reads the ACPI SRAT table to figure out what memory belongs to which CPUs.
>> + *
>> + * Called from acpi_numa_init while reading the SRAT and SLIT tables.
>> + * Assumes all memory regions belonging to a single proximity domain
>> + * are in one chunk. Holes between them will be included in the node.
>> + */
>> +
>> +#define pr_fmt(fmt) "ACPI: NUMA: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/bitmap.h>
>> +#include <linux/bootmem.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mm.h>
>> +#include <linux/memblock.h>
>> +#include <linux/mmzone.h>
>> +#include <linux/module.h>
>> +#include <linux/topology.h>
>> +
>> +#include <acpi/processor.h>
>> +#include <asm/numa.h>
>> +
>> +int acpi_numa __initdata;
>> +
>> +static __init int setup_node(int pxm)
>> +{
>> +	return acpi_map_pxm_to_node(pxm);
>> +}
>
> This function is not that useful given how it is used in the patch.

Agree, just use acpi_map_pxm_to_node() will be fine.

>
>> +
>> +static __init void bad_srat(void)
>> +{
>> +	pr_err("SRAT not used.\n");
>> +	acpi_numa = -1;
>> +}
>> +
>> +static __init inline int srat_disabled(void)
>> +{
>> +	return acpi_numa < 0;
>> +}
>> +
>> +/*
>> + * Callback for SLIT parsing.
>> + * It will get the distance information presented by SLIT
>> + * and init the distance matrix of numa nodes
>> + */
>> +void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
>> +{
>> +	int i, j;
>> +
>> +	for (i = 0; i < slit->locality_count; i++) {
>> +		const int from_node = pxm_to_node(i);
>> +
>> +		if (from_node == NUMA_NO_NODE)
>> +			continue;
>> +
>> +		for (j = 0; j < slit->locality_count; j++) {
>> +			const int to_node = pxm_to_node(j);
>> +
>> +			if (to_node == NUMA_NO_NODE)
>> +				continue;
>> +
>> +			pr_info("SLIT: Distance[%d][%d] = %d\n",
>> +					from_node, to_node,
>> +					slit->entry[
>> +					slit->locality_count * i + j]);
>> +			numa_set_distance(from_node, to_node,
>> +				slit->entry[slit->locality_count * i + j]);
>> +		}
>> +	}
>> +}
>
> This function is an x86 copy'n'paste. ia64 just requires this callback
> to save a slit table pointer (that can be moved to generic code and it is
> initdata anyway), so my question is, do we really need to duplicate it ?

Sure we need it, no matter DT or ACPI, we need to figure out the
NUMA node distance and set it properly. For IA64, the slit table
pointer is saved but it also used to setup the NUMA node distance
as you can see the code in acpi_numa_arch_fixup() in arch/ia64/kernel
/acpi.c, it just init it in different time slot.

>
>> +static int __init get_mpidr_in_madt(int acpi_id, u64 *mpidr)
>> +{
>
> Looks familiar. I guess you can't reuse the code in drivers/acpi
> (acpi_map_cpuid()) only because that implies permanent table mappings to be
> in place and you need to call this function before acpi_gbl_permanent_mmap
> is set ?

Hey, you are reading my mind :). Yes, as you said, it also will
lead to early memory remap leak, any suggestion?

>
>> +	unsigned long madt_end, entry;
>> +	struct acpi_table_madt *madt;
>> +	acpi_size tbl_size;
>> +
>> +	if (ACPI_FAILURE(acpi_get_table_with_size(ACPI_SIG_MADT, 0,
>> +			(struct acpi_table_header **)&madt, &tbl_size)))
>> +		return -ENODEV;
>> +
>> +	entry = (unsigned long)madt;
>> +	madt_end = entry + madt->header.length;
>> +
>> +	/* Parse all entries looking for a match. */
>> +	entry += sizeof(struct acpi_table_madt);
>> +	while (entry + sizeof(struct acpi_subtable_header) < madt_end) {
>> +		struct acpi_subtable_header *header =
>> +			(struct acpi_subtable_header *)entry;
>> +
>> +		if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
>> +			struct acpi_madt_generic_interrupt *gicc =
>> +				container_of(header,
>> +				struct acpi_madt_generic_interrupt, header);
>> +
>> +			if ((gicc->flags & ACPI_MADT_ENABLED) &&
>> +			    (gicc->uid == acpi_id)) {
>> +				*mpidr = gicc->arm_mpidr;
>> +				early_acpi_os_unmap_memory(madt, tbl_size);
>> +				return 0;
>> +			}
>> +		}
>> +		entry += header->length;
>> +	}
>> +
>> +	early_acpi_os_unmap_memory(madt, tbl_size);
>> +	return -ENODEV;
>> +}
>> +
>> +/* Callback for Proximity Domain -> ACPI processor UID mapping */
>> +void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
>> +{
>> +	int pxm, node;
>> +	u64 mpidr;
>> +	static int cpus_in_srat;
>> +
>> +	if (srat_disabled())
>> +		return;
>> +
>> +	if (pa->header.length < sizeof(struct acpi_srat_gicc_affinity)) {
>> +		bad_srat();
>> +		return;
>> +	}
>> +
>> +	if (!(pa->flags & ACPI_SRAT_GICC_ENABLED))
>> +		return;
>> +
>> +	if (cpus_in_srat >= NR_CPUS) {
>> +		pr_warn_once("SRAT: cpu_to_node_map[%ld] is too small, may not be able to use all cpus\n",
>> +			     NR_CPUS);
>> +		return;
>> +	}
>> +
>> +	pxm = pa->proximity_domain;
>> +	node = setup_node(pxm);
>> +
>> +	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
>> +		pr_err("SRAT: Too many proximity domains %d\n", pxm);
>> +		bad_srat();
>> +		return;
>> +	}
>> +
>> +	if (get_mpidr_in_madt(pa->acpi_processor_uid, &mpidr)) {
>> +		pr_warn("SRAT: PXM %d with ACPI ID %d has no valid MPIDR in MADT\n",
>> +			pxm, pa->acpi_processor_uid);
>> +		bad_srat();
>> +		return;
>> +	}
>> +
>> +	cpu_to_node_map[cpus_in_srat] = node;
>
> This looks wrong. cpus_in_srat is a logical index, but I do not see why
> it has to be sequential. You retrieve the mpidr for a given SRAT entry
> and with that value you should retrieve the cpu_logical index that
> corresponds to it (get_logical_index()), or maybe I am missing something
> from the ACPI specs that enforce a SRAT entries ordering, on which we
> should not rely upon anyway.

No, you are right, there is no enforce of ordering of CPU in SRAT, I
will update it, good catch.

>
>> +	node_set(node, numa_nodes_parsed);
>> +	acpi_numa = 1;
>
> What's the point if you are checking for < 0 in srat_disabled() ?

acpi_numa will be set as -1 in bad_srat(), if that happens, we
will not going to parse SRAT anymore, did I understand your
question?

>
>> +	cpus_in_srat++;
>> +	pr_info("SRAT: PXM %d -> MPIDR 0x%Lx -> Node %d cpu %d\n",
>> +			pxm, mpidr, node, cpus_in_srat);
>> +}
>> +
>> +/* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
>> +int __init acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>> +{
>> +	u64 start, end;
>> +	int node, pxm;
>> +
>> +	if (srat_disabled())
>> +		return -EINVAL;
>> +
>> +	if (ma->header.length != sizeof(struct acpi_srat_mem_affinity)) {
>> +		bad_srat();
>> +		return -EINVAL;
>> +	}
>> +
>> +	start = ma->base_address;
>> +	end = start + ma->length;
>> +	pxm = ma->proximity_domain;
>> +
>> +	node = setup_node(pxm);
>> +
>> +	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
>> +		pr_err("SRAT: Too many proximity domains.\n");
>> +		bad_srat();
>> +		return -EINVAL;
>> +	}
>> +
>> +	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
>> +		node, pxm,
>> +		(unsigned long long) start, (unsigned long long) end - 1);
>> +
>> +	if (numa_add_memblk(node, start, (end - start)) < 0) {
>> +		bad_srat();
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>
> I do not see again any major changes compared to x86, numa_add_memblk()
> has a different interface (size vs end) but apart from that it would
> be nice to avoid rewriting the same code time and again.

Let me see if I can rewrite it in next version.

>
>> +
>> +void __init acpi_numa_arch_fixup(void) { }
>
> Sigh. How many of these useless callbacks are we forced to define ?

Hmm, x86 also use a dummy function for it. I think we can fix it
in this way:

  - introduce a kconfig named ACPI_HAS_NUMA_ARCH_FIXUP

  - select it on IA64

  - introduce a stub function for x86 and ARM64 when
    !ACPI_HAS_NUMA_ARCH_FIXUP

  - remove the useless callbacks for x86 and ARM64

what do you think?

>
>> +
>> +int __init arm64_acpi_numa_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = acpi_numa_init();
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return srat_disabled() ? -EINVAL : 0;
>> +}
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index 209c7a9..c2950fc 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -17,6 +17,7 @@
>>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>    */
>>
>> +#include <linux/acpi.h>
>>   #include <linux/bootmem.h>
>>   #include <linux/ctype.h>
>>   #include <linux/init.h>
>> @@ -383,9 +384,13 @@ void __init arm64_numa_init(void)
>>   	int ret = -ENODEV;
>>
>>   #ifdef CONFIG_OF_NUMA
>> -	if (!numa_off)
>> +	if (!numa_off && acpi_disabled)
>>   		ret = numa_init(arm64_of_numa_init);
>>   #endif
>> +#ifdef CONFIG_ACPI_NUMA
>> +	if (!numa_off && !acpi_disabled)
>> +		ret = numa_init(arm64_acpi_numa_init);
>> +#endif
>
> See my comment above on DT/ACPI, this ifdeffery does not look great.

I will sync with Ganapatrao to see how to combine them together,
if any problem met, we will back to this discussion.

Thanks
Hanjun
