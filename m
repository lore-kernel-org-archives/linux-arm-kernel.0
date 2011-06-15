From: tixy@yxit.co.uk (Tixy)
Date: Wed, 15 Jun 2011 13:24:35 +0100
Subject: [RFC] kprobes with thumb2 conditional code
In-Reply-To: <20110615111656.GA3434@arm.com>
References: <1299862881.2512.314.camel@computer2.home>
	<AANLkTikno84z6+gY9hevSG++jZJbYO--bynu_ixsmkB0@mail.gmail.com>
	<alpine.LFD.2.00.1103171825040.26889@xanadu.home>
	<1308131138.3154.9.camel@computer2>  <20110615111656.GA3434@arm.com>
Message-ID: <1308140675.3154.61.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-06-15 at 12:16 +0100, Dave Martin wrote:
> On Wed, Jun 15, 2011 at 10:45:38AM +0100, Tixy wrote:
> > I would like to revisit the discussion about how to handle kprobes
> > placed on conditionally executed instructions...
> > 
> > On Thu, 2011-03-17 at 18:46 -0400, Nicolas Pitre wrote: 
> > > On Thu, 17 Mar 2011, Dave Martin wrote:
> > > > On Fri, Mar 11, 2011 at 5:01 PM, Tixy <tixy@yxit.co.uk> wrote:
> > > > > it uses unconditional instructions for its breakpoints. With thumb
> > > > > instructions we can't force unconditional execution, so we would have an
> > > > > 'implementation defined' situation whether it would fire or not when the
> > > > > condition is false. (Thought you would hope it would be consistent on a
> > > > > particular device.)
> > > > >
> > > > > Some options for dealing with this, in increasing order of
> > > > > complexity...
> > > > >
> > > > > 1. Accept the situation as described.
> > > > >
> > > > > 2. Change arm probes to use conditional instructions so we would
> > > > > (hopefully) have consistent undefined behaviour in both arm and thumb
> > > > > code. (If that isn't an oxymoron :-)
> > > > >
> > > > > 3. Do 2, and modify kprobe_handler to test for false firings (breakpoint
> > > > > when condition false) and not execute the probe's callback functions in
> > > > > these cases. E.g. consistently make probe2 appear to not fire when
> > > > > condition is false.
> > > > 
> > > > My preference would be for option (1) or (3).  For (3), we could
> > > > choose to extend this behaviour to cover the existing ARM
> > > > implementation as well as Thumb, which could be a tidier and more
> > > > consistent approach.  This seems to be the "right" thing, since it
> > > > means kprobes never fire for real on instructions which are logically
> > > > not executed, no matter how the compiler (or human) implemented the
> > > > conditionality.  Currently, ARM kprobes can fire on instructions which
> > > > would fail their condition check, which might be considered wrong.
> > > 
> > > Definitely #3.
> > > 
> > > In the ARM case, this can be achieved by saving the condition code 
> > > of the replaced instruction when installing a probe, and test it 
> > > against the CPSR value from the interrupted state.  If the condition is 
> > > false then just skip the native emulation of the resulting NOP and 
> > > ignore the probe callback.  In the Thumb2 case the IT state in the CPSR 
> > > would indicate right away if the probe should be ignored.
> > 
> > If we don't fire a probe because a conditional instruction wouldn't be
> > executed then for branch instructions we only fire when branches are
> > taken. So, with things like loops...
> > 
> > 1:  movs r0, r0, asl #1
> >     bpl 1b
> > 
> > the probe would fire on every iteration of the loop except the last.
> > This inconsistency seems bad to me.
> > 
> > We could make exceptions for branches, and every other instruction which
> > can changes PC, but we would still have the issue that we can't force
> > unconditional firing of Thumb branches in an IT block.
> 
> I suspect that it's more common to see conditional branches outside IT
> blocks than inside, due to the different encodings available and the
> fact that it's most common for a conditional branch to follow some
> unconditional instruction to set up the condition.
> 
> According to my hacky measurements, only about 2% of the conditional
> branches in a typical vmlinux image are inside IT blocks.  So if we
> don't solve this case it may not be catastrophic.
> 
> > There doesn't appear to be a single satisfactory solution. 
> 
> Since the instruction stream can be reliably decoded _forwards_, we
> could trap on the branch-not-taken case by setting an additional probe
> after the affected branch.
> 
> Where branches appear in IT blocks, they're not allowed to be anywhere
> except at the end of the block, so the next instruction is either outside
> the block, or is an IT instruction itself (in which case we can still
> set a probe on it).  In valid code there will always be a next instruction,
> since the CPU will fall through the branch if the condition is false.

But, if we are asked to probe a normal unconditional branch, we don't
know if its in an IT block or not. E.g. the branch instruction in this:

	cmp	r1, #0
	itt	eq
	moveq	r0, #1
	beq	somewhere
	ldr	r0, [r1]

and in this:

	mov	r0, #1
	b	somewhere
	.word	some_literal_pool_value

are the same instruction, the 'beq' syntax is just for readability.

The real Thumb conditional branch instructions aren't allowed in IT
blocks. It was when I implemented emulation of these that I began to
have second thoughts about the approach to conditional instructions.

> That would deal with almost all cases, but it adds a bit of complexity
> so I'm not convinced it's worth it.

Too complex to go there ;-)

<big snip>
> Either way, we should of course document clearly the implemented
> kprobe firing behaviour so that people understand how to work with it.
> 
> Those are just my thoughts ... I don't think there's any single
> correct answer to how to implement this.  Going for the simplest
> reasonable-looking approach and changing it later if and only if
> this causes problems for people seems the best approach in such cases.
> 
> If you think that that #3 is not the simplest reasonable-looking
> approach after all, then I guess we can think about alternatives.

I'm now convinced that #3 is best after all. It is the only thing we can
get simple, consistent rules for. I.e.

        "Kprobes on conditional instructions don't trigger when the
        condition is false. For conditional branches, this means that
        they don't trigger in the branch not taken case."

-- 
Tixy
