From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 16 Jun 2011 11:03:28 +0100
Subject: [RFC PATCH v2 1/5] ARM: mm: Add generic proc/arch struct
	definition macros
In-Reply-To: <alpine.LFD.2.00.1106151944240.2142@xanadu.home>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
	<1308049105-16080-2-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1106151944240.2142@xanadu.home>
Message-ID: <20110616100328.GA2460@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 07:57:13PM -0400, Nicolas Pitre wrote:
> On Tue, 14 Jun 2011, Dave Martin wrote:
> 
> > This patch adds some generic macros to reduce boilerplate when
> > declaring certain common structures in arch/arm/mm/*.S
> > 
> > Thanks to Russell King for outlining what the
> > define_processor_functions macro could look like.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > ---
> >  arch/arm/mm/proc-macros.S |   79 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 79 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> > index 34261f9..3c5ffbb 100644
> > --- a/arch/arm/mm/proc-macros.S
> > +++ b/arch/arm/mm/proc-macros.S
> > @@ -254,3 +255,81 @@
> >  	mcr	p15, 0, r0, c7, c10, 1		@ clean L1 D line
> >  	mcr	p15, 0, ip, c7, c10, 4		@ data write barrier
> >  	.endm
> > +
> > +.macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0
> > +	.pushsection .text
> > +
> > +	__INITDATA
> 
> Was this __INITDATA right after a .pushsection intentional?  One might 
> be confused about the effective section after this.

The .pushsection is needed in order to save the previous state of the
section stack so that it can be restored later with .popsection.

.pushsection syntactically requires an argument, though in this case it's
not useful, so I just specify .text since this should be harmless.

This is kind of unclear, so at the very least it could benefit from a
comment.

> 
> The __INITDATA tag is actually doing a
> 
> 	.section	".init.data","aw",%progbits
> 
> Maybe this could be used as argument to .pushsection instead of .text 
> (which in this case should probably have been .rodata otherwise anyway).

The problem is that __INITDATA conflates the information about the section
with the action of actually switching to the section.  Nowhere are the
section name and flags available by themselves.  Since the point
of a macro is to avoid copy-paste, I prefer not to manually copy-paste
this stuff into a .pushsection directive in a random assembler file...

Perhaps we should instead use

	__INITDATA

	/* ... */

	.previous
	.endm

I tend to avoid ".previous" because I consider it somewhat broken:
in the presence of macros, the section restored by .previous is
indeterminate because a called macro may switch sections and hence
change what .previous will refer to.  There is no way to restore what
.previous points at after switching sections.

In this case, we don't call any nested macro, so .previous _should_
refer to the right thing.  We mess up .previous for the caller, but
then we always mess that up when switching sections anyway.  Nothing
in arch/arm/mm/*.S uses .previous, so we shouldn't get any problems
resulting from this, in this particular case.

Alternatively, we could propose a change <linux/init.h> to split the
__INITDATA macro up, and define the related macros in a sane way:

#define __INITDATA_NAME .init.data
#define __INITDATA_FLAGS "aw",%progbtis
#define __initdata __section(__INITDATA_NAME)
#define __INITDATA .section __stringify(__INITDATA_NAME),__INITDATA_FLAGS

Any thoughts on that?

Cheers
---Dave
