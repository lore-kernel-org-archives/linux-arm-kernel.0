From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Apr 2010 15:17:59 +0100
Subject: [RFC PATCH 2/4] ARM: hw-breakpoint: add ARM backend for the
	hw-breakpoint framework
In-Reply-To: <20100415225950.GI5069@nowhere>
References: <1268236874-7877-1-git-send-email-will.deacon@arm.com>
	<1268236874-7877-2-git-send-email-will.deacon@arm.com>
	<1268236874-7877-3-git-send-email-will.deacon@arm.com>
	<h2mc62985531004130632kd086ffe9o16edafc359fa0e2@mail.gmail.com>
	<1271173965.17356.28.camel@e102144-lin.cambridge.arm.com>
	<20100413204000.GC5602@nowhere>
	<1271240821.11060.3.camel@e102144-lin.cambridge.arm.com>
	<20100415225950.GI5069@nowhere>
Message-ID: <1271427479.21600.1.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frederic,

Thanks for addressing some of these problems.

> > There are two related issues here:
> >
> > 1.) A watchpoint can be synchronous or asynchronous, you can determine which when
> >     you take the exception. If the watchpoint is synchronous, then yes, we can look
> >     at the trapped regs to find the causative instruction. Then we would need to
> >     disassemble the instruction and emulate the address generation part [which may
> >     also need the trapped regs] in order to calculate the faulting data address.
> >     If the watchpoint exception is asynchronous, we can read the WFAR register to
> >     find the address of the causative instruction. Unfortunately, we could still
> >     be screwed in this case because we won't be able to emulate the address
> >     calculation for a register-relative load/store. Thankfully, v7 cores only
> >     generate synchronous watchpoints [apart from some very early revisions which
> >     you won't see in the wild] but v6 cores are the opposite; they only generate
> >     asynchronous watchpoint exceptions.
> >
> > 2.) For a standard data abort, the DFAR is updated to contain the data address which
> >     caused the fault. Ideally this would also be the case for watchpoint exceptions
> >     because then we wouldn't have to disassemble anything [and as I mentioned
> >     previously, I'm yet to find a real implementation that doesn't set the DFAR on
> >     taking a watchpoint, but it's not something that the architecture guarantees].
> 
> 
> 
> It's a cruel architecture...
> 

It grows on you :)

> > > > > Ah and it will make ptrace support easier: the user writes into the val/ctrl
> > > > > fields directly as if they were the true registers, then you can just validate
> > > > > the fields you want without bitwise ops.
> > > > >
> > > > I'm unsure about this. As mainline stands, ARM has no ptrace support for the
> > > > hardware breakpoint registers. This means that we could expose the
> > > > hardware resources in an idealised fashion via ptrace so that if the
> > > > interface varies between CPUs, userspace doesn't need to care. I had a
> > > > crack at this with another patch in the series here:
> > > >
> > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011169.html
> > >
> > >
> > >
> > > Ah, indeed if you need to abstract out various ARM versions, that's quite sensitive.
> > > I'm going to look at this thread too.
> >
> > It's not so much about necessity, but I think it would be nice if userspace
> > didn't have to care so much about the breakpoint/watchpoint debug hardware on the
> > target. Since we don't have any backwards compatibility issues [because ptrace in
> > mainline has never supported hardware breakpoints on ARM] we can define a stable
> > API regardless of the hardware.
> 
> 
> Yeah, looking at how this is implemented across versions, it seems
> that they all share the same registers, but early versions have
> unfeatured reserved bytes in control registers that are filled
> with new features over time in subsequent versions.
> 
> It looks like the things are then forward compatible but not
> backward.
> 
> Isn't that enough to provide a ptrace interface? I mean you can't do
> much magic here. Having something that works everywhere would consist
> in implementing only the minimal set of features only.

I suppose the ptrace interface will involve bit-packing at some point anyway,
so mirroring the hardware configuration might not be as bad as I initially thought.
The hardware has some slightly more esoteric features [breakpoint linking, context
matching etc] that won't be supported in software for now so I'll ignore those bits.

> > I'm unsure about how to provide full protection though. You could still
> > set a breakpoint on the breakpoint handling code that exists outside of the
> > exception text. Do other archs suffer from this problem? I'm tempted
> > just to disallow Kernel breakpoints for now, but that would be a shame.
> 
> 
> In x86 we just write the control register to disable the breakpoints
> in the exception handler. (I suspect we don't do it early enough though).
> 
> You can do the same in ARM.

Ok.
 
> > One thing that has hit me is the behaviour of the framework when a breakpoint
> > is hit. If the breakpoint is synchronous, after the exception has been handled
> > [and perf_bp_event has been called], execution will restart at the faulting
> > instruction. It is down to the client program [traditionally a debugger] to
> > remove the breakpoint, single-step and re-insert the breakpoint. Obviously the
> > perf tool doesn't do this, so if you try to perf stat a breakpoint event you
> > will livelock [potentially another reason to disable Kernel breakpoints?]
> 
> 
> If I understand you correctly,
> 
> sync = breakpoint triggers before the instruction is executed,
>        trap return to the faulting instruction
> async = breakpoint triggers after the instruction is executed

That's right.
 
> Then yeah, the current breakpoint framework only supports async
> ones.

Oh no!

> If an arch has no choice but using sync breakpoints, it needs
> to handle that. It seems PowerPc has a similar problem, may be
> have a look at Prasad's patches.

Could you give me a pointer to these patches please [I can't see them on LKML]?
I *think* PowerPC is lucky enough to have hardware single step, so handling
synchronous breakpoints isn't *too* difficult. In ARM we have to work out the
address of the following instruction, which is quite tricky because it could be a
branch instruction [from a selection of instruction sets] and also be predicated.
GDB can handle this, but the Kernel doesn't have the capability to do so [there's
some code in arch/arm/ptrace.c but it's not feature complete].

> If there is something that can be handled from the generic
> layer to help solving this problem, I'll try something.

Unfortunately this is very much an arch problem. As a half-way house, I might
implement only the ptrace part of hw-breakpoint for ARM. That way we can
force the client to handle stepping over the breakpoint and we also won't have
to worry about recursive breakpoints in the Kernel.

Cheers,

Will
