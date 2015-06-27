From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sat, 27 Jun 2015 14:07:58 +0800
Subject: [PATCH v2 3/9] irqchip / GIC: Add GIC version support in ACPI MADT
In-Reply-To: <20150622164520.GA26129@red-moon>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
 <1434703572-26221-4-git-send-email-hanjun.guo@linaro.org>
 <20150622164520.GA26129@red-moon>
Message-ID: <558E3DBE.2020401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2015 12:45 AM, Lorenzo Pieralisi wrote:
> On Fri, Jun 19, 2015 at 09:46:06AM +0100, Hanjun Guo wrote:
>
> [...]
>
>> +
>> +static int __init
>> +match_gic_redist(struct acpi_subtable_header *header, const unsigned long end)
>> +{
>> +	return 0;
>> +}
>> +static bool __init acpi_gic_redist_is_present(void)
>> +{
>> +	int count;
>> +
>> +	/* scan MADT table to find if we have redistributor entries */
>> +	count  =  acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
>> +					match_gic_redist, 0);
>> +
>> +	/* has at least one GIC redistributor entry */
>> +	if (count > 0)
>> +		return true;
>> +	else
>> +		return false;
>> +}
>
> return count > 0;
>
> What about systems where the redistributor data is in the GICC subtable ? Do
> you treat them as GIC V2 :) ?
>
> On a side note, having to define an empty function like match_gic_redist is
> horrible.
>
> I wonder whether it is not better to refactor map_madt_entry(), create
> a MADT subtable iterator out of it and make that code generic, instead
> of being forced to add these useless MADT handlers just to count
> entries, it is not the first I noticed.

After digging into the code, it seems that we need more discussion for
this comment, you suggested that refactor map_madt_entry() and create
a MADT subtable iterator out of it, but we still need a handler
to handle each subtable entry, right? then it will become another
version of acpi_parse_entries() in drivers/acpi/table.c, and no
improvement to code, did I miss something?

Thanks
Hanjun
