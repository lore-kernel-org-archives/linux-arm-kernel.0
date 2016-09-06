From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2016 20:44:43 +0100
Subject: [PATCH] ARM: mmp: replace NO_IRQ
In-Reply-To: <6239709.hYdxF7WW9G@wuerfel>
References: <20160906140808.2883875-1-arnd@arndb.de>
 <20160906142442.GY1041@n2100.armlinux.org.uk>
 <6239709.hYdxF7WW9G@wuerfel>
Message-ID: <20160906194443.GC1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 09:28:17PM +0200, Arnd Bergmann wrote:
> On Tuesday, September 6, 2016 3:24:42 PM CEST Russell King - ARM Linux wrote:
> > On Tue, Sep 06, 2016 at 04:07:56PM +0200, Arnd Bergmann wrote:
> > > The mmp platform has its own definitions with the old NO_IRQ meaning,
> > > but compares against the global NO_IRQ macro that we should have
> > > removed long ago.
> > > 
> > > The specific usage in arch/arm/mach-mmp/devices.c is awkward, but
> > > fixing it properly would require a larger scale rewrite of the entire
> > > file, or even using devicetree for all machines. As I'm not able to
> > > do that any time soon, let's make the current behavior more explit
> > > instead and avoid the literal use of NO_IRQ.
> > 
> > So this probably continues to be a problem, but we hide it from the
> > NO_IRQ brigade.  I think it would be better to leave it as-is until
> > it can be fixed up correctly, rather than trying to hide it.
> 
> Linus explicitly asked for NO_IRQ to be finally killed off last week[1],
> and I've prepared all patches for that now, this is the last one
> aside from removing the macro.

My point still stands though.  Merely hiding it doesn't make the problem
go away - it's just the same problem but now it won't be as visible, and
as such it'll probably never get resolved.

> I'm experimenting with cleaning up the file some more, but it's unclear
> if doing it another way is an actual improvement, or if a larger change
> is worth the risk for regressions, given how little interest there is
> in this platform in general.

If there's little interest in it, and little stomach to fix it, maybe
the better thing is to remove it if no one has an interest in it?

> [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-September/003803.html

What Linus has failed to understand is that the reason why we've kept
NO_IRQ as -1 is that changing NO_IRQ to 0 results in regressions - I've
been through as much as the code that I'm personally happy to convert
each time this has come up, and what remains has been the stuff that
I've not been happy to touch through fear of breaking it.

So, changing NO_IRQ to 0 results in regressions.  Trying to fix the
sites probably results in regressions too (I've already seen one
example with your UCB1x00 patch of such breakage caused by mindless
"conversion".)

I guess you're just happier to cause regressions to keep Linus happy
than I am.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
