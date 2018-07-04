From: john.garry@huawei.com (John Garry)
Date: Wed, 4 Jul 2018 15:17:39 +0100
Subject: [PATCH] arm64: numa: rework ACPI NUMA initialization
In-Reply-To: <20180704132113.GA12592@red-moon>
References: <20180625130552.5636-1-lorenzo.pieralisi@arm.com>
 <aeb3d665-4135-f6ea-7f65-13b08983673e@huawei.com>
 <e8ddb2a4-ead5-e0b5-3078-c7c0fc4ed7b3@huawei.com>
 <20180704132113.GA12592@red-moon>
Message-ID: <122e2017-39d1-5477-5858-33acad6ab41d@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2018 14:21, Lorenzo Pieralisi wrote:
> [+Michal]
>
> On Wed, Jul 04, 2018 at 12:23:08PM +0100, John Garry wrote:
>> On 28/06/2018 13:55, Hanjun Guo wrote:
>>> On 2018/6/25 21:05, Lorenzo Pieralisi wrote:
>>>> Current ACPI ARM64 NUMA initialization code in
>>>>
>>>> acpi_numa_gicc_affinity_init()
>>>>
>>>> carries out NUMA nodes creation and cpu<->node mappings at the same time
>>>> in the arch backend so that a single SRAT walk is needed to parse both
>>>> pieces of information.  This implies that the cpu<->node mappings must
>>>> be stashed in an array (sized NR_CPUS) so that SMP code can later use
>>>> the stashed values to avoid another SRAT table walk to set-up the early
>>>> cpu<->node mappings.
>>>>
>>>> If the kernel is configured with a NR_CPUS value less than the actual
>>>> processor entries in the SRAT (and MADT), the logic in
>>>> acpi_numa_gicc_affinity_init() is broken in that the cpu<->node mapping
>>>> is only carried out (and stashed for future use) only for a number of
>>>> SRAT entries up to NR_CPUS, which do not necessarily correspond to the
>>>> possible cpus detected at SMP initialization in
>>>> acpi_map_gic_cpu_interface() (ie MADT and SRAT processor entries order
>>>> is not enforced), which leaves the kernel with broken cpu<->node
>>>> mappings.
>>>>
>>>> Furthermore, given the current ACPI NUMA code parsing logic in
>>>> acpi_numa_gicc_affinity_init(), PXM domains for CPUs that are not parsed
>>>> because they exceed NR_CPUS entries are not mapped to NUMA nodes (ie the
>>>> PXM corresponding node is not created in the kernel) leaving the system
>>>> with a broken NUMA topology.
>>>>
>>>> Rework the ACPI ARM64 NUMA initialization process so that the NUMA
>>>> nodes creation and cpu<->node mappings are decoupled. cpu<->node
>>>> mappings are moved to SMP initialization code (where they are needed),
>>>> at the cost of an extra SRAT walk so that ACPI NUMA mappings can be
>>>> batched before being applied, fixing current parsing pitfalls.
>>>>
>>>> Fixes: d8b47fca8c23 ("arm64, ACPI, NUMA: NUMA support based on SRAT and
>>>> SLIT")
>>>> Link: http://lkml.kernel.org/r/1527768879-88161-2-git-send-email-xiexiuqi at huawei.com
>>>> Reported-by: Xie XiuQi <xiexiuqi@huawei.com>
>>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Cc: Punit Agrawal <punit.agrawal@arm.com>
>>>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Cc: Hanjun Guo <guohanjun@huawei.com>
>>>> Cc: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>>>> Cc: Jeremy Linton <jeremy.linton@arm.com>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Xie XiuQi <xiexiuqi@huawei.com>
>>>> ---
>>>> arch/arm64/include/asm/acpi.h |  6 ++-
>>>> arch/arm64/kernel/acpi_numa.c | 88 ++++++++++++++++++++++++++-----------------
>>>> arch/arm64/kernel/smp.c       | 39 +++++++++++++------
>>>> 3 files changed, 85 insertions(+), 48 deletions(-)
>>>
>>> Looks good to me,
>>>
>>> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>
>>> Tested on D05 with NR_CPUS=48 (with last NUMA node boot
>>> without CPUs), the system works fine. If Xiuqi can test
>>> this patch on D06 with memory-less node, that would be
>>> more helpful.
>>>
>>
>> Hi Lorenzo,
>>
>> Thanks for this. I have noticed we now miss this log, which I think
>> was somewhat useful:
>> ACPI: NUMA: SRAT: cpu_to_node_map[5] is too small, may not be able
>> to use all cpus
>>
>> (I tested arbitary 5 CPUs)
>>
>> For example, the default ARM64 defconfig specifies NR_CPUs default
>> at 64, while some boards now have > 64 CPUs, so this info would be
>> missed with a vanilla kernel, right?
>

Hi Lorenzo,

> I did that on purpose since the aim of this patch is to remove
> that restriction, we should not be limited by the NR_CPUS when
> we parse the SRAT, that's what this patch does.

OK, understood. But I still do think that it would be useful for the 
user to know that the kernel does not support the number of CPUs in the 
system, even if this parsing is not the right place to detect/report.

>
>> Also, please note that we now have this log:
>> [    0.390565] smp: Brought up 4 nodes, 5 CPUs
>>
>> while before we had:
>> [    0.390561] smp: Brought up 1 node, 5 CPUs
>>
>> Maybe my understanding is wrong, but I find this misleading as only
>> 1 node was "Brought up".
>
> Well, that's exactly where the problem lies. This patch allows the
> kernel to inizialize NUMA nodes associated with CPUs that are not
> "brought up" with the current kernel owing to the NR_CPUS restrictions.
>
> So I think this patch still does the right thing. I reworked
> the code mechanically since it looked wrong to me but I have
> to confess I do not understand the NUMA internals in-depth either.
>
> AFAICS the original problem was that, by making the NUMA parsing
> dependent on the NR_CPUS we were not "bringing online" NUMA nodes
> that are associated with CPUs and this caused memory allocation
> failures. If this patch fixes the problem that means that we
> actually "bring up" the required NUMA nodes (and create
> zonelist for them) correctly. So the update smp: log above should
> be right.
>
> I CC'ed Michal since he knows core NUMA internals much better than I do,
> thoughts appreciated, thanks.
>

For reference, here's the new log snippet:
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x2080000000-0x23ffffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x23fff6f840-0x23fff70fff]
[    0.000000] NUMA: Initmem setup node 1 [<memory-less node>]
[    0.000000] NUMA: NODE_DATA [mem 0x23fff6e080-0x23fff6f83f]
[    0.000000] NUMA: NODE_DATA(1) on node 0
[    0.000000] NUMA: Initmem setup node 2 [<memory-less node>]
[    0.000000] NUMA: NODE_DATA [mem 0x23fff6c8c0-0x23fff6e07f]
[    0.000000] NUMA: NODE_DATA(2) on node 0
[    0.000000] NUMA: Initmem setup node 3 [<memory-less node>]
[    0.000000] NUMA: NODE_DATA [mem 0x23fff6b100-0x23fff6c8bf]
[    0.000000] NUMA: NODE_DATA(3) on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000023ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003942ffff]
[    0.000000]   node   0: [mem 0x0000000039430000-0x000000003956ffff]
[    0.000000]   node   0: [mem 0x0000000039570000-0x000000003963ffff]
[    0.000000]   node   0: [mem 0x0000000039640000-0x00000000396fffff]
[    0.000000]   node   0: [mem 0x0000000039700000-0x000000003971ffff]
[    0.000000]   node   0: [mem 0x0000000039720000-0x0000000039b6ffff]
[    0.000000]   node   0: [mem 0x0000000039b70000-0x000000003eb5ffff]
[    0.000000]   node   0: [mem 0x000000003eb60000-0x000000003eb8ffff]
[    0.000000]   node   0: [mem 0x000000003eb90000-0x000000003fbfffff]
[    0.000000]   node   0: [mem 0x0000002080000000-0x00000023ffffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000000000-0x00000023ffffffff]
[    0.000000] Could not find start_pfn for node 1
[    0.000000] Initmem setup node 1 [mem 
0x0000000000000000-0x0000000000000000]
[    0.000000] Could not find start_pfn for node 2
[    0.000000] Initmem setup node 2 [mem 
0x0000000000000000-0x0000000000000000]
[    0.000000] Could not find start_pfn for node 3
[    0.000000] Initmem setup node 3 [mem 
0x0000000000000000-0x0000000000000000]
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30001 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30002 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30003 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30100 -> Node 0


Thanks,
John

 > Lorenzo
 >
>> But the patch fixes our crash on D06:
>> Tested-by: John Garry <john.garry@huawei.com>
>>
>> Thanks very much,
>> John
>>
>>> Thanks
>>> Hanjun
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> .
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>
