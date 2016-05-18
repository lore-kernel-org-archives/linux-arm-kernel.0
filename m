From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Wed, 18 May 2016 18:11:34 +0300
Subject: [PATCH 3/3] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
In-Reply-To: <20160517124629.GE14955@leverpostej>
References: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
 <1463486765-31827-4-git-send-email-aleksey.makarov@linaro.org>
 <20160517124629.GE14955@leverpostej>
Message-ID: <b1a9ef97-618c-064c-7968-900c96fb7e27@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/17/2016 03:46 PM, Mark Rutland wrote:
> On Tue, May 17, 2016 at 03:06:03PM +0300, Aleksey Makarov wrote:

[...]

>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index feab2ee..1d5e24f 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -261,11 +261,13 @@ void __init setup_arch(char **cmdline_p)
>>  	efi_init();
>>  	arm64_memblock_init();
>>  
>> +	paging_init();
>> +
>> +	early_initrd_acpi_init();
> 
> Do we actually need full paging up here?
> 
> Why can we not use fixmap based copying as we do for the other cases
> prior to paging_init?

The implementation of the feature acpi_table_initrd_init()
(drivers/acpi/tables.c) works with initrd data represented as an array
in virtual memory.  It uses some library utility to find the redefined
tables in that array and iterates over it to copy the data to new
allocated memory.  So we need to rewrite it considerably to access the
initrd data via fixmap.

In x86 arch, linear kernel memory is already mapped by the time when
early_initrd_acpi_init() and acpi_boot_table_init() are called so I
think that we can just move this mapping one function earlier too.

Is it ok?

I will address your other comments in the next version of the patchset.

Thank you
Aleksey Makarov

>> +
>>  	/* Parse the ACPI tables for possible boot-time configuration */
>>  	acpi_boot_table_init();
>>  
>> -	paging_init();
>> -
>>  	if (acpi_disabled)
>>  		unflatten_device_tree();
>>  
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index c204344..ec694c0 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -313,7 +313,7 @@ config ACPI_CUSTOM_DSDT
>>  
>>  config ACPI_TABLE_UPGRADE
>>  	bool "Allow upgrading ACPI tables via initrd"
>> -	depends on BLK_DEV_INITRD && X86
>> +	depends on BLK_DEV_INITRD && (X86 || ARM64)
>>  	default y
>>  	help
> 
> Perhaps ARCH_HAS_ACPI_TABLE_UPGRADE?
> 
>>  	  This option provides functionality to upgrade arbitrary ACPI tables
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 82be84a..c35034d8 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -482,6 +482,14 @@ static DECLARE_BITMAP(acpi_initrd_installed, NR_ACPI_INITRD_TABLES);
>>  
>>  #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
>>  
>> +#if defined(CONFIG_X86)
>> +#define MAX_PHYS_ACPI_TABLES (max_low_pfn_mapped << PAGE_SHIFT)
>> +#elif defined(CONFIG_ARM64)
>> +#define MAX_PHYS_ACPI_TABLES PFN_PHYS(max_pfn)
>> +#else
>> +#error "MAX_PHYS_ACPI_TABLES is not defiend for this architecture"
>> +#endif
> 
> s/defiend/defined/
> 
> This should be defined in an arch-specific header if it is actually
> arch-specific.
> 
> Thanks,
> Mark.
> 
>> +
>>  static void __init acpi_table_initrd_init(void *data, size_t size)
>>  {
>>  	int sig, no, table_nr = 0, total_offset = 0;
>> @@ -541,7 +549,7 @@ static void __init acpi_table_initrd_init(void *data, size_t size)
>>  		return;
>>  
>>  	acpi_tables_addr =
>> -		memblock_find_in_range(0, max_low_pfn_mapped << PAGE_SHIFT,
>> +		memblock_find_in_range(0, MAX_PHYS_ACPI_TABLES,
>>  				       all_tables_size, PAGE_SIZE);
>>  	if (!acpi_tables_addr) {
>>  		WARN_ON(1);
>> -- 
>> 2.8.2
>>
