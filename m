From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 08 Sep 2015 10:57:57 +0100
Subject: [PATCH 1/5] acpi: Add basic device probing infrastructure
In-Reply-To: <2194763.hsLfaM94lK@vostro.rjw.lan>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
 <1441386412-8139-2-git-send-email-marc.zyngier@arm.com>
 <2194763.hsLfaM94lK@vostro.rjw.lan>
Message-ID: <55EEB125.1030708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/15 22:29, Rafael J. Wysocki wrote:
> On Friday, September 04, 2015 06:06:48 PM Marc Zyngier wrote:
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
> 
> What about things that are provided by the ACPI namespace (eg. via _MAT) rather
> than in static tables?

By the time we get to process non-static tables, the whole probing
infrastructure (including the ACPI interpreter) should be up and
running. I'm not seeing this stuff as a replacement for more dynamic
things - quite the opposite. It is only to be used for early bring-up.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
