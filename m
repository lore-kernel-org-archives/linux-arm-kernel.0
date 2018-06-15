From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Jun 2018 10:17:18 -0700
Subject: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
In-Reply-To: <098e6d53-8dc7-439f-7165-adbe0e7c4941@arm.com>
References: <51d3d738-cdf5-2992-bba5-c3e1f34096c2@infradead.org>
 <098e6d53-8dc7-439f-7165-adbe0e7c4941@arm.com>
Message-ID: <8a3034b9-6cf3-5182-717f-dd1dc8a087aa@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Just for background, this is a well known bug in the m400's AEPI/HEST
firmware.  There are a number of fixes out there the different distros
have.  I just put together this patch to unify things and have a
common 'upstream' fix.

On 06/15/2018 04:14 AM, James Morse wrote:
> On 13/06/18 19:22, Geoff Levand wrote:
>> Adds a new ACPI init routine acpi_fixup_m400_quirks that adds
>> a work-around for HPE ProLiant m400 APEI firmware problems.
>>
>> The work-around disables APEI when CONFIG_ACPI_APEI is set and
>> m400 firmware is detected.  Without this fixup m400 systems
>> experience errors like these on startup:
>>
>>   [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
>>   [Hardware Error]: event severity: fatal
>>   [Hardware Error]:  Error 0, type: fatal
>>   [Hardware Error]:   section_type: memory error
>>   [Hardware Error]:   error_status: 0x0000000000001300
> 
> "Access to a memory address which is not mapped to any component"
> 
> 
>>   [Hardware Error]:   error_type: 10, invalid address
>>   Kernel panic - not syncing: Fatal hardware error!
> 
> Why is this a problem?
> 
> Surely this is a valid description of an error.

The firmware bug causes this failure, not bad hardware.

> (okay its not particularly useful without the physical address, but the address
> is optional in that structure)
> 
> When does this happen during boot? This looks like a driver mapping some
> non-existent physical address space to see if its device is present...
> unsurprisingly this doesn't go well.
> (might also be a typo in the DSDT)
> 
> Can't we pin down the driver that does this and fix it. Its either wrong for
> everyone, or still broken after you disable APEI.
> 
> 
>> It seems unlikely there will be any m400 firmware updates to fix
>> this problem.
> 
> What is the problem? This patch looks like it shoots the messenger for bringing
> bad news.
 
The news is incorrect, so this patch disables the source (APEI code).

>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index 7b09487ff8fb..3c315c2c7476 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -31,6 +31,8 @@
>>  #include <asm/cpu_ops.h>
>>  #include <asm/smp_plat.h>
>>  
>> +#include <acpi/apei.h>
>> +
>>  #ifdef CONFIG_ACPI_APEI
>>  # include <linux/efi.h>
>>  # include <asm/pgtable.h>
>> @@ -177,6 +179,33 @@ static int __init acpi_fadt_sanity_check(void)
>>  	return ret;
>>  }
>>  
>> +/*
>> + * acpi_fixup_m400_quirks - Work-around for HPE ProLiant m400 APEI firmware
>> + * problems.
>> + */
>> +static void __init acpi_fixup_m400_quirks(void)
>> +{
>> +	acpi_status status;
>> +	struct acpi_table_header *header;
>> +#if !defined(CONFIG_ACPI_APEI)
>> +	int hest_disable = HEST_DISABLED;
>> +#endif
> 
> Yuck.

Yes, unfortunately, the hest code conditionally defines hest_disable.

>> +
>> +	if (!IS_ENABLED(CONFIG_ACPI_APEI) || hest_disable != HEST_ENABLED)
>> +		return;
>> +
>> +	status = acpi_get_table(ACPI_SIG_HEST, 0, &header);
>> +
>> +	if (ACPI_SUCCESS(status) && !strncmp(header->oem_id, "HPE   ", 6) &&
>> +		!strncmp(header->oem_table_id, "ProLiant", 8) &&
> 
> You should match the affected range of OEM table revisions too, that way a
> firmware upgrade should start working, instead of being permanently disabled
> because we think its unlikely.

The m400 has reached end of life. No one really expects to see any firmware
update.  I don't know what the effected OEM table revisions are, and I don't
think there is an active platform maintainer who could give that info either.

If someone can provide the info. I'll update the fix.

>> +		MIDR_IMPLEMENTOR(read_cpuid_id()) == ARM_CPU_IMP_APM) {
> 
> How is the CPU implementer relevant?

That was just a copy of what other fixes had.  Should I remove it?

> You suggest a firmware-update would make this issue go away...
> 
> 
>> +		hest_disable = HEST_DISABLED;
>> +		pr_info("Disabled APEI for m400.\n");
>> +	}
>> +
>> +	acpi_put_table(header);
>> +}
>> +
>>  /*
>>   * acpi_boot_table_init() called from setup_arch(), always.
>>   *	1. find RSDP and get its address, and then find XSDT
> 
> Nothing arch-specific here. You're adding this to arch/arm64 because
> drivers/acpi/apei doesn't have an existing quirks table?

There was a fix submitted that had it in drivers/acpi/scan.c, but the
ACPI maintainer said he didn't want the fix in the main ACPI code.
See:

  https://lkml.org/lkml/2018/4/19/1020 (ACPI / scan: Fix regression related to X-Gene UARTs)

The m400 is an arm64 platform, so it seems most appropriate to
have it in arch/arm64/kernel/acpi.c.  I followed what was done
for x86 quirks (into arch/x86/kernel/acpi/boot.c), and what was
suggested here: 

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=900581 (linux: Enable Buster kernel features for newer ARM64 servers)

Thanks for the review.

-Geoff
