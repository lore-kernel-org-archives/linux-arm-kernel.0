From: ahs3@redhat.com (Al Stone)
Date: Fri, 19 Jun 2015 14:02:21 -0600
Subject: [PATCH v2 2/3] ACPI: add BAD_MADT_GICC_ENTRY() macro
In-Reply-To: <5583F3D5.2020004@linaro.org>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
 <1434666968-1543-3-git-send-email-al.stone@linaro.org>
 <5583F3D5.2020004@linaro.org>
Message-ID: <5584754D.5040703@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2015 04:49 AM, Hanjun Guo wrote:
> On 06/19/2015 06:36 AM, Al Stone wrote:
>> The BAD_MADT_ENTRY() macro is designed to work for all of the subtables
>> of the MADT.  In the ACPI 5.1 version of the spec, the struct for the
>> GICC subtable (struct acpi_madt_generic_interrupt) is 76 bytes long; in
>> ACPI 6.0, the struct is 80 bytes long.  But, there is only one definition
>> in ACPICA for this struct -- and that is the 6.0 version.  Hence, when
>> BAD_MADT_ENTRY() compares the struct size to the length in the GICC
>> subtable, it fails if 5.1 structs are in use, and there are systems in
>> the wild that have them.
>>
>> This patch adds the BAD_MADT_GICC_ENTRY() that checks the GICC subtable
>> only, accounting for the difference in specification versions that are
>> possible.  The BAD_MADT_ENTRY() will continue to work as is for all other
>> MADT subtables.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   include/linux/acpi.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 33ed313..d3a1758 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -127,6 +127,16 @@ static inline void acpi_initrd_override(void *data,
>> size_t size)
>>           (!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
>>           ((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
>>
>> +#define ACPI_MADT_GICC_51_LENGTH    76
>> +#define ACPI_MADT_GICC_60_LENGTH    80
>> +
>> +#define BAD_MADT_GICC_ENTRY(entry, end) (                    \
>> +        (!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
>> +        ((ACPI_FADT_SPEC_VERSION == ACPI_SPEC_VERSION(5, 1)) &&        \
>> +         (entry->header.length != ACPI_MADT_GICC_51_LENGTH))    ||  \
>> +        ((ACPI_FADT_SPEC_VERSION == ACPI_SPEC_VERSION(6, 0)) &&        \
>> +         (entry->header.length != ACPI_MADT_GICC_60_LENGTH)))
>> +
>>   char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
>>   void __acpi_unmap_table(char *map, unsigned long size);
>>   int early_acpi_boot_init(void);
> 
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Thanks
> Hanjun
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in

Thanks for the review.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
