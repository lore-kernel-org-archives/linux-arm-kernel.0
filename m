From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 12 Dec 2013 14:50:27 +0800
Subject: [PATCH 1/6] arm64: Add asm/cpu.h
In-Reply-To: <20131211142705.GE596@darko.cambridge.arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <20131211141018.GC596@darko.cambridge.arm.com>
 <20131211142308.GY11468@sirena.org.uk>
 <20131211142705.GE596@darko.cambridge.arm.com>
Message-ID: <52A95CB3.2030805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-11 22:27, Catalin Marinas wrote:
> On Wed, Dec 11, 2013 at 02:23:08PM +0000, Mark Brown wrote:
>> On Wed, Dec 11, 2013 at 02:10:19PM +0000, Catalin Marinas wrote:
>>> On Wed, Dec 11, 2013 at 01:13:21PM +0000, Mark Brown wrote:
>>
>>>> +struct cpuinfo_arm {
>>>> +	struct cpu	cpu;
>>>> +	u64		cpuid;
>>>> +#ifdef CONFIG_SMP
>>>> +	unsigned int	loops_per_jiffy;
>>>> +#endif
>>>> +};
>>
>>> How is this structure used? I haven't seen the ACPI code doing anything
>>> with struct cpu (though I haven't dug deep enough). Also loops_per_jiffy
>>> is useless, that's related to the delay loop based on the generic timer.
>>
>> Now I look again we can probably drop this for the toplogy work - it had
>> been pulled in as part of pulling things in from pre-v8 and the cpuid
>> was used in the code while I was working on it but isn't any more unless
>> I'm misreading the code.  
>>
>> I don't know what the ACPI guys are doing wtih it, I just saw they added
>> the same thing.
> 
> It looked to me that for ACPI and empty asm/cpu.h file would do for now.
> There are a couple of prototypes for CPU hotplug I think but haven't
> seen the structure used (not even the x86_cpu one).

In ACPI code, only struct cpu is used for ACPI based CPU hotplug, here
is the code will send to upstream when the ACPI core for ARM is ready.

---
 arch/arm64/include/asm/cpu.h |    5 +++++
 arch/arm64/kernel/topology.c |   26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index dbeb98d..5613e09 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -20,6 +20,11 @@ struct cpuinfo_arm {
 #endif
 };

+#ifdef CONFIG_HOTPLUG_CPU
+extern int arch_register_cpu(int cpu);
+extern void arch_unregister_cpu(int cpu);
+#endif
+
 DECLARE_PER_CPU(struct cpuinfo_arm, cpu_data);

 #endif
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index cb548f1..5c8e69c 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -18,3 +18,29 @@ void arch_fix_phys_package_id(int num, u32 slot)
 }
 EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);

+#ifdef CONFIG_HOTPLUG_CPU
+int __ref arch_register_cpu(int cpu)
+{
+       struct cpuinfo_arm *cpuinfo = &per_cpu(cpu_data, cpu);
+
+       /* BSP cann't be taken down on arm */
+       if (cpu)
+               cpuinfo->cpu.hotpluggable = 1;
+
+       return register_cpu(&cpuinfo->cpu, cpu);
+}
+EXPORT_SYMBOL(arch_register_cpu);
+
+void arch_unregister_cpu(int cpu)
+{
+       unregister_cpu(&per_cpu(cpu_data, cpu).cpu);
+}
+EXPORT_SYMBOL(arch_unregister_cpu);
+#else /* CONFIG_HOTPLUG_CPU */
+
+static int __init arch_register_cpu(int cpu)
+{
+       return register_cpu(&per_cpu(cpu_data, cpu).cpu, cpu);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
