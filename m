From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 10 Mar 2015 19:33:21 +0800
Subject: [PATCH v9 13/21] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <20150305184925.GF4932@quad.lixom.net>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-14-git-send-email-hanjun.guo@linaro.org>
 <20150305184925.GF4932@quad.lixom.net>
Message-ID: <54FED681.8030609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 2015?03?06? 02:49, Olof Johansson wrote:
> Hi,
>
> On Wed, Feb 25, 2015 at 04:39:53PM +0800, Hanjun Guo wrote:
>> MADT contains the information for MPIDR which is essential for
>> SMP initialization, parse the GIC cpu interface structures to
>> get the MPIDR value and map it to cpu_logical_map(), and add
>> enabled cpu with valid MPIDR into cpu_possible_map.
>>
>> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
>> Parking protocol, but the Parking protocol is only specified for
>> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
>> before some updates for the ACPI spec or the Parking protocol spec.
>>
>> Parking protocol patches for SMP boot will be sent to upstream when
>> the new version of Parking protocol is ready.
>>
>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Yijing Wang <wangyijing@huawei.com>
>> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>> Tested-by: Jon Masters <jcm@redhat.com>
>> Tested-by: Timur Tabi <timur@codeaurora.org>
>> Tested-by: Robert Richter <rrichter@cavium.com>
>> Acked-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> Some nits below. Up to you if you fix incrementally or respin, but I'd like to
> see them fixed for consistency's sake.
>
> Acked-by: Olof Johansson <olof@lixom.net>
>
>> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
>> index 780f82c..bf22650 100644
>> --- a/arch/arm64/include/asm/smp.h
>> +++ b/arch/arm64/include/asm/smp.h
>> @@ -39,9 +39,10 @@ extern void show_ipi_list(struct seq_file *p, int prec);
>>   extern void handle_IPI(int ipinr, struct pt_regs *regs);
>>
>>   /*
>> - * Setup the set of possible CPUs (via set_cpu_possible)
>> + * Discover the set of possible CPUs and determine their
>> + * SMP operations.
>>    */
>> -extern void smp_init_cpus(void);
>> +extern void of_smp_init_cpus(void);
>
> This is inconsistent naming, we use dt some places, of elsewhere.

Do you mean dt_smp_init_cpus() here?

>
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index bdcc9fc..0f35d87 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -25,6 +25,10 @@
>>   #include <linux/of_fdt.h>
>>   #include <linux/smp.h>
>>
>> +#include <asm/cputype.h>
>> +#include <asm/cpu_ops.h>
>> +#include <asm/smp_plat.h>
>> +
>>   int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
>>   int acpi_disabled = 1;
>>   EXPORT_SYMBOL(acpi_disabled);
>> @@ -32,6 +36,12 @@ EXPORT_SYMBOL(acpi_disabled);
>>   int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
>>   EXPORT_SYMBOL(acpi_pci_disabled);
>>
[...]
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 97fa7f3..b278311 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -393,13 +393,16 @@ void __init setup_arch(char **cmdline_p)
>>   	if (acpi_disabled) {
>>   		unflatten_device_tree();
>>   		psci_dt_init();
>> +		cpu_read_bootcpu_ops();
>> +#ifdef CONFIG_SMP
>> +		of_smp_init_cpus();
>> +#endif
>>   	} else {
>>   		psci_acpi_init();
>> +		acpi_init_cpus();
>>   	}
>>
>> -	cpu_read_bootcpu_ops();
>>   #ifdef CONFIG_SMP
>> -	smp_init_cpus();
>>   	smp_build_mpidr_hash();
>>   #endif
>
> I'd rather do without another ifdef above and provide a stub for that function,
> but again it might make sense to just keep a small smp_init_cpus() just as with
> the psci setup.
>
> The cpu_read_bootcpu_ops() should be pushed down to the dt implementation to
> keep the paths more common between acpi and dt.

the declaration of of_smp_init_cpus() is in asm/smp.h, unfortunately
the way asm/smp.h is handled is generally a mess, it only be compiled
in SMP build:

#ifndef CONFIG_SMP
# error "<asm/smp.h> included in non-SMP build"
#endif

so I think we need more cleanup before provide a stub function.

Thanks
Hanjun
