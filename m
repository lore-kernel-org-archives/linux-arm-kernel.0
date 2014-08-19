From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 19 Aug 2014 15:36:46 +0800
Subject: [PATCH v2 06/18] ARM64 / ACPI: Parse MADT to map logical cpu
 to MPIDR and get cpu_possible/present_map
In-Reply-To: <20140818142728.GS20043@localhost>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-7-git-send-email-hanjun.guo@linaro.org>
 <20140818142728.GS20043@localhost>
Message-ID: <53F2FE8E.60307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-8-18 22:27, Catalin Marinas wrote:
> On Mon, Aug 04, 2014 at 04:28:13PM +0100, Hanjun Guo wrote:
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index 6e04868..e877967 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -64,6 +64,8 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>>  extern int (*acpi_suspend_lowlevel)(void);
>>  #define acpi_wakeup_address 0
>>  
>> +#define MAX_GIC_CPU_INTERFACE 65535
> 
> Does this need to be more than NR_CPUS?

Sometimes yes, CPU structure entries in MADT just like CPU nodes in
device tree, the number of them may more than NR_CPUS.

> 
>> +/**
>> + * acpi_register_gic_cpu_interface - register a gic cpu interface and
>> + * generates a logical cpu number
>> + * @mpidr: CPU's hardware id to register, MPIDR represented in MADT
>> + * @enabled: this cpu is enabled or not
>> + *
>> + * Returns the logical cpu number which maps to the gic cpu interface
>> + */
>> +static int acpi_register_gic_cpu_interface(u64 mpidr, u8 enabled)
>> +{
>> +	int cpu;
>> +
>> +	if (mpidr == INVALID_HWID) {
>> +		pr_info("Skip invalid cpu hardware ID\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	total_cpus++;
>> +	if (!enabled)
>> +		return -EINVAL;
>> +
>> +	if (enabled_cpus >=  NR_CPUS) {
>> +		pr_warn("NR_CPUS limit of %d reached, Processor %d/0x%llx ignored.\n",
>> +			NR_CPUS, total_cpus, mpidr);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* If it is the first CPU, no need to check duplicate MPIDRs */
>> +	if (!enabled_cpus)
>> +		goto skip_mpidr_check;
>> +
>> +	/*
>> +	 * Duplicate MPIDRs are a recipe for disaster. Scan
>> +	 * all initialized entries and check for
>> +	 * duplicates. If any is found just ignore the CPU.
>> +	 */
>> +	for_each_present_cpu(cpu) {
>> +		if (cpu_logical_map(cpu) == mpidr) {
>> +			pr_err("Firmware bug, duplicate CPU MPIDR: 0x%llx in MADT\n",
>> +			       mpidr);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +skip_mpidr_check:
>> +	enabled_cpus++;
>> +
>> +	/* allocate a logical cpu id for the new comer */
>> +	if (cpu_logical_map(0) == mpidr) {
>> +		/*
>> +		 * boot_cpu_init() already hold bit 0 in cpu_present_mask
>> +		 * for BSP, no need to allocate again.
>> +		 */
>> +		cpu = 0;
>> +	} else {
>> +		cpu = cpumask_next_zero(-1, cpu_present_mask);
>> +	}
>> +
>> +	/* map the logical cpu id to cpu MPIDR */
>> +	cpu_logical_map(cpu) = mpidr;
>> +
>> +	set_cpu_possible(cpu, true);
>> +	set_cpu_present(cpu, true);
>> +
>> +	return cpu;
>> +}
> 
> Why not only set the cpu possible here (with the additional mpidr
> validity checks changed to for_each_possible_cpu)...
> 
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 40f38f4..8f1d37c 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -36,6 +36,7 @@
>>  #include <linux/completion.h>
>>  #include <linux/of.h>
>>  #include <linux/irq_work.h>
>> +#include <linux/acpi.h>
>>  
>>  #include <asm/atomic.h>
>>  #include <asm/cacheflush.h>
>> @@ -458,7 +459,14 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>>  		if (err)
>>  			continue;
>>  
>> -		set_cpu_present(cpu, true);
>> +		/*
>> +		 * In ACPI mode, cpu_present_map was initialised when
>> +		 * MADT table was parsed which before this function
>> +		 * is called.
>> +		 */
>> +		if (acpi_disabled)
>> +			set_cpu_present(cpu, true);
>> +
>>  		max_cpus--;
> 
> ... and don't touch this at all.

the original intent was to support CPU hotplug, I will update the patch
as you suggested and introduce the change when CPU hotplug patch is upstreamed,
then it will make the patch less confusing.

Thanks
Hanjun
