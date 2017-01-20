From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 20 Jan 2017 11:12:51 -0600
Subject: [PATCH v13 1/7] arm64: Rename the common MADT parse routine
In-Reply-To: <20170120162236.GA14295@red-moon>
References: <1484686210-7211-1-git-send-email-jeremy.linton@arm.com>
 <1484686210-7211-2-git-send-email-jeremy.linton@arm.com>
 <20170120162236.GA14295@red-moon>
Message-ID: <e28bac36-23a5-ad01-3258-6ffdd6a774cf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/20/2017 10:22 AM, Lorenzo Pieralisi wrote:
> On Tue, Jan 17, 2017 at 02:50:04PM -0600, Jeremy Linton wrote:
>> The MADT parser in smp.c is now being used to parse
>> out NUMA, PMU and ACPI parking protocol information as
>
> Nit: It is not used to parse PMU yet at this stage so
> either you remove PMU from the list or you move this patch
> to the end of the series.

(per comments below)
I think the best plan is to drop it in the next spin of the series, 
although as Will has shown that he is skillful at cherry picking patches 
out of this series, so maybe that won't be necessary? Of course 3/7 
probably won't apply cleanly without this one.

>
>> well as the GIC information for which it was originally
>> created. Rename it to avoid a misleading name.
>
> It is funny smp.c never mapped _any_ GIC information :) (even
> though it parses the MADT GIC CPU interface entries).

<OT chuckle> Ha, map is pretty generic outside of LK and more accurately 
reflects the "mapping" from one structure/element to another, more so 
than parse (of which I'm a prime offender, particularly in the previous 
comment). </OT chuckle>


(trimming)
>>  static void __init
>> -acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>> +acpi_verify_and_map_madt(struct acpi_madt_generic_interrupt *processor)
>
> acpi_map_madt_cpu_entry()
>
> or just drop this patch to avoid useless bikeshedding, your choice.
>
>>  {
>>  	u64 hwid = processor->arm_mpidr;
>>
>> @@ -577,7 +578,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>>  }
>>
>>  static int __init
>> -acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
>> +acpi_parse_madt_common(struct acpi_subtable_header *header,
>>  			     const unsigned long end)
>
> acpi_madt_parse_cpus()
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
>>  {
>>  	struct acpi_madt_generic_interrupt *processor;

(trimming)
