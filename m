From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 20 Jan 2014 22:00:46 +0800
Subject: [PATCH 10/20] ARM64 / ACPI: Enumerate possible/present CPU set
 and map logical cpu id to APIC id
In-Reply-To: <52D96A61.9080505@arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-11-git-send-email-hanjun.guo@linaro.org>
 <52D96A61.9080505@arm.com>
Message-ID: <52DD2C0E.10403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?01?18? 01:37, Sudeep Holla wrote:
> On 17/01/14 12:25, Hanjun Guo wrote:
>> When boot the kernel with MADT, the cpu possible and present sets should
>> be enumerated for later smp initialization.
>>
>> The logic cpu id maps to APIC id (GIC id) is also implemented, it is
>> needed for acpi processor drivers.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/acpi.h |    7 ++--
>>   drivers/acpi/plat/arm-core.c  |   83 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 87 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index c335c6d..7edd39e 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -76,9 +76,6 @@ static inline void acpi_disable_pci(void)
>>   /* FIXME: this function should be moved to topology.h when it's ready */
>>   void arch_fix_phys_package_id(int num, u32 slot);
>>   
>> -/* temperally define -1 to make acpi core compilerable */
>> -#define cpu_physical_id(cpu) -1
>> -
>>   /* Low-level suspend routine. */
>>   extern int (*acpi_suspend_lowlevel)(void);
>>   #define acpi_wakeup_address (0)
>> @@ -86,6 +83,10 @@ extern int (*acpi_suspend_lowlevel)(void);
>>   #define MAX_GIC_CPU_INTERFACE 256
>>   #define MAX_GIC_DISTRIBUTOR   1		/* should be the same as MAX_GIC_NR */
>>   
>> +/* map logic cpu id to physical GIC id */
>> +extern int arm_cpu_to_apicid[NR_CPUS];
>> +#define cpu_physical_id(cpu) arm_cpu_to_apicid[cpu]
>> +
> You refer arm_cpu_to_apicid as a mapping from logical cpu id to GIC id,
> then why is it assigned to cpu_physical_id. cpu_physical_id must be same as
> cpu_logical_map which is from logical cpu id to MPIDRs.
>
> [...]
>
>> @@ -321,6 +401,9 @@ int __init early_acpi_boot_init(void)
>>   	if (acpi_disabled)
>>   		return -ENODEV;
>>   
>> +	/* Get the boot CPU's GIC cpu interface id before MADT parsing */
>> +	boot_cpu_apic_id = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>> +
> Code contradicts your comment. You need GIC cpu interface ID(referred as GIC ID
> in the MADT), but you are assigning the MPIDR(physical CPU ID on ARM) to
> boot_cpu_apic_id. I think you are assuming GIC ID and MPIDR to be same which is
> wrong.
>
> With ACPI5.0, IIUC the only possible way to manage mapping from GIC CPU
> interface to MPIDR is to assume(in a way enforce on ARM) ACPI Processor UID in
> MADT and CPU Device definition match MPIDR.

yes, agree with you. I mixed up the GIC Id and UID, as you said, UID can be
MPIDR, and then use as hardware id to map to the logical id, it is not the
same as x86 and ia64, will update this patch.

Thanks
Hanjun
