From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 7 Jun 2014 16:06:36 -0400 (EDT)
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 7 Jun 2014, Lorenzo Pieralisi wrote:

> On Sat, Jun 07, 2014 at 05:10:27PM +0100, Nicolas Pitre wrote:
> > On Sat, 7 Jun 2014, Abhilash Kesavan wrote:
> > 
> > > Hi Nicolas,
> > > 
> > > The first man of the incoming cluster enables its snoops via the
> > > power_up_setup function. During secondary boot-up, this does not occur
> > > for the boot cluster. Hence, I enable the snoops for the boot cluster
> > > as a one-time setup from the u-boot prompt. After secondary boot-up
> > > there is no modification that I do.
> > 
> > OK that's good.
> > 
> > > Where should this be ideally done ?
> > 
> > If I remember correctly, the CCI can be safely activated only when the 
> > cache is disabled.  So that means the CCI should ideally be turned on 
> > for the boot cluster (and *only* for the boot CPU) by the bootloader.
> 
> CCI ports are enabled per-cluster, so the boot loader must turn on
> CCI for all clusters before the respective CPUs have a chance to
> turn on their caches. It is a secure operation, this can be overriden
> and probably that's what has been done, wrongly.

Careful.  By saying "for all clusters" you might be interpreted as 
saying that the CCI must be turned on even for CPUs that are not powered 
up.

> True, TC2 on warm-boot reenables CCI, and that's because it runs the
> kernel in secure world, and again that's _wrong_.

Let me respectfully disagree.

> It must be done in firmware, and I am totally against any attempt at
> papering over what looks like a messed up firmware implementation with
> a bunch of hacks in the kernel, because that's what the patch below is
> (soft restarting a CPU to enable CCI ? and adding generic code for that ?
> what's next ?)

Are you promoting for the removal of drivers/bus/arm-cci.c ?

You do realize that the fundamental raison d'?tre for MCPM is actually 
to manage the race free enabling of the cache and CCI ?

> I understand there is an issue and lots at stake here, but I do not want the
> patch below to be merged in the kernel, I am sorry, it is a tad too much.

Lorenzo: Don't get me wrong.  The Chromebooks, and possibly to some 
extent some people at Samsung, were simply too confident in their 
ability to create absolutely bug-free firmware code to the point of not 
making its update easy in the field.  This is completely outrageous in 
my point of view.  Yet one of the reactions was to call upstream kernel 
people as purists because the kernel is so much easier to modify in 
order to cover their mess and yet that might not be accepted.  Like I 
said I won't stop shaming them publicly for their own "incompetence" 
just yet (no pun intended), but being excessively purist does not 
benefit anyone either, and for that they have a point.

*HOWEVER* I have no choice but to say that many people at ARM, including 
a couple individuals for whom I nevertheless have a lot of admiration, 
also have an incredible faith in their ability to convince themselves, 
and then turn around to preach to the world, that *more firmware* is 
going to be so much purer and solve so many more problems than it 
creates and become such a magical success that we should immediately 
dedicate our soul to the cause with no hint of a doubt.

I'm sorry to rain on your parade, but I don't believe in this one iota.

Let me repeat the MCPM story again: it took 3 people, including 2 from 
ARM, over *six* months to get everything right and stable on TC2. I 
think you also contributed to that effort as well. Subsequent MCPM 
backend contributions (yes, just the backend and not the core code) took 
at least *five* rounds of reviews in one case, and after *seven* rounds 
in another case it is still not right, despite the publicly available 
TC2 implementation to serve as a reference.

I'm sure each time a new patch set was posted, their authors honestly 
believed their code was correct.  Otherwise why would they post buggy 
code?

Now you are telling me that they should have put that code into firmware 
instead?  Can you realize what a catastrophe this would have been? Are 
you _seriously_ believing that they would be up to their 5th firmware 
revision by now?  And that updating their firmware six months after 
product launch would be as easy as updating the kernel?

Software ALWAYS has bugs, whether it is user apps, the kernel, firmware 
or boot ROM. The bigger one of those parts is, the more bugs it will 
have. And the cost to vendors for fixing those bugs grow exponentially 
down each level. For proof, we're now considering possible workarounds 
in the kernel to sidestep the difficulty with updating the firmware on a 
Chromebook.

Yet you're saying that firmware should grow code with the same 
complexity as the MCPM core, plus a machine specific backend that 
experience has proven multiple times is evidently hard to get right, 
into firmware because running Linux in secure mode is wrong?  If so we 
don't live in the same world indeed.

The day I see a firmware architecture that allows for 1) the same level 
of peer review as what we enjoy with the Linux kernel code and 2) the 
same ability to perform updates in the field as the kernel, then maybe I 
could be sold on the many advantages having generic firmware might have.  
In the meantime I consider complex firmware as a very suboptimal 
architecture with no bearing on the reality of actual short-cycled 
products, and if they prevail we'd better be ready to pile more of those 
ugly hacks in the kernel.


Nicolas
