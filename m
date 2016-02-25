From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Feb 2016 17:38:11 +0100
Subject: [PATCH 1/3] dt-bindings: arm/marvell: ABI unstability warning
 about Marvell 7K/8K
In-Reply-To: <20160225161642.GC10593@leverpostej>
References: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1456327007-31008-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160224172545.GC9137@leverpostej>
 <20160224211045.379352d3@free-electrons.com>
 <CAL_JsqLevrujSeYNBvSJA-5T0Ho8y7c0fKid7QvVm8LLvYLotw@mail.gmail.com>
 <20160225090927.13492cfb@free-electrons.com>
 <20160225161642.GC10593@leverpostej>
Message-ID: <20160225173811.23be5b05@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On Thu, 25 Feb 2016 16:16:47 +0000, Mark Rutland wrote:

> > Either because the internal processes are complicated, or simply
> > because the Linux kernel support is done without cooperation from the
> > HW vendor (it's not the case of this Marvell platform, but it's the
> > case of many other platforms).
> 
> Yes, this is a problem in some cases, and that should be considered in
> those cases. There are always shades of grey.

Sure.

> Per the above, that isn't relevant in this case. This is a pretty
> black-and-white stand against the usual rules.

I don't see why. The datasheets have not been completely written yet
for this particular chip. For other chips we've worked on where we
collaborated with the SoC vendor, we never had any datasheet, simply
because the SoC vendor doesn't have any. They have the digital logic
source code, and then tons of spreadsheets or text documents that are
not proper datasheets and that they generally cannot share with
third-parties.

Hence, even when the support for a SoC is being done in collaboration
with the SoC vendor, we don't always have a nice full datasheet that
tells us what all the registers are doing and how they are organized.
We discover things as we go.

Yes, this might be surprising to you, working at ARM, where the
technical documentation is awesome and very detailed. But trust me,
this is *NOT* what you get from many SoC vendors.

> > Submitting without merging is useless. The point of submitting is to
> > get the code merged, to reduce the amount of out-of-tree patches we
> > have to carry, and to allow users of the platform to simply run
> > mainline on their platform.
> 
> Submitting prototypes and RFCs is the usual way we get things reviewed
> early, and to allow maintainers and others to get a feel for things
> earlier. Submitting patches _for merging_ when you're not sure about
> things and don't want to agree to support them is what's being pushed
> back on.

This simply doesn't work. This initial support of a few patches (clock,
basic DT, irqchip, dmaengine) is going to be followed very soon by lots
of other patches to enable more aspects of the SoC. And we should keep
all of those patches out-of-tree, piling up hundreds of out-of-tree
patches ? Not practical at all.

And then when we'll submit them, they will all be accepted in one go,
in one kernel cycle ? Clearly not, so we would have to wait several
kernel cycles, which is clearly not what we want.

Instead, what we want is to submit the basic stuff early, and then
progressively build on top of this basic stuff by merging more and more
features. This way:

 * We don't have to pile up hundreds of out of tree patches;

 * We have a support in the mainline kernel that is progressively
   getting better as we enable more and more feature. We can show that
   4.6 has this small set of features, 4.7 has this slightly extended
   set of features supported, and so on.

So no, we clearly do not want to keep things out of tree.

> > So this proposal really doesn't make any sense. Just like Mark initial
> > statement of not submitting code so early.
> 
> As what I said was evidently ambiguous, I'm on about code being _merged_
> prior to being ready. Code and bindings should certainly be posted for
> review as soon as possible. However, it should be recognised when things
> aren't quite ready for mainline.
> 
> Even if something's unclear about a device, you can highlight more
> general issues (e.g. problematic edge cases in common subsystem code),
> and that's possible to have merged even if the binding isn't ready.
> 
> If you're unsure about something, but still want it merged, then you
> have to commit to maintaining that as far as reasonably possible, even
> if it turns out to not be quite right.

We are perfectly fine with maintaining *code*. And we have been doing
so for several years on Marvell platforms: caring about older
platforms, converting old legacy code and legacy platforms to the
Device Tree, etc.

What we don't want to commit to is to maintain the DT stability
*before* the support for a given device is sufficiently stable/sane.

> > Do you realize that this all DT binding stuff is today the *biggest* to
> > getting HW support in the Linux kernel? It has become more complicated
> > to merge a 4 properties DT binding than to merge multiple thousands of
> > lines of driver code. 
> 
> As times have changed, pain points have moved around.
> 
> To some extent that is unavoidable; more up-front effort is required
> where crutches we previously relied on are not applicable.
> 
> Elsewhere we can certainly do better.
> 
> Throwing your hands up and stating "this is unstable, it might change"
> is a crutch. It prevents any real solution to the pain points you
> encounter, and creates pain points for others. It only provides the
> _illusion_ of support.

Could you please explicit which pain points it creates for others ?

Having unstable DT bindings specific to a platform does not create any
single pain point for anyone.

Why are you talking about "illusion" of support ? Sorry, but with
unstable DT bindings, as long as you use the DT that comes with the
kernel sources, everything works perfectly fine, and is perfectly
supported.

Even Fedora is installing DTBs in a directory that is kernel-version
specific!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
