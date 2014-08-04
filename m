From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 04 Aug 2014 17:56:29 +0800
Subject: [PATCH 10/19] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
In-Reply-To: <53DA2110.8060000@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-11-git-send-email-hanjun.guo@linaro.org>
 <20140731065426.GA876@quad.lixom.net> <53DA2110.8060000@linaro.org>
Message-ID: <53DF58CD.9000704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 2014-7-31 18:57, Hanjun Guo wrote:
> On 2014-7-31 14:54, Olof Johansson wrote:
[...]
>>> +static void __init acpi_smp_init_cpus(void)
>>> +{
>>> +	int cpu;
>>> +
>>> +	for_each_possible_cpu(cpu) {
>>> +		if (cpu_acpi_read_ops(cpu) != 0)
>>> +			continue;
>>> +
>>> +		cpu_ops[cpu]->cpu_init(NULL, cpu);
>>> +	}
>>> +}
>>> +
>>> +void __init smp_init_cpus(void)
>>> +{
>>> +	if (acpi_disabled)
>>> +		of_smp_init_cpus();
>>> +	else
>>> +		acpi_smp_init_cpus();
>>
>> I'm liking these deeply split code paths less and less every time I see
>> them. :(
>>
>> I would prefer to set up shared state in separate functions, but keep the
>> control flow the same. Right now you're splitting it completely.
>>
>> I.e. split data setup between the two, but do the loop calling cpu_init()
>> the same way. (Yes, that will require you to refactor the DT code path
>> a bit too...)
> 
> OK, I will dive into the code and figure out if I can fix that as you
> suggested, thanks for your comments :)

After some investigation of the code, it seems that it is pretty hard
to do so, the major gap to do that is DT needs the device node of CPU
to init CPUs, but ACPI just needs the logical CPU number. In DT mode,
it needs to search the DT and get the CPU device node to get its enable
method, but in ACPI mode, it is a flag to indicate the CPU enable (boot)
method.

the code can be modified as below, but the logic is the same:

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 40f38f4..71a625b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -320,6 +320,17 @@ void __init smp_init_cpus(void)
        unsigned int i, cpu = 1;
        bool bootcpu_valid = false;

+       if (!acpi_disabled) {
+               for_each_possible_cpu(cpu) {
+                       if (cpu_read_ops(NULL, cpu) != 0)
+                               continue;
+
+                       cpu_ops[cpu]->cpu_init(NULL, cpu);
+               }
+
+               return;
+       }
+
        while ((dn = of_find_node_by_type(dn, "cpu"))) {
                const u32 *cell;
                u64 hwid;

Does it make sense to you?

Thanks
Hanjun
