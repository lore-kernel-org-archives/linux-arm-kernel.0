From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Jun 2015 17:59:04 +0100
Subject: Moan: usage of __iormb() and __iowmb() outside of asm/io.h
In-Reply-To: <20150610165323.GE22844@e104818-lin.cambridge.arm.com>
References: <20150608184701.GA7557@n2100.arm.linux.org.uk>
 <20150610111819.GC22973@arm.com>
 <20150610112433.GM7557@n2100.arm.linux.org.uk>
 <20150610123040.GN7557@n2100.arm.linux.org.uk>
 <20150610165323.GE22844@e104818-lin.cambridge.arm.com>
Message-ID: <20150610165904.GB6612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 05:53:24PM +0100, Catalin Marinas wrote:
> On Wed, Jun 10, 2015 at 01:30:40PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Jun 10, 2015 at 12:24:34PM +0100, Russell King - ARM Linux wrote:
> > > On Wed, Jun 10, 2015 at 12:18:20PM +0100, Will Deacon wrote:
> > > > I agree to removing these from view; we already have plenty of barrier
> > > > macros and we don't want these to proliferate outside of the arch code.
> > > > 
> > > > Any chance you could do a similar change for arm64, please (we have the
> > > > same macros there)?
> > > 
> > > Yes - as you're aware, removing them from sight does cause us to decend
> > > into macro-hell in asm/io.h, but I think that's better than having people
> > > get their grubby fingers on arch internal stuff they shouldn't be touching.
> > 
> > Here's what I'm proposing for ARM.  As I say, it's macro-hell...  It's
> > also not perfect yet (since the __LINUX_ARM_ARCH__ < 6 case isn't
> > properly handled yet.)
> 
> IMO, it makes the code pretty unreadable, it breaks searching/ctags. It
> may be easier to just randomly change the number of underscores in front
> of "io*mb" every few kernel releases (e.g. twice a year), so we identify
> the users outside asm/io.h.

Or generate static line functions from the macros, as Russell suggested
previously. Then we can #undef the macros at the end of the file (I have
patches doing this for our cmpxchg implementation).

Will
