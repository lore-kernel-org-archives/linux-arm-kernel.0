From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 5 Mar 2015 15:44:28 +0800
Subject: [PATCH v9 02/21] ACPI / processor: Introduce phys_cpuid_t for
 CPU hardware ID
In-Reply-To: <1484357.vjmmcyQq4z@vostro.rjw.lan>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-3-git-send-email-hanjun.guo@linaro.org>
 <1484357.vjmmcyQq4z@vostro.rjw.lan>
Message-ID: <54F8095C.4030308@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/5 6:29, Rafael J. Wysocki wrote:
> On Wednesday, February 25, 2015 04:39:42 PM Hanjun Guo wrote:
>> CPU hardware ID (phys_id) is defined as u32 in structure acpi_processor,
>> but phys_id is used as int in acpi processor driver, so it will lead to
>> some inconsistence for the drivers.
>>
>> Furthermore, to cater for ACPI arch ports that implement 64 bits CPU
>> ids a generic CPU physical id type is required.
>>
>> So introduce typedef u32 phys_cpuid_t for x86 and ia64, and introduce
>> a macro CPU_PHYS_ID_INVALID as (u32)(-1), use phys_cpuid_t when phys_id
>> defined in acpi processor driver, and replace CPU_PHYS_ID_INVALID as -1
>> for phys_id, this will solve the inconsistence in acpi processor driver,
>> and will prepare for the ACPI on ARM64 too.
>>
>> CC: Rafael J Wysocki <rjw@rjwysocki.net>
>> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> [hj: reworked cpu physid map return codes]
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/ia64/include/asm/acpi.h  |  4 ++++
>>  arch/ia64/kernel/acpi.c       |  2 +-
>>  arch/x86/include/asm/acpi.h   |  4 ++++
>>  arch/x86/kernel/acpi/boot.c   |  2 +-
>>  drivers/acpi/acpi_processor.c |  7 ++++---
>>  drivers/acpi/processor_core.c | 30 +++++++++++++++---------------
>>  include/acpi/processor.h      |  6 +++---
>>  include/linux/acpi.h          |  2 +-
>>  8 files changed, 33 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
>> index a1d91ab..ca1f0e4 100644
>> --- a/arch/ia64/include/asm/acpi.h
>> +++ b/arch/ia64/include/asm/acpi.h
>> @@ -34,6 +34,10 @@
>>  #include <linux/numa.h>
>>  #include <asm/numa.h>
>>  
>> +typedef u32 phys_cpuid_t;
>> +
>> +#define CPU_PHYS_ID_INVALID (u32)(-1)
>> +
>>  #ifdef	CONFIG_ACPI
>>  extern int acpi_lapic;
>>  #define acpi_disabled 0	/* ACPI always enabled on IA64 */
>> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
>> index 2c44989..067ef44 100644
>> --- a/arch/ia64/kernel/acpi.c
>> +++ b/arch/ia64/kernel/acpi.c
>> @@ -887,7 +887,7 @@ static int _acpi_map_lsapic(acpi_handle handle, int physid, int *pcpu)
>>  }
>>  
>>  /* wrapper to silence section mismatch warning */
>> -int __ref acpi_map_cpu(acpi_handle handle, int physid, int *pcpu)
>> +int __ref acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu)
>>  {
>>  	return _acpi_map_lsapic(handle, physid, pcpu);
>>  }
>> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
>> index 3a45668..cd788dd 100644
>> --- a/arch/x86/include/asm/acpi.h
>> +++ b/arch/x86/include/asm/acpi.h
>> @@ -32,6 +32,10 @@
>>  #include <asm/mpspec.h>
>>  #include <asm/realmode.h>
>>  
>> +typedef u32 phys_cpuid_t;
>> +
>> +#define CPU_PHYS_ID_INVALID (u32)(-1)
> Can we define those things in one common place instead of having to duplicate
> the definitions for every arch?

As in your reply in patch 14/21, ARM64 will use 64-bit for

phys_cpuid_t.


>
> Also, I'd like to have
>
> static inline bool invalid_cpu_phys_id(phys_cpuid_t phys_id)
> {
> 	return (int)phys_id < 0;
> }
>
> as that would cover error codes too.
>
> Moreover, why don't you use (phys_cpuid_t)(-1) in the #define?  And call is
> PHYS_CPUID_INVALID for that matter (so that the name of the symbol corresponds
> to the name of the type)?

That's pretty fine to me too.

