From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Nov 2013 15:05:33 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
Message-ID: <201311191505.33636.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 November 2013, Mark Rutland wrote:
> On Fri, Nov 15, 2013 at 05:52:41PM +0000, Olof Johansson wrote:
> > On Fri, Nov 15, 2013 at 09:57:17AM +0000, Mark Rutland wrote:

> > Oh wait, there's people who have been doing this for years. Microsoft. They
> > should be the ones driving this and taking the pain for it. Once the platform
> > is enabled for their needs, we'll sort it out at our end. After all, that has
> > worked reasonably well for x86 platforms.
> 
> I'm not sure it's entirely reasonable to assume that Microsoft will
> swoop in and develop standards that are useful to us or even applicable
> to the vast majority of the systems that are likely to exist. If they
> do, then we will (by the expectation that Linux should be able to run
> wherever another OS can) have to support whatever standards they may
> create.

That company is undergoing a lot of change now, I think anything is
possible: They might decide that ARM is a really bad idea (after
the Windows-RT fiasco), they could start working together with us
on these problems, or they could do everything in their hands to
make our lives as hard as they can (as before, see
http://www.groklaw.net/articlebasic.php?story=2010011422570951).
 
> Regardless of whether we place support for it into Linux, we should
> certainly be spending time now attempting to understand ACPI, what it
> does and does not provide, and how it can be moved towards something
> that fulfils our needs and we can support long-term. We should certainly
> not be taking a back seat approach.
>
> Outside of the ARM Linux community there is work ongoing to change ACPI
> to better suit the level of variation we seem in the ARM space (see
> Darren Hart's presentation from ELCE [1]). We need to be involved now in
> order to make sure that this is actually generally applicable.

Agreed. I'm not sure who "we" is in this, but I assume you mean the wider
ARM Linux developer community.  Linaro already has full-time developers
working on this, with ties into the UEFI and ACPI standard bodies, and that
is good. Still it does not mean we should prematurely merge any of the
code coming out of it, until there are products out there with ACPI firmware
that is not completely messed up and that is worth supporting in mainline,
considering the maintainance effort.

> I would also expect that _any_ ACPI support we would accept would not
> rely on any board-specific support code whatsoever -- either everything
> comes from ACPI or the platform doesn't boot. If we allow board files
> for a transitionary period to ACPI we'd be making the same mistake we
> did with DT.

I would go further and reject any code that adds an SoC or BIOS vendor
specific glue layer. The bar we have set with the current ARM64 code
and for new ARM32 is that everything is in device drivers of some sort.
I would hate to reintroduce platform directories just because every
company has a different understanding of how to describe the same things
in ACPI, or because ACPI-5.0 is insufficient to describe the SoC and
go back to static platform devices.

> > Once they're done, we'll figure out how to enable new hardware. Sure, someone
> > needs to keep them sane and participate in the standardization process, but we
> > don't have to drag the whole kernel through it.
> 
> To me, reworking the AML code and drivers to support AML + DT feels like
> dragging the whole kernel through it. I would rather see ACPI in full or
> no ACPI than a gigantic ARM-specific set of changes to general
> infrastructure that we'd expect to deprecate in future once we
> understand (the future state of) ACPI.

I'm skeptical about getting AML working on DT nodes, just as I doubt that
AML is sufficient to do what people want when faced with a complex SoC.

Also, if AML ends up being mainly used as a trampoline to get into EL2/EL3
firmware, I'd much rather standardize the actual firmware interfaces
underneath.
 
> As mentioned above, I think that the work to do this is going to end up
> as a weird ARM-specific legacy feature. We will get something wrong here
> in a way that we have to support long-term. I would rather support
> solely DT or solely ACPI at runtime (with a kernel supporting both),
> rather than a mixture of both forever due to an artifact of the
> development process.

I think that depends on how whether you expect ACPI to succeed in the market
or not. If it ends up being a historic sidenote, that's what the code
should be.
A precedent for this would be mach-shark, which we just removed. It
was one of the original StrongARM machines and actually came with Open
Firmware and a DT that was (rightfully so) converted to ATAGS format
on boot.
 
> > Also, we can either have some of our better people sort out the ACPI-to-DT
> > translation and management, and get it done right, or we can rely on all the
> > vendors to get ACPI right in all their drivers. While some of them will,
> > I suspect we'll be more successful driving this from a common place. It
> > also gives us a place to stick all the fixups for broken firmware,
> > since the first generations of ARM servers are bound to have them.
> 
> This common place is going to end up handling arbitrarily different
> idioms in each format (e.g. how GPIOs are represented), and is almost
> certainly going to become a sprawling mess. Also having "all the fixups"
> in there makes this sound like an every-single-board file, which is
> something I think everyone would like to avoid.

I guess if it grows too big, it could be moved into a separate boot loader
project and out of the kernel, as we do for the ATAGS-to-DT conversion
with the impedence-matcher.

> > > I'm not sure the two cases are comparable. The format of the FDT was
> > > designed to encode the data structure used by OpenFirmware, and thus the
> > > two map to each other pretty well. I do not believe that mapping from
> > > ACPI tables to an FDT blob is anywhere near as simple, and as I mention
> > > above I do not believe that we can just copy over the ACPI methods in
> > > isolation.
> >
> > Sorry, I wasn't implying that there's a one-time trivial conversion
> > to be made in the generic case, but it can still be done in a similar
> > manner even though it will be more complex.
> 
> Until I see code, I'm going to remain of the opinion that this is
> unworkable without embedding knowledge of every separate subsystem
> (GPIO, IRQ, etc) into a single place. That seems worse to me than
> teaching those subsystems to deal with the different information
> sources.

Agreed.

> > Vendors can standardise of UEFI if they want, but I would much rather
> > see them bundle DTB images with their firmware today, than rely on early
> > buggy and still-early-on-the-learning-curve ACPI bindings that we then
> > have to live with forever.
> 
> I agree that today a DTB is preferable to an ACPI implementation.
> 
> I think that mapping from ACPI => DT is less sane than building support
> for ACPI, and is not going to help us in the long term.
> 
> I think that we need to be involved in ACPI from today if we have any
> hope of having something sane in future.

I mostly agree, but I think that the decision whether to ignore, translate
or implement support for ACPI BIOS implementations depends a lot on
what kinds of systems we are going to see and the level of sophistication
they put into their firmware.

If we are basically talking about PCs with their x86 CPU removed and
an ARM chip put in there, I think an ACPI implementation would be
harmless enough. However if we are talking about complex SoCs that just
have the same information in ACPI that we have in DT in a different
format, we really need to tell the responsible developers that ACPI
support for these just won't get merged.

	Arnd
