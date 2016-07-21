From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 21 Jul 2016 16:55:27 +0100
Subject: [PATCH v10 2/7] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
In-Reply-To: <21001224.LAfp2rRWeu@vostro.rjw.lan>
References: <1468950779-21745-1-git-send-email-sudeep.holla@arm.com>
 <1468950779-21745-3-git-send-email-sudeep.holla@arm.com>
 <21001224.LAfp2rRWeu@vostro.rjw.lan>
Message-ID: <8b69bd1a-a729-cca4-43f1-84ff4de111a4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/07/16 14:34, Rafael J. Wysocki wrote:
> On Tuesday, July 19, 2016 06:52:54 PM Sudeep Holla wrote:
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
>>  drivers/acpi/bus.c              |  14 +-
>>  drivers/acpi/processor_driver.c |   2 +-
>>  drivers/acpi/processor_idle.c   | 462 +++++++++++++++++++++++++++++++++++-----
>>  include/acpi/processor.h        |  24 ++-
>>  include/linux/acpi.h            |   4 +
>>  5 files changed, 446 insertions(+), 60 deletions(-)
>>
>
> [cut]
>
>> +static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
>> +{
>> +	int ret, i;
>> +	acpi_status status;
>> +	acpi_handle handle = pr->handle, pr_ahandle;
>> +	struct acpi_device *d = NULL;
>> +	struct acpi_lpi_states_array info[2], *tmp, *prev, *curr;
>> +
>> +	if (!osc_pc_lpi_support_confirmed)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!acpi_has_method(handle, "_LPI"))
>> +		return -EINVAL;
>> +
>> +	flat_state_cnt = 0;
>> +	prev = &info[0];
>> +	curr = &info[1];
>> +	handle = pr->handle;
>> +	ret = acpi_processor_evaluate_lpi(handle, prev);
>> +	if (ret)
>> +		return ret;
>> +	flatten_lpi_states(pr, prev, NULL);
>> +
>> +	while (ACPI_SUCCESS(status = acpi_get_parent(handle, &pr_ahandle))) {
>
> I should have mentioned that earlier, but forgot, sorry about that.
>
> Assignments under while () etc are generally discouraged as (a) error-prone
> and (b) confusing to static analysis tools.
>
> So I'd do
>
> 	status = acpi_get_parent(handle, &pr_ahandle);
> 	while (ACPI_SUCCESS(status)) {
>

Sure, will update accordingly.

>> +		acpi_bus_get_device(pr_ahandle, &d);
>> +		handle = pr_ahandle;
>> +
>> +		if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
>> +			break;
>> +
>> +		/* can be optional ? */
>> +		if (!acpi_has_method(handle, "_LPI"))
>> +			break;
>> +
>> +		ret = acpi_processor_evaluate_lpi(handle, curr);
>> +		if (ret)
>> +			break;
>> +
>> +		/* flatten all the LPI states in this level of hierarchy */
>> +		flatten_lpi_states(pr, curr, prev);
>> +
>> +		tmp = prev, prev = curr, curr = tmp;
>
>
> 		status = acpi_get_parent(handle, &pr_ahandle);
>> +	}
>> +
>

OK

> Apart from this the patch looks OK to me, so please only update this one
> and I'll queue up the series.
>

Thanks, will do it shortly.

Also I found a bug in my testing creating some fake tables to test this
non-recursive logic. I have missed a pointer update in the inner loop. I
will include the below one liner in the update.


-->8

diff --git i/drivers/acpi/processor_idle.c w/drivers/acpi/processor_idle.c
index fced1df535bd..c8800b55268d 100644
--- i/drivers/acpi/processor_idle.c
+++ w/drivers/acpi/processor_idle.c
@@ -1142,6 +1142,7 @@ static int flatten_lpi_states(struct 
acpi_processor *pr,
                             combine_lpi_states(p, t, flpi)) {
                                 stash_composite_state(curr_level, flpi);
                                 flat_state_cnt++;
+                               flpi++;
                         }
                 }
         }

-- 
Regards,
Sudeep
