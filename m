From: james.morse@arm.com (James Morse)
Date: Fri, 19 Jan 2018 15:16:37 +0000
Subject: [PATCH v1] EDAC, armv8: Add Cache Error Reporting driver for
 ARMv8 processors
In-Reply-To: <6c3d84bd102d49aa78591caa5adf7bfc@codeaurora.org>
References: <1515804626-21254-1-git-send-email-kyan@codeaurora.org>
 <20180115144441.d6dlwl7herq24byv@lakrids.cambridge.arm.com>
 <3d3da849d32b1a674d1bcd560eeba261@codeaurora.org> <5A5DF9F4.90101@arm.com>
 <6c3d84bd102d49aa78591caa5adf7bfc@codeaurora.org>
Message-ID: <5A620BD5.9030205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kyle,

On 18/01/18 01:19, Kyle Yan wrote:
> On 2018-01-16 05:11, James Morse wrote:
>> On 16/01/18 01:00, Kyle Yan wrote:
>>> On 2018-01-15 06:44, Mark Rutland wrote:
>>>> On Fri, Jan 12, 2018 at 04:50:26PM -0800, Kyle Yan wrote:
>>>>> Interrupt based EDAC driver for ARMv8 processors that implement
>>>>> RAS for error detection of CPU caches and lso allows optional polling
>>>>> of error syndrome registers if interrupts are not supported.
>>>>
>>>> Is this using the architectural RAS extensions, or something specific to
>>>> QC CPUs? It would be good to call this out explicitly.
>>>>
>>>> If it's the latter, this needs rewording to be clear that this is
>>>> specific to QC CPUs, and is not a generic ARMv8 feature.
>>
>>> This is not specific to QC CPUs and looks at the system registers defined by the
>>> RAS extensions.

[...]

>>>>> diff --git a/drivers/edac/armv8_edac.c b/drivers/edac/armv8_edac.c
>>>>> new file mode 100644

>>>>> +static void init_regs_on_cpu(bool all_cpus)

[...]

>>>>> +    write_errselr_el1(1);
>>>>> +    initialize_registers(NULL);
>>
>> You seem to magically-know that this 'record 1' is shared between all CPUs and
>> visible via the cpu interface.
>>
> Yes this portion (and coming to the realization that a lot of other parts) of the
> code is specific to our topology. Is there any way to detect this?

No, we are going to need DT/ACPI data to tell us the topology.

To know if a record is shared or CPU-private, we have the ERRDEVAFF 'Device
Affinity Register', but this is only accessible via the memory-map, which also
groups records by node/device. DT/ACPI will have to tell us where the entries in
the memory-map are.

Pairing up memory-map node/devices with indexes in the cpu interface registers
is something I'm currently trying to get my head around.


> ERRIDR reports
> how many records there are but not what each record is for. Without this
> information,
> not sure how there could be a generic interrupt based driver.

Which interrupts a node/device generates (and how) is another piece of per
node/device data we need.

Do we need to know what sort of node/device the records are for in advance?

We will probably need some infrastructure to parse the DT/ACPI tables and enable
and register the appropriate interrupts. I would like any kernel-first
external-abort RAS code to have a list of the nodes that generate 'in band'
notifications, so we don't have to walk them all. If we can know the
cpu-affinity, we can make the list shorter and per-cpu.

Once we have that infrastructure, a driver can register to handle the
architected cache errors. We don't need to know what sort of records a
node/device generates until one shows up. (I assume caches can also generate
timeouts and bus errors).

I think you need to know the record types in advance because you are polling
those records. I can't see a way of determining which node/devices are caches,
so if we need this information, it will have to come from ACPI/DT.


[ ...]

> I should probably amend a previous statement about this all being defined in
> RAS. Didn't realize this initially
> but as you have mentioned, even though the registers are architected, the
> decoding/bits within the registers are
> implementation defined.
> So within the driver, some of the "magically known"
> values are because as it is right now,
> the decodings and some behavior is specific to our implementation.

(as is the toplogy), this is why its preferable to have this in firmware, and
use something like APEI.

Your level and way parameters aren't architected, does the edac driver do
anything other than print these out?

I don't see how software can avoid using way-6 in L1, all it can do is watch the
(architected) error counter and decide 'too much!' at some threshold. Future
smarts could let us offline the affected CPUs, for which we would need to know
the affinity of the device/node that generates these records. (which we have,
from the memory map).


> To more generalize this, would it be better to (after checking the IDR/FR
> registers) to instead just dump out the
> ERRXSTATUS/ERRXMISC directly, and then have registered callbacks to actually
> properly decode the values into something more readable?

I'm not convinced we need the impdef values, we can't do anything with the
information.
If we have some infrastructure for the users of these RAS ERR-registers/nodes
and drivers can register to monitor classes of error, then we've kept the door
open for SoC-specific compatibles for drivers to poke around in the impdef parts
of the registers if it turns out to be necessary.

This infrastructure would also lets us poke the edac driver for cache-errors for
in-band signalled errors.


Thanks,

James
