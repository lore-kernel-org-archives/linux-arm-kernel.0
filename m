From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Nov 2013 17:19:39 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119152157.GO5914@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <201311191505.33636.arnd@arndb.de>
 <20131119152157.GO5914@e106331-lin.cambridge.arm.com>
Message-ID: <201311191719.39788.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 November 2013, Mark Rutland wrote:
> On Tue, Nov 19, 2013 at 02:05:33PM +0000, Arnd Bergmann wrote:
> > > As mentioned above, I think that the work to do this is going to end up
> > > as a weird ARM-specific legacy feature. We will get something wrong here
> > > in a way that we have to support long-term. I would rather support
> > > solely DT or solely ACPI at runtime (with a kernel supporting both),
> > > rather than a mixture of both forever due to an artifact of the
> > > development process.
> > 
> > I think that depends on how whether you expect ACPI to succeed in the market
> > or not. If it ends up being a historic sidenote, that's what the code
> > should be.
> > A precedent for this would be mach-shark, which we just removed. It
> > was one of the original StrongARM machines and actually came with Open
> > Firmware and a DT that was (rightfully so) converted to ATAGS format
> > on boot.
> 
> From the looks of the removed arch/arm/boot/compressed/ofw-shark.c, the
> converter only converted /memory, /chosen/bootargs, and /banner-name.
> That's far less complex than converting an arbitrary ACPI table, and far
> less likely to hold subtle quirks that vendors will begin relying on in
> their firmware. It also looks like it could have been factored out were
> there more OpenFirmware systems.

Right. Of course at the time, things were much simpler in general.

> I think that with ACPI systems the data we would have to convert is
> going to be larger and more varied than that. Given we already have code
> in the kernel for handling ACPI, I believe it would be more valuable to
> leverage that and support ACPI directly in those places which require it

We have code in the kernel to handle power management and a couple of
very specific platform devices on ACPI based x86 and Itanium PCs. We would
use very little of that on ARM, and it doesn't do much of what we need
at the moment. We definitely shouldn't add all that infrastructure to
make it work on ARM just because someone accidentally put four letters into
a requirements document and didn't understand the consequences...

> > > > Also, we can either have some of our better people sort out the ACPI-to-DT
> > > > translation and management, and get it done right, or we can rely on all the
> > > > vendors to get ACPI right in all their drivers. While some of them will,
> > > > I suspect we'll be more successful driving this from a common place. It
> > > > also gives us a place to stick all the fixups for broken firmware,
> > > > since the first generations of ARM servers are bound to have them.
> > > 
> > > This common place is going to end up handling arbitrarily different
> > > idioms in each format (e.g. how GPIOs are represented), and is almost
> > > certainly going to become a sprawling mess. Also having "all the fixups"
> > > in there makes this sound like an every-single-board file, which is
> > > something I think everyone would like to avoid.
> > 
> > I guess if it grows too big, it could be moved into a separate boot loader
> > project and out of the kernel, as we do for the ATAGS-to-DT conversion
> > with the impedence-matcher.
> 
> I think there's a big difference between the impedence matcher and the
> proposed ACPI => DT converter. The impedence matcher maps a well-defined
> unique ID to a binary blob it knows nothing about. The proposed ACPI =>
> DT converter necessarily needs to map differing idioms used to represent
> classes of device, and thus picks up all the domain-specific knowledge
> that would otherwise be part of a particular subsystem (e.g. GPIO), or
> even drivers depending on the granularity of conversion.
> 
> To me it seems that placing this in an external blob is fundamentally
> the wrong way to go. It must necessarily lump together various
> unconnected concerns, and will end up mirroring the structure of Linux
> subsystems and drivers. I think by the time it "grows too big", we've
> already lost, having wasted our time putting something together that
> should have been handled in Linux from the start.

As I said, it really depends on what people actually want to do with
ACPI, and why they want it. I can see some scenarios in which it would
be fairly easy to do the conversion, such as when all the devices are
fixed in the SoC and you just need to map a couple of GPIO lines
or I2C devices. Doing the full conversion of an SoC structure otoh
would be pretty crazy.

> > > > Vendors can standardise of UEFI if they want, but I would much rather
> > > > see them bundle DTB images with their firmware today, than rely on early
> > > > buggy and still-early-on-the-learning-curve ACPI bindings that we then
> > > > have to live with forever.
> > > 
> > > I agree that today a DTB is preferable to an ACPI implementation.
> > > 
> > > I think that mapping from ACPI => DT is less sane than building support
> > > for ACPI, and is not going to help us in the long term.
> > > 
> > > I think that we need to be involved in ACPI from today if we have any
> > > hope of having something sane in future.
> > 
> > I mostly agree, but I think that the decision whether to ignore, translate
> > or implement support for ACPI BIOS implementations depends a lot on
> > what kinds of systems we are going to see and the level of sophistication
> > they put into their firmware.
> > 
> > If we are basically talking about PCs with their x86 CPU removed and
> > an ARM chip put in there, I think an ACPI implementation would be
> > harmless enough. However if we are talking about complex SoCs that just
> > have the same information in ACPI that we have in DT in a different
> > format, we really need to tell the responsible developers that ACPI
> > support for these just won't get merged.
> 
> I mostly agree. However, I'm not so sure on the latter case. If ACPI
> matures support for richer description (as some x86 people are pushing
> for) and it's used in a sane manner, then I don't think we should
> prevent that, especially if the maintenance burden is shared by the
> larger Linux community.

True, I just think that's too many "if"s to build a product roadmap on.
It can turn into that in a couple of years, but anyone building a
complex SoC today is better off assuming it won't come to that IMHO.

	Arnd
