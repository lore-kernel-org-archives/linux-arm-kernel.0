From: al.stone@linaro.org (Al Stone)
Date: Mon, 13 Jan 2014 15:46:58 -0700
Subject: [PATCH v6 4/6] ACPI: in HW reduced mode, using FADT PM information
 is not allowed.
In-Reply-To: <4248842.kTIlfoGImy@vostro.rjw.lan>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
 <1389394340-2680-5-git-send-email-al.stone@linaro.org>
 <4248842.kTIlfoGImy@vostro.rjw.lan>
Message-ID: <52D46CE2.8020300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2014 04:31 PM, Rafael J. Wysocki wrote:
> On Friday, January 10, 2014 03:52:18 PM al.stone at linaro.org wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> Per the ACPI 5.0 specification, section 5.2.9, none of the power
>> management fields in the FADT are to be used.  Short-circuit using
>> any of those fields in acpi_processor_get_power_info_fadt().
>
> So the spec says that we're supposed to ignore the information in
> certain FADT fields if the HW_REDUCED_ACPI flag is set.
>
> However, what about systems in which that information is actually
> valid even though HW_REDUCED_ACPI is set?
>
> Does it break things if we attempt to use that information?

The way I see it in the spec, we just don't use that info _if_ we wish
to remain compliant with the spec.  If we insist on using it anyway, we
can't say we're implementing hardware reduced mode correctly.  That
being said, from my read of the code it appears things would operate
the same as they did before if this part of the spec was ignored _and_
the info in the tables was still valid (same control register addresses
and content and so on).

>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/processor_idle.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index eac984a..89f0a0f 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -270,6 +270,14 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
>>   	if (!pr->pblk)
>>   		return -ENODEV;
>>
>> +	/*
>> +	 * Using power management information from the FADT is not
>> +	 * allowed when in HW reduced mode.  See ACPI 5.0, section
>> +	 * 5.2.9.
>> +	 */
>> +	if (acpi_gbl_reduced_hardware)
>> +		return -ENODEV;
>> +
>>   	/* if info is obtained from pblk/fadt, type equals state */
>>   	pr->power.states[ACPI_STATE_C2].type = ACPI_STATE_C2;
>>   	pr->power.states[ACPI_STATE_C3].type = ACPI_STATE_C3;
>>
>


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
