From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 25 Feb 2016 17:56:04 +0000
Subject: [PATCH 1/3] dt-bindings: arm/marvell: ABI unstability warning
 about Marvell 7K/8K
In-Reply-To: <20160225173811.23be5b05@free-electrons.com>
References: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1456327007-31008-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160224172545.GC9137@leverpostej>
 <20160224211045.379352d3@free-electrons.com>
 <CAL_JsqLevrujSeYNBvSJA-5T0Ho8y7c0fKid7QvVm8LLvYLotw@mail.gmail.com>
 <20160225090927.13492cfb@free-electrons.com>
 <20160225161642.GC10593@leverpostej>
 <20160225173811.23be5b05@free-electrons.com>
Message-ID: <20160225175603.GD10593@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 25, 2016 at 05:38:11PM +0100, Thomas Petazzoni wrote:
> Hello Mark,
> 
> On Thu, 25 Feb 2016 16:16:47 +0000, Mark Rutland wrote:
> 
> > > Either because the internal processes are complicated, or simply
> > > because the Linux kernel support is done without cooperation from the
> > > HW vendor (it's not the case of this Marvell platform, but it's the
> > > case of many other platforms).
> > 
> > Yes, this is a problem in some cases, and that should be considered in
> > those cases. There are always shades of grey.
> 
> Sure.
> 
> > Per the above, that isn't relevant in this case. This is a pretty
> > black-and-white stand against the usual rules.
> 
> I don't see why. The datasheets have not been completely written yet
> for this particular chip. For other chips we've worked on where we
> collaborated with the SoC vendor, we never had any datasheet, simply
> because the SoC vendor doesn't have any. They have the digital logic
> source code, and then tons of spreadsheets or text documents that are
> not proper datasheets and that they generally cannot share with
> third-parties.
> 
> Hence, even when the support for a SoC is being done in collaboration
> with the SoC vendor, we don't always have a nice full datasheet that
> tells us what all the registers are doing and how they are organized.
> We discover things as we go.

So as and when you believe you need to break a binding, we can have a
discussion on that case-by-case basis.

That's different to stating that the usual rules don't apply at all,
which is black-and-white stand I'm referring to.

> > Submitting prototypes and RFCs is the usual way we get things reviewed
> > early, and to allow maintainers and others to get a feel for things
> > earlier. Submitting patches _for merging_ when you're not sure about
> > things and don't want to agree to support them is what's being pushed
> > back on.
> 
> This simply doesn't work. This initial support of a few patches (clock,
> basic DT, irqchip, dmaengine) is going to be followed very soon by lots
> of other patches to enable more aspects of the SoC. And we should keep
> all of those patches out-of-tree, piling up hundreds of out-of-tree
> patches ? Not practical at all.
> 
> And then when we'll submit them, they will all be accepted in one go,
> in one kernel cycle ? Clearly not, so we would have to wait several
> kernel cycles, which is clearly not what we want.
> 
> Instead, what we want is to submit the basic stuff early, and then
> progressively build on top of this basic stuff by merging more and more
> features. This way:
> 
>  * We don't have to pile up hundreds of out of tree patches;

Then _support_ what you have upstreamed already. Either it's ready to be
supported or it is not. If it is, there's no need for DT breakage, and
if it isn't, then it's not ready for mainline. That's all this boils
down to. 

If it must go in, then it must be supported.

>  * We have a support in the mainline kernel that is progressively
>    getting better as we enable more and more feature. We can show that
>    4.6 has this small set of features, 4.7 has this slightly extended
>    set of features supported, and so on.

It's not "progressively getting better", if DTBs are arbitrarily getting
broken.

It's possible to incrementally add support without having to break
existing DTBs.

> > If you're unsure about something, but still want it merged, then you
> > have to commit to maintaining that as far as reasonably possible, even
> > if it turns out to not be quite right.
> 
> We are perfectly fine with maintaining *code*. And we have been doing
> so for several years on Marvell platforms: caring about older
> platforms, converting old legacy code and legacy platforms to the
> Device Tree, etc.

The parsing and handling of the existing binding is code, which you are
arguing you do not need to support.

> What we don't want to commit to is to maintain the DT stability
> *before* the support for a given device is sufficiently stable/sane.

I do not follow what you mean by support being *not sane*. If it isn't
sane, why was it merged?

If it was previously considered sane, and the code was considered
supportable, why is it necessary to break a DT that it supported?

> > > Do you realize that this all DT binding stuff is today the *biggest* to
> > > getting HW support in the Linux kernel? It has become more complicated
> > > to merge a 4 properties DT binding than to merge multiple thousands of
> > > lines of driver code. 
> > 
> > As times have changed, pain points have moved around.
> > 
> > To some extent that is unavoidable; more up-front effort is required
> > where crutches we previously relied on are not applicable.
> > 
> > Elsewhere we can certainly do better.
> > 
> > Throwing your hands up and stating "this is unstable, it might change"
> > is a crutch. It prevents any real solution to the pain points you
> > encounter, and creates pain points for others. It only provides the
> > _illusion_ of support.
> 
> Could you please explicit which pain points it creates for others ?
> 
> Having unstable DT bindings specific to a platform does not create any
> single pain point for anyone.
> 
> Why are you talking about "illusion" of support ? Sorry, but with
> unstable DT bindings, as long as you use the DT that comes with the
> kernel sources, everything works perfectly fine, and is perfectly
> supported.

A few examples:

* Distro installation (in the absence of a stable DT and a consistent
  boot environment, you have no idea how to get a kernel up and
  running). Either your user has to be intimately familiar with the
  platform, or the distro needs a separate release for each and every
  platform.

* Distro maintenance. I just upgraded to a point-release kernel and now
  have to pull down the DTBs. That required the distro to _somehow_
  identify the relevant DTBs, how to install this in the correct
  location such that the firmware and/or bootloader can pick it up, etc.

* Other developers tracking down problems that inevitable crop up on the
  platform, who now have to jump through the hoops above. As the DTBs
  change, so may the user-facing elements and/or kernel behaviour, so
  bisecting is extremely painful (though admittedly possible).

  Notice that in this case, the user has to go back in time for their
  starting point. So it doesn't matter if they're not a user _yet_.

* Portable hypervisors, bootloaders, or other system-level software
  can't add any (DTB-aware) support for a platform until the kernel
  support is considered "sane" per your argument above. That time is an
  arbitrary unknown in the future (which may be at infinity), so they
  are either indefinitely delayed or end up having attempt to have
  stable support for a variety of unstable bindings anyway, which may or
  may not be possible depending on how bindings got broken.

These may not affect _you_ directly, but they do hinder realistic
user-facing support.

> Even Fedora is installing DTBs in a directory that is kernel-version
> specific!

This is a _symptom_ of the problem. Read this as:

	Even Fedora _have to_ install DTBs in a directory that is
	kernel-version specific!

Notice how that does not sound great. Distros are being _forced_ to do
this because stuff gets broken. As covered above, this doesn't always
work anyway, so it's really not an argument in favour of breaking
things.

Thanks,
Mark.
