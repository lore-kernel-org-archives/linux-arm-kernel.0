From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jul 2018 18:33:18 +0100
Subject: [PATCHv4 11/19] arm64: don't reload GPRs after apply_ssbd
In-Reply-To: <20180710103722.GH9486@e103592.cambridge.arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
 <20180702110415.10465-12-mark.rutland@arm.com>
 <20180706163844.GB27483@arm.com>
 <20180709142159.tsxgwhjm3qziymym@lakrids.cambridge.arm.com>
 <20180710103722.GH9486@e103592.cambridge.arm.com>
Message-ID: <20180710173317.GC10177@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 11:37:24AM +0100, Dave Martin wrote:
> On Mon, Jul 09, 2018 at 03:21:59PM +0100, Mark Rutland wrote:
> > On Fri, Jul 06, 2018 at 05:38:45PM +0100, Will Deacon wrote:
> > > On Mon, Jul 02, 2018 at 12:04:07PM +0100, Mark Rutland wrote:
> > > > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > > > index c41b84d06644..728bc7cc5bbb 100644
> > > > --- a/arch/arm64/kernel/entry.S
> > > > +++ b/arch/arm64/kernel/entry.S
> > > > @@ -130,20 +130,21 @@ alternative_else_nop_endif
> > > >  
> > > >  	// This macro corrupts x0-x3. It is the caller's duty
> > > >  	// to save/restore them if required.
> > > > -	.macro	apply_ssbd, state, targ, tmp1, tmp2
> > > > +	.macro	apply_ssbd, state, tmp1, tmp2
> > > >  #ifdef CONFIG_ARM64_SSBD
> > > >  alternative_cb	arm64_enable_wa2_handling
> > > > -	b	\targ
> > > > +	b	skip_apply_ssbd\@
> > > >  alternative_cb_end
> > > >  	ldr_this_cpu	\tmp2, arm64_ssbd_callback_required, \tmp1
> > > > -	cbz	\tmp2, \targ
> > > > +	cbz	\tmp2, skip_apply_ssbd\@
> > > >  	ldr	\tmp2, [tsk, #TSK_TI_FLAGS]
> > > > -	tbnz	\tmp2, #TIF_SSBD, \targ
> > > > +	tbnz	\tmp2, #TIF_SSBD, skip_apply_ssbd\@
> > > 
> > > Talking to Dave, he makes a good point that this is pretty fragile if a
> > > macro expansion within the macro itself uses \@, since this would result
> > > in an unexpected label update and everything would go wrong.
> > 
> > I don't believe that's a problem; \@ is handled as-if it's a named
> > argument to the macro, and is not incremented within the scope of a
> > single macro expansion.
> 
> From
> https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gas/macro.c
> https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gas/read.c
> 
> it looks like the \@ counter (macro_number) is only incremented at the
> end expansion of a whole macro body before gas reads the expansion
> output (including recursive macro expansions).
> 
> So, your conclusion looks right for gas today.  The code implementing
> this looks crufty enough to be pretty old.
> 
> Can you throw a bug into https://sourceware.org/bugzilla/ to get this
> properly documented?  The current wording is ambiguous.  It would be
> nice to get gas properly committed to behaving this way.
> 
> 
> For the kernel, I suggest using a .L prefix so that the generated
> symbols don't bloat the vmlinux symbol table (similar to numbered local
> labels) -- unless you really want the symbols retained.
> 
> Having a common prefix for all "unique" assembler symbols may help us
> to avoid namespace collisions, say
> 
> .L__asm__foo_\@
> .L__asm__bar_\@

Hmm, yes, and that would allow us to replace the open-coded labels in
our assembler.h macros as well, wouldn't it?

Will
