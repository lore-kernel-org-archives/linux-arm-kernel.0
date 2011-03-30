From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 Mar 2011 14:44:37 -0700
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
	<20110318101512.GA15375@n2100.arm.linux.org.uk>
	<201103301906.42429.arnd@arndb.de>
	<AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
Message-ID: <20110330214437.GH18334@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Torvalds <torvalds@linux-foundation.org> [110330 12:19]:
> On Wed, Mar 30, 2011 at 10:06 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I'm still new to the ARM world, but I think one real problem is the way
> > that all platforms have their own trees with a very flat hierarchy --
> > a lot of people directly ask Linus to pull their trees, and the main
> > way to sort out conflicts is linux-next. The number of platforms in the
> > ARM arch is still increasing, so I assume that this only gets worse.
> 
> As far as I'm concerned, the biggest issuee is that some of the ARM
> crap is just CRAP. It's idiotic tables that get updated by multiple
> people, and in totally nonsensical ways. When I see conflicts in those
> damn clock-data files, I just go mental. Those files are an
> abomination.

Those kind of conflicts should not happen any longer that's for sure.

> Why the hell is the clock-data for fifty (number taken out of my ass)
> different clocking rules in one array? And why do we have eight
> different files of that kind of crap for omap2?

The clock*data.c files could eventually come from device tree, but that
still requires quite a bit of work to get there.
 
> Look at the dirstat for arch/ in just the current merge window
> (cut-off at 5% just to not get too much):
> 
> [torvalds at i5 linux]$ git diff -C --dirstat=5 --cumulative v2.6.38.. arch
>   14.0% arch/arm/mach-omap2/
>    5.8% arch/arm/plat-mxc/include/mach/
>    6.3% arch/arm/plat-mxc/
>   57.1% arch/arm/
>    5.4% arch/m68k/
>    9.6% arch/unicore32/
>    6.9% arch/x86/
>  100.0% arch/
> 
> almost *SIXTY* percent of all arch updates were to ARM code. And
> that's despite the fact that one of those architectures (unicore32) is
> a totally new architecture, and despite m68k having gone through a
> first-level unification of nommu and mmu code!
> 
> And was this just a fluke? No. Doing the same for 2.3.37..38 gives
> 58.3% for arch/arm (and in that release we had a blackfin unification
> effort, otherwise arm would have been an even bigger percentage).
> 
> That's ridiculous. It's entirely due to the whole f*cked-up arm ecosystem.

Yeh there's no BIOS and there are no scannable busses.. Which leads
to huge amount of data patches that show up in the diffstat.

Anyways, let's plan on kicking out per-SoC and per-board data from
the kernel and get it from the bootloader via device tree in the
long run. Most of the data is already separate from the code, so
it should not be that hard to do, just takes some time.

Regards,

Tony
