From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 01 Aug 2014 11:48:23 +0100
Subject: [PATCH 04/19] ARM64 / ACPI: Introduce arch_fix_phys_package_id()
 for cpu topology
In-Reply-To: <53DB352D.10507@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-5-git-send-email-hanjun.guo@linaro.org>
 <53D69BB3.8040106@arm.com> <53DB352D.10507@linaro.org>
Message-ID: <53DB7077.7080804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/08/14 07:35, Hanjun Guo wrote:
> On 2014-7-29 2:51, Sudeep Holla wrote:
>> On 24/07/14 14:00, Hanjun Guo wrote:
>>> arch_fix_phys_package_id() will be called in ACPI core to use
>>> the slot number provided by ACPI to update the physical package
>>> id, then we can get the right value in the "physical id" field
>>> of /proc/cpuinfo.
>>>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> ---
>>>    arch/arm64/include/asm/topology.h |    2 ++
>>>    arch/arm64/kernel/topology.c      |   14 ++++++++++++++
>>>    2 files changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/topology.h
>>> b/arch/arm64/include/asm/topology.h
>>> index 7ebcd31..2b216d4 100644
>>> --- a/arch/arm64/include/asm/topology.h
>>> +++ b/arch/arm64/include/asm/topology.h
>>> @@ -23,11 +23,13 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
>>>    void init_cpu_topology(void);
>>>    void store_cpu_topology(unsigned int cpuid);
>>>    const struct cpumask *cpu_coregroup_mask(int cpu);
>>> +void arch_fix_phys_package_id(int num, u32 slot);
>>>
>>>    #else
>>>
>>>    static inline void init_cpu_topology(void) { }
>>>    static inline void store_cpu_topology(unsigned int cpuid) { }
>>> +static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>>>
>>>    #endif
>>>
>>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>>> index 43514f9..c547885 100644
>>> --- a/arch/arm64/kernel/topology.c
>>> +++ b/arch/arm64/kernel/topology.c
>>> @@ -281,3 +281,17 @@ void __init init_cpu_topology(void)
>>>        if (parse_dt_topology())
>>>            reset_cpu_topology();
>>>    }
>>> +
>>> +/*
>>> + * Use the CPU slot number provided by ACPI to update the physical
>>> + * package id when cpuid_topo->cluster_id is not available, then we
>>> + * can get the right value in the "physical id" field of /proc/cpuinfo.
>>> + */
>>
>> We don't have "physical id" field in /proc/cpuinfo on ARM64.
>
> I'm just curious, if there are two or more CPU (SoC) chips and connected
> into one system, how to tell one SoC from another?
>

There was some discussion on ARM64 /proc/cpuinfo recently[1]. Even ARM
doesn't have this. IMO we might want to present complete MPIDR in future
if really needed.

Not sure, why we need this "physical id" field as these cpuid topology
is already visible via sysfs explicitly(we really don't need that again
elsewhere ?)

Regards,
Sudeep

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/264390.html
