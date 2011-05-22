From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 22 May 2011 09:20:09 +0200
Subject: [PATCH] [RFC] USB: fsl_udc_core: fix build-failure for ARM
In-Reply-To: <20110511162902.GG5315@n2100.arm.linux.org.uk>
References: <20110505135029.0c068b8e@wker>
	<1304672405-1102-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110511063954.GJ29089@pengutronix.de>
	<20110511155446.GA20920@suse.de>
	<20110511162902.GG5315@n2100.arm.linux.org.uk>
Message-ID: <20110522072009.GA9774@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 05:29:02PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 11, 2011 at 08:54:46AM -0700, Greg KH wrote:
> > On Wed, May 11, 2011 at 08:39:54AM +0200, Uwe Kleine-K?nig wrote:
> > > Hello Greg,
> > > 
> > > On Fri, May 06, 2011 at 11:00:05AM +0200, Uwe Kleine-K?nig wrote:
> > > > Commit
> > > > 
> > > > 	09ba0de (USB: fsl_udc_core: prepare for SoCs with BE registers and descriptors)
> > > > 
> > > > introduced two function pointers _fsl_readl and _fsl_writel in an #ifdef
> > > > CONFIG_PPC32 block and used then unconditionally in fsl_udc_probe.
> > > > To make the driver compile again this use has to be protected by
> > > > an #ifdef, too. Moreover ARM doesn't have flush_dcache_range so this
> > > > is #ifdefed out, too.
> > > > 
> > > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > > Hello,
> > > > 
> > > > I'm unsure about getting rid of the flush_dcache_range. If powerpc needs
> > > > a flush ARM probably does, too, no?
> > > > If so, what it the right thing to do? Implement flush_dcache_range for
> > > > ARM (just wrapping flush_dcache_page?)?
> > > As Russell seem to be OK with the #ifdef, can you please take this
> > > patch?
> > 
> > Ick, no.
> 
> I never said I was OK with the #ifdef...
Ah, right, sorry.

> > Come on, we don't have ifdefs in .c files for a reason, surely there is
> > a better fix for this some other way?
> 
> I suggested ways to fix it, which apparantly got ignored.  To repeat myself,
> what I said was:
> 
> "Well, the folk introducing it should have added it to cachetlb.txt so
> that other folk know what the intentions of it are.  At the moment it
> seems to be an unofficial extension with unknown semantics.  Maybe the
> PPC folk can clear it up and fix other arches if they wish to make it
> an official arch cachetlb extension."
So what should we do? The fsl_udc_core driver currently fails to build
because it uses flush_dcache_range unconditionally. So the obvious ways
to fix it are:

 1) define flush_dcache_range
   a) in arch/arm
   b) in the driver
 2) make the driver not use flush_dcache_range
   a) #ifdef 
   b) revert 09ba0de (and probably some commits that depend on it)
   c) use a different function to flush the cache


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
