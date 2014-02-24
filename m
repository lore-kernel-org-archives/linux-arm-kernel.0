From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 24 Feb 2014 14:48:13 +0800
Subject: [PATCH v5 3/5] ACPI / processor: Introduce map_gic_id() to get
 apic id from MADT or _MAT method
In-Reply-To: <d2ad8ee5d9a7875fe121a30beb8d2e8c@www.loen.fr>
References: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org>
 <1392740638-2479-4-git-send-email-hanjun.guo@linaro.org>
 <5304C0C4.3080601@arm.com> <53057DA9.3010307@linaro.org>
 <5307487F.6000308@arm.com> <53087A0F.6010302@linaro.org>
 <d2ad8ee5d9a7875fe121a30beb8d2e8c@www.loen.fr>
Message-ID: <530AEB2D.6050801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-2-22 19:30, Marc Zyngier wrote:
> On 2014-02-22 10:21, Hanjun Guo wrote:
>> On 2014-2-21 20:37, Sudeep Holla wrote:
>>> Hi Hanjun,
>>>
>>> (Adding MarcZ for his views on GIC)
>>>
>>> On 20/02/14 03:59, Hanjun Guo wrote:
>>>> Hi Sudeep,
>>>>
>>>> Thanks for your comments, please refer to the replies below. :)
>>>>
>>>> On 2014?02?19? 22:33, Sudeep Holla wrote:
>>>>> Hi Hanjun,
>>>>>
>>>>> On 18/02/14 16:23, Hanjun Guo wrote:
>>>>>> Get apic id from MADT or _MAT method is not implemented on arm/arm64,
>>>>>> and ACPI 5.0 introduces GIC Structure for it, so this patch introduces
>>>>>> map_gic_id() to get apic id followed the ACPI 5.0 spec.
>>>>>>
>>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>>> ---
>>>>>>   drivers/acpi/processor_core.c |   26 ++++++++++++++++++++++++++
>>>>>>   1 file changed, 26 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
>>>>>> index 4dcf776..d316d9b 100644
>>>>>> --- a/drivers/acpi/processor_core.c
>>>>>> +++ b/drivers/acpi/processor_core.c
>>>>>> @@ -71,6 +71,27 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
>>>>>>       return 0;
>>>>>>   }
>>>>>>
>>>>>> +static int map_gic_id(struct acpi_subtable_header *entry,
>>>>>> +        int device_declaration, u32 acpi_id, int *apic_id)
>>>>>> +{
>>>>>> +    struct acpi_madt_generic_interrupt *gic =
>>>>>> +        (struct acpi_madt_generic_interrupt *)entry;
>>>>>> +
>>>>>> +    if (!(gic->flags & ACPI_MADT_ENABLED))
>>>>>> +        return -ENODEV;
>>>>>> +
>>>>>> +    /* In the GIC interrupt model, logical processors are
>>>>>> +     * required to have a Processor Device object in the DSDT,
>>>>>> +     * so we should check device_declaration here
>>>>>> +     */
>>>>>> +    if (device_declaration && (gic->uid == acpi_id)) {
>>>>>> +        *apic_id = gic->gic_id;
>>>>> I have mentioned this earlier, it's not clear yet to me how does this work ?
>>>>> It needs more clarity in the form of comment here at-least as the ACPIv5.0 is
>>>>> also not so clear or explicit on how to handle this.
>>>>
>>>> Yes, I noticed your comments and had a reply for that, after a
>>>> long consideration for this, I would withdraw my previous comments
>>>> before, please refer to the comments below.
>>>>
>>>>>
>>>>> Here you are expecting gic->uid = acpi_id which is fine, while acpi_map_cpuid
>>>>> matches apic_id with cpu_physical_id(which must be MPIDR in ARM{32,64}). The
>>>>> latter imposes restriction that gic->gic_id has to be MPIDR. Does that mean we
>>>>> are imposing restriction on GIC ID to be MPIDR ? If so please document it here
>>>>> and please explain the reason behind that choice.
>>>>
>>>> On x86 and IA64, APIC/SAPIC ID is the hardware id of the logical
>>>> processor, and UID is just a unique ID to identify the processor in DSDT, it
>>>> can be any value, and even can be strings defined in ASL if I remember
>>>> that correctly.
>>>>
>>> OK, but that's not the case on ARM{32,64}. My main concern here is if we don't
>>> make this definitions clear enough, the vendors might produce ACPI tables with
>>> whatever suits them and we may end up supporting them. Since we are starting
>>> with clean slate, we can avoid getting into such situations. I will be to be
>>> more elaborate this time.
>>
>> I agree.
>>
>>>
>>> The GIC ID is referred as the local GIC?s hardware ID in ACPIv5.0.
>>> IIUC, since GICC is per-cpu entry, it has to GIC CPU interface ID.
>>>
>>> Now how does it differ from MPIDR ? e.g. ARM TC2(multi cluster system)
>>>     GIC ID        MPIDR            Comment
>>>     0        0x000            CA15_0
>>>     1        0x001            CA15_1
>>>     2        0x100            CA7_0
>>>     3        0x101            CA7_1
>>>     4        0x102            CA7_2
>>
>> Yes, obvious different. I know GIC ID can matche the bit index of the
>> associated processor
>> in the distributor's GICD_ITARGETSR register, and it a clear
>> statement in GICv1/GICv2, my
>> question is that is this consistent in GICv3/v4 too? this will have
>> some impact on the
>> code implementation.
> 
> For GICv3/v4, the only way you can match a CPU with its local redistributor is by using the CPU MPIDR. The GIC CPU ID is an implementation choice that may not exist (it doesn't in a distributed
> implementation), so anything that relies on a GIC CPU ID is broken for GICv3.

So that's the broken part, it seems that GIC ID is useless both
in GICv1/v2 and GICv3/v4 if it represents GIC CPU interface ID,
the only reliable one is the MPIDR.

I agree UID should be MPIDR for future usage, so how about this solution:

+static int map_gic_id(struct acpi_subtable_header *entry,
+		int device_declaration, u32 acpi_id, int *apic_id)
+{
+	struct acpi_madt_generic_interrupt *gic =
+		(struct acpi_madt_generic_interrupt *)entry;
+
+	if (!(gic->flags & ACPI_MADT_ENABLED))
+		return -ENODEV;
+
+	/* In the GIC interrupt model, logical processors are
+	 * required to have a Processor Device object in the DSDT,
+	 * so we should check device_declaration here
+	 */
+	if (device_declaration && (gic->uid == acpi_id)) {
		/*
		 * this is the special case for ARM/ARM64, gic->uid
		 * should be MPIDR which represents the CPU hardware
		 * id, so use gic->uid instead of gic->gic_id here
		 * to get the physical processor ID. (...)
		 */
+		*apic_id = gic->uid;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+

Thanks
Hanjun
