From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Dec 2014 15:27:07 +0000
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <9355623.14GfrLxEB0@wuerfel>
References: <548F9668.6080900@linaro.org>
 <9355623.14GfrLxEB0@wuerfel>
Message-ID: <20141216152707.GH11565@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 11:27:48AM +0000, Arnd Bergmann wrote:
> On Monday 15 December 2014 19:18:16 Al Stone wrote:
> > TODO List for ACPI on arm64:
> > ============================
> > 1. Define how Aarch64 OS identifies itself to firmware.
> >    * Problem:
> >      * _OSI method is demonstrably unreliable. On x86 Linux claims to
> >        be Windows
> >      * Proposal to use _OSC method as replacement is complicated and
> >        creates an explosion of combinations
> >    * Solution:
> >      * Draft and propose OS identification rules to ABST and ASWG for
> >        inclusion in ACPI spec.
> >      * Draft and propose recommended practice for current ACPI 5.1 spec
> >        platforms.
> >    * Status: Little progress, still under investigation
> 
> I must have missed the problem with _OSC, it sounded like it was good
> enough, but I have no clue about the details.

Neither do I. It's also not entirely clear whether per-device _OSC are
arbitrary or vendors need to go through some kind of approving process
(as with the new _DSD process).

> > 2. Linux must choose DT booting by default when offered both ACPI and
> >    DT on arm64
> >    * DONE

I'm fine with this but just a clarification note here. We can't have
acpi=off in the absence of DT because the system may not be able to
report the error (no PC standard with some fixed 8250 port to fall back
to). That's unless we print the error from the EFI_STUB before exiting
boot services (e.g. "No Device Tree and no acpi=on; cannot boot").

> > 4. Set clear expectations for those providing ACPI for use with Linux
> >    * Problem:
> >      * Hardware/Firmware vendors can and will create ACPI tables that
> >        cannot be used by Linux without some guidance
> >      * Kernel developers cannot determine whether the kernel or firmware
> >        is broken without knowing what the firmware should do
> >    * Solution: document the expectations, and iterate as needed.
> >      Enforce when we must.
> >    * Status: initial kernel text available; AMD has offered to make
> >      their guidance document generic; firmware summit planned for
> >      deeper discussions.
> 
> After seeing the AMD patches, I would add to this point that we need to
> find a way to come up with shared bindings for common hardware such as
> the ARM pl011/pl022/pl061/pl330 IP blocks or the designware
> i2c/spi/usb3/ahci blocks.
> 
> What I remember from this item on your list is actually a different
> problem: We need to define more clearly what kinds of machines we
> would expect ACPI support for and which machines we would not.
> 
> Fine-grained clock support is one such example: if anybody needs
> to expose that through a clock driver in the kernel, we need to be
> very clear that we will not support that kind of machine through
> ACPI, so we don't get developers building BIOS images that will
> never be supported. Other examples would be non-compliant PCI
> hosts or machines that are not covered by SBSA.

Another example is SMP booting. The ACPI 5.1 spec mentions the parking
protocol but I can't find a reference to the latest document. In the
meantime, we stick to PSCI.

>From a recent more private discussion I learnt that hardware or firmware
people are not keen on reading a Linux arm-acpi.txt document, probably
thinking it is too Linux specific. The proposal is to (longer term) move
parts of this document (which are not Linux specific) into SBBR or maybe
a new document for run-time requirements. Linux will still keep a
statement about compliance with such documents and other Linux-specific
aspects.

> > 7. Why is ACPI required?
> >    * Problem:
> >      * arm64 maintainers still haven't been convinced that ACPI is
> >        necessary.
> >      * Why do hardware and OS vendors say ACPI is required?
> >    * Status: Al & Grant collecting statements from OEMs to be posted
> >      publicly early in the new year; firmware summit for broader
> >      discussion planned.
> 
> I was particularly hoping to see better progress on this item. It
> really shouldn't be that hard to explain why someone wants this feature.

It's an "industry standard", you shouldn't question any further ;).

-- 
Catalin
