From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 01 Aug 2014 14:35:25 +0800
Subject: [PATCH 04/19] ARM64 / ACPI: Introduce arch_fix_phys_package_id()
 for cpu topology
In-Reply-To: <53D69BB3.8040106@arm.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-5-git-send-email-hanjun.guo@linaro.org>
 <53D69BB3.8040106@arm.com>
Message-ID: <53DB352D.10507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-7-29 2:51, Sudeep Holla wrote:
> On 24/07/14 14:00, Hanjun Guo wrote:
>> arch_fix_phys_package_id() will be called in ACPI core to use
>> the slot number provided by ACPI to update the physical package
>> id, then we can get the right value in the "physical id" field
>> of /proc/cpuinfo.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/topology.h |    2 ++
>>   arch/arm64/kernel/topology.c      |   14 ++++++++++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/topology.h
>> b/arch/arm64/include/asm/topology.h
>> index 7ebcd31..2b216d4 100644
>> --- a/arch/arm64/include/asm/topology.h
>> +++ b/arch/arm64/include/asm/topology.h
>> @@ -23,11 +23,13 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
>>   void init_cpu_topology(void);
>>   void store_cpu_topology(unsigned int cpuid);
>>   const struct cpumask *cpu_coregroup_mask(int cpu);
>> +void arch_fix_phys_package_id(int num, u32 slot);
>>
>>   #else
>>
>>   static inline void init_cpu_topology(void) { }
>>   static inline void store_cpu_topology(unsigned int cpuid) { }
>> +static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>>
>>   #endif
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 43514f9..c547885 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -281,3 +281,17 @@ void __init init_cpu_topology(void)
>>       if (parse_dt_topology())
>>           reset_cpu_topology();
>>   }
>> +
>> +/*
>> + * Use the CPU slot number provided by ACPI to update the physical
>> + * package id when cpuid_topo->cluster_id is not available, then we
>> + * can get the right value in the "physical id" field of /proc/cpuinfo.
>> + */
> 
> We don't have "physical id" field in /proc/cpuinfo on ARM64.

I'm just curious, if there are two or more CPU (SoC) chips and connected
into one system, how to tell one SoC from another?

> 
>> +void arch_fix_phys_package_id(int num, u32 slot)
>> +{
>> +    struct cpu_topology *cpuid_topo = &cpu_topology[num];
>> +
>> +    if (cpuid_topo->cluster_id == -1)
>> +        cpuid_topo->cluster_id = slot;
>> +}
>> +EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);
>>
> 
> The ACPI core uses this function to set the package id as read from
> _SUN from the device. As per spec, _SUN is used by OSPM UI to identify
> slots for the user. Do we know how will this be used on ARM64 ?
> 
> If not clear at this time, better to define it or keep it empty. I see
> even x86 does nothing in that function.

I'm ok with it, will introduce a stub function for it and remove this patch.

Thanks
Hanjun
