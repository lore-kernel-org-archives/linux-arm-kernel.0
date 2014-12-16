From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 16 Dec 2014 15:48:42 +0000
Subject: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
In-Reply-To: <9355623.14GfrLxEB0@wuerfel>
References: <548F9668.6080900@linaro.org>
 <9355623.14GfrLxEB0@wuerfel>
Message-ID: <20141216154842.GI19412@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

[...]

> > 6. How does the kernel handle_DSD usage?
> >    * Problem:
> >      * _DSD defines key-value properties in the DT style. How do we
> >        ensure _DSD bindings are well defined?
> >      * How do we ensure DT and _DSD bindings remain consistent with
> >        each other?
> >    * Solution: public documentation for all bindings, and a process
> >      for defining them
> >    * Status: proposal to require patch authors to point at public
> >      binding documentation; kernel Documentation/devicetree/bindings
> >      remains the default if no other location exists; UEFI forum has
> >      set up a binding repository.
> 
> I think we also need to make a decision here on whether we want to use
> PRP0001 devices on ARM64 servers, and to what degree. I would prefer
> if we could either make them required for any devices that already have
> a DT binding and that are not part of the official ACPI spec, or we
> decide to not use them at all and make any PRP0001 usage a testcase
> failure.

I am rather concerned about the relationship between items described
with _DSD and ACPI's existing device model. Describing the relationship
between devices and their input clocks, regulators, and so on defeats
much of the benefit ACPI is marketed as providing w.r.t. abstraction of
the underlying platform (and as Arnd mentioned above, that's not the
kind of platform we want to support with ACPI).

I have not seen good guidelines on the usage of _DSD in that respect,
and I'm worried we'll end up with clock controllers half-owned by AML
and half-owned by the kernel's clock framework, and this separation
varying from board to board (and FW revision to FW revision). I think
that needs to be clarified at the ACPI spec level in addition to
anything we have in the kernel documentation.

I'm still of the opinion that conflating _DSD and DT is a bad idea.

Mark.
