From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 02 Jul 2014 15:19:31 +0200
Subject: [PATCH] arm: allow all architectures to change max zone order
In-Reply-To: <20140617150804.GA2819@n2100.arm.linux.org.uk>
References: <1370019744-7588-1-git-send-email-l.stach@pengutronix.de>
 <1372689229.4277.4.camel@weser.hi.pengutronix.de>
 <20140617150804.GA2819@n2100.arm.linux.org.uk>
Message-ID: <1404307171.4250.5.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 17.06.2014, 16:08 +0100 schrieb Russell King - ARM
Linux:
> On Mon, Jul 01, 2013 at 04:33:49PM +0200, Lucas Stach wrote:
> > Am Freitag, den 31.05.2013, 19:02 +0200 schrieb Lucas Stach:
> > > Many multimedia applications on architectures without an
> > > IOMMU need large physically contiguous buffers and so need
> > > to adjust the max zone order of the page allocator.
> > > 
> > > There is zero reason to not allow this adjustment on arches
> > > other than SHMOBILE.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  arch/arm/Kconfig |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 49d993c..6ceace8 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -1710,7 +1710,7 @@ config HW_PERF_EVENTS
> > >  source "mm/Kconfig"
> > >  
> > >  config FORCE_MAX_ZONEORDER
> > > -	int "Maximum zone order" if ARCH_SHMOBILE
> > > +	int "Maximum zone order"
> > >  	range 11 64 if ARCH_SHMOBILE
> > >  	default "12" if SOC_AM33XX
> > >  	default "9" if SA1111
> > 
> > Ping. This is really straight forward and low risk.
> 
> According to my greps, this is the only copy of this mail that appeared
> on the mailing lists in 2013.  I've really not been happy with the
> blatent assertion in this commit message, so I've been ignoring the
> patch in the patch system because of that... until now.
> 
> First, let's look at the default, which is 11.  That corresponds with
> 2^10 pages, which gives a maximum allocation of 4MB.  While that's
> rather limiting when you want to allocate a 1080p framebuffer (which
> works out at slightly over 8MB), it seems that it's entirely possible
> to allocate such framebuffers without resorting to fiddling with this
> when CMA is being used.
> 
> Indeed, on iMX6 with imx-drm, I have a 1080p frame buffer provided by
> the current CMA memory backed implementation there just fine with the
> default value of this.  So, large physically contiguous buffers can
> definitely be allocated today without problem - with CMA.
> 
> Not using CMA for large memory buffers would be a mistake.  Memory
> suffers from fragmentation, which makes large memory allocations
> suffer - I see even 16K allocations fail with 3.x kernels.  So what
> hope has a 4MB (or larger) allocation got?
> 
> CMA avoids that by setting aside a special region which is only used
> for data which can be moved into other memory areas when required,
> thereby reducing the effects of memory fragmentation in this area.
> 
> So, far from "zero reason", there's a very real reason: memory
> fragmentation leading to OOM situations.  Rather than fiddling with
> this seemingly easy-to-fiddle-with constant, please use an appropriately
> adjusted CMA for your multimedia applications instead of alloc_pages().
> 
While we carried this patch around exactly for the reason that
allocating large buffers did not succeed even with CMA in place, it
seems this is no longer true on todays kernels.

So you are entirely correct in discarding this patch.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
