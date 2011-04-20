From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 20 Apr 2011 08:28:20 -0400 (EDT)
Subject: [PATCH 3/3] ARM: zImage: fix issues with missing GOT entries
	for some global variables
In-Reply-To: <20110420084234.GV31131@pengutronix.de>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-4-git-send-email-nicolas.pitre@linaro.org>
	<20110420084234.GV31131@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1104200826550.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:

> On Wed, Apr 20, 2011 at 12:15:04AM -0400, Nicolas Pitre wrote:
> > Many architecture specific versions of uncompress.h make use of global
> > variables marked static.  In such case the GOT is bypassed and the
> > code in head.S can't relocate them.
> > 
> > Instead of removing the static keyword from all those files and hope that
> > it won't come back, let's simply
> > define it out.
> > 
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > ---
> > 
> > This should fix remaining issues some people have with the DT append patch.
> > 
> >  arch/arm/boot/compressed/misc.c |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> > index a565853..0125dae 100644
> > --- a/arch/arm/boot/compressed/misc.c
> > +++ b/arch/arm/boot/compressed/misc.c
> > @@ -30,7 +30,20 @@ unsigned int __machine_arch_type;
> >  static void putstr(const char *ptr);
> >  extern void error(char *x);
> >  
> > +/*
> > + * Many instances of mach/uncompress.h are including global variables.
> > + * Contrary to standard usage, we should _not_ mark those variables
> > + * static otherwise they get accessed via GOTOFF references which cannot
> > + * be modified at run time.  The entry code in head.S relies on the ability
> > + * to move writable sections around, and for that to work, we must have all
> > + * references going through the GOT which works only with non static
> > + * variables.  So, instead of asking for a non intuitive requirement
> > + * making many files non standard according to accepted coding practices
> > + * we fix the issue here by simply defining the static keyword to nothing.
> > + */
> > +#define static /* non-static */
> >  #include <mach/uncompress.h>
> > +#undef static
> This has a strange side effect, i.e. 
> 
> 	static something *ptr;
> 
> isn't initialised to NULL anymore IIRC. So the maintainers of
> the various mach/uncompress.h still need to be aware of the issue.

Please tell me more about your setup.  This should still be initialized 
to NULL.  If not then something else is still wrong.


Nicolas
