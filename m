From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Sat, 7 Jun 2014 23:36:14 +0100
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
Message-ID: <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 07, 2014 at 09:06:36PM +0100, Nicolas Pitre wrote:
> On Sat, 7 Jun 2014, Lorenzo Pieralisi wrote:
> 
> > On Sat, Jun 07, 2014 at 05:10:27PM +0100, Nicolas Pitre wrote:
> > > On Sat, 7 Jun 2014, Abhilash Kesavan wrote:
> > > 
> > > > Hi Nicolas,
> > > > 
> > > > The first man of the incoming cluster enables its snoops via the
> > > > power_up_setup function. During secondary boot-up, this does not occur
> > > > for the boot cluster. Hence, I enable the snoops for the boot cluster
> > > > as a one-time setup from the u-boot prompt. After secondary boot-up
> > > > there is no modification that I do.
> > > 
> > > OK that's good.
> > > 
> > > > Where should this be ideally done ?
> > > 
> > > If I remember correctly, the CCI can be safely activated only when the 
> > > cache is disabled.  So that means the CCI should ideally be turned on 
> > > for the boot cluster (and *only* for the boot CPU) by the bootloader.
> > 
> > CCI ports are enabled per-cluster, so the boot loader must turn on
> > CCI for all clusters before the respective CPUs have a chance to
> > turn on their caches. It is a secure operation, this can be overriden
> > and probably that's what has been done, wrongly.
> 
> Careful.  By saying "for all clusters" you might be interpreted as 
> saying that the CCI must be turned on even for CPUs that are not powered 
> up.

Right, CCI snoops and DVMs for a cluster must be enabled by the first man
running in that cluster upon cluster power up with caches off, where the
first man must be arbitrated if multiple CPUs are racing for enabling CCI.
This is not an issue on cold boot, it is on resuming from CPUidle.

> > True, TC2 on warm-boot reenables CCI, and that's because it runs the
> > kernel in secure world, and again that's _wrong_.
> 
> Let me respectfully disagree.

You are welcome =)

> > It must be done in firmware, and I am totally against any attempt at
> > papering over what looks like a messed up firmware implementation with
> > a bunch of hacks in the kernel, because that's what the patch below is
> > (soft restarting a CPU to enable CCI ? and adding generic code for that ?
> > what's next ?)
> 
> Are you promoting for the removal of drivers/bus/arm-cci.c ?

I really do not want to go there, but I might (apart from CCI PMUs).

> You do realize that the fundamental raison d'?tre for MCPM is actually 
> to manage the race free enabling of the cache and CCI ?

Yes I do and I was willing to help implement it for TC2 to provide people
with an example on how to do it _properly_ (in secure world though, and that
was a mistake IMHO). If what we get is a workaround for every platform
going upstream, we are in a bind, seriously.

Whatever the outcome of this thread, a booting protocol update for CCI
is in order, even if we have to debate it for 6 months or more to get
an agreement.

> > I understand there is an issue and lots at stake here, but I do not want the
> > patch below to be merged in the kernel, I am sorry, it is a tad too much.
> 
> Lorenzo: Don't get me wrong.  The Chromebooks, and possibly to some 
> extent some people at Samsung, were simply too confident in their 
> ability to create absolutely bug-free firmware code to the point of not 
> making its update easy in the field.  This is completely outrageous in 
> my point of view.  Yet one of the reactions was to call upstream kernel 
> people as purists because the kernel is so much easier to modify in 
> order to cover their mess and yet that might not be accepted.  Like I 
> said I won't stop shaming them publicly for their own "incompetence" 
> just yet (no pun intended), but being excessively purist does not 
> benefit anyone either, and for that they have a point.

I do not think they do. The kernel should not become a place where firmware
bugs are fixed, if you refuse to fix the bug and this code does not get
upstream I am pretty sure next time more attention will be paid.

Booting, powering up and down cores are standard procedures, why can't we
share the same code for all v7 platforms ? Why ?

And we are not talking about a race condition hit every 10 gazillions
cycles here.

> *HOWEVER* I have no choice but to say that many people at ARM, including 
> a couple individuals for whom I nevertheless have a lot of admiration, 
> also have an incredible faith in their ability to convince themselves, 
> and then turn around to preach to the world, that *more firmware* is 
> going to be so much purer and solve so many more problems than it 
> creates and become such a magical success that we should immediately 
> dedicate our soul to the cause with no hint of a doubt.
> 
> I'm sorry to rain on your parade, but I don't believe in this one iota.
> 
> Let me repeat the MCPM story again: it took 3 people, including 2 from 
> ARM, over *six* months to get everything right and stable on TC2. I 
> think you also contributed to that effort as well. Subsequent MCPM 
> backend contributions (yes, just the backend and not the core code) took 
> at least *five* rounds of reviews in one case, and after *seven* rounds 
> in another case it is still not right, despite the publicly available 
> TC2 implementation to serve as a reference.
> 
> I'm sure each time a new patch set was posted, their authors honestly 
> believed their code was correct.  Otherwise why would they post buggy 
> code?
> 
> Now you are telling me that they should have put that code into firmware 
> instead?  Can you realize what a catastrophe this would have been? Are 
> you _seriously_ believing that they would be up to their 5th firmware 
> revision by now?  And that updating their firmware six months after 
> product launch would be as easy as updating the kernel?

If firmware messes up the DMC controller configuration, would you fix
it in the Linux kernel ? It is an unrealistic (well..) example but you should
catch my drift.

Where do we draw the line, that's my point.

> Software ALWAYS has bugs, whether it is user apps, the kernel, firmware 
> or boot ROM. The bigger one of those parts is, the more bugs it will 
> have. And the cost to vendors for fixing those bugs grow exponentially 
> down each level. For proof, we're now considering possible workarounds 
> in the kernel to sidestep the difficulty with updating the firmware on a 
> Chromebook.
> 
> Yet you're saying that firmware should grow code with the same 
> complexity as the MCPM core, plus a machine specific backend that 
> experience has proven multiple times is evidently hard to get right, 
> into firmware because running Linux in secure mode is wrong?  If so we 
> don't live in the same world indeed.
> 
> The day I see a firmware architecture that allows for 1) the same level 
> of peer review as what we enjoy with the Linux kernel code and 2) the 
> same ability to perform updates in the field as the kernel, then maybe I 
> could be sold on the many advantages having generic firmware might have.  
> In the meantime I consider complex firmware as a very suboptimal 
> architecture with no bearing on the reality of actual short-cycled 
> products, and if they prevail we'd better be ready to pile more of those 
> ugly hacks in the kernel.

Nicolas: it is not a matter of PSCI vs. MCPM, firmware vs. the kernel,
that's a debate worth having, not now.

There is a bug to solve, and you did. What I am telling you is that
I am fed up to my back teeth of having code in the kernel solving
issues that should not be solved in the kernel, if we keep doing that
hacks will become the rule not the exception. Time to draw a line,
firmware is broken, so is the platform. (BTW, if anyone can explain to
me how CPUidle works in this platform, and that's the main reason of
having MCPM in there, I am all ears).

Adding these hacks has serious maintainance consequences (eg CPUidle
code) and that's the main reason I jumped into this discussion.

Let me reiterate my point: it is not a kernel vs firmware debate, it
is about clean and maintainable code vs hackish and unmaintainable
code in the kernel.

And of top of that, people must test their code, we are not talking
about a rare race condition here, this is a blatant bug.

I have lots to add concerning the firmware implementations of power
down procedures, but let's take it offline.

I am not happy with merging your patch, I am sorry, for the reasons I've
just explained.

Lorenzo
