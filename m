From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Dec 2015 19:28:25 +0000
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <3059482.yN34NFeWWY@wuerfel>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <87610j7gmc.fsf@free-electrons.com>
 <20151202123310.GC8644@n2100.arm.linux.org.uk>
 <3059482.yN34NFeWWY@wuerfel>
Message-ID: <20151202192825.GF8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 04:49:38PM +0100, Arnd Bergmann wrote:
> On Wednesday 02 December 2015 12:33:10 Russell King - ARM Linux wrote:
> > On Mon, Nov 30, 2015 at 02:37:31PM +0100, Gregory CLEMENT wrote:
> > > Hi Arnd,
> > >  
> > >  On mer., nov. 25 2015, Arnd Bergmann <arnd@arndb.de> wrote:
> > > 
> > > > I've posted these before and now gotten around to a rebase and
> > > > want to include them in the arm-soc next/multiplatform branch for
> > > > 4.5.
> > > >
> > > > Originally the plan for these platforms was to convert all of
> > > > them to DT and use only mach-mvebu. That has not happened,
> > > > so I would do it this way instead so we can at least have
> > > > them in a single kernel.
> > > >
> > > > Let me know if there are any concerns or objections.
> > > 
> > > I have applied all the patches on mvebu/oldmvebu_multiplatform (I fixed
> > > the last one which didn't apply on Kconfig). I also merged it
> > > mvebu/for-netx to be part of the linux-next.
> > > 
> > > But before making it part of mvebu/soc, I would like to get some
> > > Tested-by. The series is available on
> > > git://git.infradead.org/linux-mvebu.git
> > > in the branch mvebu/oldmvebu_multiplatform but it also will be part soon
> > > of linux-next.
> > > 
> > > Russell, Sebastian,
> > > 
> > > would you have some time to test it on Dove?
> > 
> > Given that I'm testing on my Cubox tree, I've applied this series on top
> > of v4.3.  Patch 5 trivially conflicts on MMP context.  Fixing that and
> > merging the resulting changes gives another load of conflicts which need
> > dealing with:
> > 
> > Recorded preimage for 'arch/arm/Kconfig'
> > Recorded preimage for 'arch/arm/mach-dove/Kconfig'
> > Recorded preimage for 'arch/arm/mach-dove/irq.c'
> > Recorded preimage for 'arch/arm/mach-dove/pm.h'
> > 
> > These look less trivial to resolve, so testing this will have to wait
> > until I have sufficient time to sort this out.
> 
> I have pushed a rebased version to
> git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git multiplatform-orion-4.3
> 
> Maybe that helps

As I said above, that's not the problem, the problem is merging it into
the rest of my tree.

Having done most of that merge, I'm now tripping up on:

arch/arm/mach-dove/common.c: In function 'dove_wdt_init':
arch/arm/mach-dove/common.c:538:2: error: implicit declaration of function 'orion_wdt_init' [-Werror=implicit-function-declaration]

which I guess is because you've deleted the legacy orion watchdog stuff.
So I'm going to have to revert that.  That then gives me:

arch/arm/mach-dove/clock.c:19:21: fatal error: mach/pm.h: No such file or directory
arch/arm/mach-dove/clock.c:20:27: fatal error: mach/hardware.h: No such file or directory

The first is easy to solve, and the second by replacing it with dove.h.
The next problem is this:

arch/arm/plat-orion/common.c:25:30: fatal error: mach/bridge-regs.h: No such file or directory

which is impossible to solve, because plat-orion/common.c wants
mach-dove/bridge-regs.h.

I also have arch/arm/mach-dove/include/mach/sdhci.h to pass the GPIO
for card detection to the SDHCI driver, which is going to break unless
it's moved to include/linux/platform-data.

Everything else seems mostly happy, but I've no way to tell whether
what would be the resulting kernel would work as it's impossible to
know without fixing the wreckage above.

I'm sure I don't have to repeat my position over what I'm going to do if
these petty mainline changes which are totally unnecessary break the only
setup I have which works.  Making mach-dove multi-platform is a "wouldn't
it be nice if", it's not an absolute necessity.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
