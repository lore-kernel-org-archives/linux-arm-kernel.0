From: john.garry@huawei.com (John Garry)
Date: Wed, 4 Jul 2018 12:23:08 +0100
Subject: [PATCH] arm64: numa: rework ACPI NUMA initialization
In-Reply-To: <aeb3d665-4135-f6ea-7f65-13b08983673e@huawei.com>
References: <20180625130552.5636-1-lorenzo.pieralisi@arm.com>
 <aeb3d665-4135-f6ea-7f65-13b08983673e@huawei.com>
Message-ID: <e8ddb2a4-ead5-e0b5-3078-c7c0fc4ed7b3@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/06/2018 13:55, Hanjun Guo wrote:
> On 2018/6/25 21:05, Lorenzo Pieralisi wrote:
>> Current ACPI ARM64 NUMA initialization code in
>>
>> acpi_numa_gicc_affinity_init()
>>
>> carries out NUMA nodes creation and cpu<->node mappings at the same time
>> in the arch backend so that a single SRAT walk is needed to parse both
>> pieces of information.  This implies that the cpu<->node mappings must
>> be stashed in an array (sized NR_CPUS) so that SMP code can later use
>> the stashed values to avoid another SRAT table walk to set-up the early
>> cpu<->node mappings.
>>
>> If the kernel is configured with a NR_CPUS value less than the actual
>> processor entries in the SRAT (and MADT), the logic in
>> acpi_numa_gicc_affinity_init() is broken in that the cpu<->node mapping
>> is only carried out (and stashed for future use) only for a number of
>> SRAT entries up to NR_CPUS, which do not necessarily correspond to the
>> possible cpus detected at SMP initialization in
>> acpi_map_gic_cpu_interface() (ie MADT and SRAT processor entries order
>> is not enforced), which leaves the kernel with broken cpu<->node
>> mappings.
>>
>> Furthermore, given the current ACPI NUMA code parsing logic in
>> acpi_numa_gicc_affinity_init(), PXM domains for CPUs that are not parsed
>> because they exceed NR_CPUS entries are not mapped to NUMA nodes (ie the
>> PXM corresponding node is not created in the kernel) leaving the system
>> with a broken NUMA topology.
>>
>> Rework the ACPI ARM64 NUMA initialization process so that the NUMA
>> nodes creation and cpu<->node mappings are decoupled. cpu<->node
>> mappings are moved to SMP initialization code (where they are needed),
>> at the cost of an extra SRAT walk so that ACPI NUMA mappings can be
>> batched before being applied, fixing current parsing pitfalls.
>>
>> Fixes: d8b47fca8c23 ("arm64, ACPI, NUMA: NUMA support based on SRAT and
>> SLIT")
>> Link: http://lkml.kernel.org/r/1527768879-88161-2-git-send-email-xiexiuqi at huawei.com
>> Reported-by: Xie XiuQi <xiexiuqi@huawei.com>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Hanjun Guo <guohanjun@huawei.com>
>> Cc: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>> Cc: Jeremy Linton <jeremy.linton@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Xie XiuQi <xiexiuqi@huawei.com>
>> ---
>>  arch/arm64/include/asm/acpi.h |  6 ++-
>>  arch/arm64/kernel/acpi_numa.c | 88 ++++++++++++++++++++++++++-----------------
>>  arch/arm64/kernel/smp.c       | 39 +++++++++++++------
>>  3 files changed, 85 insertions(+), 48 deletions(-)
>
> Looks good to me,
>
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
>
> Tested on D05 with NR_CPUS=48 (with last NUMA node boot
> without CPUs), the system works fine. If Xiuqi can test
> this patch on D06 with memory-less node, that would be
> more helpful.
>

Hi Lorenzo,

Thanks for this. I have noticed we now miss this log, which I think was 
somewhat useful:
ACPI: NUMA: SRAT: cpu_to_node_map[5] is too small, may not be able to 
use all cpus

(I tested arbitary 5 CPUs)

For example, the default ARM64 defconfig specifies NR_CPUs default at 
64, while some boards now have > 64 CPUs, so this info would be missed 
with a vanilla kernel, right?

Also, please note that we now have this log:
[    0.390565] smp: Brought up 4 nodes, 5 CPUs

while before we had:
[    0.390561] smp: Brought up 1 node, 5 CPUs

Maybe my understanding is wrong, but I find this misleading as only 1 
node was "Brought up".

But the patch fixes our crash on D06:
Tested-by: John Garry <john.garry@huawei.com>

Thanks very much,
John

> Thanks
> Hanjun
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>
