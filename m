From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 14 Mar 2012 21:06:30 +0100
Subject: [PATCH v3 2/5] ARM: Add a printk loglevel modifier
In-Reply-To: <201203141312.51547.arnd@arndb.de>
References: <20120314101928.GA29474@pengutronix.de>
 <1331720516-11801-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201203141312.51547.arnd@arndb.de>
Message-ID: <20120314200630.GB2391@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 01:12:51PM +0000, Arnd Bergmann wrote:
> On Wednesday 14 March 2012, Uwe Kleine-K?nig wrote:
> > This is a needed followup for
> > 
> >         ARM: protect usage of cr_alignment by #ifdef CONFIG_CPU_CP15
> > 
> > otherwise no newline is printed for !CONFIG_CPU_CP15
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Should this be folded into the
> > 
> >         ARM: protect usage of cr_alignment by #ifdef CONFIG_CPU_CP15
> > 
> > patch? Or should it come before it?
> > 
> 
> I think this patch needs a better explanation. It looks to me that
> it's simply a bug fix, because every printk that is not a continuation
> of a previous printk needs a KERN_* line. In that case, it should
> just get applied as a bug fix independent of the other patches.
> 
> However, if you sometimes don't have a newline after the previous
> printk, this patch is actually wrong and should not get applied at
> all.
I don't get your reasoning here.

An (independant) printk (that is expected to start at a new line) must
start with KERN_SOMETHING iff the previous printk always ends in \n?
Probably not. 

Independently of the correctness of the first patch that splits the
printk I'm just taking it as an example:

In this case the two printks in question are:

		printk("CPU: %s [%08x] revision %d (ARMv%s)", ...);
	#ifdef CONFIG_CPU_CP15
		printk(KERN_CONT ", cr=%08lx\n", cr_alignment);
	#endif

and

		printk("CPU: %s data cache, %s instruction cache\n", ...)

In this case it's correct to add KERN_INFO to the last printk, isn't it?
When would you consider it to be wrong?

If you want to have the first group of printks to always end in \n, I'd
have to do:

		printk("CPU: %s [%08x] revision %d (ARMv%s)", ...);
	#ifdef CONFIG_CPU_CP15
		printk(KERN_CONT ", cr=%08lx", cr_alignment);
	#endif
		printk(KERN_CONT "\n");

but ISTR Linus (Torvalds) telling me that KERN_CONT "\n" is wrong and
should just be skipped.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
