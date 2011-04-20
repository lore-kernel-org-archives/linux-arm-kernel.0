From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 20 Apr 2011 17:19:27 +0800
Subject: [PATCH 3/3] ARM: zImage: fix issues with missing GOT entries for
	some global variables
In-Reply-To: <20110420084234.GV31131@pengutronix.de>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-4-git-send-email-nicolas.pitre@linaro.org>
	<20110420084234.GV31131@pengutronix.de>
Message-ID: <20110420091926.GA1965@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 10:42:34AM +0200, Uwe Kleine-K?nig wrote:
[...]
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
> 
Also, the static attribute of functions gets lost, though it may not
matter.

-- 
Regards,
Shawn
