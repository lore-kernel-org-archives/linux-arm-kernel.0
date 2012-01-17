From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Jan 2012 11:32:23 +0000
Subject: [RFC PATCH] ARM: new architecture for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <20120116190637.GE32049@n2100.arm.linux.org.uk>
References: <1324480428-13344-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CADMYwHzE0HeBKjA55ApQo0k5AW8+Za3kT8u5HnMorXEk4PQxjA@mail.gmail.com>
 <20120116162933.GG14252@pengutronix.de>
 <20120116174039.GD32049@n2100.arm.linux.org.uk>
 <20120116181002.GC12267@arm.com>
 <20120116190637.GE32049@n2100.arm.linux.org.uk>
Message-ID: <20120117113222.GA11475@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 07:06:37PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 16, 2012 at 06:10:02PM +0000, Catalin Marinas wrote:
> > On Mon, Jan 16, 2012 at 05:40:39PM +0000, Russell King - ARM Linux wrote:
> > > The VFP stuff - adding 'clean' which is kernel state to the _user_
> > > _exported_ VFP hardware structure is a bad idea.  So this needlessly
> > > causes a variation in the kernels userspace API.  Please find somewhere
> > > else to keep kernel internal state.  (As that patch comes from Catalin,
> > > then that comment is directed to Catalin.)
> > 
> > Are you sure we export vfp_hard_struct to user? That's a kernel-only
> > structure (and it's not by any means stable, given the number of
> > #ifdef's it has). I would also argue that 'clean' is a hardware state
> > (inferred from the exception return value).
> 
> Actually, looking at arch/arm/kernel/ptrace.c, we only export the
> fpregs and fpscr, so this should be fine.
> 
> Still, I don't see why we need this 'clean' state, when normal VFP
> doesn't need it.  Maybe you could explain why it's necessary?

The FP support on the M profile is a bit different (in terms of control
registers) from the A/R profiles. The M profile has built-in knowledge
of the AAPCS for automatically preservation of certain registers during
exceptions and it can also do lazy saving of the S0-S15 FP registers.
In general the M processors are meant to be simpler to use without a
complex OS (especially if thread switching is done synchronously at SVC
time rather than during interrupts).

For example, when user space gets an exception, the M core saves R0-R3,
R12, LR, PC, xPSR on the user stack automatically. It also preserves
space for S0-S15 and FPSCR but does not save them (it remembers the
address though for lazy saving if new thread uses the FP). If another
thread tries to use the FP for the first time, it saves the old FP state
and initialises a new one for the current thread automatically. But once
a thread touched the FP, its state is no longer 'clean' and it is
automatically loaded (non-lazily) from the stack when switching to such
thread while saving the old one on the previous stack. When switching
between two threads that have never used the FP, the processor does not
do any FP state switching.

However, it does not save S16-S31 as the AAPCS specifies that they are
caller-saved. Linux needs to do this and it uses the 'clean' state to
detect whether a thread used the FP or not. The disadvantage is that if
a thread ever used FP, its state is always saved/restored at context
switch.

Of course, we can change all this and disable the hardware automatic
saving while implementing a pure software lazy switching solution using
the CPACR (there is no FPEXC). But at the time this was the simplest
implementation, given that Cortex-M3 doesn't even have an FP unit (it
came with Cortex-M4) and most M3 software around didn't touch the FP at
all.

BTW, if you are fine with trying to get the M support into mainline, I'm
happy to revisit the code (probably with Uwe's help given that I don't
have much time available).

-- 
Catalin
