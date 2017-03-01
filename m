From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 1 Mar 2017 16:27:25 +0800
Subject: [RFC PATCH V1 v4.10-rc3 1/1] acpi: apei: handle GSIV notification
 type
In-Reply-To: <58B579A1.90109@arm.com>
References: <86258A5CC0A3704780874CF6004BA8A62DCAB57E@lhreml502-mbs>
 <58B579A1.90109@arm.com>
Message-ID: <43507f99-d80b-6409-d249-b9b18425a1da@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 2017/2/28 21:22, James Morse wrote:
> Hi Shiju,
>
> On 27/02/17 18:19, Shiju Jose wrote:
>> Add a new GHES error source handling function for
>> GSIV(Global System Interrupt Vector).
>> If an error source's notification type is GSIV,
>> then this handling function can be registered
>> into the GSIV handler and it can parse
>> and report error information when they occur.
>
> I'm missing some of the story here, but how is GSIV different from 'External
> Interrupt'? I'm guessing something other than the CPU takes this 'interrupt'...

Yes, it's the same from CPU side (they are interrupts!), but there
is history behind them and the usage is different.

I think External Interrupt was introduced before ACPI is available on
ARM (hardware reduced platforms), so I guess it was used for errors
reported to OS which were not using SCI mechanism, for example, some
IO error reporting.

For External Interrupt, we don't use the ACPI event system, so for
the firmware, it just report the errors associate with the interrupt
number, the kernel map the interrupt number and install the
irq handler for it.

For GSIV based event, it was introduced for hardware reduced platform
in recent ACPI revision, and ARM64 is one of its consumers. When
errors are reported via GSIV, ACPI event notification needs to be
implemented and requires the platform to define a hardware error device
(PNP0C33) in ACPI namespace, and also a generic event device ACPI0013.

For example, if we are using SPI (ARM GIC) 100 to report errors, there
is a ACPI0013 driver in drivers/acpi/evged.c to register the irq, when
error happened and trigger the interrupt, ACPI0013 driver will
notify the error device (PNP0C33), then error device driver
(drivers/acpi/hed.c) will process the error data form APEI table...

So GSIV is quite different from 'External interrupt' in the way of
working from both firmware and kernel side.

>
>
> The GHES GSIV code below is identical to the behaviour of the SCI Notification
> type... are these two names for the same thing? (I'm confused!)

SCI is also an 'interrupt' but it's a special irq number for ACPI
event, and it has GPE (general purpose event) registers behind it,
which is used only on Intel platforms. SCI based event use
Method(\_GPE._L0x) to notify the error device (PNP0C33), but GSIV
is used for HW-reduced platform which has no GPEs.

Hope it can clarify something :)

Thanks
Hanjun
