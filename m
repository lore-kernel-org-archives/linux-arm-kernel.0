From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 11 May 2016 16:06:14 +0100
Subject: [PATCH v4 2/5] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
In-Reply-To: <1857618.TLitUhExSh@vostro.rjw.lan>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-3-git-send-email-sudeep.holla@arm.com>
 <1857618.TLitUhExSh@vostro.rjw.lan>
Message-ID: <57334A66.6070004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/05/16 01:03, Rafael J. Wysocki wrote:
> On Tuesday, April 19, 2016 01:30:10 PM Sudeep Holla wrote:
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
>>   drivers/acpi/bus.c              |  11 +-
>>   drivers/acpi/processor_driver.c |   2 +-
>>   drivers/acpi/processor_idle.c   | 441 +++++++++++++++++++++++++++++++++++-----
>>   include/acpi/processor.h        |  25 ++-
>>   include/linux/acpi.h            |   4 +
>>   5 files changed, 422 insertions(+), 61 deletions(-)
>>
>> Hi Rafael,
>>
>> Yet to be discussed(retained as in from previous version):
>> - Kconfig entry removal: Need feedback on how to deal with that
>>    without having to introduce dummy _CST related ARM64 callbacks
>> - Didn't defer processing of LPI buffers to flattening as it
>>    results in the same buffer decoded multiple times
>> - ACPI_CSTATE_INTEGER : IMO it's reasonable to keep it aroundsince the
>>    it's part of LPI specification(not just ARM FFH)
>
> I'm basically fine with the current set, up to some minor points.
>
> I've sent my comments on patch [1/5] already.
>
> My main concern about the flattening of _LPI is that at one point we'll
> probably decide to unflatten it and that will change the behavior for
> current users.  There needs to be a plan for that IMO.
>

Are you referring the OS co-ordinated mode ? If yes, I agree. If not,
can you explain why would we not flatten the LPI states ?

[...]

>>
>> +struct acpi_processor_lpi_info {
>> +	int state_count;
>> +	struct acpi_processor_lpi *lpix;
>> +};
>
> This is a bit cryptic, especially the name of the lpix field.
>
> I'd do something like
>
> struct acpi_lpi_states_array {
> 	unsigned int size;
> 	struct acpi_lpi_state *entries;
> };
>
> and that is sort of self-documenting.
>

Agreed and that's looks much better.

>> +
>> +static int obj_get_integer(union acpi_object *obj, u32 *value)
>> +{
>> +	if (obj->type != ACPI_TYPE_INTEGER)
>> +		return -EINVAL;
>
> I'd add an empty line here and everywhere where there's only one
> statement after if () or for () etc.
>
> You've done that in some places IIRC, but please stick to one convention
> everywhere.
>

I have taken all the review comments and fixed them as suggested.

[...]

>> +
>> +	for (i = 0; i < fl_scnt && i < CPUIDLE_STATE_MAX; i++) {
>> +		lpi = &pr->power.lpi_states[i];
>> +
>> +		state = &drv->states[i];
>> +		snprintf(state->name, CPUIDLE_NAME_LEN, "LPI-%d", i);
>> +		strlcpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
>> +		state->exit_latency = lpi->wake_latency;
>> +		state->target_residency = lpi->min_residency;
>> +		if (lpi->arch_flags)
>> +			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
>> +		state->enter = acpi_idle_lpi_enter;
>
> No ->enter_freeze ?
>

I don't have a system to test this. Also IIUC the cpuidle does support
suspend-to-idle even when ->enter_freeze is not implemented right.
Can we add it later once I find a way to test. Correctly no wakeup on my
test platform :(

>>
>> +struct acpi_processor_lpi {
>
> As I said above, I'd call this
>
> struct acpi_lpi_state {
>
> because (a) it represents a state and (b) that doesn't have to be a state
> of a processor.
>

Agreed, that's mainly copy paste from _CST which calls it
acpi_processor_cx :)

-- 
-- 
Regards,
Sudeep
