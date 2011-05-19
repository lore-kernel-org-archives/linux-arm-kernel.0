From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 19 May 2011 10:47:53 +0100
Subject: Question on ARM inline assembly - stackframes, sp/fp usage,
	__naked
In-Reply-To: <alpine.DEB.2.00.1105190858320.2374@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105181505080.2374@localhost6.localdomain6>
	<20110518174531.GA28300@arm.com>
	<alpine.DEB.2.00.1105190858320.2374@localhost6.localdomain6>
Message-ID: <20110519094753.GB2431@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 09:46:30AM +0100, Frank Hofmann wrote:
> 
> 
> On Wed, 18 May 2011, Dave Martin wrote:
> 
> >On Wed, May 18, 2011 at 04:25:15PM +0100, Frank Hofmann wrote:
> >>Hi,
> >>
> >>
> >>with the work on the hibernation support code, I've managed to make
> >>it all C-with-inline-asm. This happens to work fine on OMAP3, but
> >>there's an issue when I build it for Samsung 64xx. It's about this
> >>code:
> >>
> >>
> >>int __naked swsusp_arch_resume(void)
> >>{
> >>	register struct pbe *pbe;
> >>	register void *sp asm("sp") = swsusp_resume_stack + PAGE_SIZE - 8;
> >
> >(Why - 8?)
> 
> Sorry, my mistake, thought PUSH is post-decrement (empty
> descending). From that assumption and the 8-byte-alignment-at-call,
> the offset were necessary. You're right it's not needed.
> Thanks for spotting.

OK -- I thoughr you might be using the top two words for something else.

push is just the same as stmfd sp!,

> 
> >
> >>	register void *saved_ctx asm ("r0") = ctx;
> >>
> >>	__asm__ __volatile__("" : "+sp"(sp));		/* don't optimize away ! */
> >
> >Is this an attempt to force gcc to change sp before the subsequent loop?
> 
> That's exactly what it does.
> 
> >I think you don't mean "+sp".  Something like "+r" might be appropriate.
> >
> >This feels subtle and fragile to me.
> 
> Looked this up; again you're right the direct use of "rXX" (or the
> higher reg names) for gcc ARM inline assembly input/output
> constraints is undocumented, but the "Extended ASM" section in the
> manual,
> 
> 	http://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html
> 
> states that the way to force a variable into a specific register is:
> 
> 	register <type> variable asm("register") = ...;
> 
> and then to make sure it happens, to create an
> empty-asm-with-constraint that forces a register write,
> 
> 	asm volatile("" : "+r"(variable));
> 
> For the paranoid, one could do:
> 
> 	asm volatile("mov sp, %0\n\t" : "+r"(variable) : : "sp");
> 
> which is, unlike the use of "sp" as input/output register, actually
> documented explicitly in the "Extended ASM" section of gcc's manual,
> quote:
> 
> 	If you refer to a particular hardware register from the
> 	assembler code, you will probably have to list the register
> 	after the third colon to tell the compiler the register's
> 	value is modified. In some assemblers, the register names
> 	begin with `%'; to produce one `%' in the assembler code,
> 	you must write `%%' in the input.
> 
> (That's the only place where the doc acknowledges gcc's inline
> assembler's knowledge of machine register names as constraints - in
> the clobber list)

I think the clobber list is a different thing from the constraint
lists: in the clobber list, you can only have register names and a few
special things like "cc" and "memory".

In the constraint lists, you can only have constraints, not register
names.  On some arches, there are constraints which map to a specific
register (such as the "a", "b", "c", "d" constraints on x86), but
I don't think there's anything like this for ARM.

As you observe, the register ... asm("rX") declarations are needed
instead to map arguments to specific registers.

> 
> [ ... ]
> >Probably this is a side-effect of building for ARM versus Thumb-2.
> >ARM1176 only supports ARM, and fp is used as the framepointer when
> >building a kernel in ARM.
> 
> Both targets in my compile are ARM, but yes you're right
> framepointer or no is a difference in the two defconfigs.
> 
> >
> >Building that file with -fomit-frame-pointer avoids the error,
> >but that's best avoided unless there's a really good reason.
> 
> The very specific purpose of this function ... it'd never be
> possible to backtrace over it in any case.

Yep, that was my assumption.  If a fault happens in this code, the
battle is probably already lost.

> 
> >
> >You would get the same problem when building for Thumb-2 if you pass
> >-fno-omit-frame-pointer to the compiler and attempt to clobber r7
> >(by default, Thumb-2 code has no framepointer).
> >
> [ ... ]
> >>I am wondering if there's a way to convince gcc to do the right
> >>thing here, __naked notwithstanding.
> >
> >I think basically luck is the answer.  If you ask the compiler to saw
> >its own head off it may occasionally make a neat job of it, but don't
> >bet on that happening every time...
> 
> The head-sawing-off piece works fine (substituting the
> stackpointer), but to convince it that it shouldn't attempt to
> facepalm itself afterwards looks like a bit harder ;-)

Well, no analogy is perfect ;)

> 
> 
> >
> >>
> >>Is the use of a naked "bounce function" for this specific purpose
> >>(switch the stackpointer) acceptable, and guaranteed to create the
> >>correct code ?
> >>
> >>
> >>It'd be nice not having to dump this piece into assembly...
> >
> >Using out-of-line assembler avoids the ABI issues, and is often
> >more readable IMHO.
> >
> >On Wed, May 18, 2011 at 06:50:07PM +0200, Mikael Pettersson wrote:
> >[...]
> >>Just write the stack switching fragment in proper assembly, and
> >>keep both sides of it in normal C.  End of problem.
> >
> >Indeed, though there is only a little section of C, in the middle
> >of some assembler which is not implementable in C.
> 
> The stack switching segment isn't the problem ... it's the C bit, as
> long as it lives in the same func.
> 
> >
> >
> >Maybe something like this:
> >
> >
> >ENTRY(swsusp_arch_resume)
> >	ldr	sp, resume_sp
> >	bl	__swsusp_arch_resume_copy_pages
> >	/* the rest of your code code goes here ... */
> >
> >.align 2
> >resume_sp: .long swsusp_resume_stack + PAGE_SIZE - 8
> >ENDPROC(swsusp_arch_resume)
> 
> Yow, morale of the exercise, I guess: It's possible to shoehorn GCC
> into doing what I want, but the shoe isn't a good fit ;-)

> 
> I'm still not convinced why:
> 
> void __naked swsusp_arch_resume(void)
> {
> 	register void *sp asm("sp") = ...;
> 	asm volatile("" : "+r"(sp));
> 	__swsusp_arch_resume_copy_pages();
> 	__swsusp_arch_resume_cpu();
> }
> 
> with two explicit "noinline" funcs wouldn't be ok.

As I said, it may work, today.  It just feels more complex and
failure-prone, because it reiles on details of the compiler behaviour.
If doing this provided a real benefit, like better maintainability or
performance, then it would be worth trying.  But I feel we don't get
any real advantages in this case.

That's just my opinion, but I know from experience how hard it is to get
compiler guys on your side when this kind of hack goes wrong...

> 
> >
> >
> >Then in C:
> >
> >asmlinkage void __swsusp_arch_resume_copy_pages(void)
> >{
> >	struct pbe *pbe;
> >
> >	for (pbe = restore_pblist; pbe; pbe = pbe->next)
> >		copy_page(pbe->orig_address, pbe->address);
> >}
> >
> >
> >There's now nothing for the compiler to get wrong...
> 
> Maybe I'm trying too hard ;-) all other architectures supporting
> suspend-to-disk haven't dared to put this thing into C ... even
> though they all do this very operation as well. But then, none of
> the other swsusp_arch_resume elsewhere has done the stackpointer
> switch either.

Well, the more we can put in C the better, because C code is easier to
maintain and reuse -- hence it's good to be calling copy_pages() instead
of re-coding this in the assembly code.  But there's a difference between
coding in C and shoehorning assembler into a .c file.

For totally arch-specific parts like saving/restoring the processor
state, at least some assembler is unavoidable...

Cheers
---Dave
