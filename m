From: will.deacon@arm.com (Will Deacon)
Date: Wed, 13 May 2015 17:04:42 +0100
Subject: [EDT] [PATCH 1/1] Fix: hw watchpoint continually triggers callback
In-Reply-To: <1680595986.99931431494070231.JavaMail.weblogic@ep2mlwas08c>
References: <1680595986.99931431494070231.JavaMail.weblogic@ep2mlwas08c>
Message-ID: <20150513160442.GF3343@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 06:14:30AM +0100, Vaneet Narang wrote:
> EP-2DAD0AFA905A4ACB804C4F82A001242F

Ok, I have to ask: what on Earth is this number and what does [EDT] mean?

> >On Tue, May 12, 2015 at 02:12:54PM +0100, Vaneet Narang wrote:
> >> On Tue, May 12, 2015 at 12:48:13PM +0100, Maninder Singh wrote:
> >> This fix is given for kernel developers who wants to use perf interface by
> >> registering callback using register_wide_hw_breakpoint API.  On every
> >> callback trigger they have to unregister watchpoints otherwise callback
> >> gets called in a loop and now issue is "when to register watch point back
> >> ?". 
> 
> >If you want to solve this, I think we need a better way to expose software
> >single-step/emulation to the overflow handler. If we try to do this in
> >the hw_breakpoint code itself, we run into problems:
> 
> >  - What if another thread hits the same instruction whilst we are trying
> >   to step it?
> 
> >  - What if there are two breakpoints or a breakpoint + watchpoint
> >   triggered by the same instruction?
> 
> Thanks for you input. I am not sure, issues which you have mentioned with
> this implementation will actually come.
> To address the issues you have raised, I need to brief about kprobe.
> Kprobe follows 3 steps for breakpoint (BP) handling.
> 1. Decode BP instruction.
> 2. Replace BP instruction with new instruction that will generate SWI.
> 3. Execute instruction & move PC to next instruction.
> Kprobe follows step 1 & step 2 on addition of BP and 3rd step is followed
> when SWI gets triggered.
> 
> For this fix we have used step 1 & step 3, we have skipped step 2. As we
> don't know the caller of watch point & also HW generates interrupt so step
> 2 is not required. The only difference is since we don't know the caller
> we can't decode instruction in advance. We have to follow step 1 and step
> 3 when HWI gets triggered.  Since we are not replacing instruction from
> memory and I assume kprobe implementation for execution of instruction in
> interrupt context is tested and stable, so it shouldn't  produce any of
> the above race condition issues.

Ok, so my first point shouldn't be a problem if we're just emulating the
instruction. However, I still think there are corner cases. For example,
imagine hitting a breakpoint on a ldr pc, [&foo] instruction where we've
also got a watchpoint on foo. Even with emulation, it's going to be
difficult to ensure that watchpoint is safely delivered.

As I say, I'd really rather have a kprobes-agnostic way of stepping an
instruction and let the debugger decide whether it wants to use that or
not.

> >  - What if the debugger didn't want to execute the instruction at all?
> 
> if debugger doesn't want to execute instruction then debugger should use
> single step implementation without overflow handler. 

But the debugger might want to use the overflow handler to regain control
on the exception (like ptrace does for userspace).

Will
