From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 18 Jul 2016 16:48:40 +0100
Subject: [PATCH v9 2/7] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
In-Reply-To: <1500653.yRCxZC8x7Y@vostro.rjw.lan>
References: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
 <1467997678-7107-3-git-send-email-sudeep.holla@arm.com>
 <1500653.yRCxZC8x7Y@vostro.rjw.lan>
Message-ID: <578CFA58.404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/07/16 01:32, Rafael J. Wysocki wrote:
> On Friday, July 08, 2016 06:07:53 PM Sudeep Holla wrote:
>> ACPI 6.0 introduced an optional object _LPI that provides an alternate
>> method to describe Low Power Idle states. It defines the local power
>> states for each node in a hierarchical processor topology. The OSPM can
>> use _LPI object to select a local power state for each level of processor
>> hierarchy in the system. They used to produce a composite power state
>> request that is presented to the platform by the OSPM.
>>
>> Since multiple processors affect the idle state for any non-leaf hierarchy
>> node, coordination of idle state requests between the processors is
>> required. ACPI supports two different coordination schemes: Platform
>> coordinated and  OS initiated.
>>
>> This patch adds initial support for Platform coordination scheme of LPI.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/acpi/bus.c              |  14 +-
>>   drivers/acpi/processor_driver.c |   2 +-
>>   drivers/acpi/processor_idle.c   | 468 +++++++++++++++++++++++++++++++++++-----
>>   include/acpi/processor.h        |  24 ++-
>>   include/linux/acpi.h            |   4 +
>>   5 files changed, 452 insertions(+), 60 deletions(-)
>>

[...]

>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index ca0de35d1c3a..98e8c62a961c 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c

[....]

>> +static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
>> +{
>> +	int ret, i;
>> +	struct acpi_lpi_states_array *info;
>> +	struct acpi_device *d = NULL;
>> +	acpi_handle handle = pr->handle, pr_ahandle;
>> +	acpi_status status;
>> +
>> +	if (!osc_pc_lpi_support_confirmed)
>> +		return -EOPNOTSUPP;
>> +
>> +	max_leaf_depth = 0;
>> +	if (!acpi_has_method(handle, "_LPI"))
>> +		return -EINVAL;
>> +	flat_state_cnt = 0;
>> +
>> +	while (ACPI_SUCCESS(status = acpi_get_parent(handle, &pr_ahandle))) {
>> +		acpi_bus_get_device(pr_ahandle, &d);
>> +		handle = pr_ahandle;
>> +
>> +		if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
>> +			break;
>> +
>> +		if (!acpi_has_method(pr_ahandle, "_LPI"))
>> +			break;
>> +
>> +		max_leaf_depth++;
>> +	}
>> +
>> +	info = kcalloc(max_leaf_depth + 1, sizeof(*info), GFP_KERNEL);
>> +	if (!info)
>> +		return -ENOMEM;
>> +
>> +	pr_ahandle = pr->handle;
>> +	for (i = max_leaf_depth; i >= 0 && ACPI_SUCCESS(status); i--) {
>> +		handle = pr_ahandle;
>> +		ret = acpi_processor_evaluate_lpi(handle, info + i);
>> +		if (ret)
>> +			break;
>> +
>> +		status = acpi_get_parent(handle, &pr_ahandle);
>> +	}
>> +
>> +	/* flatten all the LPI states in the entire hierarchy */
>> +	flatten_lpi_states(pr, info, NULL, max_leaf_depth);
>> +
>
> The above code doesn't look particularly straightforward and it seems to be
> using more memory than necessary.
>
> For instance, you don't need to store the acpi_processor_evaluate_lpi() data
> for all levels at the same time.  It only needs to be stored for the current
> level and you need a list of states enabling the ones at the current from
> the previous one.  Plus the current list of effective states available to the
> CPU.
>

Agreed with all the comments and fixed locally except this one. This
approach considered one leaf node and searched till the root each time.
To save memory we need to complete one level at a time. I am making
changes for this now but make require more testing with all combinations.

> It also should check the upper bound of pr->power.lpi_states[] somewhere which
> it doesn't do AFAICS.
>

Fixed now

-- 
Regards,
Sudeep
