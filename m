From: ahs3@redhat.com (Al Stone)
Date: Fri, 19 Jun 2015 14:03:51 -0600
Subject: [PATCH v2 3/3] ACPI / ARM64 : use the new BAD_MADT_GICC_ENTRY
 macro
In-Reply-To: <20150619094658.GB18017@arm.com>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
 <1434666968-1543-4-git-send-email-al.stone@linaro.org>
 <20150619094658.GB18017@arm.com>
Message-ID: <558475A7.6050209@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2015 03:46 AM, Will Deacon wrote:
> On Thu, Jun 18, 2015 at 11:36:08PM +0100, Al Stone wrote:
>> For those parts of the arm64 ACPI code that need to check GICC subtables
>> in the MADT, use the new BAD_MADT_GICC_ENTRY macro instead of the previous
>> BAD_MADT_ENTRY.  The new macro takes into account differences in the size
>> of the GICC subtable that the old macro did not; this caused failures even
>> though the subtable entries are valid.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>  arch/arm64/kernel/smp.c   | 2 +-
>>  drivers/irqchip/irq-gic.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Good to see this stuff is holding up so well...
> 
> Will

Thanks, Will.

>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 4b2121b..80d5984 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -438,7 +438,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
>>  	struct acpi_madt_generic_interrupt *processor;
>>  
>>  	processor = (struct acpi_madt_generic_interrupt *)header;
>> -	if (BAD_MADT_ENTRY(processor, end))
>> +	if (BAD_MADT_GICC_ENTRY(processor, end))
>>  		return -EINVAL;
>>  
>>  	acpi_table_print_madt_entry(header);
>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> index 8d7e1c8..4dd8826 100644
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
>> @@ -1055,7 +1055,7 @@ gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
>>  
>>  	processor = (struct acpi_madt_generic_interrupt *)header;
>>  
>> -	if (BAD_MADT_ENTRY(processor, end))
>> +	if (BAD_MADT_GICC_ENTRY(processor, end))
>>  		return -EINVAL;
>>  
>>  	/*
>> -- 
>> 2.4.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
