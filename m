From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 Dec 2011 14:49:01 -0500 (EST)
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <20111205192605.GD29812@localhost.localdomain>
References: <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
 <20111205192605.GD29812@localhost.localdomain>
Message-ID: <alpine.LFD.2.02.1112051443190.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Dec 2011, Dave Martin wrote:

> On Mon, Dec 05, 2011 at 01:18:30PM -0500, Nicolas Pitre wrote:
> > On Mon, 5 Dec 2011, Dave Martin wrote:
> > 
> > > On Mon, Dec 05, 2011 at 12:40:16PM -0500, Nicolas Pitre wrote:
> > > > On Mon, 5 Dec 2011, Dave Martin wrote:
> > > > > On Sat, Dec 03, 2011 at 10:12:53AM +1100, Benjamin Herrenschmidt wrote:
> > > > > > On Fri, 2011-12-02 at 11:28 -0800, Linus Torvalds wrote:
> > > > > > > Don't *change* NO_IRQ to zero (that whole #define is broken - leave it
> > > > > > > around as a marker of brokenness), just start removing it from all the
> > > > > > > ARM drivers that use the OF infrastructure. Which is presumably not
> > > > > > > all that many yet.
> > > > > > > 
> > > > > > > So whenever you find breakage, the fix now is to just remove NO_IRQ
> > > > > > > tests, and replace them with "!irq".
> > > > > > 
> > > > > 
> > > > > Russell, do you know whether it would make sense to set a timeline for 
> > > > > removing NO_IRQ from ARM platforms and migrating to 0 for the no-interrupt
> > > > > case?  I'm assuming that this mainly involves migrating existing hard-wired
> > > > > code that deals with interrupt numbers to use irq domains.
> > > > 
> > > > How many drivers do use IRQ #0 to start with?  We might discover that in 
> > > > practice there is only a very few cases where this is an issue if 0 
> > > > would mean no IRQ.
> > > 
> > > The total number of files referring to NO_IRQ is not that huge:
> > > 
> > > arch/arm/	188 matches in 39 files
> > > drivers/	174 matches in 84 files
> > > 
> > > Unfortunately, NO_IRQ is often not spelled "NO_IRQ".  It looks like the assumption
> > > "irq < 0 === no irq" may be quite a lot more widespread than "NO_IRQ === no irq".
> > > Since there's no specific thing we can grep for (and simply due to volume)
> > > finding all such instances may be quite a bit harder.
> > [...]
> > 
> > ARgh.
> > 
> > My point was about current actual usage of the IRQ numbered 0 which 
> > probably prompted the introduction of NO_IRQ in the first place.  What I 
> > was saying is that the number of occurrences where IRQ #0 is currently 
> > used into drivers that would get confused if 0 would mean no IRQ is 
> > probably quite small.
> 
> Ah, I misunderstood -- that's a separate issue, but also an important one.
> I guess this applies to a fair number of older boards.  One way of fixing
> this would be to migrate those boards to use irq domains -- but those boards
> may be sporadically maintained.
>  
> > But as you illustrated, there is a large number of drivers that already 
> > assume no IRQ is < 0, even if they don't use any IRQ #0 themselves.  
> > That is a much bigger problem to fix.
> 
> My concern is that as soon as we start to change this in significant
> volume, a _lot_ of stuff is going to break.  Everywhere that an irq value
> is passed from one piece of code to another, there is a potential
> interface mismatch -- there seems to be no single place where we can
> apply a conversion and fix everything.

No need to convert everything.

First move is to make irq=0 meaning no IRQ.  That means making things 
like:

	if (irq < 0)
	if (irq >= 0)

into

	if (irq <= 0)
	if (irq > 0)

And replace NO_IRQ with 0.

That change shouldn't break anything, except those drivers which are 1) 
being passed an actual IRQ #0 and 2) testing for no IRQ.  I suspect that 
those conditions aren't very common together.


Nicolas
