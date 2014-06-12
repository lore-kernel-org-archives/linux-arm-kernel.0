From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jun 2014 15:37:18 +0200
Subject: Kconfig fails: big select-based circular dependency
In-Reply-To: <20140612130330.GG23430@n2100.arm.linux.org.uk>
References: <20140607090944.GL23430@n2100.arm.linux.org.uk>
 <10376496.xoRI3F9EzH@wuerfel> <20140612130330.GG23430@n2100.arm.linux.org.uk>
Message-ID: <6046244.oz0lY2JOaZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 June 2014 14:03:30 Russell King - ARM Linux wrote:
> On Thu, Jun 12, 2014 at 02:19:45PM +0200, Arnd Bergmann wrote:
> > On Thursday 12 June 2014 12:34:45 Russell King - ARM Linux wrote:
> > > On Thu, Jun 12, 2014 at 12:31:19PM +0200, Arnd Bergmann wrote:
> > > > On Thursday 12 June 2014 10:47:45 Russell King - ARM Linux wrote:
> > > > > If no one responds, I'll assume that no one is interested, and I'll
> > > > > just create a pile of patches removing a bunch of these idiotic select
> > > > > statements at random to break this loop.
> > > > 
> > > > I missed the original mail, and I don't remember seeing this particular
> > > > dependency chain.
> > > > 
> > > > > On Sat, Jun 07, 2014 at 10:09:44AM +0100, Russell King - ARM Linux wrote:
> > > > > > This is getting silly:
> > > > > > 
> > > > > > scripts/kconfig/conf --silentoldconfig Kconfig
> > > > > > drivers/dma/Kconfig:5:error: recursive dependency detected!
> > > > > > drivers/dma/Kconfig:5:  symbol DMADEVICES is selected by SAMSUNG_DMADEV
> > > > 
> > > > The 'select DMADEVICES' from plat-samsung/Kconfig is certainly wrong,
> > > > we shouldn't do that, but I'd do some extended build regression tests
> > > > to ensure that it doesn't cause other problems.
> > > > 
> > > > I'll have a look.
> > > 
> > > Yes, SAMSUNG_DMADEV looks like it's a shim layer between DMA engine and
> > > the old Samsung platform private DMA API.  I suspect SAMSUNG_DMADEV should
> > > be selected by the drivers which make use of this shim iff DMADEVICES is
> > > enabled.
> > 
> > FWIW, SAMSUNG_DMADEV should get removed in 3.17. At the moment
> > there is only one user (sound/soc/samsung/ac97.c), and that is
> > broken because it calls a NULL function pointer returned from
> > samsung_dma_get_ops().
> 
> Well, we can't wait for 3.17 to fix this, because attempting to build
> an allyesconfig/allmodconfig/randconfig today fails.  Just look at the
> failures of those four configurations on my autobuilder over the last
> few days.

I didn't say we should not fix it, I just meant we don't need to spend
too much time on a perfect solution for code that is going away and that
is already not used anywhere.

I've just replied to an older thread "Re: [PATCH 1/2] [RFC] ASoC: samsung:
move s3c24xx over to dmaengine" with a patch that would let us kill off
the code right away, or at least disable it in Kconfig.

For some reason, I can't reproduce the failure you see in your build system,
I tried torvalds/master and next/master today and I have also done
allmodconfig and randconfig builds in the past few days on slightly
older versions.

> In some cases, kconf generates a configuration, spitting out these
> warnings, but then when you try and build that configuration, it then
> goes on to complain that some symbols need user input.  In other words,
> the first resulting configuration file from the make allyesconfig/
> allmodconfig/randconfig is invalid because the dependencies have not
> reached stability.

I think it just gives up when it sees a recursive dependency, so instead
you start out with whatever the oldconfig was, rather than actually
building the 'allmodconfig' you asked for.

	Arnd
