From: julien.grall@arm.com (Julien Grall)
Date: Wed, 24 May 2017 12:18:09 +0100
Subject: irqchip/irq-gic: BAD_MADT_GICC_ENTRY may fail when booting with
 ACPI 5.1
In-Reply-To: <20170523170657.GA3800@red-moon>
References: <432c3a63-c89f-dccc-7bdf-9d9a0aaabfe2@arm.com>
 <20170523170657.GA3800@red-moon>
Message-ID: <25d7230b-1dba-614c-7193-b9e44429b5a1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 05/23/2017 06:06 PM, Lorenzo Pieralisi wrote:
> [+Al]
>
> On Tue, May 23, 2017 at 05:40:28PM +0100, Julien Grall wrote:
>> Hi all,
>>
>> I am currently looking at adding support of ACPI 5.1 in Xen.
>> When trying to boot DOM00 I get a panic in Linux (for the full
>> log see [1]):
>>
>> (XEN) DOM0: [    0.000000] No valid GICC entries exist
>>
>> The error message is coming from gic_v2_acpi_init.
>> Digging down in the code, it is failing because of
>> BAD_MADT_GICC_ENTRY is returning false in
>> gic_acpi_parse_madt_cpu:
>>
>> /* Macros for consistency checks of the GICC subtable of MADT */
>> #define ACPI_MADT_GICC_LENGTH	\
>> 	(acpi_gbl_FADT.header.revision < 6 ? 76 : 80)
>>
>> #define BAD_MADT_GICC_ENTRY(entry, end)						\
>> 	(!(entry) || (unsigned long)(entry) + sizeof(*(entry)) > (end) ||	\
>> 	 (entry)->header.length != ACPI_MADT_GICC_LENGTH)
>>
>> The 'end' parameter corresponds to the end of the MADT table.
>> In the case of ACPI 5.1, the size of GICC is smaller compare
>> to 6.0+ (76 vs 80 bytes) but the parameter 'entry' is type
>> of acpi_madt_generic_interrupt (sizeof(...) = 80).
>
> #define BAD_MADT_GICC_ENTRY(entry, end)	\
> 	(!(entry) || (entry)->header.length != ACPI_MADT_GICC_LENGTH ||	\
> 	((unsigned long)(entry) + ACPI_MADT_GICC_LENGTH) > (end))
>
> Would this solve it ?

Yes, I am now able to boot DOM0 up to the prompt. My concern with this 
solution is the code will still use the acpi_madt_generic_interrupt 
code. If someone tries to access field not existing in 5.1 (such as 
efficiency_class), it may return wrong value or even worst crash.

Although, I don't see any user of efficiency_class in Linux so far.

Cheers,

-- 
Julien Grall
