From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Jun 2011 10:48:34 +0100
Subject: [PATCH] [RFC] USB: fsl_udc_core: fix build-failure for ARM
In-Reply-To: <BANLkTini+7kLMdCkU+kDWUXKfJ7DOPNVVA@mail.gmail.com>
References: <20110505135029.0c068b8e@wker>
	<1304672405-1102-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110511063954.GJ29089@pengutronix.de>
	<20110511155446.GA20920@suse.de>
	<20110511162902.GG5315@n2100.arm.linux.org.uk>
	<20110522072009.GA9774@pengutronix.de>
	<BANLkTini+7kLMdCkU+kDWUXKfJ7DOPNVVA@mail.gmail.com>
Message-ID: <20110621094834.GC23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 05:32:32PM +0800, Eric Miao wrote:
> 2011/5/22 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Wed, May 11, 2011 at 05:29:02PM +0100, Russell King - ARM Linux wrote:
> >> On Wed, May 11, 2011 at 08:54:46AM -0700, Greg KH wrote:
> >> > On Wed, May 11, 2011 at 08:39:54AM +0200, Uwe Kleine-K?nig wrote:
> >> > > Hello Greg,
> >> > >
> >> > > On Fri, May 06, 2011 at 11:00:05AM +0200, Uwe Kleine-K?nig wrote:
> >> > > > Commit
> >> > > >
> >> > > > ? ? ? ? 09ba0de (USB: fsl_udc_core: prepare for SoCs with BE registers and descriptors)
> >> > > >
> >> > > > introduced two function pointers _fsl_readl and _fsl_writel in an #ifdef
> >> > > > CONFIG_PPC32 block and used then unconditionally in fsl_udc_probe.
> >> > > > To make the driver compile again this use has to be protected by
> >> > > > an #ifdef, too. Moreover ARM doesn't have flush_dcache_range so this
> >> > > > is #ifdefed out, too.
> >> > > >
> >> > > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >> > > > ---
> >> > > > Hello,
> >> > > >
> >> > > > I'm unsure about getting rid of the flush_dcache_range. If powerpc needs
> >> > > > a flush ARM probably does, too, no?
> >> > > > If so, what it the right thing to do? Implement flush_dcache_range for
> >> > > > ARM (just wrapping flush_dcache_page?)?
> >> > > As Russell seem to be OK with the #ifdef, can you please take this
> >> > > patch?
> >> >
> >> > Ick, no.
> >>
> >> I never said I was OK with the #ifdef...
> > Ah, right, sorry.
> >
> >> > Come on, we don't have ifdefs in .c files for a reason, surely there is
> >> > a better fix for this some other way?
> >>
> >> I suggested ways to fix it, which apparantly got ignored. ?To repeat myself,
> >> what I said was:
> >>
> >> "Well, the folk introducing it should have added it to cachetlb.txt so
> >> that other folk know what the intentions of it are. ?At the moment it
> >> seems to be an unofficial extension with unknown semantics. ?Maybe the
> >> PPC folk can clear it up and fix other arches if they wish to make it
> >> an official arch cachetlb extension."
> > So what should we do? The fsl_udc_core driver currently fails to build
> > because it uses flush_dcache_range unconditionally. So the obvious ways
> > to fix it are:
> >
> > ?1) define flush_dcache_range
> > ? a) in arch/arm
> > ? b) in the driver
> > ?2) make the driver not use flush_dcache_range
> > ? a) #ifdef
> > ? b) revert 09ba0de (and probably some commits that depend on it)
> > ? c) use a different function to flush the cache
> 
> I see no reason why a dma_map_*() function couldn't be used here?
> 
> This is preventing the driver from being built. And the _fsl_readl stuffs,
> which was really introduced by PPC guys, yet it can be made generic
> enough I believe. The real requirement is really for a single kernel binary
> to run on different LE/BE configurations, which will hurt performance
> a bit and is normally not true on the i.MX SoCs, so that can be made as
> a config option in my POV, but not necessary #ifdef CONFIG_PPC32,
> maybe some better name

Hang on, let me get this straight.

This is an iMX driver, which was written avoiding the DMA API despite
it clearly doing DMA related stuff.  Allocating memory from kmalloc,
translating it to physical addresses using virt_to_phys, etc.

The PPC people decided to reuse it, and ended up introducing some custom
cache flushing APIs to get around the lack of dma_map_* usage.

Given that, I'm not surprised that this has ended up being broken.  Had
it been written _properly_ from the start (iow, using the DMA API) then
maybe the driver wouldn't be broken now.

I think the iMX people have got their just deserts for this.  There's a
lesson to be learnt there - always use the correct APIs from day one.

So, I have no sympathy for this self-inflicted breakage.  The solution:
fix the driver to use the proper APIs.
