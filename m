From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 20 Feb 2014 11:59:37 +0800
Subject: [PATCH v5 3/5] ACPI / processor: Introduce map_gic_id() to get
 apic id from MADT or _MAT method
In-Reply-To: <5304C0C4.3080601@arm.com>
References: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org>
 <1392740638-2479-4-git-send-email-hanjun.guo@linaro.org>
 <5304C0C4.3080601@arm.com>
Message-ID: <53057DA9.3010307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

Thanks for your comments, please refer to the replies below. :)

On 2014?02?19? 22:33, Sudeep Holla wrote:
> Hi Hanjun,
>
> On 18/02/14 16:23, Hanjun Guo wrote:
>> Get apic id from MADT or _MAT method is not implemented on arm/arm64,
>> and ACPI 5.0 introduces GIC Structure for it, so this patch introduces
>> map_gic_id() to get apic id followed the ACPI 5.0 spec.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/acpi/processor_core.c |   26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
>> index 4dcf776..d316d9b 100644
>> --- a/drivers/acpi/processor_core.c
>> +++ b/drivers/acpi/processor_core.c
>> @@ -71,6 +71,27 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
>>   	return 0;
>>   }
>>   
>> +static int map_gic_id(struct acpi_subtable_header *entry,
>> +		int device_declaration, u32 acpi_id, int *apic_id)
>> +{
>> +	struct acpi_madt_generic_interrupt *gic =
>> +		(struct acpi_madt_generic_interrupt *)entry;
>> +
>> +	if (!(gic->flags & ACPI_MADT_ENABLED))
>> +		return -ENODEV;
>> +
>> +	/* In the GIC interrupt model, logical processors are
>> +	 * required to have a Processor Device object in the DSDT,
>> +	 * so we should check device_declaration here
>> +	 */
>> +	if (device_declaration && (gic->uid == acpi_id)) {
>> +		*apic_id = gic->gic_id;
> I have mentioned this earlier, it's not clear yet to me how does this work ?
> It needs more clarity in the form of comment here at-least as the ACPIv5.0 is
> also not so clear or explicit on how to handle this.

Yes, I noticed your comments and had a reply for that, after a
long consideration for this, I would withdraw my previous comments
before, please refer to the comments below.

>
> Here you are expecting gic->uid = acpi_id which is fine, while acpi_map_cpuid
> matches apic_id with cpu_physical_id(which must be MPIDR in ARM{32,64}). The
> latter imposes restriction that gic->gic_id has to be MPIDR. Does that mean we
> are imposing restriction on GIC ID to be MPIDR ? If so please document it here
> and please explain the reason behind that choice.

On x86 and IA64, APIC/SAPIC ID is the hardware id of the logical
processor, and UID is just a unique ID to identify the processor in DSDT, it
can be any value, and even can be strings defined in ASL if I remember
that correctly.

The processor driver also follows that guidance now, and GIC structure 
in MADT
actually represents a processor (GICC) in the system, so I would let
gic->gic_id as MPIDR(processor hardware ID) for now to avoid confusions
and keep consistency with current ACPI driver.

UID can be any value and it depends on implementation, so it can be MPIDR
also, it will not conflict with GIC ID and can works fine in acpi processor
driver now.

>
> I would expect _UID to be MPIDR rather than GIC ID but you may have some reasons
> for this choice.

I think they both can be MPIDR for now, is this ok to you?

we can update the code when the new ACPI spec is coming out if there
is a clear explanation for GIC ID and UID in GIC structures, does this make
sense to you?

Thanks
Hanjun
