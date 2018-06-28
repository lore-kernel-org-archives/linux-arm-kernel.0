From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 28 Jun 2018 20:55:30 +0800
Subject: [PATCH] arm64: numa: rework ACPI NUMA initialization
In-Reply-To: <20180625130552.5636-1-lorenzo.pieralisi@arm.com>
References: <20180625130552.5636-1-lorenzo.pieralisi@arm.com>
Message-ID: <aeb3d665-4135-f6ea-7f65-13b08983673e@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/6/25 21:05, Lorenzo Pieralisi wrote:
> Current ACPI ARM64 NUMA initialization code in
> 
> acpi_numa_gicc_affinity_init()
> 
> carries out NUMA nodes creation and cpu<->node mappings at the same time
> in the arch backend so that a single SRAT walk is needed to parse both
> pieces of information.  This implies that the cpu<->node mappings must
> be stashed in an array (sized NR_CPUS) so that SMP code can later use
> the stashed values to avoid another SRAT table walk to set-up the early
> cpu<->node mappings.
> 
> If the kernel is configured with a NR_CPUS value less than the actual
> processor entries in the SRAT (and MADT), the logic in
> acpi_numa_gicc_affinity_init() is broken in that the cpu<->node mapping
> is only carried out (and stashed for future use) only for a number of
> SRAT entries up to NR_CPUS, which do not necessarily correspond to the
> possible cpus detected at SMP initialization in
> acpi_map_gic_cpu_interface() (ie MADT and SRAT processor entries order
> is not enforced), which leaves the kernel with broken cpu<->node
> mappings.
> 
> Furthermore, given the current ACPI NUMA code parsing logic in
> acpi_numa_gicc_affinity_init(), PXM domains for CPUs that are not parsed
> because they exceed NR_CPUS entries are not mapped to NUMA nodes (ie the
> PXM corresponding node is not created in the kernel) leaving the system
> with a broken NUMA topology.
> 
> Rework the ACPI ARM64 NUMA initialization process so that the NUMA
> nodes creation and cpu<->node mappings are decoupled. cpu<->node
> mappings are moved to SMP initialization code (where they are needed),
> at the cost of an extra SRAT walk so that ACPI NUMA mappings can be
> batched before being applied, fixing current parsing pitfalls.
> 
> Fixes: d8b47fca8c23 ("arm64, ACPI, NUMA: NUMA support based on SRAT and
> SLIT")
> Link: http://lkml.kernel.org/r/1527768879-88161-2-git-send-email-xiexiuqi at huawei.com
> Reported-by: Xie XiuQi <xiexiuqi@huawei.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Xie XiuQi <xiexiuqi@huawei.com>
> ---
>  arch/arm64/include/asm/acpi.h |  6 ++-
>  arch/arm64/kernel/acpi_numa.c | 88 ++++++++++++++++++++++++++-----------------
>  arch/arm64/kernel/smp.c       | 39 +++++++++++++------
>  3 files changed, 85 insertions(+), 48 deletions(-)

Looks good to me,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Tested on D05 with NR_CPUS=48 (with last NUMA node boot
without CPUs), the system works fine. If Xiuqi can test
this patch on D06 with memory-less node, that would be
more helpful.

Thanks
Hanjun
