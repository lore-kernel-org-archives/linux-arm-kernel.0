From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Nov 2013 11:30:15 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131115175241.GB27174@quad.lixom.net>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
Message-ID: <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 05:52:41PM +0000, Olof Johansson wrote:
> On Fri, Nov 15, 2013 at 09:57:17AM +0000, Mark Rutland wrote:
> > On Fri, Nov 15, 2013 at 01:44:10AM +0000, Olof Johansson wrote:
> > > The more I start to see early UEFI/ACPI code, the more I am certain
> > > that we want none of that crap in the kernel. It's making things
> > > considerably messier, while we're already very busy trying to convert
> > > everything over and enable DT -- we'll be preempting that effort just
> > > to add even more boilerplate everywhere and total progress will be
> > > hurt.
> >
> > We are certainly under a lot of pressure with the device tree migration,
> > and I agree that adding another information source is going to be a
> > source of pain. However, I'd argue that we're going to encounter pain
> > regardless of which approach we take.
> >
> > I'm of the opinion that the only way we should support ACPI is as a
> > first-class citizen. We don't need to modify every driver and subsystem
> > to support ACPI, only those necessary to support the minimal set of
> > platforms using ACPI. ACPI is new in the arm space, and we can enforce
> > quality standards on ACPI _now_ above what we're allowing for DT, and
> > avoid future problems.
>
> It's obvious from the very first submission, from a vendor that has worked
> closely with "the community" (i.e. one enterprise distro at least), that this
> is completely new territory for _everyone_ involved. There's no way that we can
> enforce quality standards for ACPI yet -- we don't know what they look like!
> Nobody knows how to design a good ACPI implementation or binding.

If we don't know what quality standards we require for ACPI, then I
would rather see ACPI delayed until we are more comfortable with it than
to enforce an arbitrary set of rules required to enable mapping it to
device tree.

> Oh wait, there's people who have been doing this for years. Microsoft. They
> should be the ones driving this and taking the pain for it. Once the platform
> is enabled for their needs, we'll sort it out at our end. After all, that has
> worked reasonably well for x86 platforms.

I'm not sure it's entirely reasonable to assume that Microsoft will
swoop in and develop standards that are useful to us or even applicable
to the vast majority of the systems that are likely to exist. If they
do, then we will (by the expectation that Linux should be able to run
wherever another OS can) have to support whatever standards they may
create.

Regardless of whether we place support for it into Linux, we should
certainly be spending time now attempting to understand ACPI, what it
does and does not provide, and how it can be moved towards something
that fulfils our needs and we can support long-term. We should certainly
not be taking a back seat approach.

