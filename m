From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 29 Sep 2015 14:17:37 +0200
Subject: [PATCH v3 1/7] acpi: Add early device probing infrastructure
In-Reply-To: <20150929082906.2cabe51a@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-2-git-send-email-marc.zyngier@arm.com>
 <560A13FC.4080204@linaro.org> <20150929082906.2cabe51a@arm.com>
Message-ID: <560A8161.1060808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/2015 09:29 AM, Marc Zyngier wrote:
> On Tue, 29 Sep 2015 06:30:52 +0200
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>>
>> Hi Marc,
>>
>> On 09/28/2015 04:49 PM, Marc Zyngier wrote:
>>> IRQ controllers and timers are the two types of device the kernel
>>> requires before being able to use the device driver model.
>>>
>>> ACPI so far lacks a proper probing infrastructure similar to the one
>>> we have with DT, where we're able to declare IRQ chips and
>>> clocksources inside the driver code, and let the core code pick it up
>>> and call us back on a match. This leads to all kind of really ugly
>>> hacks all over the arm64 code and even in the ACPI layer.
>>>
>>> In order to allow some basic probing based on the ACPI tables,
>>> introduce "struct acpi_probe_entry" which contains just enough
>>> data and callbacks to match a table, an optional subtable, and
>>> call a probe function. A driver can, at build time, register itself
>>> and expect being called if the right entry exists in the ACPI
>>> table.
>>>
>>> A acpi_probe_device_table() is provided, taking an identifier for
>>> a set of acpi_prove_entries, and iterating over the registered
>>> entries.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>    drivers/acpi/scan.c               | 39 +++++++++++++++++++++++
>>>    include/asm-generic/vmlinux.lds.h | 10 ++++++
>>>    include/linux/acpi.h              | 66 +++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 115 insertions(+)
>>>
>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>> index f834b8c..daf9fc8 100644
>>> --- a/drivers/acpi/scan.c
>>> +++ b/drivers/acpi/scan.c
>>> @@ -1913,3 +1913,42 @@ int __init acpi_scan_init(void)
>>>    	mutex_unlock(&acpi_scan_lock);
>>>    	return result;
>>>    }
>>> +
>>> +static struct acpi_probe_entry *ape;
>>> +static int acpi_probe_count;
>>> +static DEFINE_SPINLOCK(acpi_probe_lock);
>>> +
>>> +static int __init acpi_match_madt(struct acpi_subtable_header *header,
>>> +				  const unsigned long end)
>>> +{
>>> +	if (!ape->subtable_valid || ape->subtable_valid(header, ape))
>>> +		if (!ape->probe_subtbl(header, end))
>>> +			acpi_probe_count++;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
>>> +{
>>> +	int count = 0;
>>> +
>>> +	if (acpi_disabled)
>>> +		return 0;
>>> +
>>> +	spin_lock(&acpi_probe_lock);
>>> +	for (ape = ap_head; nr; ape++, nr--) {
>>> +		if (ACPI_COMPARE_NAME(ACPI_SIG_MADT, ape->id)) {
>>> +			acpi_probe_count = 0;
>>> +			acpi_table_parse_madt(ape->type, acpi_match_madt, 0);
>>
>> Isn't supposed 'acpi_table_parse_madt' to return the count ? and
>> shouldn't the return code be checked ?
>
> acpi_table_madt_parse() returns the count of the entries it has parsed.
> We're interested in the count of entries that have been successfully
> probed. Not quite the same thing.
>
> As for the return code, checking it is highly symbolic, because there
> is no way we can recover from  an error in the ACPI parsing - we're
> dead anyway, as we end up without interrupt controller. I can add a
> WARN_ON(), but I'm not sure more noise will help understanding the
> problem.
>
> There is also the perfectly valid case where ACPI has been forcefully
> disabled (or on arm64, not forcefully enabled). In which case, the
> parsing code will abort early, and there is no reason to scream about
> it.

I see. Thanks for the details.

   - Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
