From: tixy@yxit.co.uk (Tixy)
Date: Wed, 15 Jun 2011 10:45:38 +0100
Subject: [RFC] kprobes with thumb2 conditional code
In-Reply-To: <alpine.LFD.2.00.1103171825040.26889@xanadu.home>
References: <1299862881.2512.314.camel@computer2.home>
	<AANLkTikno84z6+gY9hevSG++jZJbYO--bynu_ixsmkB0@mail.gmail.com>
	<alpine.LFD.2.00.1103171825040.26889@xanadu.home>
Message-ID: <1308131138.3154.9.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I would like to revisit the discussion about how to handle kprobes
placed on conditionally executed instructions...

On Thu, 2011-03-17 at 18:46 -0400, Nicolas Pitre wrote: 
> On Thu, 17 Mar 2011, Dave Martin wrote:
> > On Fri, Mar 11, 2011 at 5:01 PM, Tixy <tixy@yxit.co.uk> wrote:
> > > it uses unconditional instructions for its breakpoints. With thumb
> > > instructions we can't force unconditional execution, so we would have an
> > > 'implementation defined' situation whether it would fire or not when the
> > > condition is false. (Thought you would hope it would be consistent on a
> > > particular device.)
> > >
> > > Some options for dealing with this, in increasing order of
> > > complexity...
> > >
> > > 1. Accept the situation as described.
> > >
> > > 2. Change arm probes to use conditional instructions so we would
> > > (hopefully) have consistent undefined behaviour in both arm and thumb
> > > code. (If that isn't an oxymoron :-)
> > >
> > > 3. Do 2, and modify kprobe_handler to test for false firings (breakpoint
> > > when condition false) and not execute the probe's callback functions in
> > > these cases. E.g. consistently make probe2 appear to not fire when
> > > condition is false.
> > 
> > My preference would be for option (1) or (3).  For (3), we could
> > choose to extend this behaviour to cover the existing ARM
> > implementation as well as Thumb, which could be a tidier and more
> > consistent approach.  This seems to be the "right" thing, since it
> > means kprobes never fire for real on instructions which are logically
> > not executed, no matter how the compiler (or human) implemented the
> > conditionality.  Currently, ARM kprobes can fire on instructions which
> > would fail their condition check, which might be considered wrong.
> 
> Definitely #3.
> 
> In the ARM case, this can be achieved by saving the condition code 
> of the replaced instruction when installing a probe, and test it 
> against the CPSR value from the interrupted state.  If the condition is 
> false then just skip the native emulation of the resulting NOP and 
> ignore the probe callback.  In the Thumb2 case the IT state in the CPSR 
> would indicate right away if the probe should be ignored.

If we don't fire a probe because a conditional instruction wouldn't be
executed then for branch instructions we only fire when branches are
taken. So, with things like loops...

1:  movs r0, r0, asl #1
    bpl 1b

the probe would fire on every iteration of the loop except the last.
This inconsistency seems bad to me.

We could make exceptions for branches, and every other instruction which
can changes PC, but we would still have the issue that we can't force
unconditional firing of Thumb branches in an IT block.

There doesn't appear to be a single satisfactory solution. 

Perhaps we should do option #1, i.e. don't change anything and have
probes always firing except when breakpoints are missed in IT blocks due
to the condition being false.

Or looking at it another way, leave things as the are until someone
comes up with a real-life use-case which indicates that a change is
needed.

-- 
Tixy 
