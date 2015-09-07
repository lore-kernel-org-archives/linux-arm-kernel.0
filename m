From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Sep 2015 18:35:52 +0100
Subject: [PATCH 1/5] acpi: Add basic device probing infrastructure
In-Reply-To: <20150907160045.GC29293@red-moon>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
 <1441386412-8139-2-git-send-email-marc.zyngier@arm.com>
 <20150907160045.GC29293@red-moon>
Message-ID: <55EDCAF8.6080605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/15 17:00, Lorenzo Pieralisi wrote:
> [+M.Salter]
> 
> On Fri, Sep 04, 2015 at 06:06:48PM +0100, Marc Zyngier wrote:
>> IRQ controllers and timers are the two types of device the kernel
>> requires before being able to use the device driver model.
>>
>> ACPI so far lacks a proper probing infrastructure similar to the one
>> we have with DT, where we're able to declare IRQ chips and
>> clocksources inside the driver code, and let the core code pick it up
>> and call us back on a match. This leads to all kind of really ugly
>> hacks all over the arm64 code and even in the ACPI layer.
>>
>> In order to allow some basic probing based on the ACPI tables,
>> introduce "struct acpi_probe_entry" which contains just enough
>> data and callbacks to match a table, an optional subtable, and
>> call a probe function. A driver can, at build time, register itself
>> and expect being called if the right entry exists in the ACPI
>> table.
>>
>> A acpi_probe_device_init() is provided, taking an ACPI table
>> identifier, and iterating over the registered entries.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/acpi/scan.c               | 41 ++++++++++++++++++++++++++++
>>  include/asm-generic/vmlinux.lds.h | 11 ++++++++
>>  include/linux/acpi.h              | 56 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 108 insertions(+)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index ec25635..9e920ec 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -2793,3 +2793,44 @@ int __init acpi_scan_init(void)
>>  	mutex_unlock(&acpi_scan_lock);
>>  	return result;
>>  }
>> +
>> +static const struct acpi_probe_entry device_acpi_probe_end
>> +		__used __section(__device_acpi_probe_table_end);
>> +extern struct acpi_probe_entry __device_acpi_probe_table[];
>> +static struct acpi_probe_entry *ape;
>> +static int acpi_probe_count;
>> +static DEFINE_SPINLOCK(acpi_probe_lock);
>> +
>> +static int __init acpi_match_madt(struct acpi_subtable_header *header,
>> +				  const unsigned long end)
>> +{
>> +	if (!ape->validate_subtbl || ape->validate_subtbl(header, ape))
>> +		if (!ape->probe_subtbl(header, end))
>> +			acpi_probe_count++;
>> +
>> +	return 0;
>> +}
>> +
>> +int __init acpi_probe_device_table(const char *id)
>> +{
>> +	int count = 0;
>> +
>> +	if (acpi_disabled)
>> +		return 0;
>> +
>> +	spin_lock(&acpi_probe_lock);
>> +	for (ape = __device_acpi_probe_table; ape->probe_table; ape++) {
>> +		if (!ACPI_COMPARE_NAME(id, ape->id))
>> +			continue;
>> +		if (ACPI_COMPARE_NAME(ACPI_SIG_MADT, ape->id)) {
>> +			acpi_probe_count = 0;
>> +			acpi_table_parse_madt(ape->type, acpi_match_madt, 0);
>> +			count += acpi_probe_count;
>> +		} else {
>> +			count = acpi_table_parse(ape->id, ape->probe_table);
>> +		}
>> +	}
>> +	spin_unlock(&acpi_probe_lock);
>> +
>> +	return count;
>> +}
> 
> We should add a mechanism to prevent re-parsing the same entries
> multiple times (in case this function is called with the same
> signature multiple times). We could create a separate table of device
> entries, per-subsystem, that we want to parse (irqchip specific table,
> timers, etc.) instead of adding all the devices to the same table (ie
> linker section), you can do this already with the current patchset by
> just choosing different table names as DT does.

Yeah, my initial approach was to have multiple tables, but I ended up
deciding against it because nothing required it so far, and I wanted to
avoid the over-engineered syndrome.

Also, it could be useful to flag entries that have been successfully
probed to ensure we don't try them again. Though having separate tables
would probably greatly reduce the usefulness of this.

> We may also want to extend this set so that it can be used to parse the
> same table, same subtype multiple times at different stages in the boot
> path (but let's first see if it is a) really needed b) feasible).
> 
> Basically it is to avoid parsing the MADT multiple times:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/340267.html
> 
> Those can be extensions to the current patchset (because basically
> they are not real issues at present), it is just a heads-up.

I'll see if I can whip that up by the end of the week - the PMU stuff is
definitely interesting.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
