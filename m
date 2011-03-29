From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 29 Mar 2011 12:55:27 -0400 (EDT)
Subject: [PATCH] Fix ldrd/strd emulation for kprobes/ARM
In-Reply-To: <4D91C1EF.1040102@nokia.com>
References: <1301087944.2744.85.camel@computer2.home>
	<1301327765-6996-1-git-send-email-viktor.rosendahl@nokia.com>
	<alpine.LFD.2.00.1103281822170.11889@xanadu.home>
	<4D91C1EF.1040102@nokia.com>
Message-ID: <alpine.LFD.2.00.1103291235380.11889@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Mar 2011, Viktor Rosendahl wrote:

> On 03/29/2011 01:39 AM, ext Nicolas Pitre wrote:
> > I agree that it might be a better idea to simply reject the dubious
> > cases upfront from arm_kprobe_decode_insn() and keep the actual
> 
> What do you mean by "dubious cases" ?
> 
> Do you mean oddball special cases of instructions that are fully legal with a
> well defined behavior, although they are unlikely to be emitted by gcc ?
> 
> ..or do you mean instructions whose behavior are undefined by the current
> architecture but would not necessarily cause an illegal instruction exception
> ?

Probably both.  This code is already complex enough as it is now, so if 
unused conplexity can go then it'll be easier to make it efficient and 
bug free.  And since our target is the kernel itself then we know with a 
high degree of confidence what kind of instructions we have to deal 
with.

> My take is that it could be worth checking for as many as possible of the
> legal oddball cases. When it comes to instructions with undefined behavior, I
> think the ideal would be if they are rejected by arm_kprobe_decode_insn().

Yes.

> My guess is that most of the kprobe slowdown will not anyway come from a few
> extra checks in the emulation/simulation code but from the handling of the
> illegal instruction exceptions that will occur when the probe is hit and at
> the end of single stepping.

Surely, but those extra checks havean implied maintenance cost too by 
making the code less obvious.

> > I think this is highly unlikely that we would find
> > some usage of LDRD/STRD indexed by r15 in the kernel.
> > 
> 
> I guess that depends on the gcc backend. When doing an "objdump -d vmlinux", I
> found this:
> 
> b00165fc <sort_main_extable>:
> b00165fc:	e59f0004 	ldr	r0, [pc, #4]	; b0016608
> b0016600:	e59f1004 	ldr	r1, [pc, #4]	; b001660c
> b0016604:	ea074262 	b	b01e6f94 <sort_extable>
> b0016608:	b0548840 	.word	0xb0548840
> b001660c:	b0549770 	.word	0xb0549770

Sorry, I meant r15-indexed with a write back.

> Now, I admit that it's possible that somewhere beyond the horizon of my
> understanding there is some good reason to do two LDRs into adjacent registers
> from adjacent memory addresses, instead of merging them into one LDRD.

In this case I suspect that the loaded values were pushed to the literal 
pool, and it is hard for the compiler to ensure the placement is always 
64-bit aligned.

> However, it gives me the impression that it would not be that unlikely that
> some future version of gcc could generate an LDRD in some function prologues.
> 
> BTW, in my kernel, LDR indexed by r15 is a really common instruction at the
> very beginning of functions. I am not sure why; it could have something to do
> with the fact that the kernel is compiled without frame pointers.

No, it's all about literal pool usage.  When you have to load the value 
0x12345678, it is cheaper to simply store the value out of line, and 
perform a relative load like this:

	ldr	r0, [pc, #_val - . - 8]
	...

_val:	.word	0x12345678

Sometimes, hand written assembly code would use this syntax:

	ldr	r0, =0x12345678

and the assembler will do the job of translating that into the above 
form automatically, or simply turn that into a "mov r0, #<value>" if the 
value is actually narrow enough to fit in the immediate constant 
constraint.

But nowhere will you find pc-indexed addressing with a writeback.  
That's one of the cases I think should be rejected upfront instead of 
evaluating this possibility which is likely to never happen in practice 
each time the instruction is emulated.


Nicolas