>
>
>> +
>>  #ifdef CONFIG_ACPI
>>  extern int acpi_lapic;
>>  extern int acpi_ioapic;
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>> index 3d525c6..e4f8582 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -757,7 +757,7 @@ static int _acpi_map_lsapic(acpi_handle handle, int physid, int *pcpu)
>>  }
>>  
>>  /* wrapper to silence section mismatch warning */
>> -int __ref acpi_map_cpu(acpi_handle handle, int physid, int *pcpu)
>> +int __ref acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu)
>>  {
>>  	return _acpi_map_lsapic(handle, physid, pcpu);
>>  }
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>> index 1020b1b..e6c7c56 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -170,7 +170,7 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>>  	acpi_status status;
>>  	int ret;
>>  
>> -	if (pr->phys_id == -1)
>> +	if (pr->phys_id == CPU_PHYS_ID_INVALID)
>>  		return -ENODEV;
>>  
>>  	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
>> @@ -215,7 +215,8 @@ static int acpi_processor_get_info(struct acpi_device *device)
>>  	union acpi_object object = { 0 };
>>  	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
>>  	struct acpi_processor *pr = acpi_driver_data(device);
>> -	int phys_id, cpu_index, device_declaration = 0;
>> +	phys_cpuid_t phys_id;
>> +	int cpu_index, device_declaration = 0;
>>  	acpi_status status = AE_OK;
>>  	static int cpu0_initialized;
>>  	unsigned long long value;
>> @@ -263,7 +264,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>>  	}
>>  
>>  	phys_id = acpi_get_phys_id(pr->handle, device_declaration, pr->acpi_id);
>> -	if (phys_id < 0)
>> +	if (phys_id == CPU_PHYS_ID_INVALID)
>>  		acpi_handle_debug(pr->handle, "failed to get CPU physical ID.\n");
>>  	pr->phys_id = phys_id;
>>  
>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
>> index 7962651..a5547dc 100644
>> --- a/drivers/acpi/processor_core.c
>> +++ b/drivers/acpi/processor_core.c
>> @@ -32,7 +32,7 @@ static struct acpi_table_madt *get_madt_table(void)
>>  }
>>  
>>  static int map_lapic_id(struct acpi_subtable_header *entry,
>> -		 u32 acpi_id, int *apic_id)
>> +		 u32 acpi_id, phys_cpuid_t *apic_id)
>>  {
>>  	struct acpi_madt_local_apic *lapic =
>>  		container_of(entry, struct acpi_madt_local_apic, header);
>> @@ -48,7 +48,7 @@ static int map_lapic_id(struct acpi_subtable_header *entry,
>>  }
>>  
>>  static int map_x2apic_id(struct acpi_subtable_header *entry,
>> -			 int device_declaration, u32 acpi_id, int *apic_id)
>> +		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id)
>>  {
>>  	struct acpi_madt_local_x2apic *apic =
>>  		container_of(entry, struct acpi_madt_local_x2apic, header);
>> @@ -65,7 +65,7 @@ static int map_x2apic_id(struct acpi_subtable_header *entry,
>>  }
>>  
>>  static int map_lsapic_id(struct acpi_subtable_header *entry,
>> -		int device_declaration, u32 acpi_id, int *apic_id)
>> +		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id)
>>  {
>>  	struct acpi_madt_local_sapic *lsapic =
>>  		container_of(entry, struct acpi_madt_local_sapic, header);
>> @@ -83,10 +83,10 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
>>  	return 0;
>>  }
>>  
>> -static int map_madt_entry(int type, u32 acpi_id)
>> +static phys_cpuid_t map_madt_entry(int type, u32 acpi_id)
>>  {
>>  	unsigned long madt_end, entry;
>> -	int phys_id = -1;	/* CPU hardware ID */
>> +	phys_cpuid_t phys_id = CPU_PHYS_ID_INVALID;	/* CPU hardware ID */
>>  	struct acpi_table_madt *madt;
>>  
>>  	madt = get_madt_table();
>> @@ -117,12 +117,12 @@ static int map_madt_entry(int type, u32 acpi_id)
>>  	return phys_id;
>>  }
>>  
>> -static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>> +static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>>  {
>>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>>  	union acpi_object *obj;
>>  	struct acpi_subtable_header *header;
>> -	int phys_id = -1;
>> +	phys_cpuid_t phys_id = CPU_PHYS_ID_INVALID;
>>  
>>  	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_MAT", NULL, &buffer)))
>>  		goto exit;
>> @@ -149,27 +149,27 @@ exit:
>>  	return phys_id;
>>  }
>>  
>> -int acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
>> +phys_cpuid_t acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
>>  {
>> -	int phys_id;
>> +	phys_cpuid_t phys_id;
>>  
>>  	phys_id = map_mat_entry(handle, type, acpi_id);
>> -	if (phys_id == -1)
>> +	if (phys_id == CPU_PHYS_ID_INVALID)
>>  		phys_id = map_madt_entry(type, acpi_id);
>>  
>>  	return phys_id;
>>  }
>>  
>> -int acpi_map_cpuid(int phys_id, u32 acpi_id)
>> +int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id)
>>  {
>>  #ifdef CONFIG_SMP
>>  	int i;
>>  #endif
>>  
>> -	if (phys_id == -1) {
>> +	if (phys_id == CPU_PHYS_ID_INVALID) {
>>  		/*
>>  		 * On UP processor, there is no _MAT or MADT table.
>> -		 * So above phys_id is always set to -1.
>> +		 * So above phys_id is always set to CPU_PHYS_ID_INVALID.
>>  		 *
>>  		 * BIOS may define multiple CPU handles even for UP processor.
>>  		 * For example,
>> @@ -190,7 +190,7 @@ int acpi_map_cpuid(int phys_id, u32 acpi_id)
>>  		if (nr_cpu_ids <= 1 && acpi_id == 0)
>>  			return acpi_id;
>>  		else
>> -			return phys_id;
>> +			return -1;
> Can we use a proper error code here?

I'm afraid not. In ACPI processor drivers, -1 will be deemed to
invalid cpu logical number, if we return error code here, we need
to modify multi places of "if (cpu_logical_num == -1)" to
"if (! (cpu_logical_num < 0))" too, so for me, I prefer to keep it as
-1, but I'm open for suggestions.

Thanks
Hanjun
