From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 26 Feb 2016 09:55:10 +0100
Subject: [PATCH 1/3] dt-bindings: arm/marvell: ABI unstability warning
 about Marvell 7K/8K
In-Reply-To: <20160225175603.GD10593@leverpostej>
References: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1456327007-31008-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160224172545.GC9137@leverpostej>
 <20160224211045.379352d3@free-electrons.com>
 <CAL_JsqLevrujSeYNBvSJA-5T0Ho8y7c0fKid7QvVm8LLvYLotw@mail.gmail.com>
 <20160225090927.13492cfb@free-electrons.com>
 <20160225161642.GC10593@leverpostej>
 <20160225173811.23be5b05@free-electrons.com>
 <20160225175603.GD10593@leverpostej>
Message-ID: <20160226095510.28a056be@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On Thu, 25 Feb 2016 17:56:04 +0000, Mark Rutland wrote:

> > Hence, even when the support for a SoC is being done in collaboration
> > with the SoC vendor, we don't always have a nice full datasheet that
> > tells us what all the registers are doing and how they are organized.
> > We discover things as we go.
> 
> So as and when you believe you need to break a binding, we can have a
> discussion on that case-by-case basis.
> 
> That's different to stating that the usual rules don't apply at all,
> which is black-and-white stand I'm referring to.

This would at least be a somewhat reasonable compromise, if that's your
preference.

However, my proposal had the advantage that potential users of the
platform are *aware* that the DT bindings are in-flux and that they may
change.

With your proposal, there is no such statement, even if we reserve the
right, on case-by-case basis to have a discussion about potentially
breaking the DT bindings.

But if that's OK for you, I'm happy with that as well.

> > Instead, what we want is to submit the basic stuff early, and then
> > progressively build on top of this basic stuff by merging more and more
> > features. This way:
> > 
> >  * We don't have to pile up hundreds of out of tree patches;
> 
> Then _support_ what you have upstreamed already. Either it's ready to be
> supported or it is not. If it is, there's no need for DT breakage, and
> if it isn't, then it's not ready for mainline. That's all this boils
> down to. 
> 
> If it must go in, then it must be supported.

Supporting something has absolutely nothing to do with keeping the DT
bindings unchanged. Supporting something means that I'll watch for
build failures and fix them, I'll watch for bug reports and act on
them, I'll watch on subsystem/infrastructure changes and change my
driver code accordingly. This is what supporting means.

> >  * We have a support in the mainline kernel that is progressively
> >    getting better as we enable more and more feature. We can show that
> >    4.6 has this small set of features, 4.7 has this slightly extended
> >    set of features supported, and so on.
> 
> It's not "progressively getting better", if DTBs are arbitrarily getting
> broken.
> 
> It's possible to incrementally add support without having to break
> existing DTBs.

Except if:

 1/ Your final production chip has some differences from your test chip
    which do affect the DT representation. The kernel community has
    asked for years that HW vendors start submitting code as early as
    possible, and they are now doing it. In order to do it as soon as
    possible, they start doing it based on test chips, which may be
    slightly different from the final chips. The kernel community
    should then understand this and be a bit flexible in that the
    kernel support might change a bit, as the HW might change a bit
    before it reaches production.

 2/ You have no documentation for your HW, and you're simply
    discovering how it works progressively. Look at all the folks who
    write nice upstream code solely based on crappy vendor BSPs, with
    no datasheet whatsoever. Do you think they can sanely have a good
    overall understanding of the HW from day 1 ? Certainly not. They
    will discover that such or such HW block is not only a timer, but
    also a watchdog. That this other HW block not only contains
    clocks, but reset and pinctrl lines.

I don't like to self-promote my own stuff, but I think you should read
the slides of my talk "Device Tree as a stable ABI: a fairy
tale" (http://free-electrons.com/pub/conferences/2015/elc/petazzoni-dt-as-stable-abi-fairy-tale/petazzoni-dt-as-stable-abi-fairy-tale.pdf).
I will clearly not suggest you to watch the video recording, as I don't
want you to suffer from one hour of my terrible English accent.

> > We are perfectly fine with maintaining *code*. And we have been doing
> > so for several years on Marvell platforms: caring about older
> > platforms, converting old legacy code and legacy platforms to the
> > Device Tree, etc.
> 
> The parsing and handling of the existing binding is code, which you are
> arguing you do not need to support.

So you like to have tons and tons of essentially dead code to parse old
versions of DT bindings?

What really strikes me here is that the Linux kernel always had a
version strong position, detailed in
Documentation/stable_api_nonsense.txt, that the kernel developers don't
want to maintain a stable API for kernel modules, because keeping old
APIs around means keeping old code, that isn't tested, confuses people,
etc. Read the file if you've never done so.

And now, for something pretty much as complicated (if not more) as the
kernel module API, the DT bindings, you want to do *exactly* what this
stable_api_nonsense.txt says we shouldn't do ?

> > What we don't want to commit to is to maintain the DT stability
> > *before* the support for a given device is sufficiently stable/sane.
> 
> I do not follow what you mean by support being *not sane*. If it isn't
> sane, why was it merged?
> 
> If it was previously considered sane, and the code was considered
> supportable, why is it necessary to break a DT that it supported?

See above: the HW has changed, or the HW is not working as it was
originally understood when the DT binding was initially designed.

> > Why are you talking about "illusion" of support ? Sorry, but with
> > unstable DT bindings, as long as you use the DT that comes with the
> > kernel sources, everything works perfectly fine, and is perfectly
> > supported.
> 
> A few examples:
> 
> * Distro installation (in the absence of a stable DT and a consistent
>   boot environment, you have no idea how to get a kernel up and
>   running). Either your user has to be intimately familiar with the
>   platform, or the distro needs a separate release for each and every
>   platform.

Irrelevant: the distro shall just ship with all the Device Trees for
all supported platforms, and that's it. Exactly like the x86 kernels
shipped by distros have essentially all kernel drivers enabled in order
to be able to have a kernel that works on all platforms.

> * Distro maintenance. I just upgraded to a point-release kernel and now
>   have to pull down the DTBs. That required the distro to _somehow_
>   identify the relevant DTBs, how to install this in the correct
>   location such that the firmware and/or bootloader can pick it up, etc.

Same, irrelevant: the DTB comes with the distro kernel package, and like
kernel modules, they are installed in a per-kernel version directory.

> * Other developers tracking down problems that inevitable crop up on the
>   platform, who now have to jump through the hoops above. As the DTBs
>   change, so may the user-facing elements and/or kernel behaviour, so
>   bisecting is extremely painful (though admittedly possible).

Exactly like they have to change their kernel modules so that they are
compatible with the kernel version they run.

> * Portable hypervisors, bootloaders, or other system-level software
>   can't add any (DTB-aware) support for a platform until the kernel
>   support is considered "sane" per your argument above. That time is an
>   arbitrary unknown in the future (which may be at infinity), so they
>   are either indefinitely delayed or end up having attempt to have
>   stable support for a variety of unstable bindings anyway, which may or
>   may not be possible depending on how bindings got broken.

Those hypervisors, bootloaders or system-level should not hardcode the
platform DTB, but simply use the one that is provided together with the
kernel.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
