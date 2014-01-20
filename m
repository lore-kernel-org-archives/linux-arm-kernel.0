From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 20 Jan 2014 16:49:00 +0800
Subject: [PATCH 09/20] ARM64 / ACPI: Implement core functions for parsing
 MADT table
In-Reply-To: <201401171512.42850.arnd@arndb.de>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-10-git-send-email-hanjun.guo@linaro.org>
 <201401171512.42850.arnd@arndb.de>
Message-ID: <52DCE2FC.30003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-1-17 22:12, Arnd Bergmann wrote:
> On Friday 17 January 2014, Hanjun Guo wrote:
>>  
>> +/*
>> + * Local interrupt controller address,
>> + * GIC cpu interface base address on ARM/ARM64
>> + */
>> +static u64 acpi_lapic_addr __initdata;
> 
> If it's cpu local, don't you need more than one address to support SMP?

Good point, thanks for pointing this out. I have a question, do we really
have some SoCs without banked registers?

I ask this question because we can do something for GIC cpu interface
with per cpu offset, but ACPI do NOT support per cpu offset for GIC
distributor.

> Also, the variable appears to be write-only.

Actually not, it will be used for GIC initialization.

> 
>> +#define BAD_MADT_ENTRY(entry, end) (					\
>> +	(!entry) || (unsigned long)entry + sizeof(*entry) > end ||	\
>> +	((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
>> +
> 
> Better make this an inline function.
> 
>> +static int __init
>> +acpi_parse_gic(struct acpi_subtable_header *header, const unsigned long end)
>> +{
>> +	struct acpi_madt_generic_interrupt *processor = NULL;
>> +
>> +	processor = (struct acpi_madt_generic_interrupt *)header;
> 
> You don't need the initialization in the first line when you write to the
> variable before reading it. Same in the other functions.

Ok, I will update them all in next version.

Thanks
hanjun
