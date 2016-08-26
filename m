From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Aug 2016 00:18:26 +0200
Subject: [PATCH 00/13] arm64: Allwinner A64 support based on sunxi-ng
In-Reply-To: <822ff63c-117d-2250-c1ac-27cd1f787095@arm.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
 <fb559224-561c-3476-1146-96f7aea427f0@arm.com>
 <20160823193129.GO2598@lukather>
 <822ff63c-117d-2250-c1ac-27cd1f787095@arm.com>
Message-ID: <20160826221826.GF3165@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 12:54:14AM +0100, Andr? Przywara wrote:
> >> Now the long part ....
> >>
> >> Basically I see those issues with the new clocks:
> >> - sunxi-ng requires a complicated SoC specific source file in the
> >> kernel. Although that makes the DT pretty easy (and avoids breaking it
> >> the future), it ultimately requires an explicit code drop for every new
> >> SoC, even if they share 95% of the clocks (as H3 and A64 do, for instance).
> >> - This code file does not actually contain any code, instead it's just
> >> data and looks like it should really be presented in DT - which brings
> >> us back to something like the old sunxi clock scheme, which is
> >> apparently not considered good enough. I still wonder if we could create
> >> a generic sunxi-ng user, which explains the needed clocks in the DT
> >> instead of in code. I admit that looks like quite some work.
> >> - It makes it quite hard for any other DT user (*BSD, U-Boot) to use the
> >> clocks, since they would have to copy quite verbatim the Linux
> >> implementation choice. This is admittedly also true for the old clock
> >> framework, but still unfortunate.
> > 
> > 3 - You never get a complete clock support for any SoC, requirining
> >     for pretty much every driver to create from scratch a new clock
> >     driver.
> 
> I don't understand this. Are you referring to the old clock system? Or
> to the proposed SCPI approach? Or to sunxi-ng with DT descriptions?

I was referring here to the old clock system.

> And why would a *driver* care about a specific clock if it's using the
> common clock framework?
> Confused ...

Because a driver drives an IP that is fed by a specific clock, and
those clocks entirely change from one controller to the other, and
from one SoC to the other.

So we were in a situation where you had to write that clock driver
before doing something useful, and then debug because obviously it was
not written properly. This is not acceptable.

> > 4 - You require for all these clocks drivers some Ack from both the DT
> >     and clocks maintainers, who both said they were fed up with this.
> 
> Again which new clock drivers? The old sunxi-clks?

Old clks. I was under the impression that you were advocating against
sunxi-ng here, and your patches were using the old system. Sorry if I
mixed things up. Obviously, that wouldn't happen with SCPI.

> For the SCPI version I propose we don't need any ACKs (apart from the
> new .dtsi, maybe), because the clocks are already there.
> 
> > 5 - If you realise some day down the road that the parenting
> >     relationship is not right, or that some clock is not doing what
> >     you thought it was, you can't really fix it properly because of
> >     the DT stability you wanted us to enforce.
> > 
> >> So as mentioned several times before, I am looking into a more firmware
> >> driven clock system using the SCPI[1] framework.
> >> The idea is:
> >> - The basic clocks (OSC24M, OSC32K, AHB1, APB1, APB2, PERIPH0) are
> >> expressed as fixed clocks. If I am not mistaken, Allwinner recommends
> >> certain frequencies for them anyway, so we just use that and set them up
> >> before booting Linux, for instance in ATF.
> >> - The gates clocks are expressed as before, but by defining a generic DT
> >> compatible fallback name. I have no idea why every SoC enters its name
> >> into the simple_gates.c source file, while just mentioning the
> >> compatible string in the DT bindings and using the SoC specific name
> >> together with a generic fallback like "allwinner,sunxi-simple-gates"
> >> would suffice. This means that we don't need to touch simple-gates.c
> >> anymore most of the time.
> >> - Any clock that can (and has to) be programmed with a variable
> >> frequency is expressed as an SCPI clock. This interface allows basically
> >> querying and setting a frequency - not very powerful, but sufficient for
> >> the clocks I checked. Firmware then takes the burden of programming the
> >> respective clock register - which is not rocket science if we lock the
> >> base clocks to a certain frequency.
> >>
> >> The advantage of this approach would be:
> >> - The impact to Linux code is minimized. Normally there would be no need
> >> to touch the kernel at all when we introduce a new SoC.
> > 
> > But you duplicate the clock framework entirely, both the core code and
> > the data you were complaining about, with all the issues that arise
> > from code duplication. You still have to create that big file you were
> > complaining about, with exactly the same constraints.
> 
> We don't need to comply with some common clock framework in firmware, we
> just need to provide implementations for specific clocks. From a
> maintainer's point of view the CCF is nice, but its implementation is
> quite complicated and hard to understand for mere mortals.

