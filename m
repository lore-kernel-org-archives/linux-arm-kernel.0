From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 27 Jan 2016 14:15:06 +0800
Subject: [PATCH v3 12/12] acpi, numa: reuse
 acpi_numa_memory_affinity_init()
In-Reply-To: <20160125102643.GF24726@rric.localdomain>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-13-git-send-email-guohanjun@huawei.com>
 <20160125102643.GF24726@rric.localdomain>
Message-ID: <56A8606A.8080407@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 2016/1/25 18:26, Robert Richter wrote:
> On 23.01.16 17:39:27, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> After the cleanup for acpi_numa_memory_affinity_init(),
>> it can be used for architetures both x86 and arm64, since
>> CONFIG_MEMORY_HOTPLUG is not enabled for arm64, so no
>> worry about that.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/kernel/acpi_numa.c | 42 -------------------------------
>>  arch/x86/mm/srat.c            | 54 ----------------------------------------
>>  drivers/acpi/numa.c           | 57 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 57 insertions(+), 96 deletions(-)
> This one reverts acpi_numa_memory_affinity_init() to the x86 version.
> I rather would prefer the arm64 version for the generic code. We could
> keep the x86 implementation until x86 maintainers agree to remove them
> and use the generic one (implemented in a separate patch).
>
> Doing so we can move acpi_numa_memory_affinity_init() from the
> beginning to generic code (used for arm64) and have this last patch to
> remove the x86 version.

I think the x86 version is the generic one, all the flags (ACPI_SRAT_MEM_HOT_PLUGGABLE and
etc) are defined in the ACPI spec, x86 just use all the flags because it support such features.
For ARM64, firmware should be careful and represent the true platform configuration to
OS, such as on ARM64, we can't set hotpluggable flag as the ARM64 arch don't support
memory hot-plug yet (also the firmware don't support it too), if firmware do things right,
it will be not worries for the kernel.

Thanks
Hanjun
