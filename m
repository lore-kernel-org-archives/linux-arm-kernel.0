From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Dec 2014 12:27:48 +0100
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <548F9668.6080900@linaro.org>
References: <548F9668.6080900@linaro.org>
Message-ID: <9355623.14GfrLxEB0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 December 2014 19:18:16 Al Stone wrote:

> Below is what we currently know about; very brief notes on status are
> included.  The TL;DR versions of the TODO list and the current status
> can be found at:
> 
>    https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI/CoreUpstreamNotes
> 
> and I'll do my best to kept that up to date.
> 
> Thanks.  Any and all feedback is greatly appreciated.

Thanks for keeping the list up to date!

> 
> TODO List for ACPI on arm64:
> ============================
> 1. Define how Aarch64 OS identifies itself to firmware.
>    * Problem:
>      * _OSI method is demonstrably unreliable. On x86 Linux claims to
>        be Windows
>      * Proposal to use _OSC method as replacement is complicated and
>        creates an explosion of combinations
>    * Solution:
>      * Draft and propose OS identification rules to ABST and ASWG for
>        inclusion in ACPI spec.
>      * Draft and propose recommended practice for current ACPI 5.1 spec
>        platforms.
>    * Status: Little progress, still under investigation

I must have missed the problem with _OSC, it sounded like it was good
enough, but I have no clue about the details.

> 2. Linux must choose DT booting by default when offered both ACPI and
>    DT on arm64
>    * DONE
> 
> 3. Linux UEFI/ACPI testing tools must be made available
>    * Problem:
>      * Hardware/Firmware vendors do not have tools to test Linux
>        compatibility.
>      * Common problems go undetected if not tested for.
>    * Solution:
>      * Port FWTS tool and LuvOS distribution to AArch64
>      * Make LuvOS images readily available
>      * Require hardware vendors to actively test against old and new
>        kernels.
>    * Status: LuvOS and FWTS ported to arm64 and running; patches being
>      mainlined; additional test cases being written.

Ah, nice!

> 4. Set clear expectations for those providing ACPI for use with Linux
>    * Problem:
>      * Hardware/Firmware vendors can and will create ACPI tables that
>        cannot be used by Linux without some guidance
>      * Kernel developers cannot determine whether the kernel or firmware
>        is broken without knowing what the firmware should do
>    * Solution: document the expectations, and iterate as needed.
>      Enforce when we must.
>    * Status: initial kernel text available; AMD has offered to make
>      their guidance document generic; firmware summit planned for
>      deeper discussions.

After seeing the AMD patches, I would add to this point that we need to
find a way to come up with shared bindings for common hardware such as
the ARM pl011/pl022/pl061/pl330 IP blocks or the designware
i2c/spi/usb3/ahci blocks.

What I remember from this item on your list is actually a different
problem: We need to define more clearly what kinds of machines we
would expect ACPI support for and which machines we would not.

Fine-grained clock support is one such example: if anybody needs
to expose that through a clock driver in the kernel, we need to be
very clear that we will not support that kind of machine through
ACPI, so we don't get developers building BIOS images that will
never be supported. Other examples would be non-compliant PCI
hosts or machines that are not covered by SBSA.

> 5. Demonstrate the ACPI core patches work
>    * Problem: how can we be sure the patches work?
>    * Solution: verify the patches on arm64 server platforms
>    * Status:
>      * ACPI core works on at least the Foundation model, Juno, APM
>        Mustang, and AMD Seattle
>      * FWTS results will be published as soon as possible

I think the problem is to a lesser degree the verification of the
patches, but to have a patch set that demonstrates /how/ everything
can work, and what the possible limitations are. I would not worry
about any bugs that might keep the system from working properly, as
long as you can show that there is a plan to make that work.

Out of the four platforms you list, I think we have concluded that
three of them are not appropriate for use with ACPI, but in order
to do that, we needed to review the patches and pinpoint specific
issues so we could avoid just exchanging different opinions on the
matter of it "works" or not.

> 6. How does the kernel handle_DSD usage?
>    * Problem:
>      * _DSD defines key-value properties in the DT style. How do we
>        ensure _DSD bindings are well defined?
>      * How do we ensure DT and _DSD bindings remain consistent with
>        each other?
>    * Solution: public documentation for all bindings, and a process
>      for defining them
>    * Status: proposal to require patch authors to point at public
>      binding documentation; kernel Documentation/devicetree/bindings
>      remains the default if no other location exists; UEFI forum has
>      set up a binding repository.

I think we also need to make a decision here on whether we want to use
PRP0001 devices on ARM64 servers, and to what degree. I would prefer
if we could either make them required for any devices that already have
a DT binding and that are not part of the official ACPI spec, or we
decide to not use them at all and make any PRP0001 usage a testcase
failure.

> 7. Why is ACPI required?
>    * Problem:
>      * arm64 maintainers still haven't been convinced that ACPI is
>        necessary.
>      * Why do hardware and OS vendors say ACPI is required?
>    * Status: Al & Grant collecting statements from OEMs to be posted
>      publicly early in the new year; firmware summit for broader
>      discussion planned.

I was particularly hoping to see better progress on this item. It
really shouldn't be that hard to explain why someone wants this feature.

> 8. Platform support patches need review
>    * Problem: the core Aarch64 patches have been reviewed and are in
>      good shape, but there is not yet a good example of server platform
>      support patches that use them.
>    * Solution: Post *good* patches for multiple ACPI platforms
>    * Status: first version for AMD Seattle has been posted to the
>      public linaro-acpi mailing list for initial review (thanks,
>      Arnd), refined versions to be posted to broader lists after a
>      few iterations for basic cleanup

	Arnd