Well, it might just be because "dealing with clocks is hard"? And you
would have to reimplement at least part of it anyway.

> Also tweaking a particular clock is not easy, as it has to fit into
> the framework and we may miss the interfaces.

Then add the interface. We do that on a regular basis, and Mike and
Stephen are usually open to it if it's relevant.

> See the MMC clock implementation for instance: it's just a simple
> divider clock. My implementation in ATF is probably bad and stupid, but
> at the end of the day I just have to provide a way to set a frequency of
> one single clock.

For all clock rates that are possible on MMC? With DDR? I seriously
doubt this will be stupid.

> I think we win a lot if we go away from possibly tuning the parent's
> clocks (AHB, PLL6 & friends), instead leaving them as fixed clocks - my
> understanding is that Allwinner recommends this anyway.

Being a fixed clock doesn't help. We had the issue in the past where
we actually had to change those rates to have DMA working (A31's AHB),
or simply because the rate was bad (A13's pll5). A fixed clock removes
that possibility. However, a clock properly modelled can.

Which doesn't mean that we would change it (and we don't!).

> Then the whole complex clock tree degrades into just a bunch of more
> or less independent clock registers.
>
> Also we can go with a much easier implementation, since we don't need to
> support all clocks in one image, but just the clocks for one particular
> SoC. This brings the complexity down, so we can get away with a much
> simpler implementation (compare U-Boot, though this isn't the best
> example, admittedly).

Yeah, ignoring 95% of the problem is usually a very efficient way to
simplify it. Now, throw the audio clocks, the pixel clocks, the SPI
clocks, the camera clocks, the GPU clocks. Had some frequency change
for all of them, with some weird frequencies for the pixel clocks to
deal with all the panels out there, and see how it goes.

For example, during the A13 DRM development, we had to support
changing from TV-out to the panel output. In order to generate the
right frequencies, we had to change the rate of 4 clocks with a direct
relationship, and try to come up with a combination of these four
clocks that would generate the right frequency.

This is trivial with the CCF. Yes, it's complex, but the complexity is
here for a reason. Otherwise no-one would use it (yet everyone does).

> >> - Any other DT user can quite easily make use of the clock system
> >> without adding tons of complicated Allwinner specific clock code. The
> >> simple-gates driver is almost trivial to implement, and chances are SCPI
> >> is already around anyway.
> >> - If there are any peculiarities with a certain clock (implementation),
> >> we can solve this in firmware. Fixes to code would immediately benefit
> >> all users - existing kernels (from distributions), newer kernels and
> >> other OSes.
> > 
> > But no-one would actually be able to use it, because no one upgrades
> > its firmware, including all the major distributions (Debian, Ubuntu,
> > Fedora, OpenWRT, Arch, Gento, you name it). So there's effectively no
> > way to fix a bug that was there.
> 
> But currently distributions do upgrade U-Boot, don't they?

Debian Jessie has a package with U-Boot 2014.10. I don't even know how
they can install it, since there's no generic way to do it.

Fedora, Arch, Gentoo don't have a package.
OpenWRT is made to run on whatever bootloader comes on the board.

So no, really, they don't.

> ATF would be part of a FIT image, compiled alongside U-Boot and
> included in one image with the SPL and the U-Boot proper. In the
> Allwinner world with firmware on SD cards or in eMMC I don't see big
> issues.

And on NAND? SPI-NOR? And on which MMC card would you install it?

> Also honestly I don't expect frequent updates. Yes: in the beginning we
> may have changes, but at some point we make a (tested) release and maybe
> publish updates every now and then. Either these updates fix bugs or
> provide new features, so there is some incentive for users to update. Or
> they don't care, in which case it may just work for them and they keep
> using the old version.

Judging from the past experience, in 4 years, we haven't been able to
complete a single clock tree. And by complete, I mean with all the
clocks defined, and tested properly. This will be much easier with
sunxi-ng, but really, don't count on having everything that works
after a short while.

Even if you have all the clocks exposed quite soon, we don't have any
driver to test them.

So what you suggest is to actually upgrade the bootloader each time,
for the foreseeable future. And that alone is a showstopper.

> >> - This approach matches many of the more serious ARM64 machines out
> >> there, which refrain from exposing all of their clock framework to Linux.
> > 
> > $ git grep -l scpi arch/arm64/boot/dts/**.dtsi
> > arch/arm64/boot/dts/arm/juno-base.dtsi
> > 
> > Are you saying that only Juno is a serious ARM64 machine?
> 
> I wasn't referring to SCPI in particular (which is indeed used only by
> Juno at the moment), but about not exposing the actual internal clock
> layout to Linux. PCs certainly don't, but also AMD Seattle and ThunderX
> avoid this.

I don't need to upgrade my BIOS or UEFI on my PC everytime I get a new
kernel release to have everything working as it should.

And I'm guessing both ThunderX and Seattle had an army of engineers
working on that firmware, and testing every last bit of it.

If we also had such a firmware, I would be all in. But we don't, and
we can't in a reasonable (less than a month) timeframe. It really
boils down to this. This has been stalled for something like 6 monthes
now, waiting for solutions that might or might not happen (and I know
I have my share of responsibilities in this). But I don't want to wait
any longer.

> >> Also this opens the door to much easier support for new SoCs - up to a
> >> point where any new chip would actually run out of the box on existing
> >> distributions (thinking of LTS releases here). The pinctrl driver is a
> >> nasty guy around here - but let's not make it worse and try to fix that
> >> guy later ;-)
> > 
> > That's not true and you know it.
> > 
> > What you actually suggest is to implement a minimal set of clocks in
> > ATF (the opposite being, the entire set of clocks, which would of
> > course be untested, so it basically falls down in the exact same
> > category).
> > 
> > What this means is that, since we will obviously not support all the
> > clocks client from day one, any user will be *required* for a new
> > kernel release to operate as it's expected to upgrade the ATF.
> 
> I don't see that these are related - unless you consider the DT part of
> the kernel - which it clearly isn't (although the current scheme of DT
> updates suggests this). Actually the firmware should provide the DT,
> just advertising all the clocks it implements.

I consider my firmware just like you consider your DT: I really like
the fact that I can go with _one_ known best firmware.

> And as I don't expect implementing an isolated clock as an SCPI clock to
> be rocket science, I'd hope for the error rate to be minimal.

I'm more pessimistic than you are on this, but even with that
assumption, the point still holds: you cannot support all the clocks
from day one.

> So we may publish an early firmware version with support for certain
> devices only and later upgrade this. U-Boot gets also upgraded via the
> distributions at the moment.

Like I said, this is not true.

> We could even introduce some firmware upgrade infrastructure (or use
> the Linux one) if we find us in dire need for.

And I want something that works *today*, not some blurry thing that
redhat, fedora and debian might or might not help us with at some
point in a vague future.

> > Without any help from the distribution (s)he's running, because no one
> > has that kind of scenario in mind. And let's be honest, I don't see
> > Ubuntu changing the dependencies for the kernel for the Allwinner SoCs
> > alone (let alone the fact that it's pretty much impossible in a
> > generic way to know where and how the ATF is installed).
> 
> Again how does this differ from U-Boot, which I consider firmware as
> well and which is handled by the distributions (although I don't like
> this approach very much, because it pushes hardware support to Linux
> vendors).

U-boot configuration is mostly static. The video modes are always the
same. You don't have to do any arbitration between devices. You don't
have audio. It's totally fine for a firmware, but you need something
more advanced in the kernel.

> 
> > Apart from being a major pain for any user, upgrading the bootloader
> > is also a showstopper for most industries.
> > 
> > So, no, we won't do that. The A64 support is something we actually
> > want to use in real-life products, and our users to be happy with the
> > support they have.
> 
> I can understand that we can just do what we did in the past: Spoon feed
> every new SoC as soon as we get our hands on some boards and explicitly
> add support for it in the Linux kernel.
> But I'd like to revisit this approach, as it actually takes quite some
> time for support to trickle in down the kernel road - especially if we
> look at major distributions (think LTS).
> If we can get closer to a state were new SoCs just require appropriate
> firmware and a DT - without any new kernel code - I see a big
> opportunity to get much quicker support for new SoCs - up to a point
> where the firmware is the only thing that's needed. Maybe some day the
> board vendors provide these firmware bits even, who knows?

I understand the need for ARM to find a technical showcase
platform. What I don't understand is why I should feel the pain of
going against the current, and waiting for suffering to (maybe) stop
at some point in the future.

That goal is very noble. I'm under the impression that it's the kind
of soft-lobbying that Marc wanted to do with PSCI too, that we were
basically the first one to implement. And it worked for us because it
worked from day one, and it was an all or nothing.

What you suggest is an entire different story.

Please speak to the vendors, make them provide those firmwares. I'll
be more than happy to switch to them then.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/33e24558/attachment.sig>
