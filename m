From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 21 Jun 2011 17:32:32 +0800
Subject: [PATCH] [RFC] USB: fsl_udc_core: fix build-failure for ARM
In-Reply-To: <20110522072009.GA9774@pengutronix.de>
References: <20110505135029.0c068b8e@wker>
	<1304672405-1102-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110511063954.GJ29089@pengutronix.de>
	<20110511155446.GA20920@suse.de>
	<20110511162902.GG5315@n2100.arm.linux.org.uk>
	<20110522072009.GA9774@pengutronix.de>
Message-ID: <BANLkTini+7kLMdCkU+kDWUXKfJ7DOPNVVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/22 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Wed, May 11, 2011 at 05:29:02PM +0100, Russell King - ARM Linux wrote:
>> On Wed, May 11, 2011 at 08:54:46AM -0700, Greg KH wrote:
>> > On Wed, May 11, 2011 at 08:39:54AM +0200, Uwe Kleine-K?nig wrote:
>> > > Hello Greg,
>> > >
>> > > On Fri, May 06, 2011 at 11:00:05AM +0200, Uwe Kleine-K?nig wrote:
>> > > > Commit
>> > > >
>> > > > ? ? ? ? 09ba0de (USB: fsl_udc_core: prepare for SoCs with BE registers and descriptors)
>> > > >
>> > > > introduced two function pointers _fsl_readl and _fsl_writel in an #ifdef
>> > > > CONFIG_PPC32 block and used then unconditionally in fsl_udc_probe.
>> > > > To make the driver compile again this use has to be protected by
>> > > > an #ifdef, too. Moreover ARM doesn't have flush_dcache_range so this
>> > > > is #ifdefed out, too.
>> > > >
>> > > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> > > > ---
>> > > > Hello,
>> > > >
>> > > > I'm unsure about getting rid of the flush_dcache_range. If powerpc needs
>> > > > a flush ARM probably does, too, no?
>> > > > If so, what it the right thing to do? Implement flush_dcache_range for
>> > > > ARM (just wrapping flush_dcache_page?)?
>> > > As Russell seem to be OK with the #ifdef, can you please take this
>> > > patch?
>> >
>> > Ick, no.
>>
>> I never said I was OK with the #ifdef...
> Ah, right, sorry.
>
>> > Come on, we don't have ifdefs in .c files for a reason, surely there is
>> > a better fix for this some other way?
>>
>> I suggested ways to fix it, which apparantly got ignored. ?To repeat myself,
>> what I said was:
>>
>> "Well, the folk introducing it should have added it to cachetlb.txt so
>> that other folk know what the intentions of it are. ?At the moment it
>> seems to be an unofficial extension with unknown semantics. ?Maybe the
>> PPC folk can clear it up and fix other arches if they wish to make it
>> an official arch cachetlb extension."
> So what should we do? The fsl_udc_core driver currently fails to build
> because it uses flush_dcache_range unconditionally. So the obvious ways
> to fix it are:
>
> ?1) define flush_dcache_range
> ? a) in arch/arm
> ? b) in the driver
> ?2) make the driver not use flush_dcache_range
> ? a) #ifdef
> ? b) revert 09ba0de (and probably some commits that depend on it)
> ? c) use a different function to flush the cache

I see no reason why a dma_map_*() function couldn't be used here?

This is preventing the driver from being built. And the _fsl_readl stuffs,
which was really introduced by PPC guys, yet it can be made generic
enough I believe. The real requirement is really for a single kernel binary
to run on different LE/BE configurations, which will hurt performance
a bit and is normally not true on the i.MX SoCs, so that can be made as
a config option in my POV, but not necessary #ifdef CONFIG_PPC32,
maybe some better name

PS: why PPC32 is using io_*() API instead of readl/writel(), ISTR PPC32
doesn't have a separate IO space.
