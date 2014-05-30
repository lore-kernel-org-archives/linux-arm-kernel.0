From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 30 May 2014 10:02:57 +0200
Subject: nommu build failures on ARM in linux-next
In-Reply-To: <20140529234012.GL3693@n2100.arm.linux.org.uk>
References: <5387661F.1050000@windriver.com>
 <20140529185534.GK3693@n2100.arm.linux.org.uk>
 <20140529234012.GL3693@n2100.arm.linux.org.uk>
Message-ID: <20140530080257.GW20155@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[adding a few people to Cc]

On Fri, May 30, 2014 at 12:40:12AM +0100, Russell King - ARM Linux wrote:
> On Thu, May 29, 2014 at 07:55:34PM +0100, Russell King - ARM Linux wrote:
> > On Thu, May 29, 2014 at 12:53:51PM -0400, Paul Gortmaker wrote:
> > > Hi Russell,
> > > 
> > > The allnoconfig builds in linux-next fail because __clear_cr
> > > lives in mmu.c without any stub or similar in nommu.c
> > > 
> > > Introduced by:
> > > 
> > > commit 247e4fff3aa927ad069447e6da05bb966b70dece
> > > Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > > Date:   Sun Apr 13 18:57:29 2014 +0100
> > > 
> > >     ARM: provide common method to clear bits in CPU control register
> > >     
> > > Sample failure:
> > >   http://kisskb.ellerman.id.au/kisskb/buildresult/11264405/
> > 
> > ALIGNMENT_TRAP depends on CPU_CP15_MMU, so it's quite reasonable that
> > __clear_cr should exist in this case - but it doesn't because it's in
> > mmu.c.  I guess we need __clear_cr moved to arch/arm/kernel/setup.c.
> 
> I've been looking at doing this, and while it can be done by applying
> a patch on top, that's not my preferred solution.
> 
> However, my preferred solution (which is to fix the commit) needs a bit
> of rework of the patch series, and given the number of patches I'm
> carrying right now, I'm just going to drop the branch out of linux-next
> and hold it off until the following merge window instead.
> 
> Even so, I suspect even with this build problem solved, that's not going
> to be the end of the story for noMMU breakage... it's certainly something
> that gets very little testing by anyone.  I suspect it should be removed
> from the mainline kernel tree rather than being a constant source of these
> kinds of problems.
That would mean that support for Cortex-M3 would die, too, which would
(IMHO) be sad.

Currently the efm32 test in our autobuilder is broken, I will address
that and then keep an eye on it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
