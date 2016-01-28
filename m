From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 28 Jan 2016 10:48:37 +0800
Subject: [PATCH v3 12/12] acpi, numa: reuse
 acpi_numa_memory_affinity_init()
In-Reply-To: <20160127141847.GR24726@rric.localdomain>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-13-git-send-email-guohanjun@huawei.com>
 <20160125102643.GF24726@rric.localdomain> <56A8606A.8080407@huawei.com>
 <20160127141847.GR24726@rric.localdomain>
Message-ID: <56A98185.4080202@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/27 22:18, Robert Richter wrote:
> On 27.01.16 14:15:06, Hanjun Guo wrote:
>> Hi Robert,
>>
>> On 2016/1/25 18:26, Robert Richter wrote:
>>> On 23.01.16 17:39:27, Hanjun Guo wrote:
>>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>>
>>>> After the cleanup for acpi_numa_memory_affinity_init(),
>>>> it can be used for architetures both x86 and arm64, since
>>>> CONFIG_MEMORY_HOTPLUG is not enabled for arm64, so no
>>>> worry about that.
>>>>
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> ---
>>>>  arch/arm64/kernel/acpi_numa.c | 42 -------------------------------
>>>>  arch/x86/mm/srat.c            | 54 ----------------------------------------
>>>>  drivers/acpi/numa.c           | 57 +++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 57 insertions(+), 96 deletions(-)
>>> This one reverts acpi_numa_memory_affinity_init() to the x86 version.
>>> I rather would prefer the arm64 version for the generic code. We could
>>> keep the x86 implementation until x86 maintainers agree to remove them
>>> and use the generic one (implemented in a separate patch).
>>>
>>> Doing so we can move acpi_numa_memory_affinity_init() from the
>>> beginning to generic code (used for arm64) and have this last patch to
>>> remove the x86 version.
>> I think the x86 version is the generic one, all the flags (ACPI_SRAT_MEM_HOT_PLUGGABLE and
>> etc) are defined in the ACPI spec, x86 just use all the flags because it support such features.
>> For ARM64, firmware should be careful and represent the true platform configuration to
>> OS, such as on ARM64, we can't set hotpluggable flag as the ARM64 arch don't support
>> memory hot-plug yet (also the firmware don't support it too), if firmware do things right,
>> it will be not worries for the kernel.
> But you are removing all arm64 from your first patches. Why do you
> introduce acpi_numa_memory_affinity_init() in the beginning to remove
> it in the end again? I esp. like the arm64 version because of its
> direct returns. So I still would like to see generic code for arm64
> from the beginning. Maybe have a copy of x86 initially and make
> modifications for arm64 to it, or move missing code (hotplug, etc.)
> from x86 to generic and remove x86 arch code with the last patch.

OK, so that's the logic and ordering of formatting the patch set, it's easy
to fix :)

I will introduce the generic code for acpi_numa_memory_affinity_init()
in drivers/acpi/numa.c and mark it as __weak from the beginning, and
move missing code from x86 to generic, then remove x86 one as you
suggested, is that OK?

Thanks
Hanjun
