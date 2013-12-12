From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 12 Dec 2013 19:20:03 +0800
Subject: [PATCH 1/6] arm64: Add asm/cpu.h
In-Reply-To: <20131212103608.GA12106@e106331-lin.cambridge.arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <20131211141018.GC596@darko.cambridge.arm.com>
 <20131211142308.GY11468@sirena.org.uk>
 <20131211142705.GE596@darko.cambridge.arm.com> <52A95CB3.2030805@linaro.org>
 <20131212103608.GA12106@e106331-lin.cambridge.arm.com>
Message-ID: <52A99BE3.9050906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-12 18:36, Mark Rutland wrote:
> On Thu, Dec 12, 2013 at 06:50:27AM +0000, Hanjun Guo wrote:
[...]
>>  #endif
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index cb548f1..5c8e69c 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -18,3 +18,29 @@ void arch_fix_phys_package_id(int num, u32 slot)
>>  }
>>  EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);
>>
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +int __ref arch_register_cpu(int cpu)
>> +{
>> +       struct cpuinfo_arm *cpuinfo = &per_cpu(cpu_data, cpu);
>> +
>> +       /* BSP cann't be taken down on arm */
>> +       if (cpu)
>> +               cpuinfo->cpu.hotpluggable = 1;
> 
> _why_ does the ACPI standard prohibit hotplugging the boot CPU?

ACPI spec has not limitations to hotplug the boot CPU, it depends
on the arch.

> 
> In non-ACPI systems we can hotplug out the boot CPU (we can do so under
> KVM using PSCI).

If all the things (interrupts and etc) running on CPU0 can be migrated to
other CPUs when offline a CPU, it can be hotplugable in ACPI way too.

> 
> I note that the x86 arch_register_cpu allows CPU0 to be hotpluggable on
> Intel systems as long as there are no dependencies on CPU0 being
> active. Surely we can test for something more fine-grained rather than
> disallowing CPU0 hotplug outright?

Ok, will update it when I formally send this patch out.

> 
> How does this interact with the existing arm64 hotplug code?

Some other patches are needed for ACPI based CPU hotplug,will send
out when the ACPI core for ARM is ready, I will cc you and then
you will know what's going on :)

Thanks
Hanjun
