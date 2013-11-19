From: olof@lixom.net (Olof Johansson)
Date: Tue, 19 Nov 2013 10:19:59 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
Message-ID: <20131119181959.GA20967@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 11:30:15AM +0000, Mark Rutland wrote:
> On Fri, Nov 15, 2013 at 05:52:41PM +0000, Olof Johansson wrote:
> > On Fri, Nov 15, 2013 at 09:57:17AM +0000, Mark Rutland wrote:
> > > On Fri, Nov 15, 2013 at 01:44:10AM +0000, Olof Johansson wrote:
> > > > The more I start to see early UEFI/ACPI code, the more I am certain
> > > > that we want none of that crap in the kernel. It's making things
> > > > considerably messier, while we're already very busy trying to convert
> > > > everything over and enable DT -- we'll be preempting that effort just
> > > > to add even more boilerplate everywhere and total progress will be
> > > > hurt.
> > >
> > > We are certainly under a lot of pressure with the device tree migration,
> > > and I agree that adding another information source is going to be a
> > > source of pain. However, I'd argue that we're going to encounter pain
> > > regardless of which approach we take.
> > >
> > > I'm of the opinion that the only way we should support ACPI is as a
> > > first-class citizen. We don't need to modify every driver and subsystem
> > > to support ACPI, only those necessary to support the minimal set of
> > > platforms using ACPI. ACPI is new in the arm space, and we can enforce
> > > quality standards on ACPI _now_ above what we're allowing for DT, and
> > > avoid future problems.
> >
> > It's obvious from the very first submission, from a vendor that has worked
> > closely with "the community" (i.e. one enterprise distro at least), that this
> > is completely new territory for _everyone_ involved. There's no way that we can
> > enforce quality standards for ACPI yet -- we don't know what they look like!
> > Nobody knows how to design a good ACPI implementation or binding.
> 
> If we don't know what quality standards we require for ACPI, then I
> would rather see ACPI delayed until we are more comfortable with it than
> to enforce an arbitrary set of rules required to enable mapping it to
> device tree.

That's essentially what we're saying here: ACPI isn't ready, let's use DT while
it's sorted out and if someone wants to try to require ACPI at some level
today, they should figure out how to translate it into DT. In reality, it might
be easiest to ship a static DT file while ACPI is being developed and sorted
out.

I think we're getting bogged down by the hypothetical AML-in-DT case. We won't
know if we want/need it until we see what kind of stuff vendors think they will
need to do in AML. On x86 it's mostly used to abstract out per-board
differences, not whole SoC behavior. It also depends on how much of their
hardware differences the silicon vendors decide to punt to software to manage
-- that's going to work a lot less well in this type of environment than it
does on 32-bit today.

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
> 
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

I agree that there should be engagement, but not at the expense of forward
progress using the technologies we're finally sorting out how to use
successfully. In other words, we should continue enabling DT on these
platforms while ACPI happens in the background for now. People who
will longer-term depend on ACPI should of course get engaged in that,
but things aren't going to work well if they?abandon working on the
short-to-medium term solutions of continued DT usage.

> > If we knew exactly what we wanted, it'd be a different story. _We
> > don't_. We're into year FOUR of the device tree conversion and we're just
> > now reaching a point where we think we know what a good solution looks
> > like. The first two years were easy -- they were the trivial devices we're
> > now talking about on ACPI. After that it got harder. Going through all
> > of that again with ACPI? No. No way. Microsoft gets to do it and while
> > they're busy sorting it out, we'll boot with device tree.
> 
> Until ACPI is able to provide all the necessary information, and has
> suitable standard mechanisms for describing the horrible portions we are
> only just figuring out how to describe in DT, then ACPI is eitehr no
> better or worse than DT, and should not be used.
> 
> However, we should be looking into it so that when portions of it
> eventually appear we have enough of an understanding to cull the
> obviously broken parts.

I think we're in full agreement on this.

> I would also expect that _any_ ACPI support we would accept would not
> rely on any board-specific support code whatsoever -- either everything
> comes from ACPI or the platform doesn't boot. If we allow board files
> for a transitionary period to ACPI we'd be making the same mistake we
> did with DT.

I don't think anyone is arguing for board files here, that's a dead end. :-)
There might however be quirks needed for drivers here and there, at least for
new platforms (chipsets), errata workarounds, etc. That's expected, and it's
something that they need on x86 today as well.

> > Once they're done, we'll figure out how to enable new hardware. Sure, someone
> > needs to keep them sane and participate in the standardization process, but we
> > don't have to drag the whole kernel through it.
> 
> To me, reworking the AML code and drivers to support AML + DT feels like
> dragging the whole kernel through it. I would rather see ACPI in full or
> no ACPI than a gigantic ARM-specific set of changes to general
> infrastructure that we'd expect to deprecate in future once we
> understand (the future state of) ACPI.

I think we're getting bogged down in details here, unfortunately. Let's see
what people have in mind to implement in AML before we go too far down this
path. In theory it could be a nightmare to deal with it given the feature set
and complexity of AML, but in reality chances are we can do quite well with
just device-tree (as Arnd and others have been arguing as well).

So I think we can postpone much of this debate until we actually have examples
of what people will use in the real world.


[pruning out some double quotes and more AML-related arguments here]


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

