From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 08 Sep 2015 21:01:20 +0800
Subject: [PATCH 1/5] acpi: Add basic device probing infrastructure
In-Reply-To: <55EEB125.1030708@arm.com>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
 <1441386412-8139-2-git-send-email-marc.zyngier@arm.com>
 <2194763.hsLfaM94lK@vostro.rjw.lan> <55EEB125.1030708@arm.com>
Message-ID: <55EEDC20.6050803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2015 05:57 PM, Marc Zyngier wrote:
> On 07/09/15 22:29, Rafael J. Wysocki wrote:
>> On Friday, September 04, 2015 06:06:48 PM Marc Zyngier wrote:
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
>>> A acpi_probe_device_init() is provided, taking an ACPI table
>>> identifier, and iterating over the registered entries.
>>
>> What about things that are provided by the ACPI namespace (eg. via _MAT) rather
>> than in static tables?
>
> By the time we get to process non-static tables, the whole probing
> infrastructure (including the ACPI interpreter) should be up and
> running. I'm not seeing this stuff as a replacement for more dynamic
> things - quite the opposite. It is only to be used for early bring-up.

Yes, this framework is for static tables and used at boot time,
sometimes quite early, which is before acpi_early_init().

But for _MAT (which is used for dynamic device configuration), it's
really a good question, I think _MAT is mainly for CPU hotplug, and
it's not related to this framework (for GIC init and clock source).
To hot add/remove a whole ARM SoC with _MAT, I think we need more
time to make the spec ready first, that's long term work, and agian
it's nothing to do with this infrastructure if I understand correctly :)

Thanks
Hanjun
