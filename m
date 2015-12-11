From: josh@joshtriplett.org (Josh Triplett)
Date: Fri, 11 Dec 2015 11:08:15 -0800
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151211184602.GE18249@io.lakedaemon.net>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <2992463.fVOGazvIkH@wuerfel> <5669F5F8.5010005@vollmann.ch>
 <14967875.ttNXUbSTvS@wuerfel>
 <20151211133601.GB18249@io.lakedaemon.net>
 <20151211182730.GA15800@cloud>
 <20151211184602.GE18249@io.lakedaemon.net>
Message-ID: <20151211190815.GA16104@cloud>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 06:46:02PM +0000, Jason Cooper wrote:
> On Fri, Dec 11, 2015 at 10:27:30AM -0800, Josh Triplett wrote:
> > On Fri, Dec 11, 2015 at 01:36:01PM +0000, Jason Cooper wrote:
> > > +Josh
> > > 
> > > Hey Arnd, Detlef,
> > > 
> > > On Fri, Dec 11, 2015 at 12:10:55AM +0100, Arnd Bergmann wrote:
> > > > On Thursday 10 December 2015 23:00:24 Detlef Vollmann wrote:
> > > > > On 12/10/15 22:29, Arnd Bergmann wrote:
> > > > > > On Thursday 10 December 2015 22:14:25 Detlef Vollmann wrote:
> > > > > >> On 12/10/15 21:59, Arnd Bergmann wrote:
> > > > > > It may also be worth investigating what has made CONFIG_OF so costly,
> > > > > Probably because too much is done at runtime and too few things can
> > > > > be fixed at build time.
> > > > > 
> > > > > > maybe we can reduce this a bit again.
> > > > > Probably not without turning the wheel backward :-(
> > > > > 
> > > > > So for the test: yes it works, but I'm unhappy with it.
> > > > 
> > > > I'm not too happy about adding 80kb to the uncompressed kernel 
> > > > image either. I've spent some more time now trying to find where
> > > > we added the bloat. It's mainly in drivers, not in arch specific
> > > > code, a kilobyte here and there eventually adds up, but the largest
> > > > portion with a little over 50% of the total diff is drivers/of.
> > > 
> > > Wasn't there an idea kicked around a while ago to create a
> > > dt2boardfile script/executable*?  Then, during kernel configuration, you
> > > enable it and select which dts file you want.  It would disable
> > > CONFIG_OF, multiplatform, etc.  And generate a board_file.c from the dts
> > > file.
> > > 
> > > If anything, it might be worth asking the kernel tinification [1], [2]
> > > folks if they'd be interested in taking this on...
> > 
> > No objection if you want to add it to the task list on
> > tiny.wiki.kernel.org (on the more difficult end).
> 
> Done.

Can you add yourself as a potential contact for that project?

> > I don't know if you could generate a board file, but I do wonder if you
> > could effectively compile in a parsed description and ditch the parser.
> > Bonus if you can make the values parsed out of it into compile-time
> > constants for constant folding.
> 
> After a bit of discussion with Arnd on irc, I agree.  Going to  a board
> file doesn't really work since the logic is now mostly in the drivers
> probe functions.
> 
> The dts parsing -> compile-time constants is worth looking into.
> 
> thx,
> 
> Jason.