Yeah, it would need to be generic enough to not require per-board changes.
Again, let's see how things turn out in reality before we go too far down that
path, doing it on theoretical needs is going to overly complicate things.

[...]

> > Nobody is expecting there to be zero work for new drivers with ACPI;
> > after all, the driver itself still has to be written. We're talking differences
> > from board to board and system to system here, which we can definitely handle
> > through a translator as well.
> >
> > And, as you say, if the first platforms are going to be trivial and easy to
> > implement with ACPI, then doing a translation for them will be simple too.
> 
> This may be true. I worry that by working on this assumption we will
> lead people to do the wrong thing by focusing on short-term gain (i.e.
> placing board-specific hacks all other drivers and not handling the
> general case), rather than getting a long term solution together.

There's going to be need for both, and we can't sacrifice work on the
short-to-medium term solution because I really don't want things to
stumble right away. As Jon is saying, lots of companies are spending
significant resources on this, and we need to make sure things are as
successful as possible right out the door.

That means not restricting short-term solutions with promises/wishes/hopes
that things will magically get sorted out by themselves down the
road. Given the initial output from the ACPI side of things, that's way
too scary a bet to make.

> > Shipping a firmware with ACPI is really no different from shipping a firmware
> > with a flashed device tree. Whatever bugs or strange things the vendor chooses
> > to do in there, we'll have to live with forever.
> >
> > We all know DT considerably better to a point where I would recommend
> > that they flash a DTB in their UEFI firmware instead of go with ACPI. For
> > simple hardware and basic devices we've got most bindings sorted out by
> > now, and we've decided on backwards compatibility from here on out.
> 
> If a vendor does this, with a DTB that correctly describes their
> hardware then I am not against it (and would prefer this case to mapping
> from ACPI to DT). For that case we will also require a nailed-down boot
> protocol that allows for either DTB or ACPI (only one at a time).

UEFI already allows this, as far as I know? Even if both are passed, we can
easily make DT take precedence over ACPI, just like DT overrides ATAGs today.

> > > > It might be done via having a skeleton/framework DT for the vendor
> > > > platform that is updated via UEFI/ACPI data, or it might be
> > > > constructed entirely out of tables coming from firmware. I don't care
> > > > about the methods for how it is done, but I do feel strongly that we
> > > > should _not_ introduce a second API for everything. I can't think of a
> > > > single good reason to do it.
> > >
> > > Where does this skeleton/framework come from? Within the kernel?
> >
> > Since there might need to be runtime modifications done to the tree based on
> > ACPI events, it seems to make sense to do it in the kernel, so that translation
> > state and such can be kept around for use by the runtime modification parts.
> >
> > Having it extractable out of the kernel tree for testing purposes would be
> > greatly appreciated, so it can be ran through valgrind, add testcases, etc.
> 
> This is still sounding awfully complicated.

Yes, but so is doing a native ACPI implementation. Anyway, let's hold off until
we know what we're actually going to need.

> > There are no known best practices with ACPI. It's a complete fumbling
> > around in the dark right now. We're complaining about reviewer bandwith
> > on DT -- do we have a single reviewer for ACPI on ARM that actually
> > knows what a good solution looks like? I don't think so.
> 
> There are many people in the Linux community who have ACPI experience.
> They may not be active on the ARM side, but it's not fair to say there
> are no known best practices. I will agree that for the level of
> variation we're likely to expect we are pushing the boundaries.

Right -- as we've seen with DT where it was easy-peasy on PowerPC since there
were only 2-4 real vendors involved, things get substantially more complicated
when you increase that by an order of magnitude. In this case, we'd be
increasing it with an order of magnitude _and_ bring in their firmware
engineers to be involved too (since we would no longer have control over what
gets put into the tables).

While there are people who have a lot of ACPI experience today, the environment
around it (community/participants and technical diversity) _and_ the new need
for more complex things is new to everybody. As we've seen with DT, we can't
always rely on the existing people to have capacity for the onslaught of
activity that will come down the pipe.

> > So, until there's strong evidence that ACPI is actually going to be
> > a sane solution, in other words, until someone has shipped a system
> > that uses it (with Windows) and does it successfully without being
> > a hot mess, we shouldn't litter the kernel with it.
> 
> Again, I'm not sure that we should rely on Windows as our saviour from
> insanity. A lot of the issues we are going to encounter are going to be
> in vendor-specific code (i.e. drivers), and I do not believe that is
> solved by having a single entity in charge of the general frameworks
> those are built upon.

As mentioned in other replies in the thread, I was a bit careless in how
I phrased this. We can't just wait until they're done, but we also shouldn't
do it all ourselves. And we definitely shouldn't bet our house on it resulting
in a useable solution at this point.

> > Vendors can standardise of UEFI if they want, but I would much rather
> > see them bundle DTB images with their firmware today, than rely on early
> > buggy and still-early-on-the-learning-curve ACPI bindings that we then
> > have to live with forever.
> 
> I agree that today a DTB is preferable to an ACPI implementation.
> 
> I think that mapping from ACPI => DT is less sane than building support
> for ACPI, and is not going to help us in the long term.

I think it'll depend on what will actually be needed on real systems. And
I'm not making many assumptions on long term here -- we can't let that
distract us from getting the first few years sorted out first.

> I think that we need to be involved in ACPI from today if we have any
> hope of having something sane in future.

We agree more than we disagree on this whole discussion, I believe.


-Olof
