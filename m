From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 May 2014 00:40:12 +0100
Subject: nommu build failures on ARM in linux-next
In-Reply-To: <20140529185534.GK3693@n2100.arm.linux.org.uk>
References: <5387661F.1050000@windriver.com>
 <20140529185534.GK3693@n2100.arm.linux.org.uk>
Message-ID: <20140529234012.GL3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 07:55:34PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 29, 2014 at 12:53:51PM -0400, Paul Gortmaker wrote:
> > Hi Russell,
> > 
> > The allnoconfig builds in linux-next fail because __clear_cr
> > lives in mmu.c without any stub or similar in nommu.c
> > 
> > Introduced by:
> > 
> > commit 247e4fff3aa927ad069447e6da05bb966b70dece
> > Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > Date:   Sun Apr 13 18:57:29 2014 +0100
> > 
> >     ARM: provide common method to clear bits in CPU control register
> >     
> > Sample failure:
> >   http://kisskb.ellerman.id.au/kisskb/buildresult/11264405/
> 
> ALIGNMENT_TRAP depends on CPU_CP15_MMU, so it's quite reasonable that
> __clear_cr should exist in this case - but it doesn't because it's in
> mmu.c.  I guess we need __clear_cr moved to arch/arm/kernel/setup.c.

I've been looking at doing this, and while it can be done by applying
a patch on top, that's not my preferred solution.

However, my preferred solution (which is to fix the commit) needs a bit
of rework of the patch series, and given the number of patches I'm
carrying right now, I'm just going to drop the branch out of linux-next
and hold it off until the following merge window instead.

Even so, I suspect even with this build problem solved, that's not going
to be the end of the story for noMMU breakage... it's certainly something
that gets very little testing by anyone.  I suspect it should be removed
from the mainline kernel tree rather than being a constant source of these
kinds of problems.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
