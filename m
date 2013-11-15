From: david.goodenough@btconnect.com (David Goodenough)
Date: Fri, 15 Nov 2013 18:13:47 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131115175241.GB27174@quad.lixom.net>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
Message-ID: <201311151813.47101.david.goodenough@btconnect.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 Nov 2013, Olof Johansson wrote:
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
> closely with "the community" (i.e. one enterprise distro at least), that
> this is completely new territory for _everyone_ involved. There's no way
> that we can enforce quality standards for ACPI yet -- we don't know what
> they look like! Nobody knows how to design a good ACPI implementation or
> binding.
> 
> Oh wait, there's people who have been doing this for years. Microsoft. They
> should be the ones driving this and taking the pain for it. Once the
> platform is enabled for their needs, we'll sort it out at our end. After
> all, that has worked reasonably well for x86 platforms.
> 
> If we knew exactly what we wanted, it'd be a different story. _We
> don't_. We're into year FOUR of the device tree conversion and we're just
> now reaching a point where we think we know what a good solution looks
> like. The first two years were easy -- they were the trivial devices we're
> now talking about on ACPI. After that it got harder. Going through all
> of that again with ACPI? No. No way. Microsoft gets to do it and while
> they're busy sorting it out, we'll boot with device tree.
> 
> Once they're done, we'll figure out how to enable new hardware. Sure,
> someone needs to keep them sane and participate in the standardization
> process, but we don't have to drag the whole kernel through it.
> 
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
Is this true.  On the Beagle Board/Bone there is extensive use of Device
Tree Overlays, which feels like run time modification to me.  It gets 
used to enable multiplexed pins to a particular configuration.

David
> 
> Also, we can either have some of our better people sort out the ACPI-to-DT
> translation and management, and get it done right, or we can rely on all
> the vendors to get ACPI right in all their drivers. While some of them
> will, I suspect we'll be more successful driving this from a common place.
> It also gives us a place to stick all the fixups for broken firmware,
> since the first generations of ARM servers are bound to have them.
> 
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
> 
> Nobody is expecting there to be zero work for new drivers with ACPI;
> after all, the driver itself still has to be written. We're talking
> differences from board to board and system to system here, which we can
> definitely handle through a translator as well.
> 
> And, as you say, if the first platforms are going to be trivial and easy to
> implement with ACPI, then doing a translation for them will be simple too.
> 
> Shipping a firmware with ACPI is really no different from shipping a
> firmware with a flashed device tree. Whatever bugs or strange things the
> vendor chooses to do in there, we'll have to live with forever.
> 
> We all know DT considerably better to a point where I would recommend
> that they flash a DTB in their UEFI firmware instead of go with ACPI. For
> simple hardware and basic devices we've got most bindings sorted out by
> now, and we've decided on backwards compatibility from here on out.
> 
> > > It might be done via having a skeleton/framework DT for the vendor
> > > platform that is updated via UEFI/ACPI data, or it might be
> > > constructed entirely out of tables coming from firmware. I don't care
> > > about the methods for how it is done, but I do feel strongly that we
> > > should _not_ introduce a second API for everything. I can't think of a
> > > single good reason to do it.
> > 
> > Where does this skeleton/framework come from? Within the kernel?
> 
> Since there might need to be runtime modifications done to the tree based
> on ACPI events, it seems to make sense to do it in the kernel, so that
> translation state and such can be kept around for use by the runtime
> modification parts.
> 
> Having it extractable out of the kernel tree for testing purposes would be
> greatly appreciated, so it can be ran through valgrind, add testcases, etc.
> 
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
> 
> > I think that trying to shoe-horn ACPI-derived information into device
> > tree is fundamentally the wrong approach. I don't think it encourages
> > best practices, and I don't think it's beneficial to the long term
> > health of Linux or the ecosystem as a whole.
> 
> There are no known best practices with ACPI. It's a complete fumbling
> around in the dark right now. We're complaining about reviewer bandwith
> on DT -- do we have a single reviewer for ACPI on ARM that actually
> knows what a good solution looks like? I don't think so.
> 
> So, until there's strong evidence that ACPI is actually going to be
> a sane solution, in other words, until someone has shipped a system
> that uses it (with Windows) and does it successfully without being
> a hot mess, we shouldn't litter the kernel with it.
> 
> Vendors can standardise of UEFI if they want, but I would much rather
> see them bundle DTB images with their firmware today, than rely on early
> buggy and still-early-on-the-learning-curve ACPI bindings that we then
> have to live with forever.
> 
> 
> -Olof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
