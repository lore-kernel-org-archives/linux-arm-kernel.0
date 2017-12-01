From: will.deacon@arm.com (Will Deacon)
Date: Fri, 1 Dec 2017 17:51:44 +0000
Subject: [PATCH v2 12/18] arm64: entry: Explicitly pass exception level
 to kernel_ventry macro
In-Reply-To: <20171201115836.jaxzbjsnpnuau56s@lakrids.cambridge.arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-13-git-send-email-will.deacon@arm.com>
 <20171201115836.jaxzbjsnpnuau56s@lakrids.cambridge.arm.com>
Message-ID: <20171201175144.GD8826@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 11:58:36AM +0000, Mark Rutland wrote:
> On Thu, Nov 30, 2017 at 04:39:40PM +0000, Will Deacon wrote:
> > We will need to treat exceptions from EL0 differently in kernel_ventry,
> > so rework the macro to take the exception level as an argument and
> > construct the branch target using that.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/entry.S | 46 +++++++++++++++++++++++-----------------------
> >  1 file changed, 23 insertions(+), 23 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index dea196f287a0..688e52f65a8d 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -71,7 +71,7 @@
> >  #define BAD_FIQ		2
> >  #define BAD_ERROR	3
> >  
> > -	.macro kernel_ventry	label
> > +	.macro kernel_ventry, el, label, regsize = 64
> >  	.align 7
> >  	sub	sp, sp, #S_FRAME_SIZE
> >  #ifdef CONFIG_VMAP_STACK
> > @@ -84,7 +84,7 @@
> >  	tbnz	x0, #THREAD_SHIFT, 0f
> >  	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
> >  	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
> > -	b	\label
> > +	b	el\()\el\()_\label
> >  
> >  0:
> >  	/*
> > @@ -116,7 +116,7 @@
> >  	sub	sp, sp, x0
> >  	mrs	x0, tpidrro_el0
> >  #endif
> > -	b	\label
> > +	b	el\()\el\()_\label
> >  	.endm
> >  
> >  	.macro	kernel_entry, el, regsize = 64
> > @@ -369,31 +369,31 @@ tsk	.req	x28		// current thread_info
> >  
> >  	.align	11
> >  ENTRY(vectors)
> > -	kernel_ventry	el1_sync_invalid		// Synchronous EL1t
> > -	kernel_ventry	el1_irq_invalid			// IRQ EL1t
> > -	kernel_ventry	el1_fiq_invalid			// FIQ EL1t
> > -	kernel_ventry	el1_error_invalid		// Error EL1t
> > +	kernel_ventry	1, sync_invalid			// Synchronous EL1t
> > +	kernel_ventry	1, irq_invalid			// IRQ EL1t
> > +	kernel_ventry	1, fiq_invalid			// FIQ EL1t
> > +	kernel_ventry	1, error_invalid		// Error EL1t
> 
> Using the el paramter to build the branch name has the unfortunate
> property of obscuring the branch name. For example, that makes it
> difficult to jump around the entry asm with ctags, which is somewhat
> painful.
> 
> Could we leave the full branch name in place, e.g.
> 
> 	kernel_ventry	1, el1_sync_invalid		// Synchronous EL1t
> 	kernel_ventry	1, el1_irq_invalid		// IRQ EL1t
> 	kernel_ventry	1, el1_fiq_invalid		// FIQ EL1t
> 	kernel_ventry	1, el1_error_invalid		// Error EL1t
> 
> ... or have separate kernel_ventry and user_ventry macros that
> implicitly encoded the source EL, also leaving the label name as-is.

The downside of doing that is that it makes it possible to say things like:

	kernel_ventry	0, el1_sync

which I don't want to be expressible.

Given that ctags already chokes on lots of entry.S (for example, any macro
that is defined outside of the file) *and* that you can easily search for
things like el1_sync_invalid within the file, I'm inclined to leave this
patch as-is, but I'll note your objection and buy you a pint.

Will