Outside of the ARM Linux community there is work ongoing to change ACPI
to better suit the level of variation we seem in the ARM space (see
Darren Hart's presentation from ELCE [1]). We need to be involved now in
order to make sure that this is actually generally applicable.

> If we knew exactly what we wanted, it'd be a different story. _We
> don't_. We're into year FOUR of the device tree conversion and we're just
> now reaching a point where we think we know what a good solution looks
> like. The first two years were easy -- they were the trivial devices we're
> now talking about on ACPI. After that it got harder. Going through all
> of that again with ACPI? No. No way. Microsoft gets to do it and while
> they're busy sorting it out, we'll boot with device tree.

Until ACPI is able to provide all the necessary information, and has
suitable standard mechanisms for describing the horrible portions we are
only just figuring out how to describe in DT, then ACPI is eitehr no
better or worse than DT, and should not be used.

However, we should be looking into it so that when portions of it
eventually appear we have enough of an understanding to cull the
obviously broken parts.

I would also expect that _any_ ACPI support we would accept would not
rely on any board-specific support code whatsoever -- either everything
comes from ACPI or the platform doesn't boot. If we allow board files
for a transitionary period to ACPI we'd be making the same mistake we
did with DT.

> Once they're done, we'll figure out how to enable new hardware. Sure, someone
> needs to keep them sane and participate in the standardization process, but we
> don't have to drag the whole kernel through it.

To me, reworking the AML code and drivers to support AML + DT feels like
dragging the whole kernel through it. I would rather see ACPI in full or
no ACPI than a gigantic ARM-specific set of changes to general
infrastructure that we'd expect to deprecate in future once we
understand (the future state of) ACPI.

> > There may even be things which we don't have to deal with at all on ACPI
> > systems as used in servers (e.g. clock management), but perhaps we will
> > if people see value in those elements.
>
> It's not about seeing value, it's about trying to shoehorn an existing
> implementation into ACPI right now. People don't program with the ACPI
> mindset since that's not what they're used to. So everybody needs to
> re-learn everything all over again.
>
> The clock issues still have to be dealt with in ACPI _somewhere_,
> and they likely have to be dealt with by the same software team at the
> vendors that do Linux kernel work. So by forcing them to figure out how
> to do it in ACPI, we're distracting from their efforts to support their
> hardware better in the kernel in the first place. That's not win-win,
> it's lose-lose. Or rather, it's lose for all of us, and win for Microsoft
> since they are DoS:ing us.
>
> > > The server guys really want UEFI for their boot protocols,
> > > installation managers, etc, etc. That's fine, let them do that, but
> > > that doesn't mean we need to bring the same APIs all the way into the
> > > kernel.
> > >
> > > So, I'm strongly urging that whatever the server guys try to do, it
> > > will in the end result in the ACPI data being translated into DT
> > > equivalents, such that the kernel _only_ needs to handle data via DT.
> >
> > I'm not sure that translating ACPI tables to dt makes any sense. If AML
> > is used (even sparingly), I do not believe that we can do any sensible
> > conversion to device tree. My understanding is that AML includes
> > functionality for modifying ACPI tables, and I don't see how we can
> > possibly support that without having to add a lot of boilerplate to all
> > the code handling AML to add a device tree backend...
>
> We can definitely modify device tree contents at runtime, it's just that
> nobody besides the POWER server guys are doing that today. So that's
> not a strong argument in ACPI's favor. We should fix device-tree where
> needed instead.

As mentioned above, I think that the work to do this is going to end up
as a weird ARM-specific legacy feature. We will get something wrong here
in a way that we have to support long-term. I would rather support
solely DT or solely ACPI at runtime (with a kernel supporting both),
rather than a mixture of both forever due to an artifact of the
development process.

> Also, we can either have some of our better people sort out the ACPI-to-DT
> translation and management, and get it done right, or we can rely on all the
> vendors to get ACPI right in all their drivers. While some of them will,
> I suspect we'll be more successful driving this from a common place. It
> also gives us a place to stick all the fixups for broken firmware,
> since the first generations of ARM servers are bound to have them.

This common place is going to end up handling arbitrarily different
idioms in each format (e.g. how GPIOs are represented), and is almost
certainly going to become a sprawling mess. Also having "all the fixups"
in there makes this sound like an every-single-board file, which is
something I think everyone would like to avoid.

> And best of all, it allows us to continue focus on device tree and
> getting that done right, than splitting all efforts into two. We can't
> affort that right now.
>
> > > Just like PowerPC scrapes the OpenFirmware client interface to build a
> > > flat device tree, we should add a pre-boot stage that scrapes
> > > ACPI/UEFI data and constructs an appropriate device-tree. We can still
> > > bring over ACPI methods and represent those in the DT, but we should
> > > _not_ have two native interfaces.
> >
> > I'm not sure the two cases are comparable. The format of the FDT was
> > designed to encode the data structure used by OpenFirmware, and thus the
> > two map to each other pretty well. I do not believe that mapping from
> > ACPI tables to an FDT blob is anywhere near as simple, and as I mention
> > above I do not believe that we can just copy over the ACPI methods in
> > isolation.
>
> Sorry, I wasn't implying that there's a one-time trivial conversion
> to be made in the generic case, but it can still be done in a similar
> manner even though it will be more complex.

Until I see code, I'm going to remain of the opinion that this is
unworkable without embedding knowledge of every separate subsystem
(GPIO, IRQ, etc) into a single place. That seems worse to me than
teaching those subsystems to deal with the different information
sources.

> Nobody is expecting there to be zero work for new drivers with ACPI;
> after all, the driver itself still has to be written. We're talking differences
> from board to board and system to system here, which we can definitely handle
> through a translator as well.
>
> And, as you say, if the first platforms are going to be trivial and easy to
> implement with ACPI, then doing a translation for them will be simple too.

This may be true. I worry that by working on this assumption we will
lead people to do the wrong thing by focusing on short-term gain (i.e.
placing board-specific hacks all other drivers and not handling the
general case), rather than getting a long term solution together.

> Shipping a firmware with ACPI is really no different from shipping a firmware
> with a flashed device tree. Whatever bugs or strange things the vendor chooses
> to do in there, we'll have to live with forever.
>
> We all know DT considerably better to a point where I would recommend
> that they flash a DTB in their UEFI firmware instead of go with ACPI. For
> simple hardware and basic devices we've got most bindings sorted out by
> now, and we've decided on backwards compatibility from here on out.

If a vendor does this, with a DTB that correctly describes their
hardware then I am not against it (and would prefer this case to mapping
from ACPI to DT). For that case we will also require a nailed-down boot
protocol that allows for either DTB or ACPI (only one at a time).

> > > It might be done via having a skeleton/framework DT for the vendor
> > > platform that is updated via UEFI/ACPI data, or it might be
> > > constructed entirely out of tables coming from firmware. I don't care
> > > about the methods for how it is done, but I do feel strongly that we
> > > should _not_ introduce a second API for everything. I can't think of a
> > > single good reason to do it.
> >
> > Where does this skeleton/framework come from? Within the kernel?
>
> Since there might need to be runtime modifications done to the tree based on
> ACPI events, it seems to make sense to do it in the kernel, so that translation
> state and such can be kept around for use by the runtime modification parts.
>
> Having it extractable out of the kernel tree for testing purposes would be
> greatly appreciated, so it can be ran through valgrind, add testcases, etc.

This is still sounding awfully complicated.

> > That
> > sounds like an arcane board file equivalent, and is counter to the
> > entire reason for using UEFI and ACPI -- having a well-defined
> > (excluding particular driver bindings, and I'm not arguing well-defined
> > means nice) stable standard that allows the kernel to boot on an
> > arbitrary platform without requiring arbitrary platform-specific code
> > everywhere in the boot path.
> >
> > It might not be pretty, and it will certainly require a lot of work, but
> > I'd prefer it at least for a semblance of uniformity.
>
> That is a red herring -- that booting standard has _nothing_ to do with
> ACPI. Once you've got a standard that is well-defined enough like that,
> you no longer need the runtime portions of ACPI to deal with it. You
> can just hardcode it. You need a way to probe _which_ type of standard
> is used, but from there on out you can assume that things are the same
> way.

The UEFI spec pulls in portions of ACPI. I do not know the full extent
of the interaction between the two, but I know that they are not
completely decoupled. As you have pointed out we are not experienced
with ACPI or UEFI, so I don't think we can make statements that one is
perfectly fine without the other.

> > I think that trying to shoe-horn ACPI-derived information into device
> > tree is fundamentally the wrong approach. I don't think it encourages
> > best practices, and I don't think it's beneficial to the long term
> > health of Linux or the ecosystem as a whole.
>
> There are no known best practices with ACPI. It's a complete fumbling
> around in the dark right now. We're complaining about reviewer bandwith
> on DT -- do we have a single reviewer for ACPI on ARM that actually
> knows what a good solution looks like? I don't think so.

There are many people in the Linux community who have ACPI experience.
They may not be active on the ARM side, but it's not fair to say there
are no known best practices. I will agree that for the level of
variation we're likely to expect we are pushing the boundaries.

> So, until there's strong evidence that ACPI is actually going to be
> a sane solution, in other words, until someone has shipped a system
> that uses it (with Windows) and does it successfully without being
> a hot mess, we shouldn't litter the kernel with it.

Again, I'm not sure that we should rely on Windows as our saviour from
insanity. A lot of the issues we are going to encounter are going to be
in vendor-specific code (i.e. drivers), and I do not believe that is
solved by having a single entity in charge of the general frameworks
those are built upon.

> Vendors can standardise of UEFI if they want, but I would much rather
> see them bundle DTB images with their firmware today, than rely on early
> buggy and still-early-on-the-learning-curve ACPI bindings that we then
> have to live with forever.

I agree that today a DTB is preferable to an ACPI implementation.

I think that mapping from ACPI => DT is less sane than building support
for ACPI, and is not going to help us in the long term.

I think that we need to be involved in ACPI from today if we have any
hope of having something sane in future.

Thanks,
Mark.

[1] http://events.linuxfoundation.org/sites/events/files/slides/x86-platform.pdf
