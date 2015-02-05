From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Feb 2015 15:38:57 +0000
Subject: [PATCH 1/4] arm64: dts: fix PMU IRQ ordering for Juno
In-Reply-To: <E1YJNUw-00009i-28@mylo>
References: <1422294858-28100-1-git-send-email-will.deacon@arm.com>
 <20150205114642.GG11344@leverpostej>
 <20150205115416.GE23241@arm.com>
 <20150205115933.GI11344@leverpostej>
 <20150205120920.GF23241@arm.com>
 <20150205122048.GJ11344@leverpostej>
 <20150205124833.GV25675@voom.fritz.box> <E1YJNUw-00009i-28@mylo>
Message-ID: <20150205153857.GA20735@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 02:33:38PM +0000, Jon Loeliger wrote:
> So, like, David Gibson said:
> > 
> > On Thu, Feb 05, 2015 at 12:20:48PM +0000, Mark Rutland wrote:
> > > [Adding dtc folk]
> > > 
> > > On Thu, Feb 05, 2015 at 12:09:20PM +0000, Will Deacon wrote:
> > > > On Thu, Feb 05, 2015 at 11:59:33AM +0000, Mark Rutland wrote:
> > > > > On Thu, Feb 05, 2015 at 11:54:16AM +0000, Will Deacon wrote:
> > > > > > On Thu, Feb 05, 2015 at 11:46:42AM +0000, Mark Rutland wrote:
> > > > > > > On Mon, Jan 26, 2015 at 05:54:15PM +0000, Will Deacon wrote:
> > > > > > > > diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> > > > > > > > index cb3073e4e7a8..4ed9287aaef1 100644
> > > > > > > > --- a/arch/arm64/boot/dts/arm/juno.dts
> > > > > > > > +++ b/arch/arm64/boot/dts/arm/juno.dts
> > > > > > > > @@ -107,11 +107,11 @@
> > > > > > > >  	pmu {
> > > > > > > >  		compatible = "arm,armv8-pmuv3";
> > > > > > > >  		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > +			     <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > +			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > >  			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > >  			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > -			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > -			     <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > -			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > > +			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > >  	};
> > > > > > > 
> > > > > > > I am very much not keen on this. While this may get things working
> > > > > > > today, it completely relies on Linux-internal details (the order of CPU
> > > > > > > bringup, which in this case is different from the order of entries in
> > > > > > > /cpus).
> > > > > > > 
> > > > > > > In all other dts that I am aware of, the order of entries in /cpus
> > > > > > > aligns with the order of interrupts in the PMU node, and the first entry
> > > > > > > is the boot CPU.
> > > > > > > 
> > > > > > > I think that we should ensure that the ordering of CPU nodes matches the
> > > > > > > order of interrupts here. That way we can fall back to that ordering (if
> > > > > > > not explicitly overridden), and even after an arbitrary logical
> > > > > > > renumbering (e.g. after a kexec) the relationship should stay intact.
> > > > > > 
> > > > > > There are a few problems with reordering the CPU nodes:
> > > > > > 
> > > > > >   (1) It breaks any existing users of taskset to pin on big/little
> > > > > >       clusters.
> > > > > 
> > > > > This is unfortunate, but this is also the case if the boot CPU is
> > > > > different.
> > > > 
> > > > Right, so don't change the boot CPU. In that vain, we also shouldn't change
> > > > the CPU order in the .dts -- the current .dts is working for taskset and
> > > > we shouldn't break people's scripts just because they want to use the PMU.
> > > 
> > > I think this is an orthogonal discussion. If Linux is booted on a
> > > different CPU, it's not the fault of Linux that CPU0 is different.
> > > 
> > > > > >   (2) It's not generally possible if, for example, the bootloader decides
> > > > > >       to boot Linux on a different CPU then we have no choice but to
> > > > > >       change the PMU interrupt order.
> > > > > 
> > > > > In that case _this_ patch is broken.
> > > > 
> > > > Why? I'm not denying that changing the boot CPU causes problems, I'm saying
> > > > that you *can't* fix that by changing the CPU node order. You still have
> > > > to change the interrupt order in that case, so why not just localise the
> > > > changes there in the first place?
> > > 
> > > If we're going to try to maintain support for these DTs long-term (with
> > > kexec and whatever logical renumbering can occur there), then we need a
> > > consistent invariant that we can rely on to associate interrupts and
> > > CPUs correctly.
> > > 
> > > The Linux logical ordering is not invariant, so we know that this _will_
> > > break.
> > > 
> > > As far as I am aware, every other DT lists the boot CPU first, and the
> > > order of entries in /cpus mathes the logical order. Using the order of
> > > entries in /cpus will remain consistent in the face of arbitrary
> > > renumbering, and is (currently) consistent with logical numbering.
> > > 
> > > So keeping the CPU nodes and interrupt entries in the same order
> > > provides us with a long-term consistent order, regardless of which CPU
> > > is the boot CPU.
> > > 
> > > This DT is currently broken. If we're going to make it work we should do
> > > so in a manner that will continue to work. Anything else is a broken
> > > bodge that hurts us in the long-term as we'll have to hack around it.
> > > 
> > > > > If we associate the interrupt with a CPU by node order, the relationship
> > > > > is preserved regardless of which CPU is the boot CPU (whether it was the
> > > > > bootloader's choice, kexec, or whatever).
> > > > 
> > > > Sure, and that requires code changes. If we're going to change the code,
> > > > then I'd much rather we make the binding explicit, like I did in the
> > > > follow-up patches to this one. As I mentioned before, this is a .dts fix
> > > > to get things working with the current code. It's really too late to argue
> > > > about the existing binding, even if it sucks.
> > > 
> > > Sure, the binding sucks.
> > > 
> > > This DT has also _never_ worked.
> > > 
> > > If we're going to fix things, let's not introduce a middle step that's
> > > broken in a different way.
> > > 
> > > > > >   (3) I didn't think that the ordering of CPU nodes was guaranteed to be
> > > > > >       preserved by dtc, whereas the order of the interrupts will be.
> > > > > 
> > > > > The order of nodes is presently preserved.
> > > > 
> > > > It's not about the present behaviour; I need a _guarantee_ that dtc/libfdt
> > > > will *never* reorder CPU nodes. Today's working .dts file needs to continue
> > > > to work with future tools.
> > >
> > > Jon, David, Grant, thoughts?
> > 
> > As a general rule, neither dtc nor libfdt will re-order any nodes
> > unless you explicitly ask them to (e.g. dtc's "-s" option).  That
> > said, you should try not to rely on dt order.
> 
> 
> Hi guys,
> 
> As you explicitly solicited my opinion, I will tell you what I think.
> 
> First, I agree with David: DTC and libfdt are not gratuitously
> re-ordering the nodes within the tree.  But nothing should rely
> on that behaviour either.  It is a tree, and the children of a
> particular node are unordered.  There *are* manipulation primitives
> that can cause a restructuring of the tree, and DTS consumers should
> be prepared to accomodate that.
> 
> Second, that Linux assumes an ordering on nodes from the tree is
> really unfortunate.  I think we should try to remoce any such
> dependency or accomodate a more relaxed DTB read.

I agree. Will's later patch will do this by describing the relationship
between interrupts and CPUs explciitly:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/319899.html

> Finally, remember that the DTS is supposed describe the hardware.
> The hardware doesn't (*usually*) require an ordering on its
> components.  In a true SMP, it is S -- symmetric -- and shouldn't
> rely on one Core being more first than another.  That one is treated
> as a special entity is entirely a SW description.  As such, it
> really shouldn't be represented as some tacit or hidden fact within
> the DTS.

I completely agree with this, which is why I'm opposed to relyiong on
the order Linux probes CPUs (as this has no guaranteed relationship with
the DTB).

While relying on the order of CPU nodes is not something I want to do,
it's at least contained within the DTB and has some chance of
functioning when Linux aribtrarily renumbers CPUs.

Does that make sense?

Thanks,
Mark.
