From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Dec 2010 13:20:29 +0000
Subject: arm cortex_a9_mpcore timer: local timer and global timer
In-Reply-To: <20101216130659.GS9937@n2100.arm.linux.org.uk>
References: <AAD1C6EB06EE3649B35B7E026785068D15345BE603@SC-VEXCH2.marvell.com>
	<AANLkTikt+CzkLBR5OCnjPUSLaLtuuBvGFSJVj+t0rRc2@mail.gmail.com>
	<20101216130659.GS9937@n2100.arm.linux.org.uk>
Message-ID: <1292505629.13150.69.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-12-16 at 13:06 +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 16, 2010 at 12:59:13PM +0000, Catalin Marinas wrote:
> > On 16 December 2010 02:02, Chao Xie <cxie4@marvell.com> wrote:
> > > In the latest arm kernel, I find that smp_twd.c has implemented
> local timer for cortex a9 MPcore. In the spec, there is global timer
> that shared by all MPcore. I did not find any implements in the arm
> kernel. What is the strategy of using these two kinds of timer? I find
> that some SOCs have additional timer which is not the local timer or
> global timer in MPcore. Then what is the strategy of using this kind
> of timer with local timer and global timer in the kernel? Thanks.
> >
> > We currently don't have any support for the global timer available on
> > Cortex-A9. It is on our to-do list but not sure when we'll have time
> > (unless someone else does it before :)).
> >
> > On the current smp_twd.c implementation, a global timer is required to
> > calibrate the local timers. So far we use the SP804 on the RealView
> > and Versatile Express boards but we could, at some point, move to the
> > global timer on A9.
> 
> MSM brings up an interesting point through - it only has local timers.
> From what I can see, it's using the CPU0 local timer as a global timer.

Yes, it's a different v7 implementation. We actually have something
similar with Cortex-A15 - it has the new architected timers and they are
local. As long as you know the frequency they are running at, you don't
need a global timer.

> I think an interesting exercise would be to allow platforms to only
> have local timers without any global timer.

I think that's possible. Even in the current configurations, the local
timers have higher priority and the global is no longer used.

We'll do this exercise for A15 on top of VE (well, only software model
at the moment).
> 
> It also means that if we do have local timers configured, we don't need
> to support a global timer (unless we need it for sleep wakeup.)

I'm not entirely sure about the sleep wake-up. I recall OMAP had issues
as the local timers couldn't wake up a CPU.

-- 
Catalin
