From: ahs3@redhat.com (Al Stone)
Date: Fri, 03 Jul 2015 13:51:36 -0600
Subject: [PATCH v3 2/3] ACPI / ARM64: add BAD_MADT_GICC_ENTRY() macro
In-Reply-To: <20150703140601.GL25907@e104818-lin.cambridge.arm.com>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
 <1435880916-2153-3-git-send-email-al.stone@linaro.org>
 <20150703140601.GL25907@e104818-lin.cambridge.arm.com>
Message-ID: <5596E7C8.7040809@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2015 08:06 AM, Catalin Marinas wrote:
> On Thu, Jul 02, 2015 at 05:48:35PM -0600, Al Stone wrote:
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index 39248d3..a3c26a4 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -19,6 +19,17 @@
>>  #include <asm/psci.h>
>>  #include <asm/smp_plat.h>
>>  
>> +/* Macros for consistency checks of the GICC subtable of MADT */
>> +#define ACPI_MADT_GICC_51_LENGTH       76
>> +#define ACPI_MADT_GICC_60_LENGTH       80
>> +
>> +#define BAD_MADT_GICC_ENTRY(entry, end) (                                   \
>> +		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
>> +		((ACPI_FADT_SPEC_VERSION == ACPI_FADT_SPEC_VERSION_51) &&   \
>> +		 (entry->header.length != ACPI_MADT_GICC_51_LENGTH))    ||  \
>> +		((ACPI_FADT_SPEC_VERSION == ACPI_FADT_SPEC_VERSION_60) &&   \
>> +		 (entry->header.length != ACPI_MADT_GICC_60_LENGTH)))
> 
> This looks ugly but, well, we could live with this.

Nod.  It's right at the hairy edge of becoming a function, I think.

> However, I'd like to avoid having to extend this macro every time we get
> a new spec released, like 6.1 defining another 80 or 84 etc. So, how
> about we only update this when there is an actual change in the length?
> Something like:
> 
> #define ACPI_MADT_GICC_LENGTH	({					\
> 	u8 length;							\
> 	if (ACPI_FADT_SPEC_VERSION < ACPI_FADT_SPEC_VERSION_6_0)	\
> 		length = 76;						\
> 	else								\
> 		length = 80;						\
> 	length;								\
> })
> 
> or just:
> 
> #define ACPI_MADT_GICC_LENGTH	\
> 	(ACPI_FADT_SPEC_VERSION < ACPI_FADT_SPEC_VERSION_6_0 ? 76 : 80)
> 
> (the latter is simpler but may not look nice if we change it again in
> 6.1; though we could re-write this macro when needed, not a problem)
> 

Perhaps the sanity checking for the MADT subtables needs to be revisited
and a more general solution provided -- this is not the only MADT subtable
with this problem and it may occur again.

Even the versions above are not technically compliant with the spec.  If
we implement what the spec currently says, it might look something like
this:

#define ACPI_MADT_GICC_LENGTH ({					\
	u8 length;							\
	switch (ACPI_FADT_SPEC_VERSION) {				\
	case ACPI_FADT_SPEC_VERSION_5_0:				\
		length = 40;						\
		break;							\
	case ACPI_FADT_SPEC_VERSION_5_1:				\
		length = 76;						\
		break;							\
	default:	/* use 6.0 size */				\
		length = 80;						\
	}								\
	length;								\
})

So it's just messy and there will be a need for change.  Let me think about
making this a function instead of a macro; it may make sense to really fix
BAD_MADT_ENTRY in general instead of just dealing with the GICC subtable,
but it could also be overkill.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
