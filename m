From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jun 2014 14:03:30 +0100
Subject: Kconfig fails: big select-based circular dependency
In-Reply-To: <10376496.xoRI3F9EzH@wuerfel>
References: <20140607090944.GL23430@n2100.arm.linux.org.uk>
 <6077426.uLBS643pC0@wuerfel> <20140612113445.GF23430@n2100.arm.linux.org.uk>
 <10376496.xoRI3F9EzH@wuerfel>
Message-ID: <20140612130330.GG23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 02:19:45PM +0200, Arnd Bergmann wrote:
> On Thursday 12 June 2014 12:34:45 Russell King - ARM Linux wrote:
> > On Thu, Jun 12, 2014 at 12:31:19PM +0200, Arnd Bergmann wrote:
> > > On Thursday 12 June 2014 10:47:45 Russell King - ARM Linux wrote:
> > > > If no one responds, I'll assume that no one is interested, and I'll
> > > > just create a pile of patches removing a bunch of these idiotic select
> > > > statements at random to break this loop.
> > > 
> > > I missed the original mail, and I don't remember seeing this particular
> > > dependency chain.
> > > 
> > > > On Sat, Jun 07, 2014 at 10:09:44AM +0100, Russell King - ARM Linux wrote:
> > > > > This is getting silly:
> > > > > 
> > > > > scripts/kconfig/conf --silentoldconfig Kconfig
> > > > > drivers/dma/Kconfig:5:error: recursive dependency detected!
> > > > > drivers/dma/Kconfig:5:  symbol DMADEVICES is selected by SAMSUNG_DMADEV
> > > 
> > > The 'select DMADEVICES' from plat-samsung/Kconfig is certainly wrong,
> > > we shouldn't do that, but I'd do some extended build regression tests
> > > to ensure that it doesn't cause other problems.
> > > 
> > > I'll have a look.
> > 
> > Yes, SAMSUNG_DMADEV looks like it's a shim layer between DMA engine and
> > the old Samsung platform private DMA API.  I suspect SAMSUNG_DMADEV should
> > be selected by the drivers which make use of this shim iff DMADEVICES is
> > enabled.
> 
> FWIW, SAMSUNG_DMADEV should get removed in 3.17. At the moment
> there is only one user (sound/soc/samsung/ac97.c), and that is
> broken because it calls a NULL function pointer returned from
> samsung_dma_get_ops().

Well, we can't wait for 3.17 to fix this, because attempting to build
an allyesconfig/allmodconfig/randconfig today fails.  Just look at the
failures of those four configurations on my autobuilder over the last
few days.

In some cases, kconf generates a configuration, spitting out these
warnings, but then when you try and build that configuration, it then
goes on to complain that some symbols need user input.  In other words,
the first resulting configuration file from the make allyesconfig/
allmodconfig/randconfig is invalid because the dependencies have not
reached stability.

So, I suspect that there's more problems in Kconfig caused by this select
madness, and I think we need a positive effort on sorting this crap out.
If we let it continue, it will eventually get noticed on x86, and we will
then have Linus flaming the ARM folk yet again...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
