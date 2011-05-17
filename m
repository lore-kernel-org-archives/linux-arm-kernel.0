From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 17 May 2011 12:44:55 +0100
Subject: Question on Thumb2 assembly, conditionals
In-Reply-To: <20110517110911.GA27546@arm.com>
References: <20110517110911.GA27546@arm.com>
Message-ID: <20110517114455.GA27656@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 08:00:24PM +0100, Frank Hofmann wrote:
> On Mon, 16 May 2011, Dave Martin wrote:
> 
> >Hi,
> >
> >On Mon, May 16, 2011 at 5:34 PM, Frank Hofmann <frank.hofmann@tomtom.com> wrote:
> >
> >[...]
> >
> >>since you're the "Thumb2 kernel man", maybe you've got a quick / simple
> >>answer.
> >
> >(What a reputation... ;)
> >
> [ ... ]
> >Most likely, you are missing ".syntax unified" -- note that the kernel
> >build automatically prepends that directive to the assembler input
> >when building a Thumb-2 kernel, which is why you won't usually see it
> >in the sources.
> 
> I've tried that in userland; have no working thumb-2 kernel here,
> our env is Froyo-based and both the kernel and default toolchain too
> old to compile successfully for thumb2.
> 
> I'm trying to get my hibernation support code (the page copy loop in
> swsusp_arch_resume) to be thumb-2 clean; but since it clones
> copy_page.S which uses conditional ldm I've thought it might be a
> good idea to be explicit. The reason why this isn't simply branching
> is because it always does a load + branch pair, i.e.

Can you reuse the copy_page.S without copying it?  Copy-pasting code can
lead to fragmentation and maintenance problems further down the line.

There already seems to be a arch/arm/lib/copy_template.S to provide a
common core for optimised memcpy operations; maybe that could be used.

> 
> 	ldmgtia	r0!, ...
> 	bgt	...
> 
> 	ldmeqia	r0!, ...
> 	bge	...
> 
> [ ... ]
> >>Is there a workaround for this not involving branching ?
> >
> >So probably, your code already works -- let me know if you still get
> >problems.  In any case, branching can actually deliver better
> 
> Difficult to actually test at the moment, my usual environment is
> 2.6.32-bound I need to squeeze some time out of the day to get a
> beagle or zoom set up with something current enough. If only it
> weren't for the day job ;-)
> I was hoping to get it to compile at least, even if I can't test.
> 
> 
> >performance under a lot of conditions: all CPUs new enough to support
> >Thumb-2 (i.e., v6T2/v7 or above) have reasonably good branch
> >prediction.
> 
> You're saying that code like this, the three branches notwithstanding,
> 
> 	subs	r3, r3, #1
> 	blt	3f
> 	ldmia	r0!, ...
> 	bgt	0b
> 	b	1b
> 3:
> 
> is pretty much the same as:
> 
> 	subs	r3, r3, #1
> 	ldmiagt	r0!, ...
> 	bgt	0b
> 	ldmiaeq	r0!, ...
> 	bge	1b
> 3:
> 

Yes, those are logically equivalent if I've read them correctly.

> >
> >As a general rule of thumb (no pun intended...) IT blocks containing
> >more than one instruction may be better replaced by a branch, but it
> >depends on your circumstances.
> 
> well, copy_page() has these explicit ldmia../b.. pairs, I went by
> the "trust Russell" basic premise when thinking of keeping that
> style.

Sure -- this is just a general rule which may make sense for new code.
This doesn't mean we should change existing code just for the sake of it.

> 
> >
> >Note that that for new code, it's better to use the suffixed condition
> >codes (i.e., ldmiaeq instead of ldmeqia) since the kernel now only
> >supports being built with binutils versions which in any case are new
> >enough to support this syntax.
> 
> Yes, again, if you're on a sufficiently recent kernel :-D

Of course, it depends on your precise circumstances.

Cheers
---Dave
