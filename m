From: sherry.hurwitz@amd.com (Hurwitz, Sherry)
Date: Wed, 17 Dec 2014 16:52:25 +0000
Subject: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
In-Reply-To: <20141217160227.GH8942@leverpostej>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
 <20141216154842.GI19412@leverpostej> <5490D042.3060901@linaro.org>
 <20141217160227.GH8942@leverpostej>
Message-ID: <ACC57DAD9FA29445AB3FF28B6500CF4E9610EB7A@satlexdag05.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First, thanks Al for organizing this list and conversation.  AMD is committed to helping with this effort.  We welcome feedback on our document and table entries.  Also, I see the following as areas that we can help the most: 3,4,5,7,8.  As far as 7.  Why ACPI?, it is clear for us -  the customers we are talking to are requiring it from us.

Thanks,
Sherry
> -----Original Message-----
> From: linaro-acpi-bounces at lists.linaro.org [mailto:linaro-acpi-
> bounces at lists.linaro.org] On Behalf Of Mark Rutland
> Sent: Wednesday, December 17, 2014 10:02 AM
> To: Al Stone
> Cc: Arnd Bergmann; linaro-acpi at lists.linaro.org; Catalin Marinas; Rafael J.
> Wysocki; ACPI Devel Mailing List; Olof Johansson; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
> 
> On Wed, Dec 17, 2014 at 12:37:22AM +0000, Al Stone wrote:
> > On 12/16/2014 08:48 AM, Mark Rutland wrote:
> > >>> 4. Set clear expectations for those providing ACPI for use with Linux
> > >>>    * Problem:
> > >>>      * Hardware/Firmware vendors can and will create ACPI tables that
> > >>>        cannot be used by Linux without some guidance
> > >>>      * Kernel developers cannot determine whether the kernel or firmware
> > >>>        is broken without knowing what the firmware should do
> > >>>    * Solution: document the expectations, and iterate as needed.
> > >>>      Enforce when we must.
> > >>>    * Status: initial kernel text available; AMD has offered to make
> > >>>      their guidance document generic; firmware summit planned for
> > >>>      deeper discussions.
> > >>
> > >> After seeing the AMD patches, I would add to this point that we
> > >> need to find a way to come up with shared bindings for common
> > >> hardware such as the ARM pl011/pl022/pl061/pl330 IP blocks or the
> > >> designware i2c/spi/usb3/ahci blocks.
> > >>
> > >> What I remember from this item on your list is actually a different
> > >> problem: We need to define more clearly what kinds of machines we
> > >> would expect ACPI support for and which machines we would not.
> > >>
> > >> Fine-grained clock support is one such example: if anybody needs to
> > >> expose that through a clock driver in the kernel, we need to be
> > >> very clear that we will not support that kind of machine through
> > >> ACPI, so we don't get developers building BIOS images that will
> > >> never be supported. Other examples would be non-compliant PCI hosts
> > >> or machines that are not covered by SBSA.
> > >
> > > [...]
> > >
> > >>> 6. How does the kernel handle_DSD usage?
> > >>>    * Problem:
> > >>>      * _DSD defines key-value properties in the DT style. How do we
> > >>>        ensure _DSD bindings are well defined?
> > >>>      * How do we ensure DT and _DSD bindings remain consistent with
> > >>>        each other?
> > >>>    * Solution: public documentation for all bindings, and a process
> > >>>      for defining them
> > >>>    * Status: proposal to require patch authors to point at public
> > >>>      binding documentation; kernel Documentation/devicetree/bindings
> > >>>      remains the default if no other location exists; UEFI forum has
> > >>>      set up a binding repository.
> > >>
> > >> I think we also need to make a decision here on whether we want to
> > >> use
> > >> PRP0001 devices on ARM64 servers, and to what degree. I would
> > >> prefer if we could either make them required for any devices that
> > >> already have a DT binding and that are not part of the official
> > >> ACPI spec, or we decide to not use them at all and make any PRP0001
> > >> usage a testcase failure.
> > >
> > > I am rather concerned about the relationship between items described
> > > with _DSD and ACPI's existing device model. Describing the
> > > relationship between devices and their input clocks, regulators, and
> > > so on defeats much of the benefit ACPI is marketed as providing
> > > w.r.t. abstraction of the underlying platform (and as Arnd mentioned
> > > above, that's not the kind of platform we want to support with ACPI).
> >
> > My belief is that all those things should be set up into a known good
> > state by UEFI on initial boot.  If they need to change, say as the
> > result of going into a deeper sleep state or something, that's what
> > the ACPI power management objects are for; Linux would execute one of
> > the ACPI methods already defined by the spec to control transition to
> > the desired state, and that method would have within it the ability to
> > change whatever clocks or regulators it deems necessary.  The kernel
> > should not have to track these things.
> >
> > If someone is describing all those relationships in _DSD, I agree that
> > is not the kind of ARM platform I think we want to deal with.  This is
> > touched on, iirc, in arm-acpi.txt, but apparently too briefly.
> 
> I think we're personally in agreement on the matter. but I'm not sure that's
> true of all involved parties, nor that they are necessarily aware of these issues.
> 
> Some parties only seem to be considering what's documented at the ACPI spec
> level, rather than what's documented in Linux. At that level, these issues are
> not touched upon.
> 
> > > I have not seen good guidelines on the usage of _DSD in that
> > > respect, and I'm worried we'll end up with clock controllers
> > > half-owned by AML and half-owned by the kernel's clock framework,
> > > and this separation varying from board to board (and FW revision to
> > > FW revision). I think that needs to be clarified at the ACPI spec
> > > level in addition to anything we have in the kernel documentation.
> >
> > Hrm.  The spec (section 6.2.5) basically says that there exists a
> > thing called _DSD and that when invoked, it returns a UUID followed by
> > a data structure.  A separate document (on http://www.uefi.org/acpi)
> > for each UUID defines the data structure it corresponds to.  The only
> > one defined so far is for device properties:
> >
> >
> > http://www.uefi.org/sites/default/files/resources/_DSD-implementation-
> > guide-toplevel.htm
> >
> > I think you are suggesting good guidelines for both, yes?  The usage
> > of new UUIDs and data structures, along with the usage of device
> > properties for the UUID we have, right?
> 
> Yes, along with how _DSD interacts with the ACPI device model.
> 
> In the document linked from the document you linked, I spot that GPIOs are
> described with something along the lines of the DT GPIO bindings (though
> using ACPI's own references rather than phandles) and for reasons I've
> described previously and below w.r.t. conflation of DT and _DSD, I'm not a fan.
> 
> I'm not keen on all the linux-specific DT properties being blindly copied into
> _DSD without consideration of their semantics in the context of the rest of the
> device description, nor whether they will be usable by anything other than
> Linux.
> 
> I note that the example in the document also inconsistently uses "linux,retain-
> state-suspended" and "retain-state-suspended", which does not fill me with
> confidence.
> 
> > I've been trying to write such a thing but all I've accomplished so
> > far is throwing away a couple of drafts that got ugly.  I'll keep at
> > it, though.
> >
> > > I'm still of the opinion that conflating _DSD and DT is a bad idea.
> >
> > Could you explain your usage of "conflating" here?  I think I
> > understand what you mean, but I'd rather be sure.
> 
> I believe that the idea that any DT binding should be a _DSD binding with
> common low-level accessors is flawed, as I've mentioned a few times in the
> past.
> 
> I think the two should be treated separately, and that commonalities should be
> handled at a higher level. While this does mean more code, I believe it's more
> manageable and results in a far smaller chance of accidentally exposing items
> as describable in _DSD.
> 
> We made mistakes in the way we bound DT to the driver model and exposed
> certain items unintentionally, and binding _DSD to DT makes the problem
> worse because now we have three not-quite-related sources of information
> masquerading as the same thing, with code authors likely only considering a
> single of these.
> 
> Thanks,
> Mark.
> 
> _______________________________________________
> Linaro-acpi mailing list
> Linaro-acpi at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-acpi
